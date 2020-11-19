package com.kmall.persistence;

import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kmall.domain.BoardVO;
import com.kmall.domain.SearchCriteria;

import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class BoardDAOImpl implements BoardDAO {
	
	private static final String MAPPER_PATH = "com.kmall.mapper.BoardMapper.";
	
	@Autowired
	private SqlSession session;
	
	public List<BoardVO> getList(SearchCriteria cri) {
		List<BoardVO> result = session.selectList(MAPPER_PATH + "getList", cri);
		return result;
	}
	
	public BoardVO getArticle(int idx) {
		BoardVO article = session.selectOne(MAPPER_PATH + "getArticle", idx);
		return article;
	}
	
	public int getCount(SearchCriteria cri) {
		int result = session.selectOne(MAPPER_PATH + "getCount", cri);
		return result;
	}
	
	public void write(BoardVO board) {
		session.insert(MAPPER_PATH + "write", board);
	}
	
	public void update(BoardVO board) {
		session.update(MAPPER_PATH + "update", board);
	}
	
	public void delete(int[] idx) {
		Map<String, Object> query = Maps.newHashMap();
		query.put("idx", idx);
		session.delete(MAPPER_PATH + "delete", query);
	}

	@Override
	public List<BoardVO> getArticlesById(String uid) {
		return session.selectList(MAPPER_PATH + "getArticlesById", uid);
	}

}
