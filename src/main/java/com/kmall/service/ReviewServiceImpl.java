package com.kmall.service;

import com.kmall.domain.ReviewVO;
import com.kmall.persistence.ReviewDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDAO dao;

    @Override
    public List<ReviewVO> getReviews(int idx) {
        return dao.getReviews(idx);
    }

    @Override
    public List<ReviewVO> getAllReviews() {
        return dao.getAllReviews();
    }

    @Override
    public ReviewVO getReview(int idx) {
        return dao.getReview(idx);
    }

    @Override
    public void insertReview(ReviewVO review) {
        dao.insertReview(review);
    }

    @Override
    public boolean isDuplicated(int od_idx, int prdt_idx, String uid) {
        ReviewVO review = dao.isDuplicated(od_idx, prdt_idx, uid);
        return review == null ? false : true;
    }

    @Override
    public void deleteReview(int[] arr) {
        dao.deleteReview(arr);
    }

    @Override
    public List<ReviewVO> getReviewsById(String uid) {
        return dao.getReviewsById(uid);
    }

    @Override
    public List<ReviewVO> getRecentReviews() {
        return dao.getRecentReviews();
    }
}
