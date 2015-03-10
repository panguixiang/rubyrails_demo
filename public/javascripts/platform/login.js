$(document).ready(function(){
    if($.cookie("email")) {
        $("#loginForm").css("display","none");
        $("#role").css("display","");
        $("#usernameId").text($.cookie("email"));
    } else {
        $("#role").css("display","none");
        $("#loginForm").css("display","");
        $("#username").text('');
    }
});
