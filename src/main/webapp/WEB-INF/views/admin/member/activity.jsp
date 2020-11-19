	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<!DOCTYPE HTML>
	<html>
	<head>
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
		<script src="/resources/js/admin/member/activity.js"></script>
		<style>
			.board, .review {
				cursor: pointer;
			}
		</style>
	</head>
	<jsp:include page="../adminHeader.jsp"/>
	<jsp:include page="../adminSidebar.jsp"/>
	<body class="sidebar-mini layout-fixed">
	<div class="content-wrapper">
		<div class="content p-5">
			<div class="card p-3 elevation-4">
				<div class="card-header">
					<h2 class="display-4">주문 내역</h2>
				</div>
				<div class="card-body">
					<table class="w-100 table-sm table-striped">
						<tr>
							<th>주문번호</th>
							<th>아이디</th>
							<th>주문일시</th>
							<th>총 주문금액</th>
							<th>운송장 번호</th>
							<th>배송 상태</th>
							<th>사용 포인트</th>
							<th>기능</th>
						</tr>
						<c:if test="${sumList.size() == 0}">
							<tr>
								<th class="text-center" colspan="6"><h2 class="display-5">표시할 주문 내역이 없습니다.</h2></th>
							</tr>
						</c:if>
						<c:forEach items="${sumList}" var="summary">
							<div>
								<tr class="summary">
									<th>${summary.od_idx}</th>
									<th>${summary.mem_id}</th>
									<th><a href="/order/getOrder?idx=${summary.od_idx}">${summary.od_date}</a></th>
									<th>
										<fmt:formatNumber value="${summary.od_total_price}" type="pattern" pattern=",###"/>
										원
									</th>
									<th>${summary.od_shipping_num}</th>
									<th>${summary.od_shipping_stat}</th>
									<th>${summary.od_use_point}</th>
									<th>
										<button class="btn btn-outline-secondary open" data-idx="${summary.od_idx}">펼치기</button>
									</th>
								<tr class="p-5 update" id="update${summary.od_idx}" style="display: none;">
									<td colspan="9">
										<form action="/admin/order/updateSummary" method="post">
											<input type="hidden" name="od_idx" value="${summary.od_idx}">
											<table class="table">
												<tr>
													<th>주문 번호</th>
													<th><a href="/order/getOrder?idx=${summary.od_idx}">${summary.od_idx}</a></th>
												</tr>
												<tr>
													<th>주문 아이디</th>
													<th>${summary.mem_id}</th>
												</tr>
												<tr>
													<th>주문 일시</th>
													<th>${summary.od_date}</th>
												</tr>
												<tr>
													<th>주문 금액</th>
													<th>
														<fmt:formatNumber value="${summary.od_total_price}" type="pattern" pattern=",###"/>
														원
													</th>
												</tr>
												<tr>
													<th>운송장 번호</th>
													<th>
														<input class="form-control-sm" type="text" name="od_shipping_num" value="${summary.od_shipping_num}">
													</th>
												</tr>
												<tr>
													<th>배송 상태</th>
													<th>
														<select class="form-control-sm" name="od_shipping_stat">
															<option value="배송 준비중" <c:out value="${summary.od_shipping_stat eq '배송 준비중' ? 'selected' : ''}"/>>배송 준비중</option>
															<option value="배송중" <c:out value="${summary.od_shipping_stat eq '배송중' ? 'selected' : ''}"/>>배송중</option>
															<option value="배송완료" <c:out value="${summary.od_shipping_stat eq '배송완료' ? 'selected' : ''}"/>>배송완료</option>
															<option value="주문 취소" <c:out value="${summary.od_shipping_stat eq '주문 취소' ? 'selected' : ''}"/>>주문 취소</option>
														</select>
													</th>
												</tr>
												<tr>
													<th>사용된 포인트</th>
													<th>${summary.od_use_point}</th>
												</tr>
												<tr>
													<th>기능</th>
													<th>
														<button class="btn btn-primary">수정하기</button>
													</th>
												</tr>
											</table>
										</form>
									</td>
								</tr>
								</tr>

							</div>
						</c:forEach>
					</table>
					<hr>
				</div>
			</div>
			<div class="card p-3 elevation-4">
				<div class="card-body">
					<h2 class="display-4">작성한 리뷰</h2>
					<table class="table-sm w-100 table-striped">
						<tr>
							<th>리뷰 번호</th>
							<th>제품 번호</th>
							<th>작성자</th>
<%--							<th>내용</th>--%>
							<th>이미지</th>
							<th>평가</th>
							<th>작성일</th>
							<th>기능</th>
						</tr>
						<c:forEach items="${rvList}" var="review">
							<tr class="review" data-idx="${review.review_idx}">
								<td>${review.review_idx}</td>
								<td>${review.prdt_idx}</td>
								<td>
									${review.mem_id}
								</td>
								<td>
									<a href="/upload/getImage?src=${review.review_img}">
										<c:if test="${review.review_img ne null}">
											<img style="width: 3rem;" src="/upload/getThumbnail?src=${review.review_img}" alt="">
										</c:if>
									</a>
								</td>
								<td>${review.review_rating}</td>
								<td>${review.review_regdate}</td>
							</tr>
							<tr id="review-content${review.review_idx}" class="p-3 text-center" style="display: none;">
								<td colspan="6">
									<c:if test="${review.review_img ne null}">
										<img src="/upload/getImage?src=${review.review_img}" alt=""><br>
									</c:if>
										${(review.review_content)}
								</td>
								<td>
									<a href="/products/getProduct?idx=${review.prdt_idx}"><button class="btn-sm btn-info">상품 보기</button></a>
									<a href="/admin/member/edit?uid=${review.mem_id}"><button class="btn-sm btn-warning">회원 조회</button></a>
									<a href="#"><button class="btn-sm btn-danger">삭제</button></a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>

			<div class="card p-3 elevation-4">
				<div class="card-body">
					<h2 class="display-4">작성한 게시물</h2>
					<table class="table-sm table-striped table-hover w-100">
						<caption></caption>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th>기능</th>
						</tr>
						<c:forEach items="${boardList}" var="board">
							<tr class="board" data-idx="${board.board_idx}">
								<td>${board.board_idx}</td>
								<td>${board.board_title}</td>
								<td>${board.mem_id}</td>
								<td>${board.board_regdate}</td>
								<td></td>
							</tr>
							<tr class="board-content p-3 bg-light" id="content${board.board_idx}" style="display: none;">
								<td class="" colspan="4">
									작성자 : ${board.mem_id}
									<br>
									제목 : ${board.board_title}
									<br>
									작성일 : ${board.board_regdate}
									<br>
									내용 : ${board.board_content}
									<br>
								</td>
								<td>
									<button class="btn-sm btn-danger board-delete" data-idx="${board.board_idx}">삭제</button>
									<a href="/admin/member/edit?uid=${board.mem_id}">
										<button class="btn-sm btn-info board-writer" data-id="${board.mem_id}">작성자 보기</button>
									</a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>

		</div>
	</div>
	</div>
	<jsp:include page="../../footer.jsp"/>
	</body>


