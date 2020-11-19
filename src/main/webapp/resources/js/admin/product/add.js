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
                $("#rCategories").append('<option value="' + category.cate_curr + '">' + category.cate_name + '</option>');
            });
        }
    });

    $("#img").change(function (event) {
        var file = $(this).prop("files")[0];
        var formData = new FormData();
        formData.append("upload", file);

        $.ajax({
            type: "post",
            url: "/upload/upload",
            enctype: 'multipart/form-data',
            dataType: 'text',
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                alert(data);
                uploadedFile = data;
                printThumbnail(data);
            }

        });
    });

    $("#rCategories").change(function () {
        $(".rChildCategory").remove();
        var category = $("#rCategories").val();

        $.ajax({
            type: "get",
            url: "/products/getChildCategories",
            data: {category: category},
            success: function (data) {
                data.forEach(function (category) {
                    $("#rChildCategories").append('<option class="rChildCategory" value="' + category.cate_curr + '">' + category.cate_name + '</option>');
                });
            }
        });
    });

    $("#form").submit(function (event) {
        event.preventDefault();

        if ($("[name='prdt_discnt']").val() > 1) {
            alert("할인율은 1을 넘길 수 없습니다 (1 = 100%)");
            return;
        }

        if ($("#rChildCategories").val() !== '') {
            $("#rChildCategories").attr("name", "cate_curr");
        } else {
            $("#rCategories").attr("name", "cate_curr");
        }

        $(this).append('<input type="hidden" name="prdt_img" value="' + uploadedFile + '">');

        $("#form").get(0).submit();
    });
});