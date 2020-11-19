<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/al3/css/adminlte.css">
    <link rel="stylesheet" href="/resources/fa/css/all.css">
    <script src="/resources/al3/js/adminlte.js"></script>
    <script src="/resources/js/sidebar.js"></script>
</head>
<aside class="main-sidebar sidebar-light-dark elevation-4">
    <a href="http://localhost:8080/" class="brand-link text-center">
        <h2 class="display-4 d-inline">K</h2>
        <span class="brand-text">-mall</span>
    </a>
    <div class="sidebar text-white">
        <div class="p-3 user-panel d-flex">
            <div class="image"></div>
            <c:if test="${user != null}">
                <div class="info w-100 text-center text-dark">
                    <a class="font-weight-bold" href="/member/memberDetail?uid=${user.mem_id}">${user.mem_nickname}님</a>
                    <br>
                    <span>보유 포인트 : ${user.mem_point}</span>
                    <br>
                    <span>최근로그인 : ${user.mem_lastlogin}</span>
                </div>
            </c:if>
            <c:if test="${user == null}">
                <div class="info text-center">
                    <a id="popLoginSidebar" href="#">
                        로그인
                    </a>
                </div>
            </c:if>
        </div>
        <nav class="mt-3">
            <ul id="categories" class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu">
                <li class="nav-item">
                    <a class="nav-link lead" href="/board/list?page=1">
                        <i class="far fa-circle nav-icon"></i>
                        <p>게시판</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="category nav-link lead" href="/product/getProducts?page=1">
                        <i class="far fa-circle nav-icon"></i>
                        <p>All</p>
                    </a>
                </li>
                <li class="nav-item has-treeview">
                    <a href="/product/getProducts?page=1" class="nav-link">
                        <i class="far fa-circle nav-icon"></i>
                        <p>열기</p>
                        <i class="right fas fa-angle-left"></i>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a class="nav-link" href="/product/getPopProducts?page=1&count=8">
                                <p>BEST</p>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</aside>