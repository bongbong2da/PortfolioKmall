function printProducts(target, array){
    $("#" + target).jqGrid({
        datatype: "local",
        height: 300,
        autowidth: true,
        colNames:['상품 번호','카테고리', '상품 이름', '가격','할인율', '제조사', '이미지', '재고', '구매가능여부', '등록일', '수정일'],
        colModel:[
            {name:'prdt_idx', align:'right',editable:true},
            {name:'cate_curr', align:'right'},
            {name:'prdt_name', align:'right'},
            {name:'prdt_price', align:'right'},
            {name:'prdt_discnt', align:'right'},
            {name:'prdt_company', align:'right'},
            {name:'prdt_img', align:'right'},
            // {name:'prdt_detail', align:'right', hidden:true},
            {name:'prdt_stock', align:'right'},
            {name:'prdt_buyable', align:'right'},
            {name:'prdt_regdate', align:'right'},
            {name:'prdt_updatedate', align:'right'}
        ],
        multiselect: true,
        caption: "상품 데이터",
        rownumbers: true,
        rowList : [10,20,30,50,100]
    });

    for(var i in array){
        $("#" + target).jqGrid('addRowData',i+1,array[i]);
    }
}
function printMembers(target, array){
    $("#" + target).jqGrid({
        datatype: "local",
        height: 300,
        autowidth: true,
        colNames:['아이디','이름', '비밀번호', '우편번호','도로명', '주소', '상세주소', '번호', '닉네임', '이메일', '포인트','등록일','수정일','접속일','매니저'],
        colModel:[
            {name:'mem_id', align:'right'},
            {name:'mem_name', align:'right'},
            {name:'mem_passwd', align:'right'},
            {name:'mem_postcode', align:'right'},
            {name:'mem_roadname', align:'right'},
            {name:'mem_addr', align:'right'},
            {name:'mem_addr_detail', align:'right'},
            // {name:'prdt_detail', align:'right', hidden:true},
            {name:'mem_tel', align:'right'},
            {name:'mem_nickname', align:'right'},
            {name:'mem_email_check', align:'right'},
            {name:'mem_point', align:'right'},
            {name:'mem_regdate', align:'right'},
            {name:'mem_updatedate', align:'right'},
            {name:'mem_lastlogin', align:'right'},
            {name:'manager', align:'right'}
        ],
        multiselect: true,
        caption: "회원 데이터",
        rownumbers: true,
        rowList : [10,20,30,50,100]
    });

    for(var i in array){
        $("#" + target).jqGrid('addRowData',i+1,array[i]);
    }
}

function printReviews(target, array){
    $("#" + target).jqGrid({
        datatype: "local",
        height: 300,
        autowidth: true,
        colNames:['아이디','이름', '비밀번호', '우편번호','도로명', '주소', '상세주소', '번호', '닉네임', '이메일', '포인트','등록일','수정일','접속일','매니저'],
        colModel:[
            {name:'mem_id', align:'right'},
            {name:'mem_name', align:'right'},
            {name:'mem_passwd', align:'right'},
            {name:'mem_postcode', align:'right'},
            {name:'mem_roadname', align:'right'},
            {name:'mem_addr', align:'right'},
            {name:'mem_addr_detail', align:'right'},
            // {name:'prdt_detail', align:'right', hidden:true},
            {name:'mem_tel', align:'right'},
            {name:'mem_nickname', align:'right'},
            {name:'mem_email_check', align:'right'},
            {name:'mem_point', align:'right'},
            {name:'mem_regdate', align:'right'},
            {name:'mem_updatedate', align:'right'},
            {name:'mem_lastlogin', align:'right'},
            {name:'manager', align:'right'}
        ],
        multiselect: true,
        caption: "회원 데이터",
        rownumbers: true,
        rowList : [10,20,30,50,100]
    });

    for(var i in array){
        $("#" + target).jqGrid('addRowData',i+1,array[i]);
    }
}

$.ajax({
    type: "get",
    url : "/product/getProducts/1",
    success : function(data) {
        printProducts("productList", data.prList);
    }
})
$.ajax({
    type: "post",
    url : "/admin/member/list",
    success : function(data) {
        printMembers("memberList", data);
    }
})
