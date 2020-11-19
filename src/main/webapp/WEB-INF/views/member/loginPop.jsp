<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <title>Login</title>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/toastr/build/toastr.min.css">
    <script src="/resources/toastr/build/toastr.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Noto+Serif+KR&display=swap" rel="stylesheet">
    <script src="/resources/js/member/loginPop.js"></script>
</head>
<script>

</script>
<body class="bg-dark text- p-5">
<div class="login-box bg-light rounded p-3">
    <div class="login-logo">
        <b class="display-4">Log-in</b>
    </div>
    <div class="login-card-body">
        <form id="form"method="post">
            <label for="mem_id">ID</label>
            <input class="form-control" type="text" id="mem_id" name="mem_id" required>
            <label for="mem_passwd">Password</label>
            <input class="form-control" type="password" id="mem_passwd" name="mem_passwd" required><br>
            <input class="form-control btn btn-info" id="submit" type="submit" value="Login">
        </form>
    </div>
</div>
</body>
</html>
