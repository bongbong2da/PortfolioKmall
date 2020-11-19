package com.kmall.domain;

public class Criteria {

	private int page;
	
	private int displayPages;
	
	private int startRow;
	private int endRow;
	
	Criteria() {
		if(this.page <= 0) {
			this.page = 1;
		}
		this.displayPages = 10;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getDisplayPages() {
		return displayPages;
	}
	public void setDisplayPages(int displayPages) {
		this.displayPages = displayPages;
	}
	
	
	public int getStartRow() {
		return (page - 1) * displayPages + 1;
	}
	public int getEndRow() {
		return getStartRow() + displayPages - 1;
	}
	
}
