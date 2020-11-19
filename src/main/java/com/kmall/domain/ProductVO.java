package com.kmall.domain;

import java.sql.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ProductVO {
	private int prdt_idx;
	private String cate_curr;
	private String prdt_name;
	private int prdt_price;
	private double prdt_discnt;
	private String prdt_company;
	private String prdt_detail;
	private String prdt_img;
	private int prdt_stock;
	private char prdt_buyable;
	private Date prdt_regdate;
	private Date prdt_updatedate;
}
