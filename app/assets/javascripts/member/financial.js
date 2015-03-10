$(document).ready(function(){
   $("#developer_team_cardtype").change(function(){
        if($(this).val()=="ID") {
            $("#idimg1").text("身份证正面：")
            $("#outSpanId").css("display","inline")
        } else {
            $("#idimg1").text("护照：")
            $("#outSpanId").css("display","none")
        }
   });

    $("#modif").click(function(){
       var disply = $(".datalist").css("display");
       if(disply=="none") {
           $("#modif").text("展开成员列表")
           $(".datalist").css("display","");
       } else {
           $("#modif").text("收起成员列表")
           $(".datalist").css("display","none");
       }
    });
    $("#addteammate").click(function(){
       $("#panel-addteammenmer").css("display","");
    });
});