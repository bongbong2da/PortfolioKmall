package com.kmall.domain;

public class SearchCriteria extends Criteria {

	private String keyword;
	private String searchType;
	private String startDate;
	private String endDate;

	@Override
	public String toString() {
		return "SearchCriteria [keyword=" + keyword + ", searchType=" + searchType + ", getPage()=" + getPage()
				+ ", getDisplayPages()=" + getDisplayPages() + ", getStartRow()=" + getStartRow() + ", getEndRow()="
				+ getEndRow() + ", getClass()=" + getClass() + ", toString()=" + super.toString() + "]";
	}
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
