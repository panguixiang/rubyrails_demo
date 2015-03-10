function FileProgress(file, targetID) {
    this.fileProgressID = file.id;
    this.opacity = 100;
    this.height = 0;
    this.fileProgressWrapper = document.getElementById(this.fileProgressID);
    if (!this.fileProgressWrapper) {
        this.fileProgressWrapper = document.createElement("div");
        this.fileProgressWrapper.className = "progressWrapper";
        this.fileProgressWrapper.id = this.fileProgressID;

        this.fileProgressElement = document.createElement("div");
        this.fileProgressElement.className = "progressContainer";

        var progressCancel = document.createElement("a");
        progressCancel.className = "progressCancel operable";
        progressCancel.href = "#";
        progressCancel.style.visibility = "hidden";
        progressCancel.appendChild(document.createTextNode("取消"));

        var progressText = document.createElement("div");
        progressText.className = "progressName";
        progressText.appendChild(document.createTextNode(file.name));

        var progressBar = document.createElement("div");
        progressBar.className = "progressBarInProgress";

        var progressStatus = document.createElement("div");
        progressStatus.className = "progressBarStatus";
        progressStatus.innerHTML = "&nbsp;";

        this.fileProgressElement.appendChild(progressCancel);
        this.fileProgressElement.appendChild(progressText);
        this.fileProgressElement.appendChild(progressStatus);
        this.fileProgressElement.appendChild(progressBar);

        this.fileProgressWrapper.appendChild(this.fileProgressElement);

        document.getElementById(targetID).appendChild(this.fileProgressWrapper);
    } else {
        this.fileProgressElement = this.fileProgressWrapper.firstChild;
        this.reset();
    }

    this.height = this.fileProgressWrapper.offsetHeight;
    this.setTimer(null);


}

FileProgress.prototype.setTimer = function (timer) {
    this.fileProgressElement["FP_TIMER"] = timer;
};
FileProgress.prototype.getTimer = function (timer) {
    return this.fileProgressElement["FP_TIMER"] || null;
};

FileProgress.prototype.reset = function () {
    this.fileProgressElement.className = "progressContainer";

    this.fileProgressElement.childNodes[2].innerHTML = "&nbsp;";
    this.fileProgressElement.childNodes[2].className = "progressBarStatus";

    this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
    this.fileProgressElement.childNodes[3].style.width = "0%";

    this.appear();
};

FileProgress.prototype.setProgress = function (percentage) {
    this.fileProgressElement.className = "progressContainer green";
    this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
    this.fileProgressElement.childNodes[3].style.width = percentage + "%";

    this.appear();
};
FileProgress.prototype.setComplete = function () {
    this.fileProgressElement.className = "progressContainer blue";
    this.fileProgressElement.childNodes[3].className = "progressBarComplete";
    this.fileProgressElement.childNodes[3].style.width = "";

    var oSelf = this;
    this.setTimer(setTimeout(function () {
        //oSelf.disappear();
    }, 10000));
};
FileProgress.prototype.setError = function () {
    this.fileProgressElement.className = "progressContainer red";
    this.fileProgressElement.childNodes[3].className = "progressBarError";
    this.fileProgressElement.childNodes[3].style.width = "";

    var oSelf = this;
    this.setTimer(setTimeout(function () {
        //oSelf.disappear();
    }, 5000));
};
FileProgress.prototype.setCancelled = function () {
    this.fileProgressElement.className = "progressContainer";
    this.fileProgressElement.childNodes[3].className = "progressBarError";
    this.fileProgressElement.childNodes[3].style.width = "";

    var oSelf = this;
    this.setTimer(setTimeout(function () {
        //oSelf.disappear();
    }, 2000));
};
FileProgress.prototype.setStatus = function (status) {
    this.fileProgressElement.childNodes[2].innerHTML = status;
};

