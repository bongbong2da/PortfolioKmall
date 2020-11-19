package com.kmall.controller;

import com.kmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice (basePackages = {"com.kmall.controller"})
public class GlobalController {

    @Autowired
    private ProductService productService;

    @ModelAttribute
    public void getCategories(){

    }
}
