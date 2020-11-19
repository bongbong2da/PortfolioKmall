package com.kmall.service;

import com.kmall.domain.*;

import java.util.List;

public interface OrderService {

    public int orderAction(OrderSummaryVO os, OrderDetailVOList odl);

    public List<OrderSummaryVO> getSummaryList(String id, SearchCriteria cri);

    public OrderSummaryVO getSummary(int idx);

    public List<OrderDetailVO> getDetailList(int idx);

    public int getCount(String id, SearchCriteria cri);

    public void updateSummary(OrderSummaryVO summary, int[] idx);

    public void editReceiveInfo(OrderSummaryVO summary);

    public List<OrderSummaryVO> getRecentOrders();

    public void cancelOrder(int od_idx);

}
