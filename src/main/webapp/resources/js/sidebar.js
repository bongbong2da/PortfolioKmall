$(function () {
    $("#popLoginSidebar").click(function () {
        window.open("/member/loginPop", "a", "width=400,height=430,left=200,top=100");
    });

    $.ajax({
        type: 'get',
        url: '/product/getCategories',
        success: function (data) {
            $.each(data, function (key, value) {
                $("#categories").append('<li id="' + value.cate_curr + '"  class="nav-item treeview">\n' +
                    '<a class="category nav-link lead" href="/product/getProducts?page=1&category=' + value.cate_curr.substring(0,1) + '">' +
                    '<i class="far fa-circle nav-icon"></i>\n' +
                    '<p>' + value.cate_name + '</p></a>\n' +
                    '</li>');

                $.ajax({
                    type: 'get',
                    url: '/product/getChildCategories',
                    data: {category: value.cate_curr},
                    success: function (data) {
                        $.each(data, function (key, value) {
                            $('#' + value.cate_prnt).append('<ul class="treeview-menu"><li>\n' +
                                '<a id="' + value.cate_curr + '" class="nav-link" href="/product/getProducts?page=1&category=' + value.cate_curr + '">' +
                                '<p>' + value.cate_name + '</p></a></li>\n' +
                                '</ul>');
                        });
                    }
                });
            });
        }
    });
});