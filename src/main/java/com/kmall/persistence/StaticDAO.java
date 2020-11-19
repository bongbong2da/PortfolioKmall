package com.kmall.persistence;

import java.util.List;
import java.util.Map;

public interface StaticDAO {

    public List<Map<String, Object>> getDailySales();

    public List<Map<String, Object>> getSalesByProduct();

    public List<Map<String, Object>> getDailySignedUp();

    public List<Map<String, Object>> getDailyTotal();

}
