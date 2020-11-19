    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <!DOCTYPE HTML>
    <html>
    <head>
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script src="/resources/js/member/quit.js"></script>
    </head>
    <body class="sidebar-mini layout-fixed">
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
    <div class="content-wrapper">
        <div class="content p-3">
            <div class="card p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">회원 탈퇴</h2>
                </div>
                <div class="card-body">
                    <form id="form" action="/member/quit" method="post">
                        <p>${user.mem_id }님, 탈퇴하시겠습니까?</p>
                        <input id="confirm" class="form-control btn btn-danger" type="submit" value="예">
                        <input id="cancel" class="form-control btn btn-secondary" type="button" value="아니오">
                        <input type="button" value="test" class="btn btn-outline-success">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../footer.jsp"/>
    </body>
