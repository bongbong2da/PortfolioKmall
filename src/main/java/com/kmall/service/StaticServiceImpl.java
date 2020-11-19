package com.kmall.service;

import com.kmall.persistence.StaticDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StaticServiceImpl implements StaticService {

    @Autowired
    private StaticDAO dao;

    @Override
    public List<Map<String, Object>> getDailySales() {
        return dao.getDailySales();
    }

    @Override
    public List<Map<String, Object>> getSalesByProduct() {
        return dao.getSalesByProduct();
    }

    @Override
    public List<Map<String, Object>> getDailySignedUp() {
        return dao.getDailySignedUp();
    }

    @Override
    public List<Map<String, Object>> getDailyTotal() {
        return dao.getDailyTotal();
    }
}
