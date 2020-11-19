	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!DOCTYPE HTML>
	<html>
	<head>
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
		<script src="/resources/js/admin/product/category.js"></script>
	</head>
	<jsp:include page="../adminHeader.jsp"/>
	<jsp:include page="../adminSidebar.jsp"/>
	<body class="sidebar-mini layout-fixed">

	<div id="editCategoryModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">카테고리 이름 변경</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="modalForm" action="/admin/category/editName" method="get">
						<label>카테고리 코드 : </label>
						<input id="modal-cate-curr" name="cate_curr" type="text" readonly><br>
						<label>카테고리 이름 : </label>
						<input id="modal-cate-name" name="cate_name" type="text">
					</form>
				</div>
				<div class="modal-footer">
					<button id="modalSubmit" type="button" class="btn btn-primary">Save changes</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="content-wrapper">
		<div class="content p-5">
			<div class="card p-3 elevation-4">
				<div class="card-header">
					<h2 class="display-4">카테고리 관리</h2>
					<samll>더블 클릭시 이름을 수정할 수 있습니다.</samll>
				</div>
				<div class="card-body">
					<table class="table table-sm">
						<tr>
							<td>
								<h2 class="display-5">1차 카테고리</h2>
								<select class="form-control" name="" id="categories" multiple>

								</select>
								<table>
									<tr>
										<th>
											<label for="cate_curr">카테고리 코드</label>
										</th>
										<td>
											<input class="form-control-sm" type="number"min="1000" max="9000" step="1000" name="cate_curr" id="cate_curr" value="1000">
										</td>
									</tr>
									<tr>
										<td>
											<label for="cate_name">카테고리 이름</label>
										</td>
										<td>
											<input class="form-control-sm" type="text" name="cate_name" id="cate_name">
										</td>
										<td>
											<button id="addCategory" class="btn btn-sm btn-primary">추가</button>
											<button class="btn-sm btn-danger" id="deleteCategory">선택 삭제</button>
										</td>
									</tr>
								</table>

							</td>
							<td>
								<h2 class="display-5">2차 카테고리</h2>
								<select class="form-control" name="" id="childCategories" multiple>
								</select>
								<table>
									<tr>
										<th>
											<label for="child_cate_curr">카테고리 코드</label>
										</th>
										<td>
											<input class="form-control-sm" type="number" min="100" step="100" max="900" name="cate_curr" id="child_cate_curr" value="100">
										</td>
									</tr>
									<tr>
										<th>
											<label for="child_cate_prnt">상위 카테고리 코드</label>
										</th>
										<td>
											<input class="form-control-sm" type="number" step="1000" name="cate_curr" id="child_cate_prnt" readonly>
										</td>
									</tr>
									<tr>
										<th>
											<label for="child_cate_name">카테고리 이름</label>
										</th>
										<td>
											<input class="form-control-sm" type="text" name="cate_name" id="child_cate_name">
										</td>
										<td>
											<button id="addChildCategory" class="btn btn-sm btn-primary">추가</button>
											<button class="btn-sm btn-danger" id="deleteChildCategory">선택 삭제</button>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	</body>

	<jsp:include page="../../footer.jsp"/>