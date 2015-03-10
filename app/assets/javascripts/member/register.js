
$(document).ready(function(){
    function change_input_bg(el,id){
        el.className="input_active";
        var warn=document.getElementById(id);
        var a=el.parentNode;
        a.parentNode.className="inputlist_active inputlist";
        warn.style.visibility="hidden";
    }
    $('#member_email').on('focus',function(){
        change_input_bg(this,'email_warn_box');
    }).on('blur',function(){
        checkNulsl(this);
        this.parentNode.parentNode.className="inputlist";
    });
    $('#member_password').on('focus',function(){
        change_input_bg(this,'pw_warn_box');
    }).on('blur',function(){
        checkNulsl(this);
        this.parentNode.parentNode.className="inputlist";
    });;
    $('#member_password_confirmation').on('focus',function(){
        change_input_bg(this,'repw_warn_box');
    }).on('blur',function(){
        checkNulsl(this);
        this.parentNode.parentNode.className="inputlist";
    });;
    $('#verifyCode').on('focus',function(){
        change_input_bg(this,'verifycode_warn_box');
    }).on('blur',function(){
        checkNulsl(this);
        this.parentNode.parentNode.className="inputlist";
    });;
    function myResize(){
        if(!('innerWidth' in window)){
            window.innerWidth = document.documentElement.clientWidth;
            window.innerHeight = document.documentElement.clientHeight;
        }
        var tmpHeight = $('.inputarea').height();
        var tmpTop = Math.max(0,(window.innerHeight-tmpHeight)/3);
        $('#page').css('padding-top',tmpTop);
    }
    $(window).resize(myResize);
    myResize();
    $("#changCapte").click(function(){
        $.ajax({
            url:'/member/login/create_capte',
            type:'get',
            success:function(data) {
                $("#changeId").text(data);
            }
        })
    });
});

function checkNulsl(obj) {
    if($.trim($(obj).val()).length==0) {
        $(obj).parent().prev().css("visibility","visible");
    } else {
        $(obj).parent().prev().css("visibility","hidden");
    }
}
			