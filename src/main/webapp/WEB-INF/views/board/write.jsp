<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="/resources/ckeditor4/ckeditor.js"></script>
</head>
<body class="sidebar-mini layout-fixed">
<jsp:include page="../header.jsp"/>
<jsp:include page="../sidebar.jsp"/>
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-5">
            <div class="card-header">
                <h2 class="display-4">게시글 작성</h2>
            </div>
            <div class="card-body">
                <form action="/board/write" method="post">
                    <input class="form-control" type="hidden" name="mem_id" value="${user.mem_id}">
                    <label for="">제목</label><br>
                    <input class="form-control" name="board_title" type="text"><br>
                    <textarea class="float-center" name="board_content" id="editor1" rows="30" cols="200"></textarea>
                    <script type="text/javascript">
                        CKEDITOR.replace( 'editor1', {
                            filebrowserUploadUrl: '/upload/uploadCKE',
                        });
                    </script>
                    <input class="btn btn-outline-primary" type="submit" value="작성"><br><br>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer.jsp"/>
</body>
