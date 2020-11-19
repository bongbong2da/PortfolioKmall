package com.kmall.persistence;

import java.util.List;

import com.kmall.domain.CategoryVO;
import com.kmall.domain.ProductCriteria;
import com.kmall.domain.ProductVO;

public interface ProductDAO {
	
	public List<ProductVO> getProducts(ProductCriteria cri);
	
	public ProductVO getProduct(int idx);
	
	public void addProduct(ProductVO product);
	
	public String getDetail(int idx);
	
	public int getCount(ProductCriteria cri);
	
	public void deleteProduct(int idx);
	
	public void editProduct(ProductVO product);
	
	public List<CategoryVO> getCategories();

	public List<CategoryVO> getChildCategories(String category);

	public CategoryVO getCategory(String cate_curr);

	public void addCategory(CategoryVO category);

	public void editCategoryName(CategoryVO category);

	public void deleteCategory(String category);

	public List<ProductVO> getByCategory(String category);

	public String getCategoryName (String category);
	
	public List<ProductVO> getPopProducts(int count, ProductCriteria cri);
	
	public List<ProductVO> getNewProducts(int count);

	public void updateStock(ProductVO product);

}
