$(document).ready(function(){
    $("#autoWithdraw").click(function(){
        if($(this).is(':checked')){
            message = "确定要开启自动提现功能？";
        }else{
            message = "确定要关闭自动提现功能？";
        }
        if(confirm(message)){
            $.ajax({
                url:'/member/financial/automatic',
                type:'get',
                success:function(data){
                    if(data=="1") {
                        $("#autoWithdraw_message").css("color","red").text("成功关闭自动提现功能");
                        $(".autoWithdraw_span").text("开启自动提现");
                    } else {
                        $(".autoWithdraw_span").text("关闭自动提现");
                        $("#autoWithdraw_message").css("color","red").text("成功开启自动提现功能");
                    }
                },
                error:function(a,b){
                    alert("异常操作，请联系管理员！");
                }
            });
        }
    });
});
function checkNull(max) {
    var money = $('#amountInput');
    if($.trim($(money).val()).length==0) {
        alert('请输入正确的提现金额');
        $(money).val('');
        $(money).focus();
        return false;
    }
    if (isNaN($(money).val())) {
        alert('请输入正确的提现金额');
        $(money).val('');
        $(money).focus();
        return false;
    } else if (parseInt($(money).val())<100) {
        alert('提现金额不能小于 100.00 元');
        $(money).val('');
        $(money).focus();
        return false;
    } else if (parseInt($(money).val())>parseInt(max)) {
        alert('单笔提现金额不能大于 '+max+'元');
        $(money).val('');
        $(money).focus();
        return false;
    }
    if(confirm('确认本次提现吗？')){
        location.href="/member/financial/amount?tocase="+$(money).val();
    }
}