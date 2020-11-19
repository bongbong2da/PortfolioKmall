package com.kmall.controller;

import com.kmall.domain.MemberVO;
import com.kmall.domain.ReviewVO;
import com.kmall.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/review/*")
public class ReviewController {

    private static final Logger log = LoggerFactory.getLogger(ReviewController.class);

    @Autowired
    private ReviewService service;

    @GetMapping("getReviews")
    public ResponseEntity<List<ReviewVO>> getReviews(int idx) {
        ResponseEntity<List<ReviewVO>> out = null;

        try {
            List<ReviewVO> rvList = service.getReviews(idx);

            out = new ResponseEntity<>(rvList, HttpStatus.OK);
            return out;
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            return out;
        }
    }

    @PostMapping("getReviews")
    public ResponseEntity<List<ReviewVO>> getReviewsAjax(int idx) {
        ResponseEntity<List<ReviewVO>> out = null;

        try {
            List<ReviewVO> rvList = service.getReviews(idx);

            out = new ResponseEntity<>(rvList, HttpStatus.OK);
            return out;
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            return out;
        }
    }

    @GetMapping("getReview")
    public ResponseEntity<ReviewVO> getReview(int idx) {
        ResponseEntity<ReviewVO> out = null;

        try {
            ReviewVO review = service.getReview(idx);

            out = new ResponseEntity<>(review, HttpStatus.OK);
            return out;
        } catch (Exception e) {
            e.printStackTrace();

            out = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            return out;
        }
    }

    @PostMapping("insertReview")
    public String insertReview(ReviewVO review) {
        try {
            service.insertReview(review);
            return "OK";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }

    @GetMapping("isDuplicated")
    public String isDuplicated(HttpServletRequest request, int od_idx, int prdt_idx) {
        MemberVO user = (MemberVO)(request.getSession().getAttribute("user"));
        String uid = user.getMem_id();
        boolean result = service.isDuplicated(od_idx, prdt_idx, uid);
        if (result) {
            return "NO";
        } else {
            return "OK";
        }
    }

    @PostMapping("delete")
    public String deleteReview(@RequestParam("arr[]") int[] arr) {
        try {
            service.deleteReview(arr);
            return "OK";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }

}
