	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<head>
		<title>KMALL</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content=""/>
<%--		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>--%>
		<script src="/resources/toastr/build/toastr.min.js"></script>
		<link rel="stylesheet" href="/resources/toastr/build/toastr.min.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Noto+Serif+KR&display=swap" rel="stylesheet">
		<script src="/resources/js/header.js"></script>
		<c:if test="${msg ne null}">
			<script>
				alert('${msg}');
			</script>
		</c:if>
		<style>
			* {
				font-family: "Nanum Gothic", serif;
			}

			#header {
				position: relative;
				background: #333 url(/resources/images/banner2.jpg) no-repeat center;
				background-size: cover;
			}

			#headerDetail {
				background-color: rgba(67, 67, 67, 0.4);
			}

		</style>
	</head>
	<div id="header" class="bg-dark clearfix p-4 main-header">
		<div id="logo" class="float-center">
			<i class="fas fa-bars" data-widget="pushmenu" data-enable-remember="true"></i>
		</div>
		<br><br><br>
		<form class="form-inline float-right" action="/admin/product/getProducts" method="get">
			<input class="form-control-xl m-2" name="keyword" type="text">
			<input class="form-control-xl m-2" name="category" type="hidden">
			<input type="submit" class="form-control-sm btn btn-outline-primary" id="search" value="검색">
		</form>
		<c:if test="${user != null}">
			<div style="letter-spacing: 5px" id="headerDetail" class="p-3 text-light text-left">
				<p id="nickname"></p>
				<a class="text-light" href="/member/memberDetail?uid=${user.mem_id }">마이페이지</a>
				<a class="text-light" href="/member/logout">로그아웃</a><br>
				<c:if test="${user.manager eq 'Y'.charAt(0)}">
					<a class="text-light" href="/admin/dashboard">관리자 페이지</a>
				</c:if>
			</div>
		</c:if>
	</div>
