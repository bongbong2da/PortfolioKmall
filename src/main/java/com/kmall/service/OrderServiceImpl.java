package com.kmall.service;

import com.kmall.domain.*;
import com.kmall.persistence.OrderDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.Iterator;
import java.util.List;

@Service
public class OrderServiceImpl implements  OrderService {

    private static final Logger log = LoggerFactory.getLogger(OrderServiceImpl.class);

    @Autowired
    private OrderDAO dao;

    @Override
    @Transactional
    @ResponseBody
    public int orderAction(OrderSummaryVO os, OrderDetailVOList odl) {
        try {
            int od_idx = dao.insertSummary(os);

            Iterator iter = odl.getOrderDetailList().iterator();

            while(iter.hasNext()) {
                OrderDetailVO temp = (OrderDetailVO)iter.next();

                //해당 리스트의 인덱스가 비어있을 경우 continue;
                if(temp.getPrdt_name() == null) continue;
                
                temp.setOd_idx(od_idx);
                dao.insertDetail(temp);
            }
            return od_idx;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<OrderSummaryVO> getSummaryList(String id, SearchCriteria cri) {
        return dao.getSummaryList(id, cri);
    }

    @Override
    public OrderSummaryVO getSummary(int idx) {
        return dao.getSummary(idx);
    }

    @Override
    public List<OrderDetailVO> getDetailList(int idx) {
        return dao.getDetailList(idx);
    }

    @Override
    public int getCount(String id, SearchCriteria cri) {
        return dao.getCount(id, cri);
    }

    @Override
    public void updateSummary(OrderSummaryVO summary, int[] idx) {
        dao.updateSummary(summary, idx);
    }

    @Override
    public void editReceiveInfo(OrderSummaryVO summary) {
        dao.editReceiveInfo(summary);
    }

    @Override
    public List<OrderSummaryVO> getRecentOrders() {
        return dao.getRecentOrders();
    }

    @Override
    public void cancelOrder(int od_idx) {
        dao.cancelOrder(od_idx);
    }
}
