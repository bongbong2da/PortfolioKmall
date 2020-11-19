<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js?ver=1" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <script src="/resources/ckeditor4/ckeditor.js"></script>
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
        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">게시글 수정</h2>
            </div>
            <div class="card-body">
                <form action="/board/updateAction" method="post">
                    <input type="hidden" name="board_idx" value="${board.board_idx }">
                    <input class="form-control" type="hidden" name="mem_id" value="${sessionScope.user }">
                    <label for="">제목</label><br>
                    <input class="form-control" name="board_title" type="text" value="${board.board_title }"><br>
                    <label for="">내용</label><br>
                    <textarea class="float-center" name="board_content" id="editor1" rows="30" cols="200">
                        ${board.board_content }
                    </textarea>
                    <script type="text/javascript">
                        CKEDITOR.replace('editor1', {
                            filebrowserUploadUrl: '/upload/ckAjax',
                        });
                    </script>
                    <input class="btn btn-outline-primary" type="submit" value="수정"><br><br>
                </form>
            </div>
        </div>

    </div>
</div>
<jsp:include page="../footer.jsp"/>
</body>
