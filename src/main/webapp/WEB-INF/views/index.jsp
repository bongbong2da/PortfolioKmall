<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html style="height: auto">

<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
</head>

<body class="sidebar-mini layout-fixed">
<div class="wrapper">
    <jsp:include page="header.jsp"/>
    <jsp:include page="sidebar.jsp"/>
    <div class="content-wrapper">
        <div class="content p-5">
            <div class="card card-secondary p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">인기 상품</h2>
                </div>
                <div id="popProducts" class="card-body row inline-block">
                    <c:forEach items="${popList }" var="product" varStatus="i">
                        <div class="card text-center m-1 elevation-3" style="width: 12rem;">
                            <div class="card-header">
                                <h5 class="card-title font-weight-bold">${product.prdt_name } (${i.index + 1}위)</h5>
                            </div>
                            <c:if test="${product.prdt_img.equals('file.png')}">
                                <a href="/product/getProduct?idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/resources/images/file.png"></a>
                            </c:if>
                            <c:if test="${!product.prdt_img.equals('file.png')}">
                                <a href="/product/getProduct?idx=${product.prdt_idx }"><img class="card-img-top thumbnail" src="/upload/getThumbnail?src=${product.prdt_img }"></a>
                            </c:if>
                            <div class="card-body">
                                <p class="card-text">
                                <c:if test="${product.prdt_buyable == 'Y'.charAt(0) && product.prdt_stock > 0}">
                                    <del class="text-secondary">
                                        <fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
                                        원
                                    </del>
                                    <br>
                                    <span class="font-weight-bold">
                                            <fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
                                            원
                                    </span><br>
                                    <c:if test="${product.prdt_discnt != 0}">
                                    <span style="color:red;"><fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !</span></p>
                                    </c:if>
                                <br>
                                </c:if>
                                <c:if test="${product.prdt_buyable != 'Y'.charAt(0) || product.prdt_stock <= 0}">
                                    <del class="text-secondary">
                                        <fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
                                        원
                                    </del>
                                    <br>
                                    <del class="text-secondary">
                                        <fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
                                        원
                                    </del>
                                    <br>
                                    <c:if test="${product.prdt_discnt != 0}">
                                        <del>
                                            <fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !
                                        </del>
                                    </c:if><br>
                                    <p style="color: red;" class="font-weight-bold">품절 / 구매불가</p>
                                    <br>
                                </c:if>
                                <a href="/product/getProduct?idx=${product.prdt_idx }"
                                   class="btn-sm btn-outline-info">보러가기</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="card p-3 card-secondary elevation-4">
                <div class="card-header">
                    <h2 class="display-4">신상품</h2>
                </div>
                <div class="row card-body">
                    <c:forEach items="${newList }" var="product" varStatus="i">
                        <div class="card text-center m-1 elevation-3" style="width: 12rem;">
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
                                    <c:if test="${product.prdt_buyable == 'Y'.charAt(0) && product.prdt_stock > 0}">
                                    <del class="text-secondary">
                                        <fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
                                        원
                                    </del>
                                    <br>
                                    <span class="font-weight-bold">
                                            <fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
                                            원
                                    </span><br>
                                    <c:if test="${product.prdt_discnt != 0}">
                                    <span style="color:red;"><fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !</span></p>
                                </c:if>
                                <br>
                                </c:if>
                                <c:if test="${product.prdt_buyable != 'Y'.charAt(0) || product.prdt_stock <= 0}">
                                    <del class="text-secondary">
                                        <fmt:formatNumber value="${product.prdt_price}" type="pattern" pattern=",###"/>
                                        원
                                    </del>
                                    <br>
                                    <del class="text-secondary">
                                        <fmt:formatNumber value="${product.prdt_price - (product.prdt_price * product.prdt_discnt) }" type="pattern" pattern=",###"/>
                                        원
                                    </del>
                                    <br>
                                    <c:if test="${product.prdt_discnt != 0}">
                                        <del><fmt:formatNumber value="${product.prdt_discnt*100 }" type="pattern" pattern=",###"/>% Off !
                                        </del>
                                    </c:if><br>
                                    <p style="color: red;" class="font-weight-bold">품절 / 구매불가</p>
                                    <br>
                                </c:if>
                                <a href="/product/getProduct?idx=${product.prdt_idx }"
                                   class="btn-sm btn-outline-info">보러가기</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <script id="product" type="text/x-handlebars-template">
            {{#each .}}
            <div class="card text-center mb-3 elevation-3 m-1" style="width: 12rem;">
                <div class="card-header">
                    <h5 class="card-title font-weight-bold text-center">{{prdt_name}}</h5>
                </div>
                <a href="/product/getProduct?idx={{prdt_idx}}"><img
                        class="card-img-top thumbnail"
                        src="/upload/getThumbnail?src={{prdt_img}}"
                        alt="Card image cap"></a>
                <div class="card-body">
                    <p class="card-text">
                    <p>{{prdt_price }}원</p>
                    <a href="/product/getProduct?idx={{prdt_idx}}"
                       class="btn-sm btn-outline-info">보러가기</a>
                </div>
            </div>
            {{/each}}
        </script>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>

</html>