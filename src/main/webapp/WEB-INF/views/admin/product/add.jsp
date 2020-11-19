    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE HTML>
    <html>
    <head>
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
        <script src="/resources/ckeditor4/ckeditor.js"></script>
        <script src="/resources/js/admin/product/add.js"></script>
    </head>
    <jsp:include page="../adminHeader.jsp"/>
    <jsp:include page="../adminSidebar.jsp"/>
    <body class="sidebar-mini layout-fixed">
    <div class="content-wrapper">
        <div class="content p-5">
            <div class="card p-3 elevation-4">
                <div class="card-header">
                    <h2 class="display-4">상품 등록</h2>
                </div>
                <div class="card-body">
                    <form id="form" action="/admin/product/add" method="post">
                        카테고리<br>
                        <select class="form-control" id="rCategories">
                            <option value="">필수 선택</option>
                        </select><br>
                        <select class="form-control" id="rChildCategories">
                            <option value="">선택하지 않음</option>
                        </select><br>
                        상품 이름<br>
                        <input class="form-control" name="prdt_name" type="text" required><br>
                        가격<br>
                        <input class="form-control" name="prdt_price" type="number" required><br>
                        할인율 (0.0 ~ 1)<br>
                        <input class="form-control" name="prdt_discnt" type="text" required><br>
                        제조사<br>
                        <input class="form-control" name="prdt_company" type="text" required><br>
                        상품 설명<br><br>

                        <textarea class="float-center" name="prdt_detail" id="editor1" rows="30" cols="200"></textarea>

                        <script type="text/javascript">
                            CKEDITOR.replace('editor1', {
                                filebrowserUploadUrl: '/upload/uploadCKE',
                            });
                        </script>

                        대표 이미지<br>
                        <input id="img" class="form-control" type="file" required><br>
                        <div id="imgBox">

                        </div>
                        재고<br>
                        <input class="form-control" type="number" name="prdt_stock" id="" value="0" required><br>
                        <input class="form-control btn btn-primary" type="submit" value="등록">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../../footer.jsp"/>
    </body>