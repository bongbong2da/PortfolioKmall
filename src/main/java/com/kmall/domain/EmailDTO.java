package com.kmall.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class EmailDTO {
	
	private String receiveMail;
	private String senderMail;
	private String senderName;
	private String subject;
	private String message;
	
	public EmailDTO() {
		senderMail = "kmalltest@gmail.com";
		senderName = "K-Mall";
		subject = "테스트 제목";
		message = "테스트 내용";
	}
	
}
