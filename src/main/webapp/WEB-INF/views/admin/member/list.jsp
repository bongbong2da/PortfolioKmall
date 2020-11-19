	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!DOCTYPE HTML>
	<html>
	<head>
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
	</head>
	<jsp:include page="../adminHeader.jsp"/>
	<jsp:include page="../adminSidebar.jsp"/>
	<body class="sidebar-mini layout-fixed">
	<div class="content-wrapper">
		<div class="content p-5">
			<div class="card p-3 elevation-4">
				<div class="card-header">
					<h2 class="display-4">회원 관리</h2>
				</div>
				<div class="card-body">
					<table class="w-100 table-sm table-striped table-hover p-3">
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>닉네임</th>
							<th>번호</th>
							<th>포인트</th>
							<th>가입일</th>
							<th>접속일</th>
							<th>기능</th>
						</tr>
						<c:forEach items="${memList}" var="member">
						<tr>
							<td>${member.mem_id}</td>
							<td>${member.mem_name}</td>
							<td>${member.mem_nickname}</td>
							<td>${member.mem_tel}</td>
							<td>${member.mem_point}</td>
							<td>${member.mem_regdate}</td>
							<td>${member.mem_lastlogin}</td>
							<td>
								<a href="/admin/member/edit?uid=${member.mem_id}"><button class="btn-sm btn-info">조회 / 수정</button></a>
								<a href="/admin/member/activity?uid=${member.mem_id}"><button class="btn-sm btn-warning">활동 조회</button></a>
							</td>
						</tr>
						</c:forEach>
					</table>

				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../footer.jsp"/>
	</body>


