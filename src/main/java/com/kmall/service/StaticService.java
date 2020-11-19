package com.kmall.service;

import com.kmall.persistence.StaticDAO;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

public interface StaticService {

    public List<Map<String, Object>> getDailySales();

    public List<Map<String, Object>> getSalesByProduct();

    public List<Map<String, Object>> getDailySignedUp();

    public List<Map<String, Object>> getDailyTotal();
}
