	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE HTML>
	<html>
	<head>
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
		<script src="/resources/ckeditor4/ckeditor.js"></script>
		<script src="/resources/js/admin/product/edit.js"></script>
	</head>
	<jsp:include page="../adminHeader.jsp"/>
	<jsp:include page="../adminSidebar.jsp"/>
	<body class="sidebar-mini layout-fixed layout-footer-fixed">
	<div class="content-wrapper">
		<div class="content p-5">
			<div class="card p-3">
				<div class="card-header">
					<h2 class="display-4">상품 수정</h2>
				</div>
				<div class="card-body">
					<form id="form" action="/admin/product/edit" method="post">

						<input class="attach" type="hidden" name="prdt_img" value="${product.prdt_img }">
						<input type="hidden" name="prdt_idx" value="${product.prdt_idx }">
						카테고리<br>
						<select class="form-control" id="mCategories" required>
							<option>필수 선택</option>
						</select><br>
						<select class="form-control" id="mChildCategories" required>
							<option>선택하지 않음</option>
						</select><br>
						상품 이름<br>
						<input class="form-control" name="prdt_name" type="text" value="${product.prdt_name }" required><br>
						가격<br>
						<input class="form-control" name="prdt_price" type="number" value="${product.prdt_price }" required><br>
						할인율 (0.0 ~ 1)<br>
						<input class="form-control" name="prdt_discnt" type="text" value="${product.prdt_discnt }" required><br>
						제조사<br>
						<input class="form-control" name="prdt_company" type="text" value="${product.prdt_company }"
							   required><br>
						상품 설명<br><br>
						<textarea class="float-center" name="prdt_detail" id="editor1" rows="100"
								  cols="200">${product.prdt_detail }</textarea>
						<script type="text/javascript">
							CKEDITOR.replace('editor1', {
								filebrowserUploadUrl: '/upload/ckAjax',
							});
						</script>
						대표 이미지<br>
						<input id="img" class="form-control" type="file"><br>
						<div id="imgBox" class="">
							<c:if test="${product.prdt_img.equals('file.png')}">
								<img class="thumbnail" src="/resources/images/file.png">
							</c:if>
							<c:if test="${!product.prdt_img.equals('file.png')}">
								<img class="thumbnail" src="/upload/getThumbnail?src=${product.prdt_img }">
							</c:if>
						</div>
						재고<br>
						<input class="form-control" type="number" name="prdt_stock" id="" value="${product.prdt_stock }"
							   required><br>
						<input class="form-control btn btn-primary" type="submit" value="수정">
					</form>
				</div>
			</div>
		</div>
	</div>
	</body>


	<jsp:include page="../../footer.jsp"/>