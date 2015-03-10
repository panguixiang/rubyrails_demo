//= require jquery_ujs
var jsonStr = {
    "a1_a11son":"/member/login/developerIndex","a2_a21son":"/member/app_manager/index","a3_a31son":"/member/financial/index",
    "a4_a41son":"/member/integral_walls","a11son":"/member/login/developerIndex","a12son":"/member/notification/note",
    "a13son":"/member/member_info/edit","a14son":"/member/changepswd/edit","a21son":"/member/app_manager/index",
    "a22son":"/member/app_statics","a31son":"/member/financial/index",
    "a32son":"/member/financial/deverWithdraw","a33son":"/member/income/index","a41son":"/member/integral_walls",
    "a42son":"/member/intelwal_statics"};
$(document).ready(function(){
    $(".tabitem").click(function(){
        var faMeanId = $(this).attr("id");
        $.cookie("meanId", faMeanId,{path:"/member"});
        $.cookie("meanSonId", faMeanId.split("_")[1],{path:"/member"});
        location.href=jsonStr[faMeanId];
    });
    $(".item").click(function(){
        var sonMeanId = $(this).attr("id");
        $.cookie("meanId", sonMeanId.substring(0,2)+"_"+sonMeanId.substring(0,2)+"1son",{path:"/member"});
        $.cookie("meanSonId", sonMeanId,{path:"/member"});
        location.href=jsonStr[sonMeanId];
    });
    $(".tabitem").removeClass("active");
    $(".item").removeClass("active2");
    $("#"+$.cookie("meanId")).addClass("active");
    $("#"+$.cookie("meanSonId")).addClass("active2");
    $(".secondlevelwrap").css("display","none");
    $("#"+$.cookie("meanSonId")).parent().css("display","");

    $('#sm_user').on('mouseover',function(){
       $(this).addClass("sm_people_hover");
       $('#sm_user_list').css('display','block');
    });
    $("#msgcount").on('mouseout',function(){
        $(this).removeClass("sm_people_hover");
        $('#sm_user_list').css('display','none');
    });
    $("#btn_logout").on('mouseout',function(){
        $(this).removeClass("sm_people_hover");
        $('#sm_user_list').css('display','none');
    });

});

var getDate=function(str){
    var tempDate=new Date();
    var list=str.split("-");
    tempDate.setFullYear(list[0]);
    tempDate.setMonth(list[1]-1);
    tempDate.setDate(list[2]);
    return tempDate;
};
function createDateBetween(value1,value2){
    var dataArr = new Array();
    var date1;
    if(value1) {
        date1=getDate(value1);
    } else {
        date1=new Date();
    }
    var date2=getDate(value2);
    if(date1>date2){
        var tempDate=date1;
        date1=date2;
        date2=tempDate;
    }
    while(!(date1.getFullYear()==date2.getFullYear()
        &&date1.getMonth()==date2.getMonth()
        &&date1.getDate()==date2.getDate())){
        dataArr.push(date1.getFullYear()+"-"+ createTwoStr(date1.getMonth()+1)
            +"-"+createTwoStr(date1.getDate()));
        date1.setDate(date1.getDate()+1);
    }
    dataArr.push(date2.getFullYear()+"-"+ createTwoStr(date2.getMonth()+1)
        +"-"+createTwoStr(date2.getDate()));
    return dataArr;
}

function createTwoStr(index) {
    if(parseInt(index)<10) {
        index="0"+index;
    }
    return index;
}
//改变时间格式//
function getLocalTime(nS) {
    var date = new Date(nS);
    var str = date.getFullYear()+"-"+ date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes();
    return str;
}