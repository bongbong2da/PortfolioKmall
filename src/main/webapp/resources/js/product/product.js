//장바구니에 입력 갯수만큼 추가해주는 메소드
$(function () {

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

    $("#reviews").on("click", ".deleteReview", function () {
        var q = confirm("리뷰를 삭제하시겠습니까?");

        if (q) {
            var review_idx = $(this).attr("data-review_idx");
            var arr = [];
            arr.push(review_idx);
            $.ajax({
                type: "post",
                url: "/review/delete",
                data: {
                    arr: arr
                },
                success: function (data) {
                    if(data == 'OK') {
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
});