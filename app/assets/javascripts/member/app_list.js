
$(document).ready(function(){

    $(".customradio8").click(
        function(){
            $(this).attr("checked","checked");
            $(this).next().addClass("customradio_checked");
            $(".customradio16").next().removeClass("customradio_checked");
        });
    $(".customradio16").click(function(){
        $(this).attr("checked","checked");
        $(this).next().addClass("customradio_checked");
        $(".customradio8").next().removeClass("customradio_checked");

    });
    $(".ac_customCheckbox_change").click(function(){
        $(this).toggleClass("customCheckbox_checked");
    });

    $("#app_produ_app_content").keyup(function(){
        var length = 200;
        var text_left=length-$("#app_produ_app_content").val().length;
        if(text_left >=0){
            $("#testTextbox_maxLength_left").text('还可以输入'+text_left+'字');
        }else{
            alert("已到达上限");
        }
    });
    $(".iconS.icon_toggle_down").next().click(function(){
        $('.detail_group').removeClass("detail_group_expanded");
    });
    $(".iconS.icon_toggle_up").next().click(function(){
        $('.detail_group').addClass("detail_group_expanded");
    });
    $(".btn_gray").click(function(){
        $('.dis_h').attr({style:"display: table-row"});
        $('#adPlace_detail').removeClass("placementpanel_hide");
        $('#adPlace_detail').addClass("placementpanel_show");
    });
    $(".icon_cancel").click(function(){
        $('.dis_h').attr({style:"display: none"});
        $('#adPlace_detail').removeClass("placementpanel_show");
        $('#adPlace_detail').addClass("placementpanel_hide");
    });


    $("#advertising_adver_type").bind("change",function(){
        if($(this).val()==2 || $(this).val()==4 ){
            $('#videoSettings').attr({style:"display: block"});
        }
        else if($(this).val()==6){
            $('#nativeSettings').attr({style:"display: block"});
            $('#videoSettings').attr({style:"display: none"});
        }
        else {
            $('#videoSettings').attr({style:"display: none"});
            $('#nativeSettings').attr({style:"display: none"});
        }
    });
    $(".displayAppStatus").change(function(){
        toPage(1);
    });

    $(".displayAppSystem").change(function(){
        toPage(1);
    });
    $(".icon_search").click(function(){
        toPage(1)
    });
    $(".ac_addApp").click(function(){
        location.href='/member/app_add/index1';
    });
    $('.odd').mousemove(function(){
        var list = $(this).find('.appStatus');
        $(list).each(function(index,obj){
            $(this).find(".run_a").css("display","inline");
            $(this).find('.upload_a').css("display","inline");
        });
    });
    $('.odd').mouseout(function(){
        var list = $(this).find('.appStatus');
        $(list).each(function(index,obj){
            $(this).find(".run_a").css("display","none");
            $(this).find('.upload_a').css("display","none");
        });
    });
    $("#slideRules").click(function(){
        $("#slideRules").css("display","none");
        $(this).prev().removeClass('icon_slide_up');
        $(this).prev().addClass('icon_slide_down');
        $("#Rulesslide").css("display","inline");
        $(".rulesContainer").removeClass("rulesSlide");
    });
    $("#Rulesslide").click(function(){
        $("#slideRules").css("display","inline");
        $("#slideRules").prev().removeClass('icon_slide_down');
        $("#slideRules").prev().addClass('icon_slide_up');
        $("#Rulesslide").css("display","none");
        $(".rulesContainer").addClass("rulesSlide");
    });
    $("#iconCancel").click(function(){
        $("#slideRules").css("display","inline");
        $("#slideRules").prev().removeClass('icon_slide_down');
        $("#slideRules").prev().addClass('icon_slide_up');
        $("#Rulesslide").css("display","none");
        $(".rulesContainer").addClass("rulesSlide");

    });

    $(".btn_gray").click(function(){
        $('.dis_h').attr({style:"display: table-row"});
        $('#adPlace_detail').removeClass("placementpanel_hide");
        $('#adPlace_detail').addClass("placementpanel_show");
    });
    $(".icon_cancel").click(function(){
        $('.dis_h').attr({style:"display: none"});
        $('#adPlace_detail').removeClass("placementpanel_show");
        $('#adPlace_detail').addClass("placementpanel_hide");
    });


    $("#advertising_adver_type").bind("change",function(){
        if($(this).val()==2 || $(this).val()==4 ){
            $('#videoSettings').attr({style:"display: block"});
        }
        else if($(this).val()==6){
            $('#nativeSettings').attr({style:"display: block"});
            $('#videoSettings').attr({style:"display: none"});
        }
        else {
            $('#videoSettings').attr({style:"display: none"});
            $('#nativeSettings').attr({style:"display: none"});
        }
    });


    $('#new_advertising').on('ajax:success', function(event, data, status, xhr) {
        var htmlStr = createAdvertisTr(data);
        $("#sdfadsf23").append(htmlStr);
        $(".adPlaceErr").text("");
    }).on("ajax:error",function(e, xhr, status, error){
        jsonObj = xhr.responseJSON;
        for(var key in jsonObj) {
            $("#id"+key).css("color","red").text(jsonObj[key]);
        }
    });

 //应用设置页面//

    $(".ac_modifyRefresh").click(function(){
        $("#refreshDiv").removeClass("refreshDivNone");
    });

    $(".dd").click(function(){
        $(".dd").children("a").removeClass("active");
        $(this).children().addClass("active");
        $(".content").css("display","none");
        var ls =$(".dd").index(this);
        $(".content").each(function(index,obj){
           if(index==ls) {
               $(obj).css("display","block");
           }
        });
    });
//减少后过滤个数//
    $('.icon_false_url').on('ajax:success', function(event, data, status, xhr) {
        $(this).parent().parent().remove();
        $("#abdcdclass").text(data);
        $('.msg-success').text("过滤器已经成功删除！");
    }).on("ajax:error",function(e, xhr, status, error){
        alert("error");
    });

    $('.icon_false_url1').on('ajax:success', function(event, data, status, xhr) {
        $(this).parent().parent().remove();
        $("#abdcdclass1").text(data);
        $('.msg-success').text("过滤器已经成功删除！");
    }).on("ajax:error",function(e, xhr, status, error){
        alert("error");
    });



//增加后过滤个数//
    $('#submitForid').on('ajax:success', function(event, data, status, xhr) {
        createAppFilterTr(data);
        $('.msg-success').text("设置成功！");
        $("#abdcdclass").text(parseInt($("#abdcdclass").text())+1);
    }).on("ajax:error",function(e, xhr, status, error){
        alert("error");
    });


    $('#submitForid1').on('ajax:success', function(event, data, status, xhr) {
        createAppFilterTr(data);
        $('.msg-success').text("设置成功！");
        $("#abdcdclass1").text(parseInt($("#abdcdclass1").text())+1);
    }).on("ajax:error",function(e, xhr, status, error){
        alert("error");
    });

    $('#123').on('ajax:success', function(event, data, status, xhr) {
        $('.msg-success').text("设置成功！");
    }).on("ajax:error",function(e, xhr, status, error){
        alert("error");
    });

//多选//
    $("#checkMain").click(function(){
       if($(this).is(':checked')) {
           $(".urlChecker").prop("checked", true);
       }
       else {
           $(".urlChecker").prop("checked", false);
       }
    });

    $("#checkMain1").click(function(){
        if($(this).is(':checked')) {
            $(".urlChecker1").prop("checked", true);
        }
        else {
            $(".urlChecker1").prop("checked", false);
        }
    });



//多项选删除
$("#removeId").click(function(){
    var str='';
    $("input[name='customCheckbox1']:checked").each(function(){
        str+=$(this).val()+",";
    });
    $.ajax({
        url:'/member/appfilters/batchDestory',
        type:'get',
        data:{id:str},
        success:function(data) {
            $("input[name='customCheckbox1']:checked").each(function(){
                $("#urlFilters"+$(this).val()).remove();
            });
            $("#abdcdclass").text(data);
            $('.msg-success').text("过滤器已经成功删除！");
        },
        error:function(a,b) {
            alert("系统异常！")
        }
    });
});

    $("#removeId1").click(function(){
        var str='';
        $("input[name='customCheckbox2']:checked").each(function(){
            str+=$(this).val()+",";
        });
        $.ajax({
            url:'/member/appfilters/batchDestory',
            type:'get',
            data:{id:str},
            success:function(data) {
                $("input[name='customCheckbox2']:checked").each(function(){
                    $("#urlFilters"+$(this).val()).remove();
                })
                $("#abdcdclass1").text(data);
                $('.msg-success').text("过滤器已经成功删除！");
            },
            error:function(a,b) {
                alert("系统异常！")
            }
        });

    });

});
var s = function() {
        $('.icon_false_url').on('ajax:success', function (event, data, status, xhr) {
            $(this).parent().parent().remove();
            $("#abdcdclass").text(data);
            $('.msg-success').text("过滤器已经成功删除！");
        }).on("ajax:error", function (e, xhr, status, error) {
            alert("error");
        });
    };
