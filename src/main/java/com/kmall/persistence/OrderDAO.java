package com.kmall.persistence;

import com.kmall.domain.Criteria;
import com.kmall.domain.OrderDetailVO;
import com.kmall.domain.OrderSummaryVO;
import com.kmall.domain.SearchCriteria;

import java.util.List;

public interface OrderDAO {

    public int insertSummary(OrderSummaryVO os);

    public void insertDetail(OrderDetailVO od);

    public List<OrderSummaryVO> getSummaryList(String id, SearchCriteria cri);

    public OrderSummaryVO getSummary(int idx);

    public List<OrderDetailVO> getDetailList(int idx);

    public int getCount(String id, SearchCriteria cri);

    public void updateSummary(OrderSummaryVO summary, int[] idx);

    public void editReceiveInfo(OrderSummaryVO summary);

    public List<OrderSummaryVO> getRecentOrders();

    public void cancelOrder(int od_idx);

}
