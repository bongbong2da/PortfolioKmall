package com.kmall.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class OrderDetailVO {
	private int od_idx;
	private int prdt_idx;
	private String prdt_name;
	private int od_amount;
	private int od_price;
}
