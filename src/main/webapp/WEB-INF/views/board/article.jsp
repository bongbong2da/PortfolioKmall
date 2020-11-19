<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <title>K-Mall / 게시물</title>
    <script src="https://code.jquery.com/jquery-3.5.1.js?ver=1" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <script src="/resources/js/board/article.js"></script>
    <style>
        #content {
            height: 400px;
        }

        th {
            width: 100px;
        }
    </style>
</head>

<body class="sidebar-mini layout-fixed">
<jsp:include page="../header.jsp"/>
<jsp:include page="../sidebar.jsp"/>
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card">
            <div class="card-header">
                <h2 class="display-4">${article.board_title}</h2>
                <table class="table table-striped table-hover p-3">
                    <tr>
                        <th>번호</th>
                        <td>${article.board_idx}</td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>${article.mem_id}</td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td>${article.board_regdate}</td>
                    </tr>
                    <tr>
                        <th>작성 IP</th>
                        <td>${article.board_ip}</td>
                    </tr>

                </table>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover p-3">
                    <tr>
                        <th>내용</th>
                        <td id="content">${article.board_content}</td>
                    </tr>
                </table>
                <div class="text-right">
                    <%--                        <a href="/board/getArticle?idx=${article.board_idx - 1 }">이전글</a>--%>
                    <%--                        <a href="/board/getArticle?idx=${article.board_idx + 1 }">다음글</a>--%>
                    <a href="/board/list${pm.makeSearch(pm.cri.page)}">
                        <button class="btn btn-primary">목록</button>
                    </a>
                    <c:if test="${user.mem_id eq article.mem_id }">
                        <a href="/board/updateForm?idx=${article.board_idx }">
<%--                        <a href="/member/checkSelf?ctx=editArticle">--%>
                            <button class="btn btn-outline-info">수정</button>
                        </a>
                        <a class="delete" href="#" data-idx="${article.board_idx}">
                            <button class="btn btn-outline-danger">삭제</button>
                        </a>
                    </c:if>
                </div>
                <table id="board" class="table table-striped table-hover">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                    <c:forEach items="${boardList}" var="board">
                        <tr class="article">
                            <td>${board.board_idx}</td>
                            <td><a href="/board/getArticle${pm.makeSearch(pm.cri.page)}&idx=${board.board_idx}">${board.board_title}</a></td>
                            <td>${board.mem_id}</td>
                            <td>${board.board_regdate}</td>
                        </tr>
                    </c:forEach>
                </table>
                <ul class="pagination">
                    <c:forEach begin="${pm.startPage}" end="${pm.endPage}" varStatus="stat">
                        <c:if test="${pm.prev eq true}">
                            <li class="page-item">
                                <a class="page-link" href="#">PREV</a>
                            </li>
                        </c:if>
                        <li class="page-item">
                            <a class="page-link" href="#">${stat.index}</a>
                        </li>
                        <c:if test="${pm.next eq true}">
                            <li class="page-item">
                                <a class="page-link" href="#">NEXT</a>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
                <br>
                <ul id="pages" class="pagination">
                </ul>
                <form id="boardSearch" action="/board/list" method="get">
                    <select id="searchType" class="form-control-sm" name="searchType">
                        <option value="t">제목</option>
                        <option value="c">내용</option>
                        <option value="tc">제목+내용</option>
                    </select>
                    <input id="keyword" class="form-control-sm" type="text" name="keyword">
                    <input class="form-control-sm btn btn-outline-info" type="submit" value="검색">
                </form>
                <br>
                <a href="/board/write">
                    <button class="btn btn-outline-info">글쓰기</button>
                </a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer.jsp"/>
</body>