// Show/Hide the cancel button
FileProgress.prototype.toggleCancel = function (show, swfUploadInstance) {
    this.fileProgressElement.childNodes[0].style.visibility = show ? "visible" : "hidden";
    if (swfUploadInstance) {
        var fileID = this.fileProgressID;
        var oSelf = this;
        this.fileProgressElement.childNodes[0].onclick = function () {
            swfUploadInstance.cancelUpload(fileID, false);
            $(swfUploadInstance.customSettings.appnameId).value = "";
            $("#divStatus").html("* 请选择大小不超过 30 MB 的 .apk 文件进行上传");
            oSelf.disappear();
            return false;
        };
    }
};

FileProgress.prototype.appear = function () {
    if (this.getTimer() !== null) {
        clearTimeout(this.getTimer());
        this.setTimer(null);
    }

    if (this.fileProgressWrapper.filters) {
        try {
            this.fileProgressWrapper.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 100;
        } catch (e) {
            // If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
            this.fileProgressWrapper.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=100)";
        }
    } else {
        this.fileProgressWrapper.style.opacity = 1;
    }

    this.fileProgressWrapper.style.height = "";

    this.height = this.fileProgressWrapper.offsetHeight;
    this.opacity = 100;
    this.fileProgressWrapper.style.display = "";

};

// Fades out and clips away the FileProgress box.
FileProgress.prototype.disappear = function () {

    var reduceOpacityBy = 15;
    var reduceHeightBy = 4;
    var rate = 30;	// 15 fps

    if (this.opacity > 0) {
        this.opacity -= reduceOpacityBy;
        if (this.opacity < 0) {
            this.opacity = 0;
        }

        if (this.fileProgressWrapper.filters) {
            try {
                this.fileProgressWrapper.filters.item("DXImageTransform.Microsoft.Alpha").opacity = this.opacity;
            } catch (e) {
                // If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
                this.fileProgressWrapper.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=" + this.opacity + ")";
            }
        } else {
            this.fileProgressWrapper.style.opacity = this.opacity / 100;
        }
    }

    if (this.height > 0) {
        this.height -= reduceHeightBy;
        if (this.height < 0) {
            this.height = 0;
        }

        this.fileProgressWrapper.style.height = this.height + "px";
    }

    if (this.height > 0 || this.opacity > 0) {
        var oSelf = this;
        this.setTimer(setTimeout(function () {
            oSelf.disappear();
        }, rate));
    } else {
        this.fileProgressWrapper.style.display = "none";
        this.setTimer(null);
    }
};

function swfupload_loaded_function(){
    $('#loading').css("display","none");
}

function preLoad() {
    if (!this.support.loading) {
        alert("您的浏览器 Flash 版本过低。");
        //alert("You need the Flash Player 9.028 or above to use SWFUpload.");
        return false;
    }
}
function loadFailed() {
    alert("上传组件加载失败，请刷新浏览器重试。");
}

function fileQueued(file) {
    myFileQueued(this.customSettings);
    this.setButtonDisabled(true);
    $("#divStatus").html("");
    try {
        var num = new Number(file.size/(1024*1024));
        var filesize = '';
        if(num >= 1){
            filesize = num.toFixed(2) + ' MB';
        }else{
            filesize = (num*1024).toFixed(0) + ' KB';
        }
        document.getElementById(this.customSettings.appnameId).value = filesize + "      |      " + file.name;
        var progress = new FileProgress(file, this.customSettings.progressTarget);
        progress.toggleCancel(true, this);

    } catch (ex) {
        ex;
        this.debug(ex);
    }
}

