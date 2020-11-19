package com.kmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kmall.domain.CartVO;
import com.kmall.persistence.CartDAO;
import com.kmall.persistence.ProductDAO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartDAO dao;
	
	@Autowired
	private ProductDAO productDAO;

	@Override
	public void addCart(CartVO cart) {
		dao.addCart(cart);
	}

	@Override
	public List<CartVO> getCart(String id) {
		List<CartVO> result = dao.getCart(id);
		return result;
	}

	@Override
	public List<CartVO> getCartByArray(String id, int[] arr) {
		List<CartVO> result = dao.getCartByArray(id, arr);
		return result;
	}

	@Override
	public int getCount(String userid) {
		return dao.getCount(userid);
	}

	@Override
	public void delete(int[] idx, String mem_id) {
		dao.delete(idx, mem_id);
	}

	@Override
	public void setAmount(int cart_idx, int prdt_idx, int amount) {
		dao.setAmount(cart_idx, prdt_idx, amount);
	}

}
