$(document).ready(function(){
// 切换自定义条件面板，当展示面版时，不允许修改时间段的列表
    $("#customConditionSwitcher").click(function(){
       $('#customCondition').css('display','block');
       $('#export').toggle();
       $('#dateSeleId').attr('disabled',"true");
    });

// 广告级别按钮
    $("input[name='adver']").click(function(){
        $('.mif-tree-children-root').css("display","none");
        $('#abc'+$(this).val()).css("display","block");
        $("#selectAllAd").prop("checked", false);
        $("#showDeletedAd").prop("checked", false);
        $('.undisplay').css("display", 'none');
        $('.choose').prop("checked", false);
    });

// 全选按钮
    $("#selectAllAd").click(function () {//当点击全选框时
        var flag = $("#selectAllAd").is(':checked');//判断全选按钮的状态
        var ss=$("input[name='adver']:checked").val();
        $('.choose').prop("checked", false);
        if(flag) {
            $('.choose'+ss).each(function() {
                $(this).prop("checked", true);
            });
        } else {
            $('.choose'+ss).each(function() {
                $(this).prop("checked", false);
            });
        }
    });
    // 显示删除广告
    $("#showDeletedAd").click(function () {
        var flag = $("#showDeletedAd").is(':checked');//判断全选按钮的状态
        var ss=$("input[name='adver']:checked").val();
        if(flag) {
            $('.undisplay'+ss).each(function() {
                $(this).css("display", 'inline');
            });
        } else {
            $('.undisplay'+ss).each(function() {
                $(this).css("display", 'none');
            });
        }

    });
    // 提交自定义查询
    $('#submit').click(function() {
        if($("input[type='checkbox']:checked").length ==0){
            alert("您选择了自定义报告，请选择广告计划，或者策略，创意")
        }
        else{
            refresh(getDateArr());
        }

    });
    // 取消查询
    $('#cancle').click(function() {
        $("#selectAllAd").prop("checked", false);
        $('.choose').prop("checked", false);
        $('#customCondition').css("display","none");
        $('#dateSeleId').removeAttr('disabled');
        refresh(getDateArr());
    });

//广告时间//
    $(".styled-select").change(function(){
        if($(this).attr("name")=='dateSele' && $.trim($(this).val()).length>0) {
           $(".endDate").val('');
           $("#dateBetweenId").css("display","none");
           refresh(getDateArr());
        }
       else {
           refresh(getDateArr());
       }
    });

//广告类型//
    $("#costType").bind("change",function(){
        $(".ac_report_change_view").removeClass("current");
        $("#adivId0").addClass("current");
        $(".ac_report_change_view").css("display","none");
        if($(this).val()=='cpm' ){
            $([0,1,4,7,9]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        }
        else if($(this).val()=='cpc'){
            $([0,1,4,7,8,9]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        }
        else if($(this).val()=='ocpc'){
            $([0,1,4,7,8,9]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        }
        else if($(this).val()=='cpd'){
            $([0,2,5,7,10]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        }
        else if($(this).val()=='cpi'){
            $([0,3,6,7,11]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        }
        else if($(this).val()==' '){
            $([0,7,9]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        }
        refresh(getDateArr());
    });
    refresh(getDateArr());
    $(".ac_report_change_view").click(function(){
        $(".ac_report_change_view").removeClass("current");
        $(this).addClass("current");
        for(var i=0;i<12;i++) {
            chartSetting.series[i].visible=false;
        }
        chartSetting.series[parseInt($(this).attr("id").replace("adivId",""))].visible=true;
        chartSetting.yAxis.title.text = $(this).text();
        $('.ow-highchart').highcharts(chartSetting);
    });
    //下载报告
    $(".ac_report_export").click(function(){
        location.href='/advertiser/adv_statics/exportCvs?'+$("#searchFormId").serialize();
    });
});
var statsData;
var chartSetting = {
    chart: {
        renderTo: 'ow-highchart',
        type: 'spline',
        defaultSeriesType: 'spline'
    },
    title: {
        text: ''
    },
    subtitle: { text: '' },
    credits: { enabled: false },
    legend: { enabled: false },
    exporting: { enabled: false },
    xAxis: {
        labels: {
            align: 'right',
            rotation: 0
        },
        maxZoom: 1,
        categories: []
    },
    yAxis: {
        title: {
            min: 0,
            maxZoom: 1,
            text: '',
            ratation: 90
        },

        plotLines: [{
            value: 0,
            width: 1,
            color: '#808080'
        }]
    },
    tooltip: {
        enabled: true,
        formatter: function() {
            return '<b>'+ this.series.name +'</b><br/>'+this.x
                +': '+ this.y;
        }
    },
    series: [{
        type: 'spline',
        name: '',
        data: []
    }]
};
var redisplayChart = function(dateArr) {
    var costArr= new Array();
        thousandArry=new Array(),displayArr=new Array();
        clickNumArr=new Array(),clicRateArr=new Array(),clicCostArr=new Array();
        downloadArr=new Array(),downloadRateArr=new Array(),downloadCostArr=new Array();
        installArr=new Array(),installRateArr=new Array(),installCostArr=new Array();

    for(var s=0;s<dateArr.length;s++) {
        costArr.push(0);
        thousandArry.push(0),displayArr.push(0);
        clickNumArr.push(0),clicRateArr.push(0),clicCostArr.push(0);
        downloadArr.push(0),downloadRateArr.push(0),downloadCostArr.push(0);
        installArr.push(0),installRateArr.push(0),installCostArr.push(0);
    }
    $.each(statsData,function(index,value) {
        costArr[$.inArray(value.timed,dateArr)]=parseFloat(value.cost);
        displayArr[$.inArray(value.timed,dateArr)]=parseFloat(value.displaynum);
        if(value.displaynum>0) {
            thousandArry[$.inArray(value.timed,dateArr)]=parseFloat(value.cost/value.displaynum)*1000;
        } else {
            thousandArry[$.inArray(value.timed,dateArr)]=0;
        }
        clickNumArr[$.inArray(value.timed,dateArr)]=parseFloat(value.clickNum);
        if(value.clickNum>0){
            clicRateArr[$.inArray(value.timed,dateArr)]=(parseFloat(value.clickNum/value.displaynum)*100)+"%";
        } else {
            clicRateArr[$.inArray(value.timed,dateArr)]=0;
        }
        if(value.clickNum>0){
            clicCostArr[$.inArray(value.timed,dateArr)]=(parseFloat(value.cost/value.clickNum));
        } else {
            clicCostArr[$.inArray(value.timed,dateArr)]=0;
        }

        downloadArr[$.inArray(value.timed,dateArr)]=parseFloat(value.download_count);
        if(value.download_count>0){
            downloadRateArr[$.inArray(value.timed,dateArr)]=(parseFloat(value.download_count/value.displaynum)*100)+"%";
        } else {
            downloadRateArr[$.inArray(value.timed,dateArr)]=0;
        }
        if(value.download_count>0){
            downloadCostArr[$.inArray(value.timed,dateArr)]=(parseFloat(value.cost/value.download_count));
        } else {
            downloadCostArr[$.inArray(value.timed,dateArr)]=0;
        }

        installArr[$.inArray(value.timed,dateArr)]=parseFloat(value.install_count);
        if(value.install_count>0){
            installRateArr[$.inArray(value.timed,dateArr)]=(parseFloat(value.install_count/value.displaynum)*100)+"%";
        } else {
            installRateArr[$.inArray(value.timed,dateArr)]=0;
        }
        if(value.install_count>0){
            installCostArr[$.inArray(value.timed,dateArr)]=(parseFloat(value.cost/value.install_count));
        } else {
            installCostArr[$.inArray(value.timed,dateArr)]=0;
        }
    });
    chartSetting.xAxis.categories = dateArr;
    chartSetting.series=new Array();
    chartSetting.series[0] =new Object();
    chartSetting.series[0].name = '有效展示';
    chartSetting.series[0].data = displayArr;
    chartSetting.series[0].visible=true;
    chartSetting.series[1] =new Object();
    chartSetting.series[1].name = '点击次数';
    chartSetting.series[1].data = clickNumArr;
    chartSetting.series[1].visible=false;
    chartSetting.series[2] =new Object();
    chartSetting.series[2].name = '下载次数';
    chartSetting.series[2].data = downloadArr;
    chartSetting.series[2].visible=false;
    chartSetting.series[3] =new Object();
    chartSetting.series[3].name = '安装次数';
    chartSetting.series[3].data = installArr;
    chartSetting.series[3].visible=false;
    chartSetting.series[4] =new Object();
    chartSetting.series[4].name = '点击率';
    chartSetting.series[4].data = clicRateArr;
    chartSetting.series[4].visible=false;
    chartSetting.series[5] =new Object();
    chartSetting.series[5].name = '下载率';
    chartSetting.series[5].data = downloadRateArr;
    chartSetting.series[5].visible=false;
    chartSetting.series[6] =new Object();
    chartSetting.series[6].name = '安装率';
    chartSetting.series[6].data = installRateArr;
    chartSetting.series[6].visible=false;
    chartSetting.series[7] =new Object();
    chartSetting.series[7].name = '成本';
    chartSetting.series[7].data = costArr;
    chartSetting.series[7].visible=false;
    chartSetting.series[8] =new Object();
    chartSetting.series[8].name = '平均每次点击成本';
    chartSetting.series[8].data = clicCostArr;
    chartSetting.series[8].visible=false;
    chartSetting.series[9] =new Object();
    chartSetting.series[9].name = '每千次展示成本';
    chartSetting.series[9].data = thousandArry;
    chartSetting.series[9].visible=false;
    chartSetting.series[10] =new Object();
    chartSetting.series[10].name = '平均每次下载成本';
    chartSetting.series[10].data = downloadCostArr;
    chartSetting.series[10].visible=false;
    chartSetting.series[11] =new Object();
    chartSetting.series[11].name = 'installCostArr';
    chartSetting.series[11].data = thousandArry;
    chartSetting.series[11].visible=false;
    chartSetting.yAxis.title.text = '有效展示';
    $('.ow-highchart').highcharts(chartSetting);
};
redisplay = function(dateArr) {
    redisplayChart(dateArr);
    redisplayTable();
};
var refresh = function(dateArr) {
    var adverIds="";
    var adver_gro_ids="";
    var adver_orig_ids="";
    var params = $("#searchFormId").serialize();
    $("input[name='adverId']:checked").each(function() {
        adverIds+=$(this).val() + ",";
    });
    $("input[name='adver_gro_id']:checked").each(function() {
        adver_gro_ids+=$(this).val() + ",";
    });

    $("input[name='adver_orig_id']:checked").each(function() {
        adver_orig_ids+=$(this).val() + ",";
    });
    adverIds=adverIds.substring(0,adverIds.length-1);
    adver_gro_ids=adver_gro_ids.substring(0,adver_gro_ids.length-1);
    adver_orig_ids=adver_orig_ids.substring(0,adver_orig_ids.length-1);
    params+="&adverIds="+adverIds;
    params+="&adver_gro_ids="+adver_gro_ids;
    params+="&adver_orig_ids="+adver_orig_ids;
    $.ajax({
        url: '/advertiser/adv_statics/advstatic',
        data: params,
        type: 'get',
        dataType: 'json',
        success: function(data) {
            statsData = data;
            redisplay(dateArr);
        },
        error: function() {
        }
    });
};
var redisplayTable = function(){
    var htmls="";
    $('.report_table').empty();
    var bill_type = $("#costType").val();
    if($.trim(bill_type)=='') {
        htmls+="<thead>" +
            "<tr>" +
                "<th>日期/时间</th>" +
                "<th>成本(元)</th>" +
                "<th>有效展示</th>" +
                "<th>每千次展示成本(元)</th>";
        htmls+="</tr></thead>";
        if(statsData.length>0) {
            $(statsData).each(function (k, value) {
                htmls += "<tr><td>" + value.timed + "</td>";
                htmls += "<td>" + parseFloat(value.cost) + "</td>";
                htmls += "<td>" + parseFloat(value.displaynum) + "</td>";
                if (value.displaynum > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.cost / value.displaynum) * 100000) + "</td>";
                } else {
                    htmls += "<td>0</td>";
                }
                htmls += "</tr>";
            });
        }
        else{
            htmls+="<tr><td>统计</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td></tr>";
        }
        $('.report_table').html(htmls);
    }
    else if(bill_type=='cpc') {
        htmls+="<thead>" +
                "<tr>" +
                    "<th>日期/时间</th>" +
                    "<th>成本(元)</th>" +
                    "<th>有效展示</th>" +
                    "<th>点击次数</th>" +
                    "<th>点击率</th>" +
                    "<th>平均每次点击成本(元)</th>" +
                    "<th>每千次展示成本(元)</th>";
        htmls+="</tr></thead>";
        if(statsData.length>0) {
            $(statsData).each(function (k, value) {
                htmls += "<tr><td>" + value.timed + "</td>";
                htmls += "<td>" + parseFloat(value.cost) + "</td>";
                htmls += "<td>" + parseFloat(value.displaynum) + "</td>";
                htmls += "<td>" + parseFloat(value.clickNum) + "</td>";
                if (value.clickNum > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.clickNum / value.displaynum) * 100) + "%" + "</td>";
                } else {
                    htmls += "<td>0%</td>";
                }
                if (value.clickNum > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.cost / value.clickNum)) + "</td>";
                } else {
                    htmls += "<td>0</td>";
                }
                if (value.displaynum > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.cost / value.displaynum) * 100000) + "</td>";
                } else {
                    htmls += "<td>0</td>";
                }
                htmls += "</tr>";
            });
        }
        else{
            htmls+="<tr><td>统计</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td></tr>";
        }
        $('.report_table').html(htmls);
    }
    else if(bill_type=='cpm') {
        htmls+="<thead>" +
            "<tr>" +
            "<th>日期/时间</th>" +
            "<th>成本(元)</th>" +
            "<th>有效展示</th>" +
            "<th>点击次数</th>" +
            "<th>点击率</th>" +
            "<th>每千次展示成本(元)</th>";
        htmls+="</tr></thead>";
        if(statsData.length>0) {
            $(statsData).each(function (k, value) {
                htmls += "<tr><td>" + value.timed + "</td>";
                htmls += "<td>" + parseFloat(value.cost) + "</td>";
                htmls += "<td>" + parseFloat(value.displaynum) + "</td>";
                htmls += "<td>" + parseFloat(value.clickNum) + "</td>";
                if (value.clickNum > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.clickNum / value.displaynum) * 100) + "%" + "</td>";
                } else {
                    htmls += "<td>0%</td>";
                }
                if (value.displaynum > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.cost / value.displaynum) * 100000) + "</td>";
                } else {
                    htmls += "<td>0</td>";
                }
                htmls += "</tr>";
            });
        }
        else{
            htmls+="<tr><td>统计</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td></tr>";
        }
        $('.report_table').html(htmls);
    }
    else if(bill_type=='ocpc') {
        htmls+="<thead>" +
            "<tr>" +
            "<th>日期/时间</th>" +
            "<th>成本(元)</th>" +
            "<th>有效展示</th>" +
            "<th>点击次数</th>" +
            "<th>点击率</th>" +
            "<th>平均每次点击成本(元)</th>" +
            "<th>每千次展示成本(元)</th>";
        htmls+="</tr></thead>";
        if(statsData.length>0){
            $(statsData).each(function(k, value) {
                htmls+="<tr><td>"+value.timed+"</td>";
                htmls+="<td>"+parseFloat(value.cost)+"</td>";
                htmls+="<td>"+parseFloat(value.displaynum)+"</td>";
                htmls+="<td>"+parseFloat(value.clickNum)+"</td>";
                if(value.clickNum>0) {
                    htmls+="<td>"+Math.round(parseFloat(value.clickNum/value.displaynum)*100)+"%"+"</td>";
                } else {
                    htmls+="<td>0%</td>";
                }
                if(value.clickNum>0) {
                    htmls+="<td>"+Math.round(parseFloat(value.cost/value.clickNum))+"</td>";
                } else {
                    htmls+="<td>0</td>";
                }
                if(value.displaynum>0) {
                    htmls+="<td>"+Math.round(parseFloat(value.cost/value.displaynum)*100000)+"</td>";
                } else {
                    htmls+="<td>0</td>";
                }
                htmls+="</tr>";
            });
        }
        else{
            htmls+="<tr><td>统计</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td></tr>";
        }

        $('.report_table').html(htmls);
    }
    else if(bill_type=='cpd') {
        htmls+="<thead>" +
            "<tr>" +
            "<th>日期/时间</th>" +
            "<th>成本(元)</th>" +
            "<th>有效展示</th>" +
            "<th>下载次数</th>" +
            "<th>下载率</th>" +
            "<th>平均每次下载成本(元)</th>";
        htmls+="</tr></thead>";
        if(statsData.length>0) {
            $(statsData).each(function (k, value) {
                htmls += "<tr><td>" + value.timed + "</td>";
                htmls += "<td>" + parseFloat(value.cost) + "</td>";
                htmls += "<td>" + parseFloat(value.displaynum) + "</td>";
                htmls += "<td>" + parseFloat(value.download_count) + "</td>";
                if (value.download_count > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.download_count / value.displaynum) * 100) + "%" + "</td>";
                } else {
                    htmls += "<td>0%</td>";
                }
                if (value.download_count > 0) {
                    htmls += "<td>" + Math.round(parseFloat(value.cost / value.download_count)) + "</td>";
                } else {
                    htmls += "<td>0</td>";
                }
                htmls += "</tr>";
            });
        }
        else{
                htmls+="<tr><td>统计</td>";
                htmls+="<td>0</td>";
                htmls+="<td>0</td>";
                htmls+="<td>0</td>";
                htmls+="<td>0</td>";
                htmls+="<td>0</td></tr>";
            }
        $('.report_table').html(htmls);
    }
    else if(bill_type=='cpi') {
        htmls+="<thead>" +
            "<tr>" +
            "<th>日期/时间</th>" +
            "<th>成本(元)</th>" +
            "<th>有效展示</th>" +
            "<th>安装次数</th>" +
            "<th>安装率</th>" +
            "<th>平均每次安装成本(元)</th>";
        htmls+="</tr></thead>";
        if(statsData.length>0) {
            $(statsData).each(function(k, value) {
                htmls+="<tr><td>"+value.timed+"</td>";
                htmls+="<td>"+parseFloat(value.cost)+"</td>";
                htmls+="<td>"+parseFloat(value.displaynum)+"</td>";
                htmls+="<td>"+parseFloat(value.install_count)+"</td>";
                if(value.install_count>0) {
                    htmls+="<td>"+Math.round(parseFloat(value.install_count/value.displaynum)*100)+"%"+"</td>";
                } else {
                    htmls+="<td>0%</td>";
                }
                if(value.install_count>0) {
                    htmls+="<td>"+Math.round(parseFloat(value.cost/value.install_count))+"</td>";
                } else {
                    htmls+="<td>0</td>";
                }
                htmls+="</tr>";
            });
        }
        else{
            htmls+="<tr><td>统计</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td>";
            htmls+="<td>0</td></tr>";
        }
        $('.report_table').html(htmls);
    }
};
function getDateArr() {
    var dateSele = $("#dateSeleId").val();
    var arrays;
    if($.trim(dateSele).length==0) {
        var beginTime = $("#beginTimeId").val();
        var endTime = $("#endTimeId").val();
        if($.trim(beginTime).length>0&&$.trim(endTime).length>0) {
            arrays = createDateBetween(beginTime,endTime);
        } else {
            if($.trim(beginTime).length>0) {
                arrays = [beginTime];
            }
            else if($.trim(endTime).length>0) {
                arrays = [endTime];
            }
        }
    } else {
        arrays = createDateBetween(null,dateSele);
    }
    if(arrays.length<3) {
        for(var i=0;i<24;i++) {
            arrays[i]=createTwoStr(i)+':00'
        }
        return arrays;
    }
    else if(arrays.length>60) {
        var oneYear = arrays[0].split("-");
        var lastMonth = parseInt(oneYear[1]);
        var moth =(13-lastMonth);
        var yearArr = new Array();
        for(var i=0;i<moth;i++) {
            yearArr[i]=oneYear[0]+'-'+lastMonth;
            lastMonth=lastMonth+1
        }
        oneYear = arrays[arrays.length-1].split("-");
        lastMonth = parseInt(oneYear[1]);
        for(var i=1;i<lastMonth+1;i++) {
            yearArr[yearArr.length]=oneYear[0]+'-'+createTwoStr(i);
        }
        return yearArr;
    } else {
        return arrays;
    }
}
