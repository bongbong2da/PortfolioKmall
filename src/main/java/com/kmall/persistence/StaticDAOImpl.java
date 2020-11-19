package com.kmall.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class StaticDAOImpl implements StaticDAO {

    private static final String MAPPER_PATH = "com.kmall.mapper.StaticMapper.";

    @Autowired
    private SqlSession session;

    @Override
    public List<Map<String, Object>> getDailySales() {
        return session.selectList(MAPPER_PATH + "getDailySales");
    }

    @Override
    public List<Map<String, Object>> getSalesByProduct() {
        return session.selectList(MAPPER_PATH + "getSalesByProduct");
    }

    @Override
    public List<Map<String, Object>> getDailySignedUp() {
        return session.selectList(MAPPER_PATH + "getDailySignedUp");
    }

    @Override
    public List<Map<String, Object>> getDailyTotal() {
        return session.selectList(MAPPER_PATH + "getDailyTotal");
    }
}
