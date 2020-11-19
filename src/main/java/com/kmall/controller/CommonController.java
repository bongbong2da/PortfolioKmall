package com.kmall.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/common/*", method = RequestMethod.GET)
public class CommonController {

    private static final Logger log = LoggerFactory.getLogger(CommonController.class);

}
