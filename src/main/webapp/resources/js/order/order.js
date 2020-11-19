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

function printCart(data) {
    if (data == '') {
        $("#cartList").append('<tr class="text-center p-5"><th colspan="5"><h2 class="dispaly-5">표시할 품목이 없습니다.</h2></th></tr>');
    } else {
        let source = $("#cart").html();
        let template = Handlebars.compile(source);
        let complete = template(data);

        $("#cartList").append(complete);
    }

}

function calcPrice() {
    $("#totalPrice").text('');
    let sum_price = 0;
    $(".cart").each(function () {
        if (!$(this).find(".check").is(":checked")) {
            return true;
        }
        let priceSource = $(this).find("#od_price").attr("data-price");
        let price = parseInt(priceSource);
        let amount = parseInt($(this).find(".amount").val());
        sum_price += price * amount;
    });
    $("#sumPrice").text(sum_price);
    let total_price = sum_price - parseInt($("#usePoint").val());
    $("#totalPrice").text(total_price);
    $("#od_total_price").val(total_price);
}

$(function () {
    $("#orderAction").click(function (event) {
        event.preventDefault();

        $("#orderForm").submit();
    });

    $("#pointBtn").click(function (event) {
        event.preventDefault();

        let usePoint = parseInt($("#usePoint").val());

        if (usePoint > $("#mem_point").val()) {
            $("#usePoint").val(0);
            alert("포인트가 모자랍니다.");
            return;
        }

        $("#od_use_point").val(usePoint);

        calcPrice();
    });


    $("#selectAll").change(function () {
        if ($("input:checkbox[id='selectAll']").is(":checked") == true) {
            $("input:checkbox").prop("checked", true);
            calcPrice();
        } else {
            $("input:checkbox").prop("checked", false);
            calcPrice();
        }
    });

    $("#selectDelete").click(function (event) {
        //event.preventDefault();
        let query = [];
        $("input:checkbox[name='idx[]']:checked").each(function () {
            query.push($(this).val());
        });

        $.ajax({
            type: 'post',
            url: "/cart/delete",
            data: {idx: query, mem_id: "${user.mem_id}"},
            success: function (data) {
                alert(data);
            }
        })

    });

    $(".amount").change(function () {
        calcPrice();
    });

    //체크박스를 선택/해제 할 시 가격 계산
    $(".check").on("change keyup paste input", function () {
        calcPrice();
    });

    $("#orderForm").submit(function (event) {
        if($("input[name=od_method]").val() == '') {
            alert("결제 수단을 선택해야 합니다.");
            event.preventDefault();
            return;
        }

        if($("#infoAgree").is(":checked") == false) {
            alert("정보 제공 약관을 동의해야합니다.");
            event.preventDefault();
            return;
        }

        if($("#tradeAgree").is(":checked") == false) {
            alert("거래조건 약관을 동의해야합니다.");
            event.preventDefault();
            return;
        }

        let q = confirm("주문을 진행하시겠습니까?");

        if (q) {
            var check = false;
            //체크가 하나도 되어있지 않을 시 리턴
            $(".cart").each(function (cart) {
                if ($(this).find('input:checkbox').prop("checked")) {
                    check = true;
                }
            });

            if (check) {
                //체크가 되어있지 않은 상품은 삭제 후 진행
                $(".cart").each(function () {
                    if (!$(this).find(".check").is(":checked")) {
                        $(this).remove();
                    }
                });
            } else {
                alert("체크된 상품이 없습니다.");
                event.preventDefault();
            }
        } else {
            event.preventDefault();
        }

    });

    $("#same").click(function () {
        $("#od_postcode").val($("#mem_postcode").val());
        $("#od_roadname").val($("#mem_roadname").val());
        $("#od_addr").val($("#mem_addr").val());
        $("#od_addr_detail").val($("#mem_addr_detail").val());
        $("#od_tel").val($("#mem_tel").val());
    });
});