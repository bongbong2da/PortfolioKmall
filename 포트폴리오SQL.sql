--회원 테이블
CREATE TABLE MEMBERS
(
    MEM_ID          VARCHAR2(30) PRIMARY KEY,
    MEM_NAME        VARCHAR2(30)  NOT NULL,
    MEM_PASSWD      VARCHAR2(60)  NOT NULL,
    MEM_POSTCODE    CHAR(10)      NOT NULL,
    MEM_ROADNAME    VARCHAR2(100) NOT NULL,
    MEM_ADDR        VARCHAR2(100) NOT NULL,
    MEM_ADDR_DETAIL VARCHAR2(100) NOT NULL,
    MEM_TEL         VARCHAR2(20)  NOT NULL,
    MEM_NICKNAME    VARCHAR2(20)  NOT NULL,
    MEM_EMAIL_CHECK CHAR(1)       NOT NULL,
    MEM_POINT       NUMBER  DEFAULT 1000,
    MEM_REGDATE     DATE    DEFAULT SYSDATE,
    MEM_UPDATEDATE  DATE    DEFAULT SYSDATE,
    MEM_LASTLOGIN   DATE    DEFAULT SYSDATE,
    MANAGER         CHAR(1) DEFAULT 'N'
);

ALTER TABLE MEMBERS
    ADD MEM_ROADNAME VARCHAR2(100);

CREATE SEQUENCE SEQ_MEMBERS_IDX
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0;

--카테고리 테이블
CREATE TABLE CATEGORIES
(
    CATE_CURR VARCHAR2(20) PRIMARY KEY,
    CATE_PRNT VARCHAR2(20),
    CATE_NAME VARCHAR2(50) NOT NULL
);

--카테고리 샘플 데이터
--관리자 페이지에서 별도로 관리(추가/삭제)가능
INSERT INTO CATEGORIES (CATE_CURR, CATE_PRNT, CATE_NAME)
VALUES ('1000', '', 'TOP');
INSERT INTO CATEGORIES (CATE_CURR, CATE_PRNT, CATE_NAME)
VALUES ('1100', '1000', 'HALF');
INSERT INTO CATEGORIES (CATE_CURR, CATE_PRNT, CATE_NAME)
VALUES ('1200', '1000', 'SHIRT');
INSERT INTO CATEGORIES (CATE_CURR, CATE_PRNT, CATE_NAME)
VALUES ('2000', '', 'BOTTOM');
INSERT INTO CATEGORIES (CATE_CURR, CATE_PRNT, CATE_NAME)
VALUES ('2100', '2000', 'JEAN');

