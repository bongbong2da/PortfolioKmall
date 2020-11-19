<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%--    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>--%>
    <link rel="stylesheet" href="/resources/al3/css/adminlte.css">
    <link rel="stylesheet" href="/resources/fa/css/all.css">
    <script src="/resources/al3/js/adminlte.js"></script>
</head>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="/" class="brand-link text-center"><h2 class="display-4 d-inline">K</h2><span
            class="brand-text">-mall</span></a>
    <div class="sidebar text-white">
        <div class="p-3 user-panel d-flex">
            <div class="image"></div>
            <div class="info">
                <a class="d-block" href="/member/checkSelf?ctx=edit">${user.mem_id}님</a>
            </div>
        </div>
        <nav class="mt-3">
            <ul class="nav nav-pills nav-sidebar flex-column" role="menu">
                <li class="nav-item">
                    <a class="nav-link text-light lead" href="/admin/dashboard">
                        <i class="far fa-circle nav-icon"></i>
                        <p>대쉬보드</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/admin/product/list" class="nav-link text-light lead">
                        <i class="fas fa-plus nav-icon"></i>
                        <p>상품 관리</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/admin/product/stock" class="nav-link text-light lead">
                        <i class="far fa-circle nav-icon"></i>
                        <p>재고 관리</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light lead" href="/admin/category">
                        <i class="fas fa-bars nav-icon"></i>
                        <p>카테고리 관리</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light lead" href="/admin/order/list">
                        <i class="fas fa-bars nav-icon"></i>
                        <p>주문 관리</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light lead" href="/admin/board/list">
                        <i class="fas fa-bars nav-icon"></i>
                        <p>게시판 관리</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light lead" href="/admin/review/list">
                        <i class="fas fa-bars nav-icon"></i>
                        <p>리뷰 관리</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light lead" href="/admin/member/list">
                        <i class="fas fa-user-friends nav-icon"></i>
                        <p>회원 관리</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light lead" href="/admin/grid/grid">
                        <i class="fas fa-circle nav-icon"></i>
                        <p>jQ그리드</p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</aside>