package com.kmall.persistence;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kmall.domain.CartVO;

@Repository
public class CartDAOImpl implements CartDAO {
	
	private static final String MAPPER_PATH = "com.kmall.mapper.CartMapper.";
	
	@Autowired
	private SqlSession session;

	@Override
	public void addCart(CartVO cart) {
		session.insert(MAPPER_PATH + "addCart", cart);
	}

	@Override
	public List<CartVO> getCart(String id) {
		List<CartVO> result = session.selectList(MAPPER_PATH + "getCart", id);
		return result;
	}

	@Override
	public List<CartVO> getCartByArray(String id, int[] arr) {
		Map<String, Object> query = Maps.newHashMap();
		query.put("id", id);
		query.put("arr", arr);
		System.out.println(query);
		System.out.println(Arrays.toString(arr));

		List<CartVO> result = session.selectList(MAPPER_PATH + "getCartByArray", query);
		return result;
	}

	@Override
	public int getCount(String userid) {
		return session.selectOne(MAPPER_PATH + "getCount", userid);
	}

	@Override
	public void delete(int[] idx, String mem_id) {
		Map<String, Object> query = Maps.newHashMap();
		query.put("idx", idx);
		query.put("mem_id", mem_id);
		session.delete(MAPPER_PATH + "delete", query);
	}

	@Override
	public void setAmount(int cart_idx, int prdt_idx, int amount) {
		Map<String, Object> query = Maps.newHashMap();
		query.put("cart_idx", cart_idx);
		query.put("prdt_idx", prdt_idx);
		query.put("amount", amount);
		session.update(MAPPER_PATH + "setAmount", query);
	}

}
