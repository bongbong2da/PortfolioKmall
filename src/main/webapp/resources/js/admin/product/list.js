$(function () {
    $.ajax({
        type: "get",
        url: "/product/getCategories",
        success: function (data) {
            data.forEach(function (category) {
                $("#categories").append('<option class="prntCategory" value="' + category.cate_curr + '">' + category.cate_name + '</option>');
            });
        }
    });

    $("#categories").change(function () {
        $(".childCategory").remove();
        var category = $("#categories").val();

        $.ajax({
            type: "get",
            url: "/product/getChildCategories",
            data: {category: category},
            success: function (data) {
                data.forEach(function (category) {
                    $("#childCategories").append('<option class="childCategory" value="' + category.cate_curr + '">' + category.cate_name + '</option>');
                });
            }
        })
    });

    $("#adSearch").submit(function (event) {
        if (!$("#childCategories").val() == '') {
            var val = $("#childCategories").val();
            $("#adSearch").append('<input type="hidden" name="category" value="' + val + '"/>');
        } else {
            var val = $("#categories").val().substring(0, 1);
            $("#adSearch").append('<input type="hidden" name="category" value="' + val + '"/>');
        }
    });

    $(".delBtn").click(function () {
        var idx = $(this).attr("name");
        var q = confirm("정말로 삭제하시겠습니까?");
        if (q) {
            window.location.href = "/admin/product/delete?idx=" + idx;
        }
    });
});