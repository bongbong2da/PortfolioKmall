<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <title>관리자 / 게시판 관리</title>
    <meta content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/resources/jqGrid/css/ui.jqgrid.css">
    <link rel="stylesheet" href="/resources/jQuery/css/jquery-ui.css">
    <link rel="stylesheet" href="/resources/jQuery/css/jquery-ui.theme.css">
    <link rel="stylesheet" href="/resources/jqGrid/plugins/css/ui.multiselect.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script>
        $(function () {
            jQuery.noConflict();
        });
    </script>
    <script src="/resources/jqGrid/js/i18n/grid.locale-kr.js"></script>
    <script src="/resources/jqGrid/js/jquery.jqgrid.min.js"></script>
    <script src="/resources/js/admin/grid/grid.js"></script>
</head>
<jsp:include page="../adminHeader.jsp"/>
<jsp:include page="../adminSidebar.jsp"/>
<body class="sidebar-mini layout-fixed">
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-3">
            <div class="card-body">
                <table id="productList"></table>
                <table id="memberList"></table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../footer.jsp"/>
</body>
