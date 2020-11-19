//daum 주소 api
function daumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            var roadAddr = data.roadAddress; // 도로명 주소 변수

            document.getElementById('mem_postcode').value = data.zonecode;
            document.getElementById("mem_roadname").value = roadAddr;
            document.getElementById("mem_addr").value = data.jibunAddress;

            var guideTextBox = document.getElementById("guide");
            if (data.autoRoadAddress) {
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if (data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}

$(function () {
    //아이디 중복 체크 및 정규식 검사
    var idChecked = false;
    $("#idCheck").click(function (event) {
        var idReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        if (!idReg.test($("#mem_id").val())) {
            $("#idCheckMsg").text("이메일 형식이 아닙니다.");
            toastr.error("이메일 형식이 아닙니다.");
            $("#idCheckMsg").css({color: "red"});
            event.preventDefault();
            return;
        }

        if ($("#mem_id").val() == '') {
            $("#mem_id").focus();
            $("#idCheckMsg").text("아이디를 입력해주세요.");
            toastr.error("아이디를 입력해주세요.");
            $("#idCheckMsg").css({color: "red"});
            return;
        }

        $.ajax({
            type: "get",
            url: "/member/isIdDuplicated",
            data: {uid: $("#mem_id").val()},
            success: function (data) {
                if (data == 'OK') {
                    //$("#mem_id").attr("readonly", true);
                    $("#idCheckMsg").text("사용가능한 아이디입니다.");
                    toastr.success("사용가능한 아이디입니다.");
                    $("#idCheckMsg").css({color: "green"});
                    idChecked = true;
                } else {
                    $("#mem_id").val('');
                    $("#mem_id").focus();
                    $("#idCheckMsg").text("중복된 아이디입니다.");
                    toastr.error("중복된 아이디 입니다.");
                    $("#idCheckMsg").css({color: "red"});
                }
            }
        });
    });
    //아이디값이 변경될 시
    $("#mem_id").change(function () {
        $("#idCheckMsg").text("중복체크를 해주세요.");
        toastr.error("중복체크를 해주세요.");
        $("#idCheckMsg").css({color: "red"});
        idChecked = false;
    });

    //닉네임 중복 체크
    var nickChecked = false;
    $("#nickCheck").click(function () {
        if ($("#mem_nickname").val() == '') {
            $("#mem_nickname").focus();
            $("#nickCheckMsg").text("닉네임을 입력해주세요.");
            toastr.error("닉네임을 입력해주세요.");
            $("#nickCheckMsg").css({color: "red"});
            return;
        }
        $.ajax({
            type: "get",
            url: "/member/isNickDuplicated",
            data: {nickname: $("#mem_nickname").val()},
            success: function (data) {
                if (data == 'OK') {
                    //$("#mem_id").attr("readonly", true);
                    $("#nickCheckMsg").text("사용가능한 닉네임입니다.");
                    toastr.success("사용가능한 닉네임입니다.");
                    $("#nickCheckMsg").css({color: "green"});
                    nickChecked = true;
                } else {
                    $("#mem_nickname").val('');
                    $("#mem_nickname").focus();
                    $("#nickCheckMsg").text("중복된 닉네임입니다.");
                    toastr.error("중복된 닉네임입니다.");
                    $("#nickCheckMsg").css({color: "red"});
                }
            }
        });
    });
    //닉네임 값이 변경될 시
    $("#mem_nickname").change(function () {
        $("#nickCheckMsg").text("중복체크를 해주세요.");
        $("#nickCheckMsg").css({color: "red"});
        nickChecked = false;
    });

    //폼이 Submit되었을 때
    $("#form").submit(function (event) {

        if(!idChecked) {
            alert("아이디를 확인해주세요.");
            event.preventDefault();
            return;
        }
        if(!passwdChecked) {
            alert("비밀번호를 확인해주세요.");
            event.preventDefault();
            return;
        }
        if(!nickChecked) {
            alert("닉네임을 확인해주세요.");
            event.preventDefault();
            return;
        }
        if(!authChecked) {
            alert("메일을 인증해주세요.");
            event.preventDefault();
            return;
        }

        if ($("#mem_passwd").val() != $("#mem_passwdConfirm").val()) {
            alert("비밀번호를 다시 확인해주세요.");
            $("#mem_passwdConfirm").focus();
            event.preventDefault();
            return;
        }

        // 이메일 수신이 체크되어있다면
        if ($("#email_check").attr('checked') == true) {
            $("#mem_email_check").val("y");
        } else {
            $("#mem_email_check").val("n");
        }
    });

    var authChecked = false;
    $("#sendAuthCode").click(function (event) {
        event.preventDefault();
        if(!idChecked) {
            alert("아이디를 먼저 확인해주세요");
            return;
        }
        $.ajax({
            type: "post",
            url: "/email/send",
            data : {receiveMail : $("#mem_id").val()},
            success : function (data) {
                alert("이메일이 전송되었습니다.\n인증번호를 정확이 입력해주세요");
            }
        });
    });

    $("#authCodeCheck").click(function (event) {
        event.preventDefault();
        var authCodeInput = $("#authCodeInput").val();

        $.ajax({
            type : "get",
            url : "/email/getAuthCode",
            success : function(data) {
                if (authCodeInput == data) {
                    $("#authMsg").text("인증되었습니다.");
                    authChecked = true;
                } else {
                    $("#authMsg").text("인증에 실패했습니다.");
                    authChecked = false;
                }
            }
        })
    });

    var passwdChecked = false;
    $("#mem_passwd").change(function () {
        var regPasswd = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        var input = $(this).val();

        if(regPasswd.test(input)) {
            passwdChecked = true;
            $("#passwdMsg").text("사용할 수 있는 비밀번호입니다.");
        } else {
            passwdChecked = false;
            $("#passwdMsg").text("사용할 수 없는 비밀번호입니다.");
            $(this).val('');
        }

    });

});