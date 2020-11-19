package com.kmall.domain;

import java.sql.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class OrderSummaryVO {
	private int od_idx;
	private String mem_id;
	private String od_receiver;
	private String od_postcode;
	private String od_roadname;
	private String od_addr;
	private String od_addr_detail;
	private String od_tel;
	private String od_method;
	private String od_shipping_num;
	private String od_shipping_stat;
	private int od_total_price;
	private int od_use_point;
	private Date od_date;
}
