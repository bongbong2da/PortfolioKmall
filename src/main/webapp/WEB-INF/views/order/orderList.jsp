    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE HTML>
    <html>
    <head>
        <script src="https://code.jquery.com/jquery-3.5.1.js"
                integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js"
                integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw=="
                crossorigin="anonymous"></script>
    </head>
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
    <body class="sidebar-mini layout-fixed">
    <div class="content-wrapper">
        <div class="content p-5">
            <div class="card p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">주문 내역 (총 ${pm.totalCount} 건)</h2>
                    <div class="w-100 text-right">
                        <a class="" href="/order/getSummaryList?page=1&displayPages=20" name="">20개씩 보기</a>
                        <a class="" href="/order/getSummaryList?page=1&displayPages=50" name="">50개씩 보기</a>
                    </div>
                </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <tr>
                            <th>주문번호</th>
                            <th>주문일시</th>
                            <th>총 주문금액</th>
                            <th>운송장 번호</th>
                            <th>배송 상태</th>
                            <th>사용 포인트</th>
                        </tr>
                        <c:if test="${sumList.size() == 0}">
                            <tr>
                                <th class="text-center" colspan="6"><h2 class="display-5">표시할 주문 내역이 없습니다.</h2></th>
                            </tr>
                        </c:if>
                        <c:forEach items="${sumList}" var="summary">
                            <tr>
                                <th>${summary.od_idx}</th>
                                <th><a href="/order/getOrder?idx=${summary.od_idx}">${summary.od_date}</a></th>
                                <th>
                                    <fmt:formatNumber value="${summary.od_total_price}" type="pattern" pattern=",###"/>
                                    원
                                </th>
                                <th>${summary.od_shipping_num}</th>
                                <th>${summary.od_shipping_stat}</th>
                                <th>${summary.od_use_point}</th>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
<%--                <c:if test="${pm.endPage ne 1}">--%>
                    <div class="card-footer">
                        <ul class="pagination float-center" id="pages">
                            <c:if test="${pm.prev}">
                                <li class="page-item">
                                    <a class="page-link page" href="/order/getSummaryList?page=${pm.cri.page-1}" name="">Prev</a>
                                </li>
                            </c:if>
                            <c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="pageNum" varStatus="">
                                <c:if test="${pageNum == pm.cri.page }">
                                    <li class="page-item active">
                                        <a class="page-link page" href="/order/getSummaryList${pm.makeBasicQuery(pageNum, pm.cri.displayPages)}" name="${pageNum }">${pageNum }</a>
                                    </li>
                                </c:if>
                                <c:if test="${pageNum != pm.cri.page }">
                                    <li class="page-item">
                                        <a class="page-link page" href="/order/getSummaryList${pm.makeBasicQuery(pageNum, pm.cri.displayPages)}">${pageNum }</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pm.next}">
                                <li class="page-item">
                                    <a class="page-link page" href="/order/getSummaryList?page=${pm.cri.page+1}" name="">
                                        Next
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
<%--                </c:if>--%>
            </div>

        </div>
    </div>
    <jsp:include page="../footer.jsp"/>
    </body>