--상품 테이블
CREATE TABLE PRODUCTS
(
    PRDT_IDX        NUMBER PRIMARY KEY,
    CATE_CURR       VARCHAR2(20) NOT NULL,
    PRDT_NAME       VARCHAR2(50) NOT NULL,
    PRDT_PRICE      NUMBER       NOT NULL,
    PRDT_DISCNT     NUMBER       NOT NULL,
    PRDT_COMPANY    VARCHAR2(30) NOT NULL,
    PRDT_DETAIL     CLOB         NOT NULL,
    PRDT_IMG        VARCHAR2(200),
    PRDT_STOCK      NUMBER       NOT NULL,
    PRDT_BUYABLE    CHAR(1) DEFAULT 'Y',
    PRDT_REGDATE    DATE    DEFAULT SYSDATE,
    PRDT_UPDATEDATE DATE    DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_PRDT_IDX
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0;

--장바구니 테이블
CREATE TABLE CART
(
    CART_IDX    NUMBER PRIMARY KEY,
    PRDT_IDX    NUMBER        NOT NULL,
    MEM_ID      VARCHAR2(20)  NOT NULL,
    CART_AMOUNT NUMBER        NOT NULL,
    PRDT_NAME   VARCHAR2(200) NOT NULL,
    PRDT_PRICE  NUMBER        NOT NULL,
    PRDT_DISCNT NUMBER        NOT NULL,
    PRDT_IMG    VARCHAR2(200)
);

CREATE SEQUENCE SEQ_CART_IDX
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0;

--주문 요약 테이블
CREATE TABLE ORDER_SUMMARY
(
    OD_IDX           NUMBER PRIMARY KEY,
    MEM_ID           VARCHAR2(50)  NOT NULL,
    OD_RECEIVER      VARCHAR2(30)  NOT NULL,
    OD_POSTCODE      CHAR(10)      NOT NULL,
    OD_ROADNAME      VARCHAR2(100) NOT NULL,
    OD_ADDR          VARCHAR2(50)  NOT NULL,
    OD_ADDR_DETAIL   VARCHAR2(50)  NOT NULL,
    OD_TEL           VARCHAR2(20)  NOT NULL,
    OD_TOTAL_PRICE   NUMBER        NOT NULL,
    OD_USE_POINT     NUMBER,
    OD_METHOD        VARCHAR2(50)  not null,
    OD_SHIPPING_NUM  VARCHAR2(50)  default '미등록',
    OD_SHIPPING_STAT VARCHAR2(100) default '배송 준비중',
    OD_DATE          DATE          DEFAULT SYSDATE
);

drop table ORDER_SUMMARY;
drop table ORDER_DETAIL;

alter table ORDER_SUMMARY
    add OD_USE_POINT number;
alter table ORDER_SUMMARY
    add od_shipping_num varchar2(50) default '미등록';
alter table ORDER_SUMMARY
    add od_shipping_stat varchar2(100) default '배송 준비중';
alter table ORDER_SUMMARY
    add od_roadname varchar2(100);


CREATE SEQUENCE SEQ_OD_IDX
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0;

--주문 상세 테이블
--각 주문에 포함된 상품들의 정보를 담음.
CREATE TABLE ORDER_DETAIL
(
    OD_IDX    NUMBER,
    PRDT_IDX  NUMBER,
    PRDT_NAME VARCHAR2(50),
    OD_AMOUNT NUMBER NOT NULL,
    OD_PRICE  NUMBER NOT NULL,
    CONSTRAINT od_detail_pk PRIMARY KEY (od_idx, prdt_idx)
);
alter table ORDER_DETAIL
    add prdt_name varchar2(50);

--게시판 테이블
CREATE TABLE BOARD
(
    BOARD_IDX     NUMBER PRIMARY KEY,
    MEM_ID        VARCHAR2(20)  NOT NULL,
    BOARD_TITLE   VARCHAR2(100) NOT NULL,
    BOARD_CONTENT CLOB          NOT NULL,
    BOARD_REGDATE DATE DEFAULT SYSDATE,
    board_ip      varchar2(50)
);

alter table board
    add board_ip varchar2(50);

CREATE SEQUENCE SEQ_BOARD_IDX
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0;

--리뷰 테이블
CREATE TABLE REVIEW
(
    REVIEW_IDX     NUMBER PRIMARY KEY,
    MEM_ID         VARCHAR2(50)  NOT NULL,
    OD_IDX         number        not null,
    PRDT_IDX       NUMBER        NOT NULL,
    REVIEW_IMG     VARCHAR2(200),
    REVIEW_CONTENT VARCHAR2(200) NOT NULL,
    REVIEW_RATING  NUMBER        NOT NULL,
    REVIEW_REGDATE DATE DEFAULT SYSDATE
);

alter table review add review_img varchar2(200);
alter table review
    add od_idx number;
alter table review
    drop column od_idx;

CREATE SEQUENCE SEQ_REVIEW_IDX
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0;


-- 주문 상세 레코드 삽입 트리거
/*
주문 상세 레코드가 삽입 될 때 해당 상품의 갯수 만큼
상품테이블의 재고수에서 감소시킴.
*/
CREATE OR REPLACE TRIGGER OD_INSERT_TRIG
    AFTER INSERT
    ON ORDER_DETAIL
    FOR EACH ROW
DECLARE
    TEMP_AMOUNT NUMBER;
    TEMP_IDX    NUMBER;
BEGIN
    SELECT :NEW.OD_AMOUNT INTO TEMP_AMOUNT FROM DUAL;
    SELECT :NEW.PRDT_IDX INTO TEMP_IDX FROM DUAL;

    UPDATE PRODUCTS
    SET PRDT_STOCK = PRDT_STOCK - TEMP_AMOUNT
    WHERE PRDT_IDX = TEMP_IDX;
END;

--주문 종합 레코드 삽입 트리거
/*
주문 종합 레코드가 삽입 될 시, 사용한 포인트를
회원 테이블에서 해당 회원의 포인트에서 감소시킴.
*/
CREATE OR REPLACE TRIGGER OD_SUMMARY_POINT_TRIG
    AFTER INSERT
    ON ORDER_SUMMARY
    FOR EACH ROW
DECLARE
    T_POINT  number;
    T_MEM_ID varchar2(50);
BEGIN
    SELECT :NEW.OD_USE_POINT INTO T_POINT FROM DUAL;
    SELECT :NEW.MEM_ID INTO T_MEM_ID FROM DUAL;

    UPDATE MEMBERS SET MEM_POINT = MEM_POINT - T_POINT WHERE MEM_ID = T_MEM_ID;
end;

COMMIT;

-- create or replace Trigger review_insert_trigger
--     after insert
--     on REVIEW
--     for each row
-- Declare
--     t_od_idx order_detail.OD_IDX%type;
--     t_prdt_idx order_detail.prdt_idx%type;
--     begin
--         select :new.od_idx into t_od_idx from dual;
--         select :new.prdt_idx into t_prdt_idx from dual;
--         update ORDER_DETAIL set od_review = 'Y' where od_idx = t_od_idx
--         and prdt_idx = t_prdt_idx;
--     end;
--
--     drop trigger REVIEW_INSERT_TRIGGER;