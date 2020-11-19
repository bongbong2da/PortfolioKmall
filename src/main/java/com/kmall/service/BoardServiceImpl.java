package com.kmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kmall.domain.BoardVO;
import com.kmall.domain.SearchCriteria;
import com.kmall.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	public List<BoardVO> getList(SearchCriteria cri) {
		List<BoardVO> result = dao.getList(cri);
		return result;
	}
	
	public BoardVO getArticle(int idx) {
		BoardVO article = dao.getArticle(idx);
		return article;
	}
	
	public int getCount(SearchCriteria cri) {
		return dao.getCount(cri);
	}
	
	public void write(BoardVO board) {
		dao.write(board);
	}
	
	public void update(BoardVO board) {
		dao.update(board);
	}
	
	public void delete(int[] idx) {
		dao.delete(idx);
	}

	@Override
	public List<BoardVO> getArticlesById(String uid) {
		return dao.getArticlesById(uid);
	}

}
