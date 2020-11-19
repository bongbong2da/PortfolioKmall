package com.kmall.controller;

import com.kmall.domain.*;
import com.kmall.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.lang.reflect.Method;
import java.util.List;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	private static final Logger log = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private ProductService productService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private BoardService boardService;

	@GetMapping("/dashboard")
	public void dashboard(Model model){

		List<OrderSummaryVO> sumList = orderService.getRecentOrders();
		List<ReviewVO> rvList = reviewService.getRecentReviews();

		model.addAttribute("sumList", sumList);
		model.addAttribute("rvList", rvList);

	}

	@RequestMapping(value = "/product/list", method = RequestMethod.GET)
	public void productList(ProductCriteria cri,Model model) {
		List<ProductVO> prList = productService.getProducts(cri);
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(productService.getCount(cri));

		model.addAttribute("prList", prList);
		model.addAttribute("pm", pm);
		
	}

	@RequestMapping(value = "/product/getProducts", method = RequestMethod.GET)
	public String getAllProducts(ProductCriteria cri, Model model) {

		log.info("CRITERIA = " + cri);

		try {
			List<ProductVO> prList = productService.getProducts(cri);
			PageMaker pm = new PageMaker();
			pm.setCri(cri);
			pm.setTotalCount(productService.getCount(cri));
			log.info("PageMaker = " + pm);
			model.addAttribute("prList", prList);
			model.addAttribute("pm", pm);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/admin/main";
	}
	@GetMapping("/product/stock")
	public void stockList(ProductCriteria cri, Model model) {
		try {
			List<ProductVO> prList = productService.getProducts(cri);
			PageMaker pm = new PageMaker();
			pm.setCri(cri);
			pm.setTotalCount(productService.getCount(cri));
			log.info("PageMaker = " + pm);
			model.addAttribute("prList", prList);
			model.addAttribute("pm", pm);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@PostMapping("/product/stock")
	public String stockUpdate (ProductVO product) {
		productService.updateStock(product);
		return "redirect:/admin/product/stock";
	}

	@RequestMapping(value = "/product/add", method = RequestMethod.GET)
	public String addProductForm() {
		return "/admin/product/add";
	}

	@RequestMapping(value = "/product/add", method = RequestMethod.POST)
	public String addProductAction(ProductVO product) {

		productService.addProduct(product);

		return "redirect:/";
	}

	@RequestMapping(value = "/product/edit", method=RequestMethod.GET)
	public String editProductForm(int idx, Model model) {

		ProductVO product = productService.getProduct(idx);

		model.addAttribute("product", product);
		return "/admin/product/edit";
	}

	@Transactional
	@RequestMapping(value = "/product/edit", method=RequestMethod.POST)
	public String editProductAction(ProductVO product) {
		System.out.println(product);
		productService.editProduct(product);

		return "redirect:/admin/main";
	}

	@RequestMapping(value = "/product/delete")
	public String delete(int idx) {
		productService.deleteProduct(idx);
		return "redirect:/admin/main";
	}

	@GetMapping("/category")
	public String categoryHome() {
		return "/admin/product/category";
	}

	@ResponseBody
	@GetMapping("/category/add")
	public String addCategory(CategoryVO category) {
		try {
			productService.addCategory(category);
			return "OK";
		} catch (Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
	}

	@ResponseBody
	@GetMapping("/category/editName")
	public String editCategoryName(CategoryVO category) {
		try {
			productService.editCategoryName(category);
			return "OK";
		} catch (Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
	}

	@ResponseBody
	@GetMapping("/category/delete")
	public String deleteCategory(String category) {
		try {
			String result = productService.deleteCategory(category);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return "ERROR";
		}
	}

	@GetMapping("/member/list")
	public String getMembers(Model model) {
		List<MemberVO> memList = memberService.getMembers();

		model.addAttribute("memList", memList);

		return "/admin/member/list";
	}

	@ResponseBody
	@PostMapping("/member/list")
	public ResponseEntity getMembersPost() {
		List<MemberVO> memList = memberService.getMembers();

		ResponseEntity out = new ResponseEntity(memList, HttpStatus.OK);

		return out;
	}

	@GetMapping("/member/edit")
	public String editMemberForm(String uid, Model model, RedirectAttributes rttr) {
		MemberVO member = memberService.getMember(uid);

		if (member == null) {
			rttr.addAttribute("msg", "탈퇴한 사용자입니다.");
			return "redirect:/admin/dashboard";
		}

		model.addAttribute("member", member);
		return "/admin/member/edit";
	}

	@PostMapping("/member/edit")
	public String editMemberAction(MemberVO member, Model model) {

		log.info("Editing for : " + member);

		try {
			memberService.updateMemberByAdmin(member);
			model.addAttribute("msg", "수정되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "수정에 실패했습니다.");
		}

		return "redirect:/admin/member/list";
	}

	@GetMapping("/member/activity")
	public void memberActivity(String uid, Model model, @ModelAttribute("osCri") SearchCriteria osCri) {

		List<OrderSummaryVO> sumList = orderService.getSummaryList(uid, osCri);
		List<BoardVO> boardList = boardService.getArticlesById(uid);
		List<ReviewVO> rvList = reviewService.getReviewsById(uid);

		model.addAttribute("sumList", sumList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("rvList",rvList);
	}

	@GetMapping("/order/list")
	public void getOrderSumList(Model model, @ModelAttribute("cri") SearchCriteria cri) {
		List<OrderSummaryVO> sumList = orderService.getSummaryList(null, cri);
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(orderService.getCount(null, cri));

		model.addAttribute("sumList", sumList);
		model.addAttribute("pm", pm);

	}

	@PostMapping("/order/updateSummary")
	public String updateSummary(OrderSummaryVO summary, int[] idx) {
		try {
			orderService.updateSummary(summary, idx);
			return "redirect:/admin/order/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/admin/order/list";
		}
	}

	@GetMapping("/review/list")
	public void reviewList(Model model) {
		try {
			List<ReviewVO> rvList = reviewService.getAllReviews();

			model.addAttribute("rvList", rvList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/board/list")
	public void boardList(SearchCriteria cri, Model model) {
		try {
			List<BoardVO> boardList = boardService.getList(cri);
			PageMaker pm = new PageMaker();
			pm.setCri(cri);
			pm.setTotalCount(boardService.getCount(cri));

			model.addAttribute("boardList", boardList);
			model.addAttribute("pm", pm);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@GetMapping("/grid/grid")
	public void grid() {

	}


}