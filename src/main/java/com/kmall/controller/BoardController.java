package com.kmall.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kmall.domain.BoardVO;
import com.kmall.domain.MemberVO;
import com.kmall.domain.PageMaker;
import com.kmall.domain.SearchCriteria;
import com.kmall.service.BoardService;
import com.kmall.service.MemberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/board/*")
public class BoardController {

	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String boardHome(@ModelAttribute("cri") SearchCriteria cri) {
		return "list";
	}

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void getList(SearchCriteria cri, Model model) {
		log.info(cri.toString());

		List<BoardVO> list = service.getList(cri);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.getCount(cri));
		
		model.addAttribute("boardList", list);
		model.addAttribute("pm", pm);

	}
	
	@RequestMapping(value = "getArticle", method = RequestMethod.GET)
	public String getArticle(SearchCriteria cri, int idx, Model model) {
		BoardVO article = service.getArticle(idx);

		List<BoardVO> list = service.getList(cri);

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.getCount(cri));

		System.out.println(article);
		model.addAttribute("article", article);
		model.addAttribute("boardList", list);
		model.addAttribute("pm", pm);
		return "/board/article";
	}

	@Deprecated
	@ResponseBody
	@RequestMapping(value = "getList/{page}", method = RequestMethod.GET)
	public ResponseEntity<Object> getList(@PathVariable("page") int page) {
		ResponseEntity<Object> out = null;

		SearchCriteria cri = new SearchCriteria();
		cri.setPage(page);
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.getCount(cri));
		
		List<BoardVO> list = service.getList(cri);
			
		Map<String, Object> query = Maps.newHashMap();
		query.put("list", list);
		query.put("pm", pm);
			
		out = new ResponseEntity<Object>(query, HttpStatus.OK);

		return out;
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public void writeForm() {}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeAction(BoardVO board, HttpServletRequest request) {

		board.setBoard_ip(request.getRemoteAddr());

		service.write(board);
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "updateForm", method = RequestMethod.GET)
	public String updateForm(HttpSession session, int idx, Model model) {
		MemberVO sMember = (MemberVO) session.getAttribute("user");
		BoardVO board = service.getArticle(idx);

		if(!sMember.getMem_id().equals(board.getMem_id())) {
			return "redirect:/";
		}

		model.addAttribute("board", board);
		return "/board/update";
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public String updateAction(BoardVO board) {
		service.update(board);
		return "redirect:/board/getArticle?idx=" + board.getBoard_idx();
	}

	@Transactional
	@RequestMapping(value = "deleteAction", method=RequestMethod.GET)
	public String deleteAction(MemberVO member,@RequestParam("idx") int[] idx, RedirectAttributes rttr) {
		try {
			service.delete(idx);
			rttr.addFlashAttribute("msg", "삭제에 성공했습니다.");
		} catch (Exception e) {
			rttr.addFlashAttribute("msg", "삭제에 실패했습니다.");
		}

		return "redirect:/board/home";
	}

	@ResponseBody
	@PostMapping("delete")
	public String deleteAction(@RequestParam("idx[]") int[] idx) {
		log.info(Arrays.toString(idx));
		try {
			service.delete(idx);
			return "OK";
		} catch (Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
	}
}
