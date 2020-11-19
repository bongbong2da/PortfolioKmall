<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <script src="/resources/js/admin/product/stock.js"></script>
</head>
<jsp:include page="../adminHeader.jsp"/>
<jsp:include page="../adminSidebar.jsp"/>
<body class="sidebar-mini layout-fixed">
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">재고 관리</h2>
            </div>
            <div class="card-body">
                <form id="adSearch" action="/admin/product/stock" method="get">
                    <select class="form-control" id="categories" name="">
                        <option value="">선택하지 않음</option>
                    </select><br>
                    <select class="form-control" id="childCategories" name="">
                        <option value="">선택하지 않음</option>
                    </select><br>
                    <input type="text" name="keyword">
                    <button class="btn btn-primary">검색</button>
                </form>
                <table class="table-sm w-100 table-hover">
                    <tr>
                        <th>상품 이름</th>
                        <th>이미지</th>
                        <th>가격</th>
                        <th>기능</th>
                    </tr>
                    <c:forEach items="${prList }" var="product">
                        <tr class="product">
                            <th>
                                <h5 class="card-title font-weight-bold">${product.prdt_name }</h5>
                            </th>
                            <th>
                                <c:if test="${product.prdt_img.equals('file.png')}">
                                    <a href="/product/getProduct?idx=${product.prdt_idx }"><img style="width: 6rem;" class="card-img-top thumbnail" src="/resources/images/file.png"></a>
                                </c:if>
                                <c:if test="${!product.prdt_img.equals('file.png')}">
                                    <a href="/product/getProduct?idx=${product.prdt_idx }"><img style="width: 6rem;" class="card-img-top thumbnail" src="/upload/getThumbnail?src=${product.prdt_img }"></a>
                                </c:if>
                            </th>
                            <th>
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
                            </th>
                            <th>
                                <form class="update" action="/admin/product/stock" method="post">
                                    <input type="hidden" name="prdt_idx" value="${product.prdt_idx}">
                                    <table class="table text-center">
                                        <tr>
                                            <td>
                                                <input class="form-control-sm" type="number" name="prdt_stock" value="${product.prdt_stock}">
                                                <br><br>
                                            </td>
                                            <td>
                                                구매 가능 여부
                                                <br>
                                                <input class="form-control-sm" type="checkbox" name="prdt_buyable"<c:out value="${product.prdt_buyable == 'Y'.charAt(0) ? 'checked' : ''}"/>>
                                            </td>
                                            <td>
                                                <button class="btn btn-primary">변경</button>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
<%--                                <a href="/product/getProduct?idx=${product.prdt_idx }">--%>
<%--                                    <button class="btn-sm btn-outline-secondary">보기</button>--%>
<%--                                </a>--%>
<%--                                <a href="/admin/product/edit?idx=${product.prdt_idx }">--%>
<%--                                    <button class="btn-sm btn-outline-warning">수정</button>--%>
<%--                                </a>--%>
<%--                                <button class="btn-sm btn-outline-danger delBtn" name="${product.prdt_idx}">삭제</button>--%>
                            </th>

                        </tr>
                    </c:forEach>
                </table>
            </div>
            <ul class="pagination float-center" id="pages">
                <c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="pageNum" varStatus="">
                    <c:if test="${pageNum == pm.cri.page }">
                        <li class="page-item active"><a class="page-link page" href="/admin/getProduct?${pm.makeProductSearch(pageNum) }" name="${pageNum }">${pageNum }</a></li>
                    </c:if>
                    <c:if test="${pageNum != pm.cri.page }">
                        <li class="page-item">
                            <a class="page-link page" href="/admin/product/stock${pm.makeProductSearch(pageNum) }" name="${pageNum }">${pageNum }</a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
            <br>
        </div>
    </div>
</div>
</div>
<jsp:include page="../../footer.jsp"/>
</body>

