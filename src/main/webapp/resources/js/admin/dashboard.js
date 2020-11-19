function randomColor() {
    var color_r = Math.floor(Math.random() * 255);
    var color_g = Math.floor(Math.random() * 255);
    var color_b = Math.floor(Math.random() * 255);
    var color = 'rgba(' + color_r + "," + color_g + ',' + color_b + ', 0.8)'
    return color;
}

function makeChart(title, type, url, target) {
    var colors = [];
    var labels;
    var datas;
    $.ajax({
        type : 'get',
        url : url,
        success : function(data) {
            labels = data.map(function (e) {
                return e.LABEL;
            });
            datas = data.map(function (e) {
                return e.DATA;
            });

            for (var i = 0; i < data.length; i++) {
                colors.push(randomColor());
            }

            var ctx = document.getElementById(target).getContext('2d');
            var myChart = new Chart(ctx, {
                type: type,
                data: {
                    labels: labels,
                    datasets: [{
                        label: title,
                        data: datas,
                        backgroundColor: colors,
                        borderColor: colors,
                        borderWidth: 1
                    }]
                },
                options: {
                    title : {
                        display : true,
                        text : title
                    },
                    responsive : false,
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });
        }
    });


}
makeChart("일별 주문한 상품 갯수" ,"bar" ,"/static/getSalesDaily", "myChart");
makeChart("판매량" ,"horizontalBar" ,"/static/getSalesByProduct", "myChart2");
makeChart("가입자 추이" ,"line" ,"/static/getDailySignedUp", "myChart3");
makeChart("일별 매출", "bar", "/static/getDailyTotal", "dailyTotal");