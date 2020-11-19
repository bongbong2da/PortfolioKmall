package com.kmall.persistence;

import com.google.common.collect.Maps;
import com.kmall.domain.ReviewVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    private static final String MAPPER_PATH = "com.kmall.mapper.ReviewMapper.";

    @Autowired
    private SqlSession session;

    @Override
    public List<ReviewVO> getReviews(int idx) {
        return session.selectList(MAPPER_PATH + "getReviews", idx);
    }

    @Override
    public List<ReviewVO> getAllReviews() {
        return session.selectList(MAPPER_PATH + "getAllReviews");
    }

    @Override
    public ReviewVO getReview(int idx) {
        return session.selectOne(MAPPER_PATH + "getReview", idx);
    }

    @Override
    public void insertReview(ReviewVO review) {
        session.insert(MAPPER_PATH + "insertReview", review);
    }

    @Override
    public ReviewVO isDuplicated(int od_idx, int prdt_idx, String uid) {
        Map<String, Object> query = Maps.newHashMap();

        query.put("od_idx", od_idx);
        query.put("prdt_idx", prdt_idx);
        query.put("uid", uid);

        return session.selectOne(MAPPER_PATH + "isDuplicated", query);
    }

    @Override
    public void deleteReview(int[] arr) {
        Map<String, Object> query = Maps.newHashMap();
        query.put("arr", arr);
        session.delete(MAPPER_PATH + "deleteReview", query);
    }

    @Override
    public List<ReviewVO> getReviewsById(String uid) {
        return session.selectList(MAPPER_PATH + "getReviewsById", uid);
    }

    @Override
    public List<ReviewVO> getRecentReviews() {
        return session.selectList(MAPPER_PATH + "getRecentReviews");
    }
}
