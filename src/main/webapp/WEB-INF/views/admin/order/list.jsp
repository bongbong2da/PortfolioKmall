<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <script src="/resources/js/admin/order/list.js"></script>
</head>
<jsp:include page="../adminHeader.jsp"/>
<jsp:include page="../adminSidebar.jsp"/>
<body class="sidebar-mini layout-fixed">
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">주문 관리</h2>
                <hr>
                <p>총 ${pm.totalCount}건</p><small>현재 페이지 내 ${sumList.size()}건</small>
                <div class="w-100 text-right">
                    <ul class="list-group list-group-horizontal justify-content-end">
                        <a class="list-group-item" href="/admin/order/list?page=1&displayPages=10">10개씩 보기</a>
                        <a class="list-group-item" href="/admin/order/list?page=1&displayPages=20">20개씩 보기</a>
                        <a class="list-group-item" href="/admin/order/list?page=1&displayPages=50">50개씩 보기</a>
                    </ul>
                    <form class="form-inline" action="/admin/order/list" method="get">
                        <select class="form-control-sm" name="searchType">
                            <option value="id" <c:out value="${pm.cri.searchType eq 'id' ? 'selected' : ''}"/>>아이디</option>
                            <option value="idx" <c:out value="${pm.cri.searchType eq 'idx' ? 'selected' : ''}"/>>주문번호</option>
                        </select>
                        <input class="form-control-sm" type="text" name="keyword" value="<c:out value="${pm.cri.searchType eq 'id' || pm.cri.searchType eq 'idx' ? pm.cri.keyword : ''}"/>">
                        <input class="btn btn-sm btn-primary" type="submit" value="검색">
                    </form>
                    <br>
                    <form class="form-inline" action="/admin/order/list">
                        <input type="hidden" name="searchType" value="stat">
                        <select class="form-control-sm" name="keyword">
                            <option value="배송 준비중" <c:out value="${pm.cri.keyword eq '배송 준비중' ? 'selected' : ''}"/>>배송 준비중</option>
                            <option value="배송중" <c:out value="${pm.cri.keyword eq '배송중' ? 'selected' : ''}"/>>배송중</option>
                            <option value="배송완료" <c:out value="${pm.cri.keyword eq '배송완료' ? 'selected' : ''}"/>>배송완료</option>
                            <option value="주문취소" <c:out value="${pm.cri.keyword eq '주문취소' ? 'selected' : ''}"/>>주문취소</option>
                        </select>
                        <input class="btn btn-sm btn-primary" type="submit" value="배송상태로 검색">
                    </form>
                    <br>
                    <form class="form-inline" action="#">
                        <input type="hidden" name="searchType" value="date">
                        <input class="form-control-sm" type="date" name="startDate" value="${pm.cri.startDate}">
                        ~
                        <input class="form-control-sm" type="date" name="endDate" value="${pm.cri.endDate}">
                        <input class="btn btn-sm btn-primary" type="submit" value="날짜로 검색">
                    </form>
                </div>
            </div>
            <div class="card-body">
                <table class="w-100 table-sm table-striped">
                    <tr>
                        <th><input type="checkbox" name="" id="selectAll"></th>
                        <th>주문번호</th>
                        <th>아이디</th>
                        <th>주문일시</th>
                        <th>총 주문금액</th>
                        <th>운송장 번호</th>
                        <th>배송 상태</th>
                        <th>사용 포인트</th>
                        <th>기능</th>
                    </tr>
                    <c:if test="${sumList.size() == 0}">
                        <tr>
                            <th class="text-center" colspan="6"><h2 class="display-5">표시할 주문 내역이 없습니다.</h2></th>
                        </tr>
                    </c:if>
                    <c:forEach items="${sumList}" var="summary">
                        <div>
                            <tr class="summary">
                                <th>
                                    <input type="checkbox" class="select" name="idx[${summary.od_idx}]" value="${summary.od_idx}">
                                </th>
                                <th>${summary.od_idx}</th>
                                <th>${summary.mem_id}</th>
                                <th><a href="/order/getOrder?idx=${summary.od_idx}">${summary.od_date}</a></th>
                                <th>
                                    <fmt:formatNumber value="${summary.od_total_price}" type="pattern" pattern=",###"/>
                                    원
                                </th>
                                <th>${summary.od_shipping_num}</th>
                                <th>${summary.od_shipping_stat}</th>
                                <th>${summary.od_use_point}</th>
                                <th>
                                    <button class="btn btn-outline-secondary open" data-idx="${summary.od_idx}">펼치기</button>
                                </th>
                            <tr class="p-5 update" id="update${summary.od_idx}" style="display: none;">
                                <td colspan="9">
                                    <form action="/admin/order/updateSummary" method="post">
                                        <input type="hidden" name="od_idx" value="${summary.od_idx}">
                                        <table class="table">
                                            <tr>
                                                <th>주문 번호</th>
                                                <th><a href="/order/getOrder?idx=${summary.od_idx}">${summary.od_idx}</a></th>
                                            </tr>
                                            <tr>
                                                <th>주문 아이디</th>
                                                <th>${summary.mem_id}</th>
                                            </tr>
                                            <tr>
                                                <th>주문 일시</th>
                                                <th>${summary.od_date}</th>
                                            </tr>
                                            <tr>
                                                <th>주문 금액</th>
                                                <th>
                                                    <fmt:formatNumber value="${summary.od_total_price}" type="pattern" pattern=",###"/>
                                                    원
                                                </th>
                                            </tr>
                                            <tr>
                                                <th>운송장 번호</th>
                                                <th>
                                                    <input class="form-control-sm" type="text" name="od_shipping_num" value="${summary.od_shipping_num}">
                                                </th>
                                            </tr>
                                            <tr>
                                                <th>배송 상태</th>
                                                <th>
                                                    <select class="form-control-sm" name="od_shipping_stat">
                                                        <option value="배송 준비중" <c:out value="${summary.od_shipping_stat eq '배송 준비중' ? 'selected' : ''}"/>>배송 준비중</option>
                                                        <option value="배송중" <c:out value="${summary.od_shipping_stat eq '배송중' ? 'selected' : ''}"/>>배송중</option>
                                                        <option value="배송완료" <c:out value="${summary.od_shipping_stat eq '배송완료' ? 'selected' : ''}"/>>배송완료</option>
                                                        <option value="주문 취소" <c:out value="${summary.od_shipping_stat eq '주문 취소' ? 'selected' : ''}"/>>주문 취소</option>
                                                    </select>
                                                </th>
                                            </tr>
                                            <tr>
                                                <th>사용된 포인트</th>
                                                <th>${summary.od_use_point}</th>
                                            </tr>
                                            <tr>
                                                <th>기능</th>
                                                <th>
                                                    <button class="btn btn-primary">수정하기</button>
                                                </th>
                                            </tr>
                                        </table>
                                    </form>
                                </td>
                            </tr>
                            </tr>

                        </div>
                    </c:forEach>
                </table>
            </div>
            <div class="card-footer text-right p-3">

                <ul class="pagination float-center" id="pages">
                    <c:if test="${pm.prev}">
                        <li class="page-item">
                            <a class="page-link page" href="/admin/order/list${pm.makeFullSearch(pm.cri.page-1)}" name="">Prev</a>
                        </li>
                    </c:if>
                    <c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="pageNum" varStatus="">
                        <c:if test="${pageNum == pm.cri.page }">
                            <li class="page-item active">
                                <a class="page-link page" href="/admin/order/list${pm.makeFullSearch(pageNum)}" name="${pageNum }">${pageNum }</a>
                            </li>
                        </c:if>
                        <c:if test="${pageNum != pm.cri.page }">
                            <li class="page-item">
                                <a class="page-link page" href="/admin/order/list${pm.makeFullSearch(pageNum)}">${pageNum }</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pm.next}">
                        <li class="page-item">
                            <a class="page-link page" href="/admin/order/list${pm.makeFullSearch(pm.cri.page+1)}" name="">
                                Next
                            </a>
                        </li>
                    </c:if>
                </ul>

                <p>선택 일괄 배송상태 변경</p>
                <form id="selectForm" action="/admin/order/updateSummary" method="post">
                    <input type="hidden" name="od_shipping_num" value="미등록">
                    <select class="form-control-sm" name="od_shipping_stat">
                        <option value="배송 준비중">배송 준비중</option>
                        <option value="배송중">배송중</option>
                        <option value="배송완료">배송완료</option>
                        <option value="주문 취소">주문 취소</option>
                    </select>
                    <button class="btn btn-primary" id="selectUpdate">변경</button>
                </form>
            </div>
        </div>

    </div>
</div>
<jsp:include page="../../footer.jsp"/>
</body>
