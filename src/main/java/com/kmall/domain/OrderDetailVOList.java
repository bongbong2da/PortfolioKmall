package com.kmall.domain;

import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
public class OrderDetailVOList {

    private List<OrderDetailVO> orderDetailList;

}
