package com.kmall.interceptor;

import com.kmall.domain.MemberVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthInterceptor extends HandlerInterceptorAdapter {

    private static final Logger log = LoggerFactory.getLogger(AuthInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("AuthInterceptor preHandle called...");

        MemberVO check = (MemberVO) request.getSession().getAttribute("user");

        if (check == null) {
            System.out.println("Session is empty");
            response.sendRedirect("/");
            return false;
        }

        String uid = (String) request.getParameter("uid");
        String id = (String) request.getParameter("id");

        if (check.getMem_id().equals(uid)) {
            System.out.println("UID is Matched");
            return true;
        } else if (check.getMem_id().equals(id)) {
            System.out.println("ID is Matched");
            return true;
        }

        System.out.println("ID/UID doesn't Matched");
        response.sendRedirect("/");
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        MemberVO check = (MemberVO) request.getSession().getAttribute("user");

        System.out.println("AuthInterceptor postHandle called...");

        if (check == null) {
            System.out.println("UserVO is Null");
            ModelMap model = (ModelMap) modelAndView.getModel();
            model.addAttribute("msg", "로그인 후 이용해주세요.");
            response.sendRedirect("/");
        }

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}
