<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
    <script src="/resources/js/admin/dashboard.js"></script>
</head>

<jsp:include page="adminHeader.jsp"/>
<jsp:include page="adminSidebar.jsp"/>
<body class="sidebar-mini layout-fixed">
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-5 elevation-4">
            <div class="card-header">
                <h2 class="display-4">대쉬 보드</h2>
            </div>
            <div class="w-100">
            <div style="width: 45%;" class="card m-2 float-left elevation-3">
                <div class="card-header">
                    <h2 class="display-6">주문 알림</h2>
                </div>
                <div class="card-body">
                    <div class="direct-chat-messages">
                        <c:forEach items="${sumList}" var="summary">
                            <div class="direct-chat-msg w-100">
                                <div class="direct-chat-infos clearfix">
                                    <span class="direct-chat-name">새로운 주문이 등록되었습니다.</span>
                                </div>
                                <img class="fas fa-circle direct-chat-img" src="/resources/images/file.png">
                                <div class="direct-chat-text">
                                    <a href="/order/getOrder?idx=${summary.od_idx}">${summary.od_date} :
                                        ${summary.mem_id}님이 ${summary.od_total_price}원을 주문하셨습니다.</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div style="width: 45%;" class="card m-2 w-50 elevation-3">
                <div class="card-header">
                    <h2 class="display-6">리뷰 알림</h2>
                </div>
                <div class="card-body">
                    <div class="direct-chat-messages">
                        <c:forEach items="${rvList}" var="review">
                            <div class="direct-chat-msg w-100">
                                <div class="direct-chat-infos clearfix">
                                    <span class="direct-chat-name">새로운 리뷰가 등록되었습니다.</span>
                                </div>
                                <img class="fas fa-circle direct-chat-img" src="/resources/images/file.png">
                                <div class="direct-chat-text">
                                    <a href="/product/getProduct?idx=${review.prdt_idx}">${review.review_regdate} :
                                        ${review.mem_id}님이 ${review.prdt_idx}번 상품에 리뷰를 남겼습니다.</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            </div>
            <div class="card m-1 elevation-3">
                <div class="card-body">
                    <canvas class="w-100" id="dailyTotal" height="300"></canvas>
                </div>
            </div>
            <div class="card-body row">
                <div class="card m-1 elevation-3">
                    <div class="card-body">
                        <canvas id="myChart" width="400" height="300"></canvas>
                    </div>
                </div>
                <div class="card m-1 elevation-3">
                    <div class="card-body">
                        <canvas id="myChart2" width="400" height="300"></canvas>
                    </div>
                </div>
                <div class="card m-1 elevation-3">
                    <div class="card-body">
                        <canvas id="myChart3" width="400" height="300"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp"/>
</body>

