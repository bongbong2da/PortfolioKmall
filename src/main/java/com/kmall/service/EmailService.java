package com.kmall.service;

import com.kmall.domain.EmailDTO;

public interface EmailService {
	
	public void sendMail(EmailDTO email, String authCode);
	
}
