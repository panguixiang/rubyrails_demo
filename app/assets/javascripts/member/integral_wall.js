$(document).ready(function(){
   $('.platformClass').change(function(){
     var platform = $(this).val();
     if(platform=='ios') {
         $("#type").css("display","block");
         $("#sssssss").css("display","block");
         $("#type2_content").css("display","none");
         $("#score").css("display","none");
     } else {
         $("#type").css("display","none");
         $("#sssssss").css("display","none");
         $("#type2_content").css("display","block");
         $("#score").css("display","block");
         $("#select_content").css("display","none");
     }
   });
    $("#score0").click(function(){
        $(this).css("display","none");
        $("#score1").css("display","inline-block");
        $("#score_balance").val(2);
    });
    $("#score1").click(function(){
        $(this).css("display","none");
        $("#score0").css("display","inline-block");
        $("#score_balance").val(1);
    });
    $(".packageTypeClass").change(function(){
        var packageType = $(this).val();
        if(packageType==1) {
            $("#source_id").val("");
            $("#package_name_id").val("");
            $("#version_code_id").val("");
            $("#select_content").css("display","block");
            $("#type2_content").css("display","none");
        } else {
            $("#select_content").css("display","none");
            $("#type2_content").css("display","block");
        }
    });
    $(".adverTpyeClass").change(function() {
        var adverTpye = $(this).val();
        if(adverTpye==1) {
            $(".rateCsd").text("兑换比例");
            $('.ratellll').text("1元 =");
            $(".msgow").text("以1元为单位，如填入10000，则当开发者分成得到1元时，用户能获得10000个货币单位；请不要超过 200000");
        } else {
            $(".rateCsd").text("奖励数");
            $('.ratellll').text("单次观看 =");
            $(".msgow").text("请填写大于0的整数，如填入100表示：用户每次观看可获得100个应用内货币");
        }
    });
});

var swfu;
if($('#apkinfo')){
    var apkinfo = $('#apkinfo');
    apkinfo.hide();
}
window.onload = function () {
    swfu = new SWFUpload({
        upload_url : "/member/integral_walls/uploadapk",
        flash_url : "/swfupload.swf",
        file_size_limit : "300 MB",
        file_types : "*.ipa;*.apk",
        file_types_description : "All Files",
        file_upload_limit : 0,
        file_queue_limit : 1,
        custom_settings : {
            progressTarget : "fsUploadProgress",
            cancelButtonId : "btnCancel",
            appnameId : "appnamesd"
        },
        debug: false,
        button_placeholder_id:'spanButtonPlaceHolder',
        button_image_url: "/images/selectapp.png",
        button_width: "96",
        button_height: "28",
        button_text: "",
        button_text_style: "",
        button_text_left_padding: 12,
        button_text_top_padding: 5,
        button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
        button_cursor: SWFUpload.CURSOR.HAND,
        swfupload_loaded_handler : swfupload_loaded_function,
        swfupload_preload_handler : preLoad,
        swfupload_load_failed_handler : loadFailed,
        file_queued_handler : fileQueued,
        file_queue_error_handler : fileQueueError,
        file_dialog_complete_handler : fileDialogComplete,
        upload_start_handler : uploadStart,
        upload_progress_handler : uploadProgress,
        upload_error_handler : uploadError,
        upload_success_handler : uploadSuccesss,
        upload_complete_handler : uploadComplete,
        queue_complete_handler : queueComplete	// Queue plugin event
    });
};