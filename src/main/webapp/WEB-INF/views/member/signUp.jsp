<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="/resources/js/member/signUp.js"></script>
</head>
<body class="sidebar-mini layout-fixed">
<jsp:include page="../header.jsp"/>
<jsp:include page="../sidebar.jsp"/>
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">Sign-Up </h2>
            </div>
            <div class="card-body">
                <form class="form-group rounded p-3" id="form" action="/member/signUp" method="POST">

                    <label for="mem_id">ID (E-mail)</label><br>
                    <input class="form-control" type="text" name="mem_id" id="mem_id" required><br>
                    <input class="form-control-sm btn btn-outline-info btn-sm" id="idCheck" type="button" value="중복 확인">
                    <p style="display:inline" id="idCheckMsg"></p>
                    <br><br>
                    <label for="mem_passwd">Password</label><br>
                    <label>6자 이상, 영문과 숫자 조합</label>
                    <input class="form-control" type="password" name="mem_passwd" id="mem_passwd" required><br>
                    <p id="passwdMsg"></p>
                    <label for="mem_passwdConfirm">Password Confirm</label><br>
                    <input class="form-control" type="password" name="mem_passwdConfirm" id="mem_passwdConfirm" required><br>
                    <label for="mem_name">Name</label><br>
                    <input class="form-control" type="text" name="mem_name" id="mem_name" placeholder="" required><br>
                    <label for="mem_nickname">Nickname</label><br>
                    <input class="form-control" type="text" name="mem_nickname" id="mem_nickname" required><br>
                    <input class="form-control-sm btn btn-outline-info btn-sm" id="nickCheck" type="button" value="중복 확인">
                    <p style="display:inline" id="nickCheckMsg"></p>
                    <br><br>
                    <label for="mem_postcode">Address</label><br>
                    <input class="form-control-sm d-inline" type="text" id="mem_postcode" name="mem_postcode" placeholder="우편번호"
                           required>
                    <input class="btn btn-sm btn-outline-primary" type="button" onclick="daumPostcode()"
                           value="우편번호 찾기"><br><br>
                    <input class="form-control" type="text" id="mem_roadname" name="mem_roadname" placeholder="도로명주소"
                           required><br>
                    <input class="form-control" type="text" id="mem_addr" name="mem_addr" placeholder="지번주소" required><br>
                    <span id="guide" style="color:#999;display:none"></span>
                    <input class="form-control" type="text" id="mem_addr_detail" name="mem_addr_detail" placeholder="상세주소"
                           required><br>

                    <br>
                    <label for="authCodeInput">이메일 인증</label>
                    <input class="form-control" type="text" id="authCodeInput">
                    <br>
                    <button class="btn btn-info" id="sendAuthCode">인증코드 보내기</button>
                    <button class="btn btn-primary" id="authCodeCheck">확인</button>
                    <br>
                    <p id="authMsg"></p>
                    <br>

                    <label for="mem_tel">Tel</label><br>
                    <input class="form-control" type="text" name="mem_tel" id="mem_tel" required><br>
                    <label for="mem_email_check">이벤트 및 프로모션 이메일 수신을 동의합니다.</label>
                    <input class="" type="checkbox" name="email_check" id="email_check" value="y"><br>
                    <input class="" type="hidden" name="mem_email_check" id="mem_email_check" value="y"><br>
                    <br>
                    <input class="form-control btn btn-primary" type="submit" name="submit" id="sumbit" value="Sign-Up">
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<jsp:include page="../footer.jsp"/>