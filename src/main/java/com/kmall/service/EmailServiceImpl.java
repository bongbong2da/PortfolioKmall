package com.kmall.service;

import com.kmall.domain.EmailDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	private JavaMailSender sender;

	@Override
	public void sendMail(EmailDTO mail, String authCode) {

		System.out.println("메일 : " + mail);
		
		MimeMessage msg = sender.createMimeMessage();
		
		try {
			//받는 사람의 주소
			msg.addRecipient(RecipientType.TO, new InternetAddress(mail.getReceiveMail()));
			
			//보내는 사람의 정보
			msg.addFrom(new InternetAddress[] {new InternetAddress(mail.getSenderMail(), mail.getSenderName())});
			
			//제목
			msg.setSubject(mail.getSubject(), "utf-8");
			
			//내용
			msg.setText(makeMsg(authCode), "utf-8");

			msg.setHeader("Content-Type","text/plain; charset=utf-8");

			System.out.println(mail.getMessage());
			
			//보내기
			sender.send(msg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String makeMsg(String authCode) {
		return "인증번호는 " + authCode + "입니다.\n확인란에 입력해주세요.";
	}
	
}
