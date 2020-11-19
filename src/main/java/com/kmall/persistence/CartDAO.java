package com.kmall.persistence;

import java.util.List;

import com.kmall.domain.CartVO;

public interface CartDAO {
	
	public void addCart(CartVO cart);
	
	public List<CartVO> getCart(String userId);

	public List<CartVO> getCartByArray (String id, int[] arr);

	public int getCount(String userid);

	public void delete(int[] idx, String mem_id);

	public void setAmount(int cart_idx, int prdt_idx, int amount);
}