var m = function() {
        $('.icon_false_url1').on('ajax:success', function (event, data, status, xhr) {
            $(this).parent().parent().remove();
            $("#abdcdclass1").text(data);
            $('.msg-success').text("过滤器已经成功删除！");
        }).on("ajax:error", function (e, xhr, status, error) {
            alert("error");
        });
};
function createAppFilterTr(data) {
    var tr = $("<tr id=urlFilters"+data.id+"></tr>");
    var td1 = $("<td class=filterTd></td>");
    if  (data.filter_type==1){
        var label=$("<label><input type=checkbox name=customCheckbox1 class=urlChecker value="+data.id+"></labe>");
    }
    else if (data.filter_type==2){
        var label=$("<label><input type=checkbox name=customCheckbox2 class=urlChecker1 value="+data.id+"></labe>");
    }

    td1.append(label);
    var td2= $("<td class=filterTd2>"+data.filter_content+"</td>");
    var td3 = $("<td><a class='icon iconM icon_false icon_false_url' data-confirm='您确定要删除吗?' "
        +"data-method='delete' data-remote='true' rel='nofollow' href=/member/appfilters/"+data.id+ ">删除</a>");
    $('.icon_false_url').unbind("click");
    if  (data.filter_type==1) {
        $(td3.find("a")).bind('click', function () {
            s();
        });
    }
    else if (data.filter_type==2){
        $(td3.find("a")).bind('click', function () {
            m();
        });
    }

    tr.append(td1);
    tr.append(td2);
    tr.append(td3);
    if  (data.filter_type==1){
       $("#add123").append(tr);
    }
    else if (data.filter_type==2){
        $("#add1234").append(tr);
    }
}


function toPage(page) {
    var status=$(".displayAppStatus").val();
    var system = $(".displayAppSystem").val();
    var mediaName = $("#mediaName").val();
    location.href="/member/app_manager/index?pageNum="+page+"&status="+status+"&platform="+system+"&appName="+mediaName;
}
function pausd(id) {
    $.ajax({
        url:'/member/app_manager/set_status',
        type:'get',
        data:{id:id},
        success:function(data) {
            var htmlStr = createAdvertisTr(data);
            var ss= $("#dervertisTr"+id).prev();
            $("#dervertisTr"+id).remove();
            $(ss).after(htmlStr);
        },
        error:function(a,b) {
            alert("系统异常！")
        }
    });
}


function createAdvertisTr(data) {
    var adver_type11=data.adver_type;
    if(adver_type11==1){
        adver_type1="inline";
    }
    else if(adver_type11==2){
        adver_type1="普通插屏";
    }
    else if(adver_type11==3){
        adver_type1="开屏广告位";
    }
    else if(adver_type11==4){
        adver_type1="信息流顶部广告位";
    }
    else if(adver_type11==5){
        adver_type1="多宝屋广告位";
    }
    else if(adver_type11==6){
        adver_type1="Native广告位";
    }

    var htmlStr="<tr id=dervertisTr"+data.id+"><td class='left'>&nbsp;"+data.adver_name;
    htmlStr+="<td class='typeThTd'>&nbsp;"+adver_type1;
    htmlStr+="<td class='running'>&nbsp;";
    if(data.status==1){
        htmlStr+="运行"+"&nbsp;&nbsp;<a href='javascript:;' onclick=pausd("+data.id+")>暂停</a>";
    }
    else if(data.status==2){
        htmlStr+="暂停"+"&nbsp;&nbsp;<a href='javascript:;' onclick=pausd("+data.id+")>运行</a>";
    }
    htmlStr+="<td class='appSetting'><span class='ppidSpan'>"+data.innlinepid+"</span>";
    htmlStr+="<a href='#'>复制</a>";
    htmlStr+="<td>"+getLocalTime(data.created_at)+"</td>";
    htmlStr+="<td class=appSetting>";
    if(data.status==2){
        htmlStr+='&nbsp;&nbsp;<a onclick=deleteDever('+data.id+')>删除</a>';
    }
    htmlStr+"</td></tr>";
    return htmlStr;
}
//删除广告//
function deleteDever(id) {
    $.ajax({
        url:'/member/app_manager/deleteAdvertising',
        type:'get',
        data:{id:id},
        success:function(data) {
            $("#dervertisTr"+id).remove();
        },
        error:function(a,b) {
            alert("系统异常！")
        }
    });
}



