$(function () {
    $("#form").submit(function(event) {

        var q = confirm("정말로 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.");

        if(q) {
        } else {
            event.preventDefault();
            return;
        }

    });

    $("#cancel").click(function (event) {
        event.preventDefault();

        window.location = "/";
    });
});