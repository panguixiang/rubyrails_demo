$(document).ready(function(){
    $("#oneSelect").change(function(){
       $('#twoSelect option:first').attr('selected','selected');
       $(".optionclass").css("display","none");
      $(".optId"+$(this).val()).css("display","block");
   });
    $(".styled-select").change(function(){
       if($(this).attr("name")=='dateSele' && $.trim($(this).val()).length==0) {
           $("#dateBetweenId").css("display","block");
       }
       else if($(this).attr("name")=='dateSele' && $.trim($(this).val()).length>0) {
           $(".endDate").val('');
           $("#dateBetweenId").css("display","none");
           refresh(getDateArr());
       }
       else {
           refresh(getDateArr());
       }
    });
    $(".btnS").click(function(){
        if($.trim($("#beginTimeId").val()).length>0
            || $.trim($("#endTimeId").val()).length>0) {
            refresh(getDateArr());
        }
    });
    $("input[name='bill_type']").click(function(){
        $(".ac_report_change_view").removeClass("current");
        $("#adivId0").addClass("current");
        $(".ac_report_change_view").css("display","none");
        $("input[name='adverting_type']").get(0).checked=true;
        if($(this).val()=='cpc') {
            $(".onlyRadioId").css("display",'none');
            $([0,1,4,5,6]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        } else if($(this).val()=='cpm') {
            $(".onlyRadioId").css("display",'');
            $([0,1,4]).each(function(index){
                $("#adivId"+this).css("display","block");
            });
        } else {
            $(".onlyRadioId").css("display",'');
            for(var i=0;i<5;i++) {
                $("#adivId"+i).css("display","block");

            }
        }
        refresh(getDateArr());
    });
    $("input[name='adverting_type']").click(function(){
        refresh(getDateArr());
    });
    refresh(getDateArr());//初始化页面
    $(".ac_report_change_view").click(function(){
        $(".ac_report_change_view").removeClass("current");
        $(this).addClass("current");
        for(var i=0;i<7;i++) {
            chartSetting.series[i].visible=false;
        }
        chartSetting.series[parseInt($(this).attr("id").replace("adivId",""))].visible=true;
        chartSetting.yAxis.title.text = $(this).text();
        $('.ow-highchart').highcharts(chartSetting);
    });

    $(".ac_report_export").click(function(){
        location.href='/member/app_statics/exportCvs?'+$("#searchFormId").serialize();
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
    var incomingArr= new Array(),thousandArry=new Array(),
        requestArr=new Array(),fillArr=new Array(),
        displayArr=new Array(),clickCountArr=new Array(),
        clicRateArr=new Array();
    for(var s=0;s<dateArr.length;s++) {
        incomingArr.push(0),thousandArry.push(0);
        requestArr.push(0),fillArr.push(0);
        displayArr.push(0),clickCountArr.push(0);
        clicRateArr.push(0);
    }
    $.each(statsData,function(index,value) {
        incomingArr[$.inArray(value.timed,dateArr)]=parseFloat(value.incoming);
        if(value.display_count>0) {
            thousandArry[$.inArray(value.timed,dateArr)]=parseFloat(value.incoming/value.display_count)*1000;
        } else {
            thousandArry[$.inArray(value.timed,dateArr)]=0;
        }
        displayArr[$.inArray(value.timed,dateArr)]=parseFloat(value.display_count);
        requestArr[$.inArray(value.timed,dateArr)]=parseFloat(value.request_count);
        fillArr[$.inArray(value.timed,dateArr)]=parseFloat(value.fill_count);
        clickCountArr[$.inArray(value.timed,dateArr)]=parseFloat(value.click_count);
        if(value.display_count>0){
            clicRateArr[$.inArray(value.timed,dateArr)]=(parseFloat(value.click_count/value.display_count)*100)+"%";
        } else {
            clicRateArr[$.inArray(value.timed,dateArr)]=0;
        }

    });
    chartSetting.xAxis.categories = dateArr;
    chartSetting.series=new Array();
    chartSetting.series[0] =new Object();
    chartSetting.series[0].name = '收入(元)';
    chartSetting.series[0].data = incomingArr;
    chartSetting.series[1] =new Object();
    chartSetting.series[1].name = '每千次有效展示收入';
    chartSetting.series[1].data = thousandArry;
    chartSetting.series[1].visible=false;
    chartSetting.series[2] =new Object();
    chartSetting.series[2].name = '有效请求';
    chartSetting.series[2].data = requestArr;
    chartSetting.series[2].visible=false;
    chartSetting.series[3] =new Object();
    chartSetting.series[3].name = '有效填充';
    chartSetting.series[3].data = fillArr;
    chartSetting.series[3].visible=false;
    chartSetting.series[4] =new Object();
    chartSetting.series[4].name = '有效展示';
    chartSetting.series[4].data = displayArr;
    chartSetting.series[4].visible=false;
    chartSetting.series[5] =new Object();
    chartSetting.series[5].name = '点击次数';
    chartSetting.series[5].data = clickCountArr;
    chartSetting.series[5].visible=false;
    chartSetting.series[6] =new Object();
    chartSetting.series[6].name = '点击率';
    chartSetting.series[6].data = clicRateArr;
    chartSetting.series[6].visible=false;
    chartSetting.yAxis.title.text = '收入(元)';
    $('.ow-highchart').highcharts(chartSetting);
};
redisplay = function(dateArr) {
    redisplayChart(dateArr);
    redisplayTable();
};
var refresh = function(dateArr) {
    $.ajax({
        url: '/member/app_statics/appstatic',
        data: $("#searchFormId").serialize(),
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
    var bill_type = $("input[name='bill_type']:checked").val();
    if($.trim(bill_type)=='') {
        htmls+="<thead><tr><th>日期/时间</th><th>收入(元)</th><th>每千次有效展示收入(元)</th><th>有效请求</th>";
        htmls+="<th>有效填充</th><th>有效展示</th></tr></thead>";
        $(statsData).each(function(k, value) {
            htmls+="<tr><td>"+parseFloat(value.timed)+"</td>";
            htmls+="<td>"+parseFloat(value.incoming)+"</td>";
            if(value.display_count>0) {
                htmls+="<td>"+Math.round(parseFloat(value.incoming/value.display_count)*100000)/100+"</td>";
            } else {
                htmls+="<td>0</td>";
            }
            htmls+="<td>"+parseFloat(value.request_count)+"</td>";
            htmls+="<td>"+parseFloat(value.fill_count)+"</td>";
            htmls+="<td>"+parseFloat(value.display_count)+"</td>";
            htmls+="</tr>";
        });
        $('.report_table').html(htmls);
    }
    else if(bill_type=='cpc') {
        htmls+="<thead><tr><th>日期/时间</th><th>收入(元)</th><th>每千次有效展示收入(元)</th><th>有效展示</th>";
        htmls+="<th>点击次数</th><th>点击率</th></tr></thead>";
        $(statsData).each(function(k, value) {
            htmls+="<tr><td>"+parseFloat(value.timed)+"</td>";
            htmls+="<td>"+parseFloat(value.incoming)+"</td>";
            if(value.display_count>0) {
                htmls+="<td>"+Math.round(parseFloat(value.incoming/value.display_count)*100000)/100+"</td>";
            } else {
                htmls+="<td>0</td>";
            }
            htmls+="<td>"+parseFloat(value.display_count)+"</td>";
            htmls+="<td>"+parseFloat(value.click_count)+"</td>";
            if(value.display_count>0) {
                htmls += "<td>" + Math.round(parseFloat(value.click_count / value.display_count)*10000)/100 + "% </td>";
            } else {
                htmls += "<td>0%</td>";
            }
            htmls+="</tr>";
        });
        $('.report_table').html(htmls);
    }
    else if(bill_type=='cpm') {
        htmls+="<thead><tr><th>日期/时间</th><th>收入(元)</th><th>每千次有效展示收入(元)</th><th>有效展示</th></tr></thead>";
        $(statsData).each(function(k, record) {
            htmls+="<tr><td>"+parseFloat(value.timed)+"</td>";
            htmls+="<td>"+parseFloat(value.incoming)+"</td>";
            if(value.display_count>0) {
                htmls+="<td>"+Math.round(parseFloat(value.incoming/value.display_count)*100000)/100+"</td>";
            } else {
                htmls+="<td>0</td>";
            }
            htmls+="<td>"+parseFloat(value.display_count)+"</td>";
            htmls+="</tr>";
        });
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
