<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="ko">
	<head>
        <title>K-Mall / 게시판</title>
    <script src="https://code.jquery.com/jquery-3.5.1.js?ver=1" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
	</head>
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
	<body class="sidebar-mini layout-fixed">
    <div class="content-wrapper">
        <div class="content p-5">
            <div class="card p-5">
                <div class="card-header">
                    <h2 class="display-4">자유게시판</h2>
                </div>
                <div class="card-body">
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
                        <a href="/board/write"><button class="btn btn-outline-info">글쓰기</button></a>
                </div>
            </div>
        </div>
    </div>

    <script id="article" type="text/x-handlebars-template">
        {{#each .}}
        <tr class="article">
            <td>{{board_idx}}</td>
            <td><a href="/board/getArticle?idx={{board_idx}}">{{board_title}}</a></td>
            <td>{{mem_id}}</td>
            <td>{{board_regdate}}</td>
        </tr>
        {{/each}}
    </script>
    <jsp:include page="../footer.jsp"/>
    </body>
