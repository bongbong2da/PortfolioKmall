$(function () {
    $.ajax({
        type : "get",
        url : "/product/getCategories",
        success : function (data) {
            data.forEach(function (category) {
                $("#categories").append('<option class="category category-edit" value="'+category.cate_curr+'" name="'+category.cate_name+'">('+category.cate_curr+')'+category.cate_name+'</option>');
            });

            $(".category").click(function() {
                var category = $(this).val();
                var cate_name = $(this).attr("name");
                $.ajax({
                    type : "get",
                    url : "/product/getChildCategories",
                    data : {category : category},
                    success : function (data) {
                        $("#cate_curr").val(category);
                        $("#cate_name").val(cate_name);
                        $("#child_cate_prnt").val(category);
                        $(".childCategory").remove();
                        data.forEach(function (category) {
                            $("#childCategories").append('<option class="childCategory category-edit" value="'+category.cate_curr+'" name="'+ category.cate_name +'">('+category.cate_curr+')'+category.cate_name+'</option>');
                        });
                    }
                });
            });
        }
    });

    $("#addCategory").click(function () {
        var cate_curr = $("#cate_curr").val();
        var cate_name = $("#cate_name").val();
        if(cate_name == ''){
            alert("카테고리 이름을 입력해주세요.");
            $("#cate_name").focus();
            return;
        }

        $.ajax({
            type : "get",
            url : "/admin/category/add",
            data : {cate_curr : cate_curr,
                cate_name : cate_name},
            success : function (data) {
                if(data == "OK") {
                    alert("추가 되었습니다.");
                    window.location.reload();
                } else {
                    alert("추가에 실패했습니다.");
                    window.location.reload();
                }
            }
        });
    });

    $("#addChildCategory").click(function () {
        var cate_prnt = $("#child_cate_prnt").val();
        if(cate_prnt == ''){
            alert("상위 카테고리를 클릭해주세요.");
            return;
        }
        var cate_curr = cate_prnt.substring(0,1) + $("#child_cate_curr").val();
        var cate_name = $("#child_cate_name").val();
        if(cate_name == ''){
            alert("카테고리 이름을 입력해주세요.");
            $("#child_cate_name").focus();
            return;
        }

        $.ajax({
            type : "get",
            url : "/admin/category/add",
            data : {cate_curr : cate_curr,
                cate_prnt : cate_prnt,
                cate_name : cate_name},
            success : function (data) {
                if(data == "OK") {
                    alert("추가 되었습니다.");
                    window.location.reload();
                } else {
                    alert("추가에 실패했습니다.");
                    window.location.reload();
                }
            }
        });
    });

    $("#deleteCategory").click(function () {
        var category = $("#categories").find(":selected").val();
        $.ajax({
            type : "get",
            url : "/admin/category/delete",
            data : {category, category},
            success : function (data) {
                if(data == "OK") {
                    alert("삭제 되었습니다.");
                    window.location.reload();
                } else {
                    alert(data);
                    window.location.reload();
                }
            }
        });
    });

    $("#deleteChildCategory").click(function () {
        var category = $("#childCategories").find(":selected").val();

        $.ajax({
            type : "get",
            url : "/admin/category/delete",
            data : {category, category},
            success : function (data) {
                if(data == "OK") {
                    alert("삭제 되었습니다.");
                    window.location.reload();
                } else {
                    alert(data);
                    window.location.reload();
                }
            }
        });
    });

    $("body").on("dblclick", ".category-edit", function () {
        var cate_name = $(this).attr("name");
        var cate_curr = $(this).val();
        $("#modal-cate-curr").val(cate_curr);
        $("#modal-cate-name").val(cate_name);
        $("#editCategoryModal").modal('show');
    });

    $("#modalSubmit").click(function () {
        var query = $("#modalForm").serialize();
        $.ajax({
            type : "get",
            url : "/admin/category/editName",
            data : query,
            success : function(data) {
                if(data == 'OK') {
                    alert("수정되었습니다.");
                    window.location.reload();
                } else {
                    alert("실패했습니다.");
                    window.location.reload();
                }
            }
        })
    });

});