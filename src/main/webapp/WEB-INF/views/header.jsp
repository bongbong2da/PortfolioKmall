	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<head>
		<title>KMALL</title>
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content=""/>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Noto+Serif+KR&display=swap"
			  rel="stylesheet">
		<script src="/resources/toastr/toastr.js"></script>
		<link rel="stylesheet" href="/resources/toastr/build/toastr.min.css">
		<script src="/resources/js/header.js"></script>
		<c:if test="${!(msg == null)}">
			<script>
				var msg = '${msg}';
				new_msg = decodeURI(decodeURIComponent(msg));
				alert(new_msg);
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

			.carousel-item {
				height: 300px;
				position: relative;
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
		<form class="form-inline float-right" action="/product/getProducts" method="get">
			<input class="form-control-xl m-2" name="keyword" type="text">
			<input type="submit" class="form-control-sm btn btn-outline-primary" id="search" value="검색">
		</form>
		<c:if test="${user == null}">
			<div id="headerDetail"  class="p-3 text-light text-left">
				<p>로그인하세요</p>
					<%--					<a href="/member/loginForm"><button class="btn btn-sm btn-primary">로그인</button></a>--%>
				<a id="popLogin" href="#">
					<button class="btn btn-sm btn-primary">로그인</button>
				</a>
				<a href="/member/signUp">
					<button class="btn btn-sm btn-info">회원가입</button>
				</a>
			</div>
		</c:if>
		<c:if test="${user != null}">
			<script>
				$(function () {
					$.ajax({
						type: "get",
						url: "/cart/getCount",
						data: {uid: '${user.mem_id}'},
						success: function (data) {
							$("#cartCount").text(data);
						}
					});
				});
			</script>
			<div style="letter-spacing: 5px" id="headerDetail" class="p-3 text-light text-left">
				<p id="nickname"></p>
				<a class="text-light" href="/cart/list">장바구니(<span id="cartCount"></span>)</a>
				<a class="text-light" href="/order/getSummaryList">배송조회</a>
				<a class="text-light" href="/member/memberDetail?uid=${user.mem_id }">내 정보</a>
				<a class="text-light" href="/member/logout">로그아웃</a><br>
				<c:if test="${user.manager eq 'Y'.charAt(0)}">
					<a class="text-light" href="/admin/dashboard">관리자 페이지</a>
				</c:if>
			</div>
		</c:if>
		<div id="caro" class="carousel slide rounded" data-ride="carousel" data-interval="3000">
			<ol class="carousel-indicators">
				<li data-target="#caro" data-slide-to="0" class="active"></li>
				<li data-target="#caro" data-slide-to="1"></li>
				<li data-target="#caro" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item mw-100 active">
					<a href="#">
						<img class="d-block mw-100" src="/resources/images/banner.jpg" alt="">
						<div class="carousel-caption">
							<h2>K-Mall GRAND OPEN !!!</h2>
							<p>K-mall에 오신것을 환영합니다.</p>
						</div>
					</a>
				</div>
				<div class="carousel-item mw-100">
					<a href="#">
						<img class="d-block mw-100" src="/resources/images/banner.jpg" alt="">
						<div class="carousel-caption">
							<h2>test 2..</h2>
						</div>
					</a>
				</div>
				<div class="carousel-item mw-100">
					<a href="#">
						<img class="d-block mw-100" src="/resources/images/memberBanner.jpg" alt="">
						<div class="carousel-caption">
							<h2>test 3..</h2>
						</div>
					</a>
				</div>
			</div>
			<a class="carousel-control-prev" href="#caro" role="button" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next" href="#caro" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>
