$(function () {
    $("#selectAll").change(function () {
        if ($("input:checkbox[id='selectAll']").is(":checked")) {
            $("input:checkbox").prop("checked", true);
        } else {
            $("input:checkbox").prop("checked", false);
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

    $("#collapse").click(function (event) {
        event.preventDefault();
        $(".board-content").hide();
    });

    $("#expand").click(function (event) {
        event.preventDefault();
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

    $("#selectDelete").click(function () {
        var idx = [];
        $(".check").each(function () {
            if ($(this).is(":checked") == true) {
                idx.push(parseInt($(this).attr("name")));
            }
        });

        if (idx.length <= 0) {
            alert("선택된 게시물이 없습니다.");
            return;
        }

        var q = confirm("총 " + idx.length + "개의 게시물을 삭제하시겠습니까?\n" + idx);

        if (q) {
            $.ajax({
                type: "post",
                url: "/board/delete",
                data: {
                    idx : idx
                },
                success: function (data) {
                    if (data == "OK") {
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