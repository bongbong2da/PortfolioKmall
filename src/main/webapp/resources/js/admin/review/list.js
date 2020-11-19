$(function () {
    $("#selectAll").change(function () {
        if ($("input:checkbox[id='selectAll']").is(":checked")) {
            $("input:checkbox").prop("checked", true);
        } else {
            $("input:checkbox").prop("checked", false);
        }
    });

    $("#selectDelete").click(function () {
        var arr = [];
        $(".select").each(function () {
            if($(this).is(":checked") == true){
                arr.push($(this).attr("data-idx"));
            }
        });

        var q = confirm("총 " + arr.length + "개의 리뷰를 삭제하시겠습니까?\n" + arr);

        if (q) {
            $.ajax({
                type : "post",
                url : "/review/delete",
                data : {
                    arr : arr
                },
                success : function (data) {
                    if(data == "OK") {
                        alert("삭제되었습니다.");
                        window.location.reload();
                    } else {
                        alert("실패했습니다.");
                        window.location.reload();
                    }
                }
            });
        } else {
            return;
        }
    });

    $(".review").click(function (event) {
        event.preventDefault();
        var idx = $(this).attr("data-idx");
        var target = $("#review-content" + idx);
        if (target.css("display") == "none") {
            target.show();
        } else {
            target.hide();
        }
    });

    $(".deleteReview").click(function (event) {
        event.preventDefault();
        var q = confirm('삭제 하시겠습니까?');
        if (q) {
            var arr = [];
            arr.push($(this).attr("data-idx"));

            $.ajax({
                type : "post",
                url : "/review/delete",
                data : {
                    arr : arr
                },
                success : function (data) {
                    if(data == "OK") {
                        alert("삭제되었습니다.");
                        window.location.reload();
                    } else {
                        alert("실패했습니다.");
                        window.location.reload();
                    }
                }
            });
        }
    });
});