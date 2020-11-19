<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<script src="https://code.jquerycom/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="/resources/js/admin/member/edit.js"></script>
<head>
</head>
<body class="sidebar-mini layout-fixed layout-footer-fixed">
<jsp:include page="../adminHeader.jsp"/>
<jsp:include page="../adminSidebar.jsp"/>
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">회원 정보 수정</h2>
            </div>
            <div class="card-body">
                <form class="form-group rounded p-3" id="updateForm" action="/admin/member/edit" method="POST">
                    <label for="mem_id">ID (E-mail)</label><br>
                    <lable>${member.mem_id }</lable>
                    <input class="form-control" type="hidden" name="mem_id" id="mem_id" value="${member.mem_id }">
                    <input class="form-control" type="hidden" name="mem_passwd" id="mem_passwd" value="${member.mem_passwd}"><br>
                    <label>Name</label>
                    <input class="form-control" type="text" name="mem_name" value="${member.mem_name}">
                    <label>Point</label>
                    <input class="form-control" type="text" name="mem_point" value="${member.mem_point}">
                    <label for="mem_postcode">Address</label><br>
                    <input class="form-control-sm d-inline" type="text" id="mem_postcode" name="mem_postcode" placeholder="우편번호" value="${member.mem_postcode}"
                           required>
                    <input class="btn btn-sm btn-outline-primary" type="button" onclick="daumPostcode()"
                           value="우편번호 찾기"><br><br>
                    <input class="form-control" type="text" id="mem_roadname" name="mem_roadname" placeholder="도로명주소" value="${member.mem_roadname}"
                           required><br>
                    <input class="form-control" type="text" id="mem_addr" name="mem_addr" placeholder="지번주소" value="${member.mem_addr}" required><br>
                    <span id="guide" style="color:#999;display:none"></span>
                    <input class="form-control" type="text" id="mem_addr_detail" name="mem_addr_detail" placeholder="상세주소" value="${member.mem_addr_detail}"
                           required><br>
                    <lable>Tel</lable>
                    <input class="form-control" type="text" name="mem_tel" id="tel" value="${member.mem_tel }"><br>
                    <lable>Nickname</lable>
                    <input class="form-control" type="text" name="mem_nickname" id="nickName" value="${member.mem_nickname }"><br>
                    <lable>Mail Receive</lable>
                    <input type="checkbox" name="mem_email_check" id="mem_email_check" <c:out value="${member.mem_email_check == 'Y' ? 'checked' : ''}"/>>
                    <lable>Manager Mode</lable>
                    <input type="checkbox" name="manager" id="manager" <c:out value="${member.manager eq 'Y'.charAt(0) ? 'checked' : ''}"/>>
                    <br>
                    <input class="form-control btn btn-outline-primary" type="submit" name="submit" id="sumbit" value="Update">
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../footer.jsp"/>
</body>
