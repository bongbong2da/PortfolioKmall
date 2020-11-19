package com.kmall.controller;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kmall.service.StaticService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/static/*")
public class StaticController {

    private static final Logger log = LoggerFactory.getLogger(StaticController.class);

    @Autowired
    private StaticService service;

    @GetMapping("getSalesDaily")
    public ResponseEntity getSalesDaily() {
        ResponseEntity out = null;

        try {
            List<Map<String, Object>> query = service.getDailySales();

            out = new ResponseEntity(query, HttpStatus.OK);
            return out;
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity(HttpStatus.BAD_REQUEST);
            return out;
        }
    }

    @GetMapping("getSalesByProduct")
    public ResponseEntity getSalesByProduct() {
        ResponseEntity out = null;

        try {
            List<Map<String, Object>> query = service.getSalesByProduct();

            out = new ResponseEntity(query, HttpStatus.OK);
            return out;
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity(HttpStatus.BAD_GATEWAY);
            return out;
        }
    }

    @GetMapping("getDailySignedUp")
    public ResponseEntity getDailySignedUp() {
        ResponseEntity out = null;

        try {
            List<Map<String, Object>> query = service.getDailySignedUp();

            out = new ResponseEntity(query, HttpStatus.OK);
            return out;
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity(HttpStatus.BAD_GATEWAY);
            return out;
        }
    }

    @GetMapping("getDailyTotal")
    public ResponseEntity getDailyTotal() {
        ResponseEntity out = null;

        try {
            List<Map<String, Object>> query = service.getDailyTotal();

            out = new ResponseEntity(query, HttpStatus.OK);
            return out;
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity(HttpStatus.BAD_GATEWAY);
            return out;
        }
    }
}
