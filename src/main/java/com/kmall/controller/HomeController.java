package com.kmall.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kmall.domain.PageMaker;
import com.kmall.domain.ProductCriteria;
import com.kmall.domain.ProductVO;
import com.kmall.service.ProductService;

@Controller
public class HomeController {
	
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private ProductService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, ProductCriteria cri) {
		
		List<ProductVO> newList = service.getNewProducts(14);
		List<ProductVO> popList = service.getPopProducts(7, cri);
		
		model.addAttribute("newList", newList);
		model.addAttribute("popList", popList);
		
		return "/index";
	}
	
}
