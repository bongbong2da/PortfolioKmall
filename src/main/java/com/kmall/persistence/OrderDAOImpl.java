package com.kmall.persistence;

import com.google.common.collect.Maps;
import com.kmall.domain.Criteria;
import com.kmall.domain.OrderDetailVO;
import com.kmall.domain.OrderSummaryVO;
import com.kmall.domain.SearchCriteria;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class OrderDAOImpl implements OrderDAO {

    @Autowired
    private SqlSession session;

    private static final String MAPPER_PATH = "com.kmall.mapper.OrderMapper.";

    @Override
    public int insertSummary(OrderSummaryVO os) {
        session.insert(MAPPER_PATH + "insertSummary", os);
        return os.getOd_idx();
    }

    @Override
    public void insertDetail(OrderDetailVO od) {
        session.insert(MAPPER_PATH + "insertDetail", od);
    }

    @Override
    public List<OrderSummaryVO> getSummaryList(String id, SearchCriteria cri) {
        Map<String, Object> query = Maps.newHashMap();
        query.put("id", id);
        query.put("cri", cri);
        return session.selectList(MAPPER_PATH + "getSummaryList", query);
    }

    @Override
    public OrderSummaryVO getSummary(int idx) {
        return session.selectOne(MAPPER_PATH + "getSummary", idx);
    }

    @Override
    public List<OrderDetailVO> getDetailList(int idx) {
        return session.selectList(MAPPER_PATH + "getDetailList", idx);
    }

    @Override
    public int getCount(String id, SearchCriteria cri) {
        Map<String, Object> query = Maps.newHashMap();
        query.put("id", id);
        query.put("cri", cri);
        return session.selectOne(MAPPER_PATH + "getCount", query);
    }

    @Override
    public void updateSummary(OrderSummaryVO summary, int[] idx) {
        Map<String, Object> query = Maps.newHashMap();
        query.put("summary", summary);
        query.put("idx", idx);
        session.update(MAPPER_PATH + "updateSummary", query);
    }

    @Override
    public void editReceiveInfo(OrderSummaryVO summary) {
        session.update(MAPPER_PATH + "editReceiveInfo", summary);
    }

    @Override
    public List<OrderSummaryVO> getRecentOrders() {
        return session.selectList(MAPPER_PATH + "getRecentOrders");
    }

    @Override
    public void cancelOrder(int od_idx) {
        session.update(MAPPER_PATH + "cancelOrder", od_idx);
    }
}
