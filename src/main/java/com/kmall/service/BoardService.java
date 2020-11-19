package com.kmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kmall.domain.BoardVO;
import com.kmall.domain.SearchCriteria;
import com.kmall.persistence.BoardDAO;

public interface BoardService {
	
	public List<BoardVO> getList(SearchCriteria cri);
	
	public BoardVO getArticle(int idx);
	
	public int getCount(SearchCriteria cri);
	
	public void write(BoardVO board);
	
	public void update(BoardVO board);
	
	public void delete(int[] idx);

	public List<BoardVO> getArticlesById(String uid);
	
}
