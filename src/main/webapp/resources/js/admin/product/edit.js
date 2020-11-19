var uploadedFile;

function printThumbnail(fileName) {
    $(".thumbnail").remove();
    $("#imgBox").append('<img class="thumbnail" src="/upload/getThumbnail?src=' + fileName + '">');
}

$(function () {
    $.ajax({
        type: "get",
        url: "/products/getCategories",
        success: function (data) {
            data.forEach(function (category) {
                if((category.cate_curr.charAt(0)) == ('${product.cate_curr}'.charAt(0))) {
                    $("#mCategories").append('<option value="' + category.cate_curr + '" selected>' + category.cate_name + '</option>');

                    $.ajax({
                        type: "get",
                        url: "/products/getChildCategories",
                        data: {category: category.cate_curr},
                        success: function (data) {
                            data.forEach(function (category) {
                                if(category.cate_curr == '${product.cate_curr}') {
                                    $("#mChildCategories").append('<option class="mChildCategory" value="' + category.cate_curr + '" selected>' + category.cate_name + '</option>');
                                } else {
                                    $("#mChildCategories").append('<option class="mChildCategory" value="' + category.cate_curr + '">' + category.cate_name + '</option>');
                                }
                            });
                        }
                    });
                } else {
                    $("#mCategories").append('<option value="' + category.cate_curr + '">' + category.cate_name + '</option>');
                }
            });
        }
    });

    $("#mCategories").change(function () {
        $(".mChildCategory").remove();
        var category = $("#mCategories").val();

        $.ajax({
            type: "get",
            url: "/products/getChildCategories",
            data: {category: category},
            success: function (data) {
                data.forEach(function (category) {
                    $("#mChildCategories").append('<option class="mChildCategory" value="' + category.cate_curr + '">' + category.cate_name + '</option>');
                });
            }
        });
    });

    $("#img").change(function () {
        $(".attach").remove();

        var file = $(this).prop("files")[0];

        var formData = new FormData();

        formData.append("upload", file);

        $.ajax({
            type: "post",
            url: "/upload/uploadAjax",
            enctype: 'multipart/form-data',
            dataType: 'text',
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                if(data == "file.png") {
                    $(".thumbnail").remove();
                    $("#imgBox").append('<img class="thumbnail" src="/resources/images/file.png">');
                    $("#form").append('<input type="hidden" name="prdt_img" value="file.png">');
                    return;
                }
                uploadedFile = data
                printThumbnail(data);
                $("#form").append('<input type="hidden" name="prdt_img" value="' + uploadedFile + '">');
            }

        });
    });

    $("#form").submit(function (event) {
        event.preventDefault();

        if ($("[name='prdt_discnt']").val() > 1) {
            alert("할인율은 1을 넘길 수 없습니다 (1 = 100%)");
            return;
        }

        if ($("#mChildCategories").val() !== '') {
            $("#mChildCategories").attr("name", "cate_curr");
        } else {
            $("#mCategories").attr("name", "cate_curr");
        }

        $("#form").get(0).submit();
    });
});