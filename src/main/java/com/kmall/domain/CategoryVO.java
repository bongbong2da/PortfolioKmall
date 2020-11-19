package com.kmall.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CategoryVO {
	private String cate_curr;
	private String cate_prnt;
	private String cate_name;
}
