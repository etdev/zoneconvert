$(function () {
  $('#datetimepicker1').datetimepicker();
});

$("#datepicker1").datepicker({
    showOn: 'button',
    onClose: function(dateText, inst)
    {
        $(this).attr("disabled", false);
    },
    beforeShow: function(input, inst)
    {
        $(this).attr("disabled", true);
    }
});
