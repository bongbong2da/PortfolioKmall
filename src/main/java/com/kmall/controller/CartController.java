package com.kmall.controller;

import java.util.*;

import com.kmall.domain.MemberVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kmall.domain.CartVO;
import com.kmall.service.CartService;
import com.kmall.service.ProductService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/cart/*")
public class CartController {

	private static final Logger log = LoggerFactory.getLogger(CartController.class);
	
	@Autowired
	private CartService service;
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value = "goCart")
	public String goCart() {
		return "list";
	}
	
	@ResponseBody
	@RequestMapping(value = "addCart", method = RequestMethod.POST)
	public ResponseEntity<String> addCart(CartVO cart) {
		ResponseEntity<String> out = null;
		
		try {
			service.addCart(cart);
			
			out = new ResponseEntity<String>("success", HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			
			out = new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
		}
		
		return out;
	}
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void getCart(Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("user");

		if(member.getMem_id() == null) return;

		try {
			List<CartVO> cartList = service.getCart(member.getMem_id());

			model.addAttribute("cartList", cartList);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	}

	@ResponseBody
	@RequestMapping(value = "getCartByArray", method = RequestMethod.POST)
	public ResponseEntity<List<CartVO>> getCartByArray(String id, @RequestParam("idx[]") int[] idx) {
		ResponseEntity<List<CartVO>> out = null;

		log.info("getByArray's idx = " + Arrays.toString(idx));

		try {
			List<CartVO> cartList = service.getCartByArray(id, idx);

			out = new ResponseEntity<List<CartVO>>(cartList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();

			out = new ResponseEntity<List<CartVO>>(HttpStatus.BAD_REQUEST);
		}

		return out;
	}

	@ResponseBody
	@RequestMapping(value = "getCount", method = RequestMethod.GET)
	public ResponseEntity<Integer> getCount(String uid) {
		ResponseEntity<Integer> out = null;
		int result = 0;
		
		try {
			result = service.getCount(uid);
			out = new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			out = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return out;
	}

	@ResponseBody
	@PostMapping("delete")
	public String delete(@RequestParam(value="idx[]") int[] idx, String mem_id) {
		try {
			service.delete(idx, mem_id);
			return "OK";
		} catch (Exception e) {
			e.printStackTrace();
			return "err";
		}
	}

	@ResponseBody
	@GetMapping("delete")
	public String delete(HttpServletRequest request, int idx) {
		MemberVO member = (MemberVO)request.getSession().getAttribute("user");

		try {
			int[] query = new int[1];
			query[0] = idx;
			service.delete(query, member.getMem_id());
			return "OK";
		} catch (Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
	}

	@ResponseBody
	@PostMapping("setAmount")
	public String setAmount(CartVO cart) {

		try {
			service.setAmount(cart.getCart_idx(), cart.getPrdt_idx(), cart.getCart_amount());
			return "OK";
		} catch (Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
	}
}