function fileQueueError(file, errorCode, message) {
    myFileQueueError(this.customSettings);
    try {
        if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
            //alert("You have attempted to queue too many files.\n" + (message === 0 ? "You have reached the upload limit." : "You may select " + (message > 1 ? "up to " + message + " files." : "one file.")));
            return;
        }
        var progress = new FileProgress(file, this.customSettings.progressTarget);
        progress.setError();
        progress.toggleCancel(false);
        progress.setStatus("<span class='red'>上传失败</span>");
        switch (errorCode) {
            case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
                //progress.setStatus("<span class='red'>上传应用不得超过30MB。请重新上传合适的应用。</span>");
                //progress.setStatus("File is too big.");
                $("#divStatus").html("<span class='red'> * 上传应用不得超过 300 MB，请重新上传合适的应用。</span>");
                this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
                break;
            case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
                //progress.setStatus("<span class='red'>不支持上传 0 字节大小的文件。</span>");
                //progress.setStatus("Cannot upload Zero Byte files.");
                $("#divStatus").html("<span class='red'> * 请选择大小不超过 300 MB 的 .apk 文件进行上传</span>");
                this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
                break;
            case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
                //progress.setStatus("<span class='red'>您上传的文件格式不正确。</span>");
                //progress.setStatus("Invalid File Type.");
                this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
                break;
            default:
                if (file !== null) {
                    //progress.setStatus("<span class='red'>未知错误，请重试。</span>");
                    //progress.setStatus("Unhandled Error");
                }
                this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
                break;
        }
    } catch (ex) {
        this.debug(ex);
    }
}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
    try {
        if (numFilesSelected > 0) {
            document.getElementById(this.customSettings.cancelButtonId).disabled = false;
        }

        /* I want auto start the upload and I can do that here */
        this.startUpload();
    } catch (ex)  {
        this.debug(ex);
    }
}
var statusTimer;
function uploadStart(file) {
    try {

        var progress = new FileProgress(file, this.customSettings.progressTarget);
        progress.toggleCancel(true, this);
    }
    catch (ex) {}

    return true;
}

function uploadProgress(file, bytesLoaded, bytesTotal) {
    try {
        var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
        var progress = new FileProgress(file, this.customSettings.progressTarget);
        progress.setProgress(percent);
        if(100 == percent){
            progress.setStatus("<span class='superstrong'>解析中</span>");
            clearInterval(statusTimer);
            statusTimer = setInterval("updateStatus()", 1000);
            progress.toggleCancel(false);
        }else{
            progress.setStatus(percent + "%");
        }
    } catch (ex) {
        ex;
        this.debug(ex);
    }
}

function updateStatus(){
    var progress = $('.progressBarStatus');
    var text = $(progress).text();
    var dots = text.match(/\./g);
    if(!dots || dots.length < 3){
        $(progress).text(text + ".");
    }else{
        $(progress).text(text.replace(/\./g, ""));
    }
}
function uploadError(file, errorCode, message) {
    clearInterval(statusTimer);
    try {
        var progress = new FileProgress(file, this.customSettings.progressTarget);
        progress.setError();
        progress.toggleCancel(false);
        progress.setStatus("<span class='red'>上传失败</span>");
        $("#divStatus").html("<span class='red'> * 请选择大小不超过 300 MB 的 .apk 文件进行上传</span>");
    } catch (ex) {
        this.debug(ex);
    }
}

// added by cxy, trying to clear out this mess....
function uploadSuccesss(file, serverData) {
    var data = jQuery.parseJSON(serverData);
    var progress = new FileProgress(file, this.customSettings.progressTarget);
    progress.setComplete();
    if($("#showName")) {
        $("#showName").remove();
    }
    if(data.errorCode){
        progress.setError();
        progress.setStatus("上传失败");
        $('#divStatus').html("错误信息："+data.errorMessage);
        return;
    }
    progress.setStatus("上传成功");
    progress.toggleCancel(false);
    $("#package_name_id").val(data.package_name);
    $("#version_code_id").val(data.version_code);
    $("#source_id").val(data.path);
    $('#packageName').text("*应用包名:    "+data.package_name);
    $('#version').text("*应用版本:	"+data.version_code);
    $('#filesize').text("*应用大小:	"+file.size);
}

function uploadComplete(file) {
    clearInterval(statusTimer);
    this.setButtonDisabled(false);
    if (this.getStats().files_queued === 0) {
        document.getElementById(this.customSettings.cancelButtonId).disabled = true;
    }
}

function queueComplete(numFilesUploaded) {}

function myFileQueued(customSettings){
    $(customSettings.progressTarget).empty();
}

function myFileQueueError(customSettings){
    $(customSettings.progressTarget).empty();
}