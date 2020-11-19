package com.kmall.controller;

import com.kmall.domain.*;
import com.kmall.service.CartService;
import com.kmall.service.OrderService;
import oracle.jdbc.proxy.annotation.Post;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/order/*")
public class OrderController {

    private static final Logger log = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private CartService cartService;

    @Autowired
    private OrderService service;

    @PostMapping("goOrder")
    public String goOrder(String id, @RequestParam("idx[]") int[] idx, Model model) {
        List<CartVO> cartList = cartService.getCartByArray(id, idx);

        model.addAttribute("cartList", cartList);

        return "/order/order";
    }

    @PostMapping("orderAction")
    @Transactional
    public String orderAction(OrderSummaryVO os, OrderDetailVOList odl, HttpSession session) {

        int[] idx = new int[odl.getOrderDetailList().size()];
        for(int i = 0; i < odl.getOrderDetailList().size(); i++) {
            idx[i] = odl.getOrderDetailList().get(i).getPrdt_idx();
        }

        MemberVO member = (MemberVO) session.getAttribute("user");

        try {
            int od_idx = service.orderAction(os, odl);
            cartService.delete(idx, member.getMem_id());

            member.setMem_point(member.getMem_point() - os.getOd_use_point());
            session.setAttribute("user", member);

            return "redirect:/order/getOrder?idx=" + od_idx;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/";
    }

    @GetMapping("getSummaryList")
    public String orderList(Model model, HttpSession session, @ModelAttribute("cri") SearchCriteria cri) {

        MemberVO member = (MemberVO)session.getAttribute("user");

        PageMaker pm = new PageMaker();
        pm.setCri(cri);
        pm.setTotalCount(service.getCount(member.getMem_id(), cri));
        log.info("GETCOUNT = " + service.getCount(member.getMem_id(), cri)+"");
        List<OrderSummaryVO> sumList = service.getSummaryList(member.getMem_id(), cri);
        log.info(sumList.toString());

        model.addAttribute("sumList", sumList);
        model.addAttribute("pm", pm);

        return "/order/orderList";
    }

    @GetMapping("getOrder")
    public String getOrder(Model model, int idx) {

        try {
            OrderSummaryVO summary = service.getSummary(idx);
            List<OrderDetailVO> detailList = service.getDetailList(idx);

            model.addAttribute("summary", summary);
            model.addAttribute("detailList", detailList);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/order/bill";
    }

    @PostMapping("editReceiveInfo")
    public String editReceiveInfo(OrderSummaryVO summary) {
        try {
            service.editReceiveInfo(summary);
            return "redirect:/order/getOrder?idx=" + summary.getOd_idx();
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/";
        }
    }

    @ResponseBody
    @PostMapping("cancelOrder")
    public String cancel(int od_idx) {
        try {
            service.cancelOrder(od_idx);
            return "OK";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }
}
