$(document).ready(function(){
    $(".buttonClas").click(function(){
        var parent = $(this).parent();
        if($(parent).attr("id")=="developerbtn") {
            $("#advertiserinfo").css("display","none");
            $("#developerform").css("display","");
            $("#companyContact").css("display","none");
            $("#mTypeId").val("1");
        } else {
            $("#advertiserinfo").css("display","");
            $("#developerform").css("display","none");
            $("#companyContact").css("display","");
            $("#mTypeId").val("2");
        }
    });

    $('.typeCorp').click(function(){
        if($(this).val()==1) {
            $("#taxing").css("display","table-row");
            $("#identityType").css("display","");
            $("#identityName").css("display","");
            $("#identityNO").css("display","");
            $("#companyName").css("display","none");
            $("#companyNotice").css("display","none");
            $("#companyContact").css("display","none");
        }
        if ($(this).val()==2) {
            $("#identityType").css("display","none");
            $("#identityName").css("display","none");
            $("#identityNO").css("display","none");
            $("#taxing").css("display","none");
            $("#companyName").css("display","");
            $("#companyNotice").css("display","");
            $("#companyContact").css("display","");
        }
    });



    $(".subButtClass").click(function(){
        var isErr=0;
        var mTypeId = $("#mTypeId").val();
        var typeCorp = $("input[name='developer_info[accountype]']:checked").val();
        if($.trim(mTypeId)=='1'&& $.trim(typeCorp)=='1') {
            if($.trim($("#cardnameId").val()).length==0) {
                $("#person_nameerr").css("color","red");
                isErr=1
            } else {
                $("#person_nameerr").css("color","gray");
            }
            if($.trim($("#cardnumId").val()).length==0) {
                $("#person_identityerr").css("color","red");
                isErr=1
            } else {
                $("#person_identityerr").css("color","gray");
            }
        }
        if($.trim(mTypeId)=='1'&& $.trim(typeCorp)=='2') {
            if($.trim($("#developer_info_company").val()).length==0) {
                isErr=1
                $("#corp_nameerr").css("color","red");
            } else {
                $("#corp_nameerr").css("color","gray");
            }
            if($.trim($("#developer_info_contact").val()).length==0) {
                $("#corp_cpersonerr").css("color","red");
                isErr=1
            } else {
                $("#corp_cpersonerr").css("color","gray");
            }
        }
        if($.trim(mTypeId)=='2') {
            if($.trim($("#developer_info_contact").val()).length==0) {
                $("#corp_cpersonerr").css("color","red");
                isErr=1
            } else {
                $("#corp_cpersonerr").css("color","gray");
            }
        }
        if($.trim($("#developer_info_qq").val()).length==0) {
            $("#qqerr").css("color","red");
            isErr=1
        } else {
            $("#qqerr").css("color","gray");
        }
        if($.trim($("#developer_info_mobile").val()).length==0) {
            $("#mobileerr").css("color","red");
            isErr=1
        } else {
            $("#mobileerr").css("color","gray");
        }
        if(isErr==1) {
            return false;
        } else {
            $("#new_developer_info").submitForm();
        }
    });
});