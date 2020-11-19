<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <title>관리자 / 게시판 관리</title>
    <meta content="text/html; charset=utf-8"/>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <script src="/resources/js/admin/board/list.js"></script>
    <style>
        .board {
            cursor: pointer;
        }
    </style>
</head>
<body class="sidebar-mini layout-fixed">
<jsp:include page="../adminHeader.jsp"/>
<jsp:include page="../adminSidebar.jsp"/>
<div class="content-wrapper">
    <div class="content p-5">

        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">게시판 관리</h2>
            </div>
            <div class="card-body">
                <form class="form-inline" action="/admin/board/list">
                    <button id="expand" class="btn-sm btn-primary">모두 펼치기</button>
                    <button id="collapse" class="btn-sm btn-primary">모두 접기</button>
                    <input class="form-control-sm" type="text" name="keyword">
                    <select class="form-control-sm" name="searchType">
                        <option value="t">제목</option>
                        <option value="c">내용</option>
                        <option value="tc">제목+내용</option>
                        <input type="submit" value="검색">
                    </select>
                </form>
                <table class="table-sm table-striped table-hover w-100">
                    <caption></caption>
                    <tr>
                        <th scope="col"><input type="checkbox" name="" id="selectAll"></th>
                        <th scope="col">번호</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성자</th>
                        <th scope="col">작성일</th>
                    </tr>
                    <c:forEach items="${boardList}" var="board">
                        <tr class="board" data-idx="${board.board_idx}">
                            <td><input class="check" type="checkbox" name="${board.board_idx}" id=""></td>
                            <td>${board.board_idx}</td>
                            <td>${board.board_title}</td>
                            <td>${board.mem_id}</td>
                            <td>${board.board_regdate}</td>
                        </tr>
                        <tr class="board-content p-3 bg-light" id="content${board.board_idx}" style="display: none;">
                            <td class="" colspan="5">
                                작성자 : ${board.mem_id}
                                <br>
                                제목 : ${board.board_title}
                                <br>
                                작성일 : ${board.board_regdate}
                                <br>
                                내용 : ${board.board_content}
                                <br>
                                <button class="btn btn-danger board-delete" data-idx="${board.board_idx}">삭제</button>
                                <a href="/admin/member/edit?uid=${board.mem_id}">
                                    <button class="btn btn-info board-writer" data-id="${board.mem_id}">작성자 보기</button>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>

            </div>
            <div class="card-footer">
                <button class="btn btn-danger" id="selectDelete">선택 삭제</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../footer.jsp"/>
</body>
