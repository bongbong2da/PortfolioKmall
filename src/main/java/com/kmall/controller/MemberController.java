package com.kmall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kmall.domain.MemberVO;
import com.kmall.service.MemberService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
@RequestMapping(value = "/member/*")
public class MemberController {

    private static final Logger log = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    private MemberService service;
    @Autowired
    private BCryptPasswordEncoder encoder;

    @RequestMapping(value = "/signUp", method = RequestMethod.GET)
    public String signUpForm() {
        return "/member/signUp";
    }

    @RequestMapping(value = "/signUp", method = RequestMethod.POST)
    public String signUpAction(MemberVO member) {
        log.info(member.toString());
        try {
            service.addMember(member);
        } catch (Exception e) {
        }
        return "redirect:/";
    }

    @ResponseBody
    @RequestMapping(value = "isIdDuplicated", method = RequestMethod.GET)
    public String isIdDuplicated(String uid) {

        boolean result = service.isIdDuplicated(uid);

        if (result) {
            return "OK";
        } else {
            return "EXISTS";
        }
    }

    @ResponseBody
    @RequestMapping(value = "isNickDuplicated", method = RequestMethod.GET)
    public String isNickDuplicated(String nickname) {

        boolean result = service.isNickDuplicated(nickname);

        if (result) {
            return "OK";
        } else {
            return "EXISTS";
        }
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginForm() {
        return "/member/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginAction(MemberVO member, HttpServletRequest request, RedirectAttributes rttr) {
        MemberVO check = service.login(member);
        if (check != null) {
            if (encoder.matches(member.getMem_passwd(), check.getMem_passwd())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", check);
                // Cookie Test
            } else {
                rttr.addAttribute("msg", "로그인에 실패했습니다.");
            }
        } else {
            rttr.addAttribute("msg", "없는 아이디 입니다.");
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/loginPop", method = RequestMethod.GET)
    public String popLoginForm() {
        return "/member/loginPop";
    }

    @ResponseBody
    @RequestMapping(value = "/loginAjax", method = RequestMethod.POST)
    public String loginAjax(MemberVO member, HttpServletRequest request) {
        MemberVO check = service.login(member);
        if (check != null) {
            log.info("LOGIN SUCCESS");
            HttpSession session = request.getSession();
            session.setAttribute("user", check);
            return "SUCCESS";
        } else {
            log.info("LOGIN FAILED");
            return "FAIL";
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        return "redirect:/";
    }

    @RequestMapping(value = "memberDetail", method = RequestMethod.GET)
    public String memberDetail(String uid, Model model) {
        //MemberVO member = service.getMember(uid);
        //model.addAttribute("member", member);
        return "/member/detail";
    }
//    @ResponseBody
//    @RequestMapping(value = "headerDetail", method = RequestMethod.GET)
//    public ResponseEntity<MemberVO> headerDetail(String uid) {
//        ResponseEntity<MemberVO> out = null;
//
//        MemberVO member = service.getMember(uid);
//
//        out = new ResponseEntity<MemberVO>(member, HttpStatus.OK);
//
//        return out;

//    }
//    @RequestMapping(value = "goModify", method = RequestMethod.GET)
//    public String goModify() {
//        return "/member/modifyCheck";

//    }

    @RequestMapping(value = "edit", method = RequestMethod.GET)
    public String modifyForm(RedirectAttributes rttr) {
    	rttr.addFlashAttribute("msg", "BAD_REQUEST");
        return "redirect:/";
    }

    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public String modifyAction(MemberVO member, HttpServletRequest request, RedirectAttributes rttr) {
        log.info(member.toString());
        try {
            MemberVO updatedMember = service.updateMember(member);

            request.getSession().invalidate();
            request.getSession().setAttribute("user", updatedMember);

            rttr.addFlashAttribute("msg", "정보를 수정했습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msg", "정보 수정에 실패했습니다.");
        }

        return "redirect:/";
    }

	@GetMapping("quit")
	public String quitForm(RedirectAttributes rttr) {
		rttr.addFlashAttribute("msg", "BAD_REQUEST");
		return "redirect:/";
	}

    @PostMapping("quit")
    public String quitAction(HttpServletRequest request, RedirectAttributes rttr) {
        MemberVO member = (MemberVO) (request.getSession().getAttribute("user"));

        try {
            service.quitMember(member.getMem_id());
            request.getSession().invalidate();
            rttr.addFlashAttribute("msg", "SUCCESS");
            return "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msg", "WRONG INFO");
            return "redirect:/";
        }

    }

    @GetMapping("checkSelf")
    public String checkSelfForm(@ModelAttribute("ctx") String ctx, RedirectAttributes rttr) {
    	if(ctx.equals("")) {
    		rttr.addFlashAttribute("msg", "BAD_REQUEST");
    		return "redirect:/";
		}
        return "/member/check";
    }

    @PostMapping("checkSelf")
    public String checkSelfAction(@RequestParam("ctx") String ctx, @RequestParam("mem_passwd") String mem_passwd,
                                  HttpServletRequest request, RedirectAttributes rttr) throws UnsupportedEncodingException {
        log.info("CTX = " + ctx);

        MemberVO user = (MemberVO) (request.getSession().getAttribute("user"));

        boolean verify = service.verifyPasswd(user.getMem_id(), mem_passwd);

        if (verify) {
			String dest = "";
        	if (ctx.equals("edit")) dest = "/member/edit";
        	if (ctx.equals("quit")) dest = "/member/quit";
        	if (ctx.equals("editArticle")) dest = "/";
            return dest;
        } else {
            rttr.addFlashAttribute("msg", URLEncoder.encode("AUTH FAILED", "UTF-8"));
            return "redirect:/";
        }
    }

}
