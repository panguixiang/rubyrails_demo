$(document).ready(function(){
    $(".nav").mouseover(function(){
        $(this).children().removeClass("menu_nor");
        $(this).children().addClass("menu_act");
        $(this).children().next().css("display","block");
    });
    $(".nav").mouseout(function(){
        $(this).children().removeClass("menu_act");
        $(this).children().addClass("menu_nor");
        $(this).children().next().css("display","none");
    });
    $(".more_nor").mouseover(function(){
        $("#nav_more").css("display","block");
     });
     $(".more_nor").mouseout(function(){
         $("#nav_more").css("display","none");
    });

    $(".up").click(function(){
        $('body,html').animate({scrollTop:0},1000);
        return false;
    });
    if($.cookie('email')) {
        $("#loigspan").css("display","none");
        $("#userspan").css("display","");
        $('#userNameIda').text($.cookie('email'));
    } else {
        $("#loigspan").css("display","");
        $("#userspan").css("display","none");
        $('#userNameIda').text('');
    }

    $('#userspan').on('mouseover',function(){
        $('#userlist').css('display','block');
    }).on('mouseout',function(){
        $('#userlist').css('display','none');
    });

});
window.onscroll = function() {
    if(document.getElementById("contact-said")){
        var _contact=document.getElementById("contact-said");
        var _scrolltop=document.documentElement.scrollTop || document.body.scrollTop;
        _contact.style.top=_scrolltop+230+'px';
    }
}
if(typeof(Worker) !== "undefined"){
    window.html5 = true;
}
else{
    window.html5 = false;
}
window.rAF = window.requestAnimationFrame
    ||window.webkitRequestAnimationFrame
    ||window.mozRequestAnimationFrame
    ||window.oRequestAnimationFrame
    ||window.msRequestAnimationFrame
    ||function (callback){window.setTimeout(callback, 1000 / 60);};