//应用设置页面//
window.onload = function () {
    var swfu = new SWFUpload({
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
        button_image_url:  "/images/selectapp.png",
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