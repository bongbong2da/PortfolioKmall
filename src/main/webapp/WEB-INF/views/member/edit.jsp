    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE HTML>
    <html>
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script src="/resources/js/member/edit.js"></script>
    <head>
        <script>
        </script>
    </head>
    <body class="sidebar-mini layout-fixed layout-footer-fixed">
    <jsp:include page="../header.jsp"/>
    <jsp:include page="../sidebar.jsp"/>
    <div class="content-wrapper">
        <div class="content p-5">
            <div class="card p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">회원 정보 수정</h2>
                </div>
                <div class="card-body">
                    <form class="form-group rounded p-3" id="updateForm" action="/member/edit" method="POST">
                        <input class="form-control" type="hidden" name="mem_id" id="mem_id" value="${user.mem_id }"><br>
                        <input class="form-control" type="hidden" name="mem_name" id="mem_name" placeholder="" value="${user.mem_name }"><br>
                        <input type="hidden" name="manager" value="${user.manager}">
                        <input type="hidden" name="mem_point" id="mem_point" value="${user.mem_point}">
                        <label for="mem_id">ID (E-mail)</label><br>
                        <p>${user.mem_id }</p>
                        <label for="mem_passwd">Password</label><br>
                        <input class="form-control" type="password" name="mem_passwd" id="mem_passwd"><br>
                        <label for="mem_passwdConfirm">Password Confirm</label><br>
                        <input class="form-control" type="password" name="mem_passwdConfirm" id="mem_passwdConfirm"><br>
                        <p>Name</p>
                        <p>${user.mem_name }</p>
                        <label for="mem_postcode">Address</label><br>
                        <input class="form-control-sm d-inline" type="text" id="mem_postcode" name="mem_postcode" placeholder="우편번호" value="${user.mem_postcode}"
                               required>
                        <input class="btn btn-sm btn-outline-primary" type="button" onclick="daumPostcode()"
                               value="우편번호 찾기"><br><br>
                        <input class="form-control" type="text" id="mem_roadname" name="mem_roadname" placeholder="도로명주소" value="${user.mem_roadname}"
                               required><br>
                        <input class="form-control" type="text" id="mem_addr" name="mem_addr" placeholder="지번주소" value="${user.mem_addr}" required><br>
                        <span id="guide" style="color:#999;display:none"></span>
                        <input class="form-control" type="text" id="mem_addr_detail" name="mem_addr_detail" placeholder="상세주소" value="${user.mem_addr_detail}"
                               required><br>
                        <p>Tel</p>
                        <input class="form-control" type="text" name="mem_tel" id="tel" value="${user.mem_tel }"><br>
                        <p>Nickname</p>
                        <input class="form-control" type="text" name="mem_nickname" id="nickName"
                               value="${user.mem_nickname }"><br>
                        <p>Mail Receive</p>
                        <input type="checkbox" name="mem_email_check" id="mem_email_check" <c:out value="${user.mem_email_check == 'y' ? 'checked' : ''}"/>>
                        <br>
                        <input class="form-control btn btn-outline-primary" type="submit" name="submit" id="sumbit"
                               value="Update">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../footer.jsp"/>
    </body>
