<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
    <style>
        th {
            width: 100px;
        }
    </style>
    <script>
        //초기화 및 수량 변경시 가격을 계산해주는 함수
        function calcPrice() {
            $("#totalPrice").remove();
            let total_price = 0;
            $(".cart").each(function () {
                if(!$(this).find(".check").is(":checked")) {
                    return true;
                }
                let priceSource = $(this).find(".price").attr("data-price");
                let price = parseInt(priceSource);
                let amount = parseInt($(this).find(".cart-amount").val());
                total_price += price * amount;
            });
            $("#priceSpace").append('<p id="totalPrice" colspan="6" class="text-right" data-price="' + total_price + '"> 총 금액 : ' + total_price + '원</p>');
        }

        $(function () {
            //수량을 변경할 시 가격 계산
            $(".cart-amount").on("change keyup paste input", function () {
                calcPrice();
            });

            //체크박스를 선택/해제 할 시 가격 계산
            $(".check").on("change keyup paste input", function () {
                calcPrice();
            });

            //수량변경 버튼을 클릭 할 시 이벤트
            $(".cart").on("click", ".set-amount", function (event) {
                event.preventDefault();
                var cart_idx = $(this).attr("name");
                var prdt_idx = $(this).val();
                var cart_amount = $("input[name=cart_amount_" + cart_idx + "]").val();
                var buyable;

                //수량을 변경하는 해당 상품 정보를 가져와
                //주문 수량과 재고 수량을 비교한다.
                $.ajax({
                    type : "post",
                    url : "/product/getProductAjax",
                    data : {idx : prdt_idx},
                    success : function(data) {
                        if(data.prdt_stock < cart_amount) {
                            alert("수량이 부족합니다.");
                            buyable = false;
                            window.location.reload();
                        } else {
                            $.ajax({
                                type : "post",
                                url : "/cart/setAmount",
                                data : {cart_idx : cart_idx,
                                    prdt_idx : prdt_idx,
                                    cart_amount : cart_amount},
                                success : function (data) {
                                    if(data == "OK") {
                                        alert("변경 되었습니다.");
                                    } else {
                                        alert("수량변경을 실패했습니다.");
                                        window.location.reload();
                                    }
                                }
                            });
                        }
                    }
                });
            });

            //삭제 버튼을 클릭 할 시 이벤트
            $(".cart").on("click", ".delete", function (event) {
                event.preventDefault();
                var q = confirm("정말로 삭제 하시겠습니까?");
                if(q) {
                } else return;

                var src = $(this).attr("name");
                var idx = parseInt(src);

                $.ajax({
                    type : "get",
                    url : "/cart/delete",
                    data : {idx : idx},
                    success : function (data) {
                        window.location.reload();
                    }
                });

            })

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
                event.preventDefault();
                let query = [];
                $("input:checkbox[name='idx[]']:checked").each(function () {
                    query.push($(this).val());
                });

                if(query.length == 0) {
                    alert("선택된 상품이 없습니다.");
                    return;
                }

                $.ajax({
                    type: 'post',
                    url: "/cart/delete",
                    data: {idx: query, mem_id: "${user.mem_id}"},
                    success: function (data) {
                        if(data == "OK") {
                            alert("성공적으로 삭제했습니다.");
                            window.location.href = "/cart/goCart";
                        } else {
                            alert("삭제에 실패했습니다.");
                            window.location.href = "/cart/goCart";
                        }
                    }
                })

            });

            $("#orderForm").submit(function () {
                var check;
                $(".cart").each(function (cart) {
                    if($(this).find('input:checkbox').prop("checked")) {
                        check = true;
                    }
                });

                if(check) {
                    //체크가 되어있지 않은 상품은 삭제 후 진행
                    $(".cart").each(function () {
                        if (!$(this).find(".check").is(":checked")) {
                            $(this).remove();
                        }
                    });
                } else {
                    alert("체크된 상품이 없습니다.");
                    event.preventDefault();
                    return;
                }
            });
        });
    </script>
</head>
<jsp:include page="../header.jsp"/>
<jsp:include page="../sidebar.jsp"/>
<body class="sidebar-mini layout-fixed">
<div class="content-wrapper">
    <div class="content p-5">
        <div class="card p-3 elevation-4">
            <div class="card-header">
                <h2 class="display-4">장바구니</h2>
            </div>
            <div class="card-body text-center">
                <form id="orderForm" action="/order/goOrder" method="post">
                    <input type="hidden" name="id" value="${user.mem_id}">
                    <table id="cartList" class="table table-striped table-hover">
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAll" checked>
                            </th>
                            <th style="width: 20px;">번호</th>
                            <th>제품</th>
                            <th>썸네일</th>
                            <th>가격</th>
                            <th>수량</th>
                        </tr>
                        <c:forEach items="${cartList}" var="cart">
                        <tr class="cart">
                            <input type="hidden" name="cart_idx" value="${cart.cart_idx}">
                            <th><input class="check" type="checkbox" name="idx[]" value="${cart.prdt_idx}" checked></th>
                            <td>${cart.prdt_idx}</td>
                            <td>
                                <a class="product" href="/products/getProduct?idx=${cart.prdt_idx}">${cart.prdt_name}</a>
                            </td>
                            <td>
                                <img style="width: 50px; height: 50px" class="card-img-top thumbnail"
                                     src="/upload/getThumbnail?src=${cart.prdt_img}" alt="Card image cap">
                            </td>
                            <td class="price" data-price="${cart.prdt_price}">${cart.prdt_price}원</td>
                            <td><input style="width: 50px" class="form-control-sm cart-amount" type="number" name="cart_amount_${cart.cart_idx}"
                                       value="${cart.cart_amount}">
                                <button class="btn-sm btn-info set-amount" name="${cart.cart_idx}" value="${cart.prdt_idx}">수량 변경</button>
                                <button class="btn-sm btn-danger delete" name="${cart.prdt_idx}">삭제</button>
                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                    <div class="bg-light p-3 m-1" id="priceSpace"></div>
                    <input class="btn btn-primary" type="submit" value="주문하기">
                    <button class="btn btn-danger" id="selectDelete">선택 삭제</button>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer.jsp"/>
<script id="cart" type="text/x-handlebars-template">
    {{#each .}}
    <tr class="cart">
        <input type="hidden" name="cart_idx" value="{{cart_idx}}">
        <th><input class="check" type="checkbox" name="idx[]" id="" value="{{prdt_idx}}" checked></th>
        <td>{{prdt_idx}}</td>
        <td>
            <a class="product" href="/products/getProduct?idx={{prdt_idx}}">{{prdt_name}}</a>
        </td>
        <td>
            <img style="width: 50px; height: 50px" class="card-img-top thumbnail"
                 src="/upload/getThumbnail?src={{prdt_img }}" alt="Card image cap">
        </td>
        <td class="price" data-price="{{prdt_price}}">{{prdt_price}}원</td>
        <td><input style="width: 50px" class="form-control-sm cart-amount" type="number" name="cart_amount_{{cart_idx}}"
                   value="{{cart_amount}}">
            <button class="btn-sm btn-info set-amount" name="{{cart_idx}}" value="{{prdt_idx}}">수량 변경</button></a>
            <button class="btn-sm btn-danger delete" name="{{prdt_idx}}">삭제</button>
        </td>
    </tr>
    {{/each}}
</script>
</body>
