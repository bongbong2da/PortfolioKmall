package com.kmall.domain;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.ToString;
@Data
@ToString
public class MemberVO {
	private String mem_id;
	private String mem_name;
	private String mem_passwd;
	private String mem_postcode;
	private String mem_roadname;
	private String mem_addr;
	private String mem_addr_detail;
	private String mem_tel;
	private String mem_nickname;
	private String mem_email_check;
	private int mem_point;
	private LocalDateTime mem_regdate;
	private LocalDateTime mem_updatedate;
	private LocalDateTime mem_lastlogin;
	private char manager;
}
