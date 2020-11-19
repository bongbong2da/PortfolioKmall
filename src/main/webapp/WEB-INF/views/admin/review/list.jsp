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
    <script src="/resources/js/admin/review/list.js"></script>
</head>
<jsp:include page="../adminHeader.jsp"/>
<jsp:include page="../adminSidebar.jsp"/>
<body class="sidebar-mini layout-fixed">
<div class="content-wrapper">
    <div class="content p-5">

        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">리뷰 관리</h2>
            </div>
            <div class="card-body">
                <table class="table-sm w-100 table-striped">
                    <tr>
                        <th><input type="checkbox" name="" id="selectAll"></th>
                        <th>리뷰 번호</th>
                        <th>제품 번호</th>
                        <th>아이디</th>
                        <th>내용</th>
                        <th>이미지</th>
                        <th>평가</th>
                        <th>작성일</th>
                        <th>기능</th>
                    </tr>
                    <c:forEach items="${rvList}" var="review">
                        <tr>
                            <td><input class="select" type="checkbox" name="" id="" data-idx="${review.review_idx}"></td>
                            <td>${review.review_idx}</td>
                            <td><a href="/product/getProduct?idx=${review.prdt_idx}">${review.prdt_idx}</a></td>
                            <td>
                                <a href="/admin/member/edit?uid=${review.mem_id}">${review.mem_id}</a>
                            </td>
                            <td>
                                <a class="review" data-idx="${review.review_idx}" href="#">${fn:substring(review.review_content,0,10)}</a>
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
                            <td colspan="8">
                                <c:if test="${review.review_img ne null}">
                                    <img src="/upload/getImage?src=${review.review_img}" alt=""><br>
                                </c:if>
                             ${(review.review_content)}
                            </td>
                            <td>
                                <a class="deleteReview" href="#" data-idx="${review.review_idx}"><button class="btn-sm btn-danger">삭제</button></a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="card-footer">
                <button class="btn btn-danger" id="selectDelete"><i class="fas fa-trash-alt"></i></button>
            </div>
        </div>

    </div>
</div>
<jsp:include page="../../footer.jsp"/>
</body>
