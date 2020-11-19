toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": false,
    "progressBar": true,
    "positionClass": "toast-top-center",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "3000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
}

$(function () {
    $("#form").submit(function (event) {
        event.preventDefault();

        $.ajax({
            type : 'post',
            url :'/member/loginAjax',
            data : {
                mem_id : $("#mem_id").val(),
                mem_passwd : $("#mem_passwd").val()
            },
            success : function(data) {
                if(data == 'SUCCESS') {
                    window.opener.location.reload();
                    window.close();
                } else {
                    $("#mem_id").val("");
                    $("#mem_passwd").val("");
                    toastr["error"]("로그인 실패", "로그인을 실패했습니다.");
                }
            }
        });
    });
});