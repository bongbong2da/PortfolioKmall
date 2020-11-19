<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <script src="/resources/js/admin/product/list.js"></script>
</head>
<jsp:include page="../adminHeader.jsp"/>
<jsp:include page="../adminSidebar.jsp"/>
<body class="sidebar-mini layout-fixed">
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-5 elevation-4">
            <div class="card-header">
                <h2 class="display-4">상품 관리</h2>
            </div>
            <div class="card-body">
                <table class="table">
                    <tr>
                        <td>
                            <form class="form-inline" id="adSearch" action="/admin/product/list" method="get">
                                <select class="form-control" id="categories" name="">
                                    <option value="">선택하지 않음</option>
                                </select><br>
                                <select class="form-control" id="childCategories" name="">
                                    <option value="">선택하지 않음</option>
                                </select><br>
                                <input class="form-control" type="text" name="keyword"><br>
                                <input class="form-control btn-sm btn-secondary" type="submit" value="검색">
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/admin/product/add" class="btn btn-primary">상품 등록</a>
                            <a href="/admin/category" class="btn btn-info">카테고리 관리</a>
                            <a href="/admin/product/stock" class="btn btn-warning">재고 관리</a>
                        </td>
                    </tr>
                </table>

                <br>
                <div id="products" class="row">
                    <c:forEach items="${prList }" var="product">
                        <div class="product">
                            <div class="card text-center mb-3 m-1 elevation-4" style="width: 12rem;">
                                <div class="card-header">
                                    <h5 class="card-title font-weight-bold">${product.prdt_name }</h5>
                                </div>
                                <c:if test="${product.prdt_img.equals('file.png')}">
                                    <a href="/product/getProduct?idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/resources/images/file.png"></a>
                                </c:if>
                                <c:if test="${!product.prdt_img.equals('file.png')}">
                                    <a href="/product/getProduct?idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/upload/getThumbnail?src=${product.prdt_img }"></a>
                                </c:if>
                                <div class="card-body">
                                    <p class="card-text">
                                        <span>정가 :
                                        <fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
                                        원</span>
                                        <br>
                                        <span>
                                        할인가 :
                                        <fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
                                        원
                                    </span><br>
                                        <span>할인율 : <fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>%</span>
                                    </p>
                                    <a href="/product/getProduct?idx=${product.prdt_idx }">
                                        <button class="btn-sm btn-outline-secondary">보기</button>
                                    </a>
                                    <a href="/admin/product/edit?idx=${product.prdt_idx }">
                                        <button class="btn-sm btn-outline-warning">수정</button>
                                    </a>
                                    <button class="btn-sm btn-outline-danger delBtn" name="${product.prdt_idx}">삭제</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="clearfix text-center">
                    <ul class="pagination float-center" id="pages">
                        <c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="pageNum" varStatus="">
                            <c:if test="${pageNum == pm.cri.page }">
                                <li class="page-item active"><a class="page-link page" href="/admin/product/list?${pm.makeProductSearch(pageNum) }" name="${pageNum }">${pageNum }</a></li>
                            </c:if>
                            <c:if test="${pageNum != pm.cri.page }">
                                <li class="page-item">
                                    <a class="page-link page" href="/admin/product/list${pm.makeProductSearch(pageNum) }" name="${pageNum }">${pageNum }</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <br>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../footer.jsp"/>
</body>

