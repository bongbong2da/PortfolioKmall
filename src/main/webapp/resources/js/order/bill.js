function daumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            var roadAddr = data.roadAddress; // 도로명 주소 변수

            document.getElementById('od_postcode').value = data.zonecode;
            document.getElementById("od_roadname").value = roadAddr;
            document.getElementById("od_addr").value = data.jibunAddress;

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

function printThumbnail(fileName, target) {
    console.log("print thumbnail...");
    $(".thumbnail").remove();
    target.append('<img class="thumbnail" src="/upload/getThumbnail?src=' + fileName + '">');
}

$(function () {
    jQuery.noConflict();
    $("#editReceiveInfo").click(function () {
       $("#editReceiveInfoModal").modal('show');
    });

    $("#modalSubmit").click(function () {
       $("#modalForm").submit();
    });

    //
    $(".write-review").click(function () {
        var od_idx = parseInt($(this).attr("data-od"));
        var prdt_idx = parseInt($(this).attr("data-prdt"));
        $.ajax({
            type: "get",
            url: "/review/isDuplicated",
            data: {
                od_idx: od_idx,
                prdt_idx: prdt_idx
            },
            success: function (data) {
                if (data == "OK") {
                    $("#review" + prdt_idx).show();
                } else if (data == "NO") {
                    alert("이미 리뷰를 남기셨습니다.");
                    return;
                }
            }
        });
    });

    $(".reviewForm").submit(function (event) {
        event.preventDefault();
        var query = $(this).serialize();
        $.ajax({
            type: "post",
            url: "/review/insertReview",
            data: query,
            success: function (data) {
                if (data == "OK") {
                    window.location.reload();
                } else {
                    alert("등록에 실패했습니다.");
                    window.location.reload();
                }
            }
        });
    });

    $(".review-img").change(function () {
        console.log("image changed...");
        $(".initImg").remove();
        var query = new FormData();
        var data = $(this).prop("files")[0];
        var prnt = $(this).parents(".reviewForm");
        console.log(prnt.html());
        query.append("upload", data);

        $.ajax({
            type: "post",
            url: "/upload/upload",
            data: query,
            enctype: "multipart/form-data",
            processData: false,
            contentType: false,
            success: function (data) {
                printThumbnail(data, prnt);
                prnt.append('<input class="review-img" type="hidden" name="review_img" value="' + data + '">');
            }
        });

    });

    $("#cancelOrder").click(function() {
        var q = confirm("정말로 주문을 취소하시겠습니까?\n환불이 진행됩니다.");
        if (q) {
            var od_idx = parseInt($(this).attr("data-idx"));
            $.ajax({
                type : "post",
                url : "/order/cancelOrder",
                data : {od_idx : od_idx},
                success : function (data) {
                    if(data == 'OK') {
                        alert("주문이 취소되었습니다.");
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