$(function () {
    $(".delete").click(function() {
        var q = confirm("삭제하시겠습니까?");

        if(q) {
            var src = parseInt($(this).attr("data-idx"));
            var idx = [];
            idx.push(src);
            $.ajax({
                type : "post",
                url : "/board/delete",
                data : {idx : idx},
                success : function(data) {
                    if(data == 'OK') {
                        alert("삭제되었습니다.");
                        window.location.href = "/board/list?page=1";
                    } else {
                        alert("실패했습니다.");
                        window.location.reload();
                    }
                }
            })
        }
    });
});