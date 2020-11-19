function daumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            var roadAddr = data.roadAddress; // 도로명 주소 변수

            document.getElementById('mem_postcode').value = data.zonecode;
            document.getElementById("mem_roadname").value = roadAddr;
            document.getElementById("mem_addr").value = data.jibunAddress;

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

$(function () {
    $("#updateForm").submit(function (event) {
        //event.preventDefault();
        if ($('#mem_email_check').is(":checked") === true) {
            $('#mem_email_check').val('Y');
        } else {
            $('#mem_email_check').val('N');
        }
        if ($('#manager').is(":checked") === true) {
            $('#manager').val('Y');
        } else {
            $('#manager').val('N');
        }
    });
});