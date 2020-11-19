	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!DOCTYPE HTML>
	<html>
	<head>
		<title>K-Mall / 상품 리스트</title>
		<script src="https://code.jquery.com/jquery-3.5.1.js?ver=1" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
	</head>

	<body class="sidebar-mini layout-fixed">
	<jsp:include page="../header.jsp"/>
	<jsp:include page="../sidebar.jsp"/>
	<div class="content-wrapper">
		<div class="content p-5">
			<div class="card p-1 elevation-4">
				<div class="card-body">
					<c:if test="${category ne null}">
						<p class="text-secondary">카테고리 : ${category.cate_name} (${pm.totalCount}개)</p>
					</c:if>
					<c:if test="${pm.cri.keyword.length() != 0}">
						<p class="text-secondary">"${pm.cri.keyword}"로 검색한 결과입니다. (${pm.totalCount}개)</p>
					</c:if>
				</div>
			</div>
			<c:if test="${pm.cri.page eq 1}">
				<div class="card p-3 elevation-4">
					<div class="card-header">
						<h2 class="display-4">인기 상품</h2>
					</div>
					<div id="popProducts" class="card-body row inline-block">
						<c:forEach items="${popList }" var="product" varStatus="i">
							<div class="card text-center m-1 elevation-3" style="width: 12rem;">
								<div class="card-header">
									<h5 class="card-title font-weight-bold">${product.prdt_name } (${i.index + 1}위)</h5>
								</div>
								<c:if test="${product.prdt_img.equals('file.png')}">
									<a href="/product/getProduct${pm.makeProductSearch(pm.cri.page)}&idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/resources/images/file.png"></a>
								</c:if>
								<c:if test="${!product.prdt_img.equals('file.png')}">
									<a href="/product/getProduct${pm.makeProductSearch(pm.cri.page)}&idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/upload/getThumbnail?src=${product.prdt_img }"></a>
								</c:if>
								<div class="card-body">
									<p class="card-text">
										<c:if test="${product.prdt_buyable == 'Y'.charAt(0) && product.prdt_stock > 0}">
										<del class="text-secondary">
											<fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
											원
										</del>
										<br>
										<span class="font-weight-bold">
                                            <fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
                                            원
                                    </span><br>
										<c:if test="${product.prdt_discnt != 0}">
										<span style="color:red;"><fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !</span></p>
									</c:if>
									<br>
									</c:if>
									<c:if test="${product.prdt_buyable != 'Y'.charAt(0) || product.prdt_stock <= 0}">
										<del class="text-secondary">
											<fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
											원
										</del>
										<br>
										<del class="text-secondary">
											<fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
											원
										</del>
										<br>
										<c:if test="${product.prdt_discnt != 0}">
											<del>
												<fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !
											</del>
										</c:if><br>
										<p style="color: red;" class="font-weight-bold">품절 / 구매불가</p>
										<br>
									</c:if>
									<a href="/product/getProduct${pm.makeProductSearch(pm.cri.page)}&idx=${product.prdt_idx }"
									   class="btn-sm btn-outline-info">보러가기</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>

			<div class="card p-3 elevation-4">
				<div class="card-header">
					<h2 id="categoryName" class="display-4">상품 목록</h2>
				</div>
				<div class="card-body row">
					<c:if test="${prList.size() == 0}">
						<h2 class="display-5">표시할 상품이 없습니다.</h2>
					</c:if>
					<c:forEach items="${prList }" var="product">
						<div class="card text-center m-1 elevation-3" style="width: 12rem;">
							<div class="card-header">
								<h5 class="card-title font-weight-bold">${product.prdt_name }</h5>
							</div>
							<c:if test="${product.prdt_img.equals('file.png')}">
								<a href="/product/getProduct${pm.makeProductSearch(pm.cri.page)}&idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/resources/images/file.png"></a>
							</c:if>
							<c:if test="${!product.prdt_img.equals('file.png')}">
								<a href="/product/getProduct${pm.makeProductSearch(pm.cri.page)}&idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/upload/getThumbnail?src=${product.prdt_img }"></a>
							</c:if>
							<div class="card-body">
								<p class="card-text">
								<c:if test="${product.prdt_buyable == 'Y'.charAt(0) && product.prdt_stock > 0}">
									<del class="text-secondary">
										<fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
										원
									</del>
									<br>
									<span class="font-weight-bold">
                                            <fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
                                            원
                                    </span><br>
									<c:if test="${product.prdt_discnt != 0}">
									<span style="color:red;"><fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !</span></p>
									</c:if>
								<br>
								</c:if>
								<c:if test="${product.prdt_stock <= 0 || product.prdt_buyable != 'Y'.charAt(0)}">
									<del class="text-secondary">
										<fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
										원
									</del>
									<br>
									<del class="text-secondary">
										<fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
										원
									</del>
									<br>
									<c:if test="${product.prdt_discnt != 0}">
										<del><fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !
										</del>
									</c:if><br>
									<p style="color: red;" class="font-weight-bold">품절 / 구매불가</p>
									<br>
								</c:if>
								<a href="/product/getProduct${pm.makeProductSearch(pm.cri.page)}&idx=${product.prdt_idx }"
								   class="btn-sm btn-outline-info">보러가기</a>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="text-center card-footer">
					<ul class="pagination float-center" id="pages">
						<c:if test="${pm.prev}">
							<li class="page-item">
								<a class="page-link page" href="/product/getProducts${pm.makeProductSearch(pm.cri.page-1) }" name="">Prev</a>
							</li>
						</c:if>
						<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="pageNum" varStatus="">
							<c:if test="${pageNum == pm.cri.page }">
								<li class="page-item active">
									<a class="page-link page" href="/product/getProducts${pm.makeProductSearch(pageNum) }" name="${pageNum }">${pageNum }</a>
								</li>
							</c:if>
							<c:if test="${pageNum != pm.cri.page }">
								<li class="page-item">
									<a class="page-link page" href="/product/getProducts${pm.makeProductSearch(pageNum) }" name="${pageNum }">${pageNum }</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${pm.next}">
							<li class="page-item">
								<a class="page-link page" href="/product/getProducts${pm.makeProductSearch(pm.cri.page+1) }" name="">
									Next
								</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
	</body>

