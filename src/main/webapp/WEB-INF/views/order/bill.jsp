    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE HTML>
    <html>
    <head>
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script src="/resources/bs4/js/bootstrap.js"></script>
        <script src="/resources/bs4/js/bootstrap.js"></script>
        <script src="/resources/js/order/bill.js"></script>
    </head>
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
    <body class="sidebar-mini layout-fixed">

    <div id="editReceiveInfoModal" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">배송지 변경</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="modalForm" action="/order/editReceiveInfo" method="post">
                        <label>받는 주소</label><br>
                        <input type="hidden" name="od_idx" value="${summary.od_idx}">
                        <input id="od_postcode" name="od_postcode" type="text" value="${summary.od_postcode}" required>
                        <input type="button" value="찾기" onclick="daumPostcode()">
                        <input id="od_roadname" type="text" name="od_roadname" value="${summary.od_roadname}" required>
                        <input id="od_addr" name="od_addr" class="form-control" type="text" value="${summary.od_addr}" required>
                        <input id="od_addr_detail" name="od_addr_detail" type="text" value="${summary.od_addr_detail}" required>
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="modalSubmit" type="button" class="btn btn-primary">Save changes</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div class="content-wrapper">
        <div class="content p-5">
            <div class="card elevation-4">
                <div class="card-header">
                    <h2 class="display-4">주문 종합 정보</h2>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <tr>
                            <th>주문 번호</th>
                            <td>${summary.od_idx}</td>
                        </tr>
                        <tr>
                            <th>받는 사람</th>
                            <td>${summary.od_receiver}</td>
                        </tr>
                        <tr>
                            <th>우편번호</th>
                            <td>${summary.od_postcode}</td>
                        </tr>
                        <tr>
                            <th>도로명 주소</th>
                            <td>${summary.od_roadname}</td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td>${summary.od_addr}</td>
                        </tr>
                        <tr>
                            <th>상세 주소</th>
                            <td>${summary.od_addr_detail}</td>
                        </tr>
                        <c:if test="${summary.od_shipping_stat eq '배송 준비중'}">
                            <tr>
                                <th></th>
                                <th><button class="btn btn-primary" id="editReceiveInfo">배송지 변경</button></th>
                            </tr>
                        </c:if>
                        <tr>
                            <th>전화 번호</th>
                            <td>${summary.od_tel}</td>
                        </tr>
                        <tr>
                            <th>총 주문 금액</th>
                            <td>
                                <fmt:formatNumber value="${summary.od_total_price}" type="pattern" pattern=",###"/>원
                            </td>
                        </tr>
                        <tr>
                            <th>주문 일시</th>
                            <td>${summary.od_date}</td>
                        </tr>
                        <tr>
                            <th>결제 수단</th>
                            <td>${summary.od_method}</td>
                        </tr>
                        <tr>
                            <th>사용 포인트</th>
                            <td>${summary.od_use_point}</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="card elevation-4">
                <div class="card-header">
                    <h2 class="display-4">배송 정보</h2>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <tr>
                            <th>운송장 번호</th>
                            <td>${summary.od_shipping_num}</td>
                        </tr>
                        <tr>
                            <th>배송 상태</th>
                            <td>${summary.od_shipping_stat}</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="card p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">주문 상세 목록</h2>
                </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <tr>
                            <th>번호</th>
                            <th>상품이름</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>개별 합</th>
                            <th>리뷰</th>
                        </tr>
                        <c:forEach items="${detailList}" var="detail" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td><a href="/product/getProduct?idx=${detail.prdt_idx}">${detail.prdt_name}</a></td>
                                <td>${detail.od_price}원</td>
                                <td>${detail.od_amount}</td>
                                <td>
                                    <fmt:formatNumber value="${detail.od_price * detail.od_amount}" type="pattern" pattern=",###"/>원
                                </td>
                                <td>
                                <c:if test="${summary.od_shipping_stat == '배송완료'}">
                                    <button class="btn btn-sm btn-primary write-review" data-od="${summary.od_idx}" data-prdt="${detail.prdt_idx}">리뷰 남기기</button>
                                </c:if>
                                <c:if test="${summary.od_shipping_stat != '배송완료'}">
                                    <p>상품 수령 후 작성 가능</p>
                                </c:if>
                                </td>
                            </tr>
                            <tr id="review${detail.prdt_idx}" style="display: none;">
                                <th colspan="6">
                                    <form class="reviewForm form-group-sm" action="/review/insertReview" method="post">
                                        <input type="hidden" class="initImg" name="review_img" value="">
                                        <input type="hidden" name="od_idx" value="${summary.od_idx}">
                                        <input type="hidden" name="prdt_idx" value="${detail.prdt_idx}">
                                        <input type="hidden" name="mem_id" value="${user.mem_id}">
                                        <textarea class="form-control" name="review_content"></textarea>
                                        <div class="w-100 text-right">
                                            점수 : <input class="form-control-sm" type="number" value="5" max="5" name="review_rating"><br>
                                            <input class="form-control-sm review-img" type="file"><br>
                                            <input class="btn btn-sm btn-primary" type="submit" value="리뷰 작성">
                                        </div>
                                    </form>
                                </th>
                            </tr>
                        </c:forEach>
                        <tr>
                            <th colspan="4"></th>
                            <th>사용 포인트</th>
                            <th>${summary.od_use_point}</th>
                        </tr>
                        <tr>
                            <th colspan="4"></th>
                            <th>총 합</th>
                            <th>
                                <fmt:formatNumber value="${summary.od_total_price}" type="pattern" pattern=",###"/>
                                원
                            </th>
                        </tr>
                        <c:if test="${summary.od_shipping_stat eq '배송 준비중'}">
                        <tr>
                            <th colspan="5"></th>
                            <th>
                                <button class="btn btn-danger" id="cancelOrder" data-idx="${summary.od_idx}">주문 취소</button>
                            </th>
                        </tr>
                        </c:if>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../footer.jsp"/>
    </body>
