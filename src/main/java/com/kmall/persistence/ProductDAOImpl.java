package com.kmall.persistence;

import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kmall.domain.CategoryVO;
import com.kmall.domain.ProductCriteria;
import com.kmall.domain.ProductVO;


@Repository
public class ProductDAOImpl implements ProductDAO {

    private static final String MAPPER_PATH = "com.kmall.mapper.ProductMapper.";

    private static final Logger log = LoggerFactory.getLogger(ProductDAOImpl.class);

    @Autowired
    private SqlSession session;

    @Override
    public List<ProductVO> getProducts(ProductCriteria cri) {
        List<ProductVO> result = session.selectList(MAPPER_PATH + "getProducts", cri);
        return result;
    }

    @Override
    public ProductVO getProduct(int idx) {
        ProductVO product = session.selectOne(MAPPER_PATH + "getProduct", idx);
        return product;
    }

    @Override
    public void addProduct(ProductVO product) {
        session.insert(MAPPER_PATH + "register", product);
    }

    @Override
    public String getDetail(int idx) {
        String result = session.selectOne(MAPPER_PATH + "getDetail", idx);
        return result;
    }

    @Override
    public int getCount(ProductCriteria cri) {
        int result = session.selectOne(MAPPER_PATH + "getCount", cri);
        return result;
    }

    @Override
    public void deleteProduct(int idx) {
        session.delete(MAPPER_PATH + "delete", idx);
    }

    @Override
    public void editProduct(ProductVO product) {
        session.insert(MAPPER_PATH + "modify", product);
    }

    @Override
    public List<CategoryVO> getCategories() {
        return session.selectList(MAPPER_PATH + "getCategories");
    }

    @Override
    public List<CategoryVO> getChildCategories(String category) {
        return session.selectList(MAPPER_PATH + "getChildCategories", category);
    }

    @Override
    public CategoryVO getCategory(String cate_curr) {
        return session.selectOne(MAPPER_PATH + "getCategory", cate_curr);
    }

    @Override
    public List<ProductVO> getByCategory(String category) {
        return session.selectList(MAPPER_PATH + "getByCategory", category);
    }

    @Override
    public String getCategoryName(String category) {
        return session.selectOne(MAPPER_PATH + "getCategoryName", category);
    }

    @Override
    public List<ProductVO> getPopProducts(int count, ProductCriteria cri) {
        Map<String, Object> query = Maps.newHashMap();
        query.put("count", count);
        query.put("cri", cri);
        return session.selectList(MAPPER_PATH + "getPopProducts", query);
    }

    @Override
    public List<ProductVO> getNewProducts(int count) {
        return session.selectList(MAPPER_PATH + "getNewProducts", count);
    }

    @Override
    public void updateStock(ProductVO product) {
        session.update(MAPPER_PATH + "updateStock", product);
    }

    @Override
    public void addCategory(CategoryVO category) {
        session.insert(MAPPER_PATH + "addCategory", category);
    }

    @Override
    public void editCategoryName(CategoryVO category) {
        session.update(MAPPER_PATH + "editCategoryName", category);
    }

    @Override
    public void deleteCategory(String category) {
        session.delete(MAPPER_PATH + "deleteCategory", category);
    }

}
