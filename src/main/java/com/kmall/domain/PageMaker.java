package com.kmall.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class PageMaker {

	private static final Logger log = LoggerFactory.getLogger(PageMaker.class);
	
	private int totalCount;
	private int displayPages = 10;
	
	private int startPage;
	private int endPage;
	
	private boolean prev;
	private boolean next;
	
	private Criteria cri;
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	private void calcData() {
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPages) * displayPages);
		startPage = (endPage - displayPages) + 1;
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getDisplayPages()));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		this.prev = cri.getPage() == 1 ? false : true;
		this.next = cri.getPage() * cri.getDisplayPages() >= totalCount ? false : true;

		log.info(this.toString());
	}

	public String makeBasicQuery(int page, int displayPages) {
		UriComponents uc =
				UriComponentsBuilder.newInstance()
				.queryParam("page" , page)
				.queryParam("displayPages", displayPages)
				.build();
		return uc.toUriString();
	}
	
	public String makeSearch(int page) {
		UriComponents uriComponents = 
		UriComponentsBuilder.newInstance()
			.queryParam("page", page)
			.queryParam("displayPages", cri.getDisplayPages())
			.queryParam("searchType", ((SearchCriteria)cri).getSearchType())
			.queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
			.build();
		
		return uriComponents.toUriString();
	}

	public String makeFullSearch(int page) {
		UriComponents uriComponents =
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("displayPages", cri.getDisplayPages())
				.queryParam("searchType", ((SearchCriteria)cri).getSearchType())
				.queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
				.queryParam("startDate", ((SearchCriteria)cri).getStartDate())
				.queryParam("endDate", ((SearchCriteria)cri).getEndDate())
				.build();
		return uriComponents.toUriString();
	}
	
	public String makeProductSearch(int page) {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("category", ((ProductCriteria)cri).getCategory())
				.queryParam("keyword", encoding(((ProductCriteria)cri).getKeyword()))
				.build();
		
		return uriComponents.toUriString();
	}
	
	private Object encoding(String keyword) {
		// 검색어가 최초에 값이 없을 때는 그냥 공백으로 값을 넘김
		if(keyword == null || keyword.length()==0)
		{
			return "";
		}
		
		
		// 검색어가 한글값이 들어 갈 경우
		String val = "";
		
		// 여기서 URLEncoder.encode이 한글로 인코딩 작업을 해줌
		try 
		{
			val = URLEncoder.encode(keyword, "UTF-8");
		} 
		catch (UnsupportedEncodingException e) 
		{
			e.printStackTrace();
		}
		
		return keyword;
	}
}
