package com.kmall.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CartVO {
	private int cart_idx;
	private int prdt_idx;
	private String prdt_name;
	private int	prdt_price;
	private double prdt_discnt;
	private String prdt_img;
	private String mem_id;
	private int cart_amount;
}
