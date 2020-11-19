package com.kmall.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kmall.domain.BoardVO;
import com.kmall.domain.SearchCriteria;

import lombok.extern.log4j.Log4j;

public interface BoardDAO {
	
	public List<BoardVO> getList(SearchCriteria cri);
	
	public BoardVO getArticle(int idx);
	
	public int getCount(SearchCriteria cri);
	
	public void write(BoardVO board);
	
	public void update(BoardVO board);
	
	public void delete(int[] idx);

	public List<BoardVO> getArticlesById (String uid);
	
}
