	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!DOCTYPE HTML>
	<html>
	<head>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
		<script src="/resources/js/product/product.js"></script>
		<script>
			$(function() {
				$("#addCart").click(function () {
					var prdt_idx = ${product.prdt_idx};
					var prdt_name = '${product.prdt_name}';
					var prdt_price = ${product.prdt_price};
					var prdt_discnt = ${product.prdt_discnt};
					var prdt_img = '${product.prdt_img}';
					var mem_id = '${sessionScope.user.mem_id}';
					var cart_amount = $("#amount").val();

					if (cart_amount > ${product.prdt_stock}) {
						alert("재고가 부족합니다.");
						alert("남은 재고 수 : ${product.prdt_stock}개");
						return;
					}

					$.ajax({
						type: "post",
						url: "/cart/addCart",
						data: {
							prdt_idx: prdt_idx,
							prdt_name: prdt_name,
							prdt_price: prdt_price,
							prdt_discnt: prdt_discnt,
							prdt_img: prdt_img,
							mem_id: mem_id,
							cart_amount: cart_amount
						},
						success: function (data) {
							var check = confirm('물품을 담았습니다.\n장바구니로 이동하시겠습니까?');

							if (check) {
								window.location.href = "/cart/list";
							} else {
								window.location.href = "/product/getProduct?idx=" + prdt_idx;
							}
						}
					});

				});
			});
		</script>
	</head>
	<jsp:include page="../header.jsp"/>
	<jsp:include page="../sidebar.jsp"/>
	<body class="sidebar-mini sidebar-collapse layout-fixed layout-footer-fixed">
	<div class="content-wrapper text-center bg-light p-5 rounded border">
		<div class="content">
			<input type="hidden" id="prdt_stock" val="${product.prdt_stock}">
			<div class="card elevation-4 p-3">
				<div class="card-header clearfix">
					<img style="width: 40%;" class="float-left rounded elevation-3" alt="${product.prdt_name }"
						 src="/upload/getImage?src=${product.prdt_img }">
					<div style="width: 60%;" class="float-right pt-5">
						<h2 class="display-4">${product.prdt_name }</h2>
						<p><a href="/product/getProducts?category=${category.cate_curr}">${category.cate_name}</a></p>
						<p>제조사 : ${product.prdt_company}</p>
						<h2 class="display-5">가격 :
							<fmt:formatNumber
									value="${product.prdt_price - (product.prdt_price * product.prdt_discnt)}"
									type="pattern"
									pattern=",###"
							/>원
							<c:if test="${product.prdt_discnt != 0}">
								(<fmt:formatNumber
									value="${product.prdt_discnt*100}"
									type="pattern"
									pattern=",###"
							/>
								% 할인 적용)
							</c:if>
						</h2>
						<c:if test="${!empty sessionScope.user }">
							<c:if test="${product.prdt_stock > 0 && product.prdt_buyable == 'Y'.charAt(0)}">
								<input id="amount" class="form-control-sm" type="number" value="1">
								<input id="addCart" class="btn btn-primary" type="button" value="장바구니 담기">
							</c:if>
							<c:if test="${product.prdt_stock <= 0 || product.prdt_buyable != 'Y'.charAt(0)}">
								품절
							</c:if>
						</c:if>
						<c:if test="${empty sessionScope.user }">
							<a href="/member/login">
								<button class="btn btn-primary">로그인 후 장바구니 담기</button>
							</a>
						</c:if>
					</div>
				</div>
				<div class="card-body">
					<h2 class="display-4">상세 정보</h2>
					${product.prdt_detail }
				</div>
				<div class="card-footer">
					<h2 class="display-4">상품평</h2>
					<table id="reviews" class="table table-sm table-hover">
						<tr>
							<th>번호</th>
							<th>점수</th>
							<th>내용</th>
							<th>이미지</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>기능</th>
						</tr>
						<c:if test="${rvList.size() == 0}">
							<tr>
								<th colspan="7">
									<h2 class="display-5">작성된 리뷰가 없습니다.</h2>
								</th>
							</tr>
						</c:if>
						<c:forEach items="${rvList}" var="review">
							<tr>
								<td>${review.review_idx}</td>
								<td>${review.review_rating}</td>
								<td>
									<a class="review" href="#" data-idx="${review.review_idx}">${review.review_content}</a>
								</td>
								<td>
									<c:if test="${review.review_img ne null}">
										<img style="width: 3rem;" src="/upload/getThumbnail?src=${review.review_img}" alt="">
									</c:if>
								</td>
								<td>${review.mem_id}</td>
								<input type="hidden" name="mem_id" value="mem_id">
								<td>${review.review_regdate}</td>
								<td>
									<c:if test="${review.mem_id.equals(user.mem_id)}">
										<button class="btn btn-danger deleteReview" data-mem_id="${review.mem_id}" data-review_idx="${review.review_idx}">삭제</button>
									</c:if>
								</td>
							</tr>
							<tr id="review-content${review.review_idx}" class="p-3" style="display: none;">
								<td colspan="7">
									<c:if test="${review.review_img ne null}">
										<img src="/upload/getImage?src=${review.review_img}" alt=""><br>
									</c:if>
										${review.review_content}
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>

		<!-- Criteria에 맞는 상품리스트 출력 -->
		<div class="card p-3 elevation-4">
			<div class="card-header">
				<c:if test="${category ne null}">
					<p class="text-secondary">카테고리 : ${category.cate_name} (${pm.totalCount}개)</p>
				</c:if>
				<c:if test="${pm.cri.keyword.length() != 0}">
					<p class="text-secondary">"${pm.cri.keyword}"로 검색한 결과입니다. (${pm.totalCount}개)</p>
				</c:if>
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
	<jsp:include page="../footer.jsp"/>
	</body>