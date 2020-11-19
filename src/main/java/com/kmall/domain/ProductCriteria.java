package com.kmall.domain;

public class ProductCriteria extends Criteria {
	
	private String category;
	private String keyword;

	{
		this.category = "";
		this.keyword = "";
	}
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "ProductCriteria{" +
				"category='" + category + '\'' +
				", keyword='" + keyword + '\'' +
				"} " + super.toString();
	}
}
