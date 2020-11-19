package com.kmall.persistence;

import com.kmall.domain.ReviewVO;

import java.util.List;

public interface ReviewDAO {

    public List<ReviewVO> getReviews(int idx);

    public List<ReviewVO> getAllReviews();

    public ReviewVO getReview(int idx);

    public void insertReview(ReviewVO review);

    public ReviewVO isDuplicated(int od_idx, int prdt_idx, String uid);

    public void deleteReview(int[] arr);

    public List<ReviewVO> getReviewsById(String uid);

    public List<ReviewVO> getRecentReviews();

}
