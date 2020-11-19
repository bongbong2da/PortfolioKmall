package com.kmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kmall.domain.CategoryVO;
import com.kmall.domain.ProductCriteria;
import com.kmall.domain.ProductVO;
import com.kmall.persistence.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO dao;

    @Override
    public List<ProductVO> getProducts(ProductCriteria cri) {
        List<ProductVO> result = dao.getProducts(cri);
        return result;
    }

    @Override
    public ProductVO getProduct(int idx) {
        ProductVO product = dao.getProduct(idx);
        String clob = dao.getDetail(idx);

        return product;
    }

    @Override
    public void addProduct(ProductVO product) {
        dao.addProduct(product);
    }

    @Override
    public void deleteProduct(int idx) {
        dao.deleteProduct(idx);
    }

    @Override
    public void editProduct(ProductVO product) {
        dao.editProduct(product);
    }

    @Override
    public List<CategoryVO> getCategories() {
        return dao.getCategories();
    }

    @Override
    public List<CategoryVO> getChildCategories(String category) {
        return dao.getChildCategories(category);
    }

    @Override
    public CategoryVO getCategory(String cate_curr) {
        return dao.getCategory(cate_curr);
    }

    @Override
    public void addCategory(CategoryVO category) {
        dao.addCategory(category);
    }

    @Override
    public void editCategoryName(CategoryVO category) {
        dao.editCategoryName(category);
    }

    @Override
    public String deleteCategory(String category) {

        List<CategoryVO> categoryTemp = dao.getChildCategories(category);
        List<ProductVO> productTemp = dao.getByCategory(category);

        if (categoryTemp.size() == 0 && productTemp.size() == 0) {
            dao.deleteCategory(category);
            return "OK";
        } else if (categoryTemp.size() != 0) return "CHILD CATEGORY EXISTS";
        else if (productTemp.size() != 0) return "PRODUCT EXISTS";
        else return "BOTH EXISTS";
    }

    @Override
    public List<ProductVO> getByCategory(String category) {
        return dao.getByCategory(category);
    }

    @Override
    public String getCategoryName(String category) {
        return dao.getCategoryName(category);
    }

    @Override
    public int getCount(ProductCriteria cri) {
        return dao.getCount(cri);
    }

    @Override
    public List<ProductVO> getPopProducts(int count, ProductCriteria cri) {
        return dao.getPopProducts(count, cri);
    }

    @Override
    public List<ProductVO> getNewProducts(int count) {
        return dao.getNewProducts(count);
    }

    @Override
    public void updateStock(ProductVO product) {
        dao.updateStock(product);
    }

}
