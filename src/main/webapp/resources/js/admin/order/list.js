$(function () {
    $(".summary").on("click", ".open", function () {

        var idx = $(this).attr("data-idx");
        var target = $("#update" + idx);

        if (target.css("display") == "none") {
            $(".update").hide();
            target.show();
        } else {
            target.hide();
        }
    });

    $("#selectAll").change(function () {
        if ($("input:checkbox[id='selectAll']").is(":checked")) {
            $("input:checkbox").prop("checked", true);
        } else {
            $("input:checkbox").prop("checked", false);
        }
    });

    $("#selectForm").submit(function (event) {
        var q = confirm("변경하시겠습니까?");
        if (q){
            var query = [];
            $(".select").each(function () {
                if ($(this).is(":checked")) {
                    query.push($(this).val());
                } else {
                    return true;
                }
            });
            $("#selectForm").append('<input type="hidden" name="idx" value="' + query + '">');
        } else {
            event.preventDefault();
            return;
        }

    });
});