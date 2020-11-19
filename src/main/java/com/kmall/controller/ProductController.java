package com.kmall.controller;

import com.kmall.domain.*;
import com.kmall.service.ProductService;
import com.kmall.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
@RequestMapping(value = "/product/*")
public class ProductController {

    private static final Logger log = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    private ProductService service;

    @Autowired
    private ReviewService reviewService;

    //상품 목록 메인
    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String productHome() {
        return "/products/productsList";
    }

    //서블릿을 이용한 상품 목록 가져오기
    @RequestMapping(value = "getProducts", method = RequestMethod.GET)
    public String getProducts(@ModelAttribute("cri") ProductCriteria cri, Model model) {

        try {
            List<ProductVO> prList = service.getProducts(cri);
            List<ProductVO> popList = service.getPopProducts(7,cri);

            PageMaker pm = new PageMaker();
            pm.setCri(cri);
            pm.setTotalCount(service.getCount(cri));

            CategoryVO category = new CategoryVO();
            //1차 카테고리가 쿼리로 한자리수만 들어왔을 경우
            if(cri.getCategory().length() == 1) {
                //카테고리 이름을 구하기위해 000을 붙여 완전한 코드로 만들어준다.
                String categoryCode = "";
                categoryCode =cri.getCategory()+"000";
                category = service.getCategory(categoryCode);
            } else {
                category = service.getCategory(cri.getCategory());
            }


            model.addAttribute("prList", prList);
            model.addAttribute("popList", popList);
            model.addAttribute("pm", pm);
            model.addAttribute("category", category);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/products/productsList";
    }

    //AJAX를 이용한 상품 목록 가져오기
    @ResponseBody
    @RequestMapping(value = "getProducts/{page}", method = RequestMethod.GET)
    public ResponseEntity<Object> getProducts(@PathVariable("page") int page) {
        ResponseEntity<Object> out = null;
        Map<String, Object> result = new HashMap<String, Object>();
        ProductCriteria cri = new ProductCriteria();
        cri.setDisplayPages(service.getCount(cri));
        cri.setPage(page);

        try {
            List<ProductVO> prList = service.getProducts(cri);
            PageMaker pm = new PageMaker();
            pm.setCri(cri);
            pm.setTotalCount(service.getCount(cri));

            result.put("prList", prList);
            result.put("pm", pm);

            out = new ResponseEntity<Object>(result, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }

        return out;
    }

    //AJAX를 이용해 해당 카테고리의 상품을 불러오는 메소드
    @ResponseBody
    @RequestMapping(value = "getByCategory", method = RequestMethod.GET)
    public ResponseEntity<Object> getByCategory(String category) {
        ResponseEntity<Object> out = null;

        try {
            List<ProductVO> prList = service.getByCategory(category);

            out = new ResponseEntity<Object>(prList, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }

        return out;
    }

    //상품 정보 불러오기
	//후에 상품 상세 정보 페이지에서 이용됨
    @RequestMapping(value = "getProduct", method = RequestMethod.GET)
    public String getProduct(int idx, Model model, @ModelAttribute("cri") ProductCriteria cri, RedirectAttributes rttr) {

        ProductVO product = service.getProduct(idx);
        //주문조회에서 삭제된 상품이 요청되었을 때
        if(product == null) {
            rttr.addFlashAttribute("msg", "DELETED PRODUCT");
            return "redirect:/";
        }
        PageMaker pm = new PageMaker();
        pm.setCri(cri);
        pm.setTotalCount(service.getCount(cri));
        List<ProductVO> prList = service.getProducts(cri);
        List<ReviewVO> rvList = reviewService.getReviews(idx);
        CategoryVO category = service.getCategory(product.getCate_curr());

        model.addAttribute("prList", prList);
        model.addAttribute("pm", pm);
        model.addAttribute("product", product);
        model.addAttribute("category", category);
        model.addAttribute("rvList", rvList);

        return "/products/product";
    }

    //AJAX를 이용한 상품 정보 불러오기
    @Deprecated
    @RequestMapping(value = "getProductAjax", method = RequestMethod.POST)
    public ResponseEntity<Object> getProductAjax(int idx) {
        ResponseEntity<Object> out = null;
        ProductVO product = null;

        try {
            product = service.getProduct(idx);

            out = new ResponseEntity<Object>(product, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            out = new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }

        return out;
    }

    //AJAX를 이용해 1차 카테고리 정보를 가져오기
	//사이드바, 검색에 사용됨
    @ResponseBody
    @RequestMapping(value = "getCategories", method = RequestMethod.GET)
    public ResponseEntity<List<CategoryVO>> getCategories() {
        ResponseEntity<List<CategoryVO>> out = null;

        try {
            List<CategoryVO> categories = service.getCategories();

            out = new ResponseEntity<List<CategoryVO>>(categories, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
        }

        return out;
    }

	//AJAX를 이용해 2차 카테고리 정보를 가져오기
	//파라미터에 1차 카테고리 코드를 넣어 해당되는 자식 카테고리를 리스트 형태로 가져온다.
    @ResponseBody
    @RequestMapping(value = "/getChildCategories", method = RequestMethod.GET)
    public ResponseEntity<List<CategoryVO>> getChildCategories(String category) {
        ResponseEntity<List<CategoryVO>> out = null;

        try {
            List<CategoryVO> childCategories = service.getChildCategories(category);

            out = new ResponseEntity<>(childCategories, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        return out;
    }
    @RequestMapping(value = "/getPopProducts", method = RequestMethod.GET)
    public String getPopProducts(int count, ProductCriteria cri, Model model) {

        try {
            PageMaker pm = new PageMaker();
            pm.setCri(cri);
            pm.setTotalCount(service.getCount(cri));
            List<ProductVO> prList = service.getPopProducts(count, cri);

            model.addAttribute("prList", prList);
            model.addAttribute("pm",pm);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/products/productsList";
    }

}
