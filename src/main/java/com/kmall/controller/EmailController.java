package com.kmall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kmall.domain.EmailDTO;
import com.kmall.service.EmailService;

@Controller
@RequestMapping("/email/*")
public class EmailController {

	private static final Logger log = LoggerFactory.getLogger(EmailController.class);
	
	@Autowired
	private EmailService service;
	
	@ResponseBody
	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public ResponseEntity<String> send(EmailDTO mail, HttpSession session) {
		
		ResponseEntity<String> out = null;
		
		String authCode = "";
		
		for (int i = 0; i < 6; i++) {
			authCode += String.valueOf((int)(Math.random()*10));
		}

		log.info("AuthCode = " + authCode);
		session.setAttribute("authCode", authCode);
		
		try {
			service.sendMail(mail, authCode);
			
			out = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			out = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return out;
	}
	
	@ResponseBody
	@GetMapping("getAuthCode")
	public String getSessionAttr(HttpSession session) {
		return (String)session.getAttribute("authCode");
	}
}
