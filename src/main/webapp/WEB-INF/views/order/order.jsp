    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE HTML>
    <html lang="ko">
    <head>
        <title>관리자 / 주문 관리</title>
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
        <script src="/resources/js/order/order.js"></script>
    </head>
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
    <body class="sidebar-mini layout-fixed">
    <div class="content-wrapper">
        <div class="content p-5">
            <input type="hidden" id="mem_postcode" value="${user.mem_postcode}">
            <input type="hidden" id="mem_roadname" value="${user.mem_roadname}">
            <input type="hidden" id="mem_addr" value="${user.mem_addr}">
            <input type="hidden" id="mem_addr_detail" value="${user.mem_addr_detail}">
            <input type="hidden" id="mem_tel" value="${user.mem_tel}">
            <input type="hidden" id="mem_point" value="${user.mem_point}">
            <form id="orderForm" action="/order/orderAction" method="post">
                <div class="card p-3 elevation-4">
                    <div class="card-header">
                        <h2 class="display-4">장바구니</h2>
                    </div>
                    <div class="card-body">
                        <table id="cartList" class="table table-striped table-hover">
                            <tr>
                                <th>
                                    <input type="checkbox" id="selectAll" checked>
                                </th>
                                <th style="width: 20px;">번호</th>
                                <th>제품</th>
                                <th>썸네일</th>
                                <th>가격</th>
                                <th>수량</th>
                            </tr>
                            <c:forEach items="${cartList}" var="cart" varStatus="i">
                                <tr class="cart">
                                    <td><input class="check" type="checkbox" checked></td>
                                    <td>
                                        <span>${cart.prdt_idx}</span>
                                        <input type="hidden" name="orderDetailList[${i.index}].prdt_idx" value="${cart.prdt_idx}">
                                    </td>
                                    <td>
                                        <a href="/products/getProduct?idx=${cart.prdt_idx}">${cart.prdt_name}</a>
                                        <input type="hidden" name="orderDetailList[${i.index}].prdt_name" value="${cart.prdt_name}">
                                    </td>
                                    <td><img style="width: 50px; height: 50px"
                                             src="/upload/getThumbnail?src=${cart.prdt_img}" alt=""></td>
                                    <td>
                                            <span id="od_price" data-price="${cart.prdt_price - (cart.prdt_price * cart.prdt_discnt)}">
                                                <fmt:formatNumber value="${cart.prdt_price - (cart.prdt_price * cart.prdt_discnt)}" type="pattern" pattern=",###"/>원
                                            </span>
                                        <input name="orderDetailList[${i.index}].od_price" type="hidden" value="<fmt:formatNumber value="${cart.prdt_price - (cart.prdt_price * cart.prdt_discnt)}" type="pattern" pattern="#"/>">
                                    </td>
                                    <td>
                                        <input class="amount" name="orderDetailList[${i.index}].od_amount" style="width: 50px" type="number" value="${cart.cart_amount}">
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                <div class="card p-3 elevation-4">
                    <div class="card-header">
                        <h2 class="display-4">합계 및 포인트</h2>
                    </div>
                    <div class="card-body p-5">
                        <table>
                            <tr>
                                <th><span>전체 가격</span></th>
                                <td><span id="sumPrice">0</span>원</td>
                                <td></td>
                            </tr>
                            <tr>
                                <th><span>고객 포인트</span></th>
                                <td><span>${user.mem_point}</span> point</td>
                                <td>
                                    <input id="usePoint" class="" type="number" value="0">
                                    <input id="pointBtn" class="btn btn-outline-dark btn-sm" type="button" value="사용">
                                    <input type="hidden" id="od_use_point" name="od_use_point" value="0">
                                </td>
                            </tr>
                            <tr>
                                <th><span>최종 가격</span></th>
                                <td>
                                    <span id="totalPrice">0</span><span>원</span>
                                    <input type="hidden" id="od_total_price" name="od_total_price" value="0">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="card p-3 elevation-4">
                    <input type="hidden" name="mem_id" value="${user.mem_id}">
                    <div class="card-header">
                        <h2 class="display-4">배송 정보</h2>
                    </div>
                    <div class="card-body">
                        <h2 class="display-5">배송지 정보</h2><br>
                        <input id="same" type="checkbox">회원 정보와 동일<br>
                        <label>받는 사람 이름</label>
                        <input name="od_receiver" class="form-control" type="text" value="test" required>
                        <label>받는 주소</label>
                        <input id="od_postcode" name="od_postcode" type="text" value="" required>
                        <input type="button" value="찾기" onclick="daumPostcode()">
                        <input id="od_roadname" type="text" name="od_roadname" required>
                        <input id="od_addr" name="od_addr" class="form-control" type="text" value="" required>
                        <input id="od_addr_detail" name="od_addr_detail" type="text" value="" required>
                        <label>받는 사람 전화번호</label>
                        <input id="od_tel" name="od_tel" class="form-control" type="text" value="" required>
                    </div>
                </div>

                <div class="card p-3 elevation-4">
                    <div class="card-header">
                        <h2 class="display-4">* 결제 수단 및 주문</h2>
                    </div>
                    <div class="card-body">
                        <span>신용카드</span>
                        <input name="od_method" type="radio" value="credit" required>
                        <span>Toss</span>
                        <input name="od_method" type="radio" value="toss">
                        <span>무통장입금</span>
                        <input name="od_method" type="radio" value="account">
                        <br><br>
                        <span class="display-5 font-weight-bold">* 개인정보 제 3자 제공 동의(필수)</span>
                        <input id="infoAgree" type="checkbox" required><br>
                        <textarea class="form-control">
                            약관 내용
                        </textarea>
                        <br>o
                        <span class="display-5 font-weight-bold">위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에 동의합니다.(필수)</span>
                        <input id="tradeAgree" type="checkbox">
                        <br>

                        <div class="card-footer text-center">
                            <button id="orderAction" class="btn btn-primary">주문</button>
                            <button class="btn btn-dark">돌아가기</button>
                        </div>

                    </div>
                </div>
            </form>
        </div>

    </div>
    <jsp:include page="../footer.jsp"/>
    <script>
        calcPrice();
    </script>
    </body>
