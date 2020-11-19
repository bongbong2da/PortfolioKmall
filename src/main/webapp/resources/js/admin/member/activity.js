$(function () {
    $(".summary").on("click", ".open", function () {

        var idx = $(this).attr("data-idx");
        var target = $("#update" + idx);

        if (target.css("display") == "none") {
            $(".update").hide();
            target.show();
        } else {
            target.hide();
        }
    });

    $(".board").on("click", function () {
        var idx = $(this).attr("data-idx");
        var target = $("#content" + idx);
        if (target.css("display") == "none") {
            target.show();
        } else {
            target.hide();
        }
    });

    $("#collapse").click(function () {
        $(".board-content").hide();
    });

    $("#expand").click(function () {
        $(".board-content").show();
    });

    $(".board-delete").click(function () {
        var q = confirm("정말로 삭제하시겠습니까?");

        if (q) {
            var idxSrc = parseInt($(this).attr("data-idx"));
            var idx = []
            idx.push(idxSrc);
            $.ajax({
                type: "post",
                url: "/board/delete",
                data: {
                    idx: idx
                },
                success: function (data) {
                    if (data == "OK") {
                        alert("삭제되었습니다.");
                        window.location.reload();
                    } else {
                        alert("삭제되었습니다.");
                        window.location.reload();
                    }
                }
            });
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