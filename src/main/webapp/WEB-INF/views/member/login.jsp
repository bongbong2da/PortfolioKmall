<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<body class="sidebar-mini layout-fixed">
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
	<div class="content-wrapper">
        <div class="content p-3">
            <div class="card p-5 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">Log-in</h2>
                </div>
                <div class="card-body">
                    <form action="/member/login" method="post">
                        <label for="">ID</label>
                        <input class="form-control" type="text" name="mem_id">
                        <label for="">Password</label>
                        <input class="form-control" type="password" name="mem_passwd"><br>
                        <input class="form-control btn btn-info" type="submit" value="Login">
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="../footer.jsp"/>
    </div>
</body>
