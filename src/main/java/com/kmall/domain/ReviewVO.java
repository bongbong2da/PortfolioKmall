package com.kmall.domain;

import java.sql.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ReviewVO {
	private int review_idx;
	private String mem_id;
	private int od_idx;
	private int prdt_idx;
	private String review_img;
	private String review_content;
	private int review_rating;
	private Date review_regdate;
}
