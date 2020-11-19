    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>
    <head>
    </head>
    <body class="sidebar-mini layout-fixed layout-footer-fixed">
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
    <div class="content-wrapper">
        <div class="content p-5">
            <div class="card p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">User Information</h2>
                </div>
                <div class="card-body">
                <table class="table table-sm table-striped table-light table-hover p-5">
                    <tr>
                        <th>ID</th>
                        <td>${user.mem_id}</td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td>${user.mem_name}</td>
                    </tr>
                    <tr>
                        <th>Postcode</th>
                        <td>${user.mem_postcode }</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${user.mem_addr }</td>
                    </tr>
                    <tr>
                        <th>Road Address</th>
                        <td>${user.mem_roadname}</td>
                    </tr>
                    <tr>
                        <th>Address Detail</th>
                        <td>${user.mem_addr_detail }</td>
                    </tr>
                    <tr>
                        <th>Tel</th>
                        <td>${user.mem_tel }</td>
                    </tr>
                    <tr>
                        <th>Nickname</th>
                        <td>${user.mem_nickname }</td>
                    </tr>
                    <tr>
                        <th>Point</th>
                        <td>${user.mem_point }</td>
                    </tr>
                    <tr>
                        <th>Registered</th>
                        <td>${user.mem_regdate }</td>
                    </tr>
                    <tr>
                        <th>Last Login</th>
                        <td>${user.mem_lastlogin }</td>
                    </tr>
                    <tr>
                        <th>이메일 수신</th>
                        <td><c:out value="${user.mem_email_check eq 'y' ? '수신함' : '수신하지 않음'}"/></td>
                    </tr>

                </table>
                </div>
                <div class="card-footer text-right pr-5">
                    <a href="/member/checkSelf?ctx=edit">
                        <button class="btn btn-outline-primary">수정</button>
                    </a>
                    <a href="/member/checkSelf?ctx=quit">
                        <button class="btn btn-outline-danger">탈퇴</button>
                    </a>
                </div>

            </div>
        </div>
    </div>
    </body>
    <jsp:include page="../footer.jsp"/>
    </html>