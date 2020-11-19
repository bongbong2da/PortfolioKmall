    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <!DOCTYPE HTML>
    <html>
    <head>
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    </head>
    <body class="sidebar-mini layout-fixed">
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
    <div class="content-wrapper">
        <div class="content p-3">
            <div class="card p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">Check</h2>
                </div>
                <div class="card-body">
                    <form id="form" action="/member/checkSelf" method="post">
                        <label for="mem_id">ID</label>
                        <p>${user.mem_id }</p>
                        <input type="hidden" name="ctx" value="${ctx}">
                        <input name="mem_id" id="mem_id" type="hidden" value="${user.mem_id }">
                        <label for="mem_passwd">Password</label>
                        <input id="mem_passwd" class="form-control" type="password" name="mem_passwd"><br>
                        <input id="check" class="form-control btn btn-info" type="submit" value="Check">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../footer.jsp"/>
    </body>
