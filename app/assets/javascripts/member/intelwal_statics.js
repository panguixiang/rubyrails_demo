$(document).ready(function(){
    refresh(0,getDateArr());
    $(".ajaxClass").click(function(){
        $(".ajaxClass").removeClass("selected");
        $(this).addClass("selected");
        for(var i=0;i<8;i++) {
            chartSetting.series[i].visible=false;
        }
        var id=parseInt($(this).attr("id").replace("adivId",""));
        chartSetting.series[id].visible=true;
        chartSetting.yAxis.title.text = $(this).text();
        $(".pclass").removeClass("selected");
        $("#pId"+id).addClass("selected");
        $('.ow-highchart').highcharts(chartSetting);
    });
    $(".ajaxSelect").change(function(){
        $(".ajaxClass").css("display","none");
        $(".pclass").removeClass("selected");
        $(".adivclass").removeClass("selected");
        var dateArr = getDateArr();
        if($.trim($("#selectadverType").val()).length==0) {
            $("#adivId0").css("display","");
            refresh(0,dateArr);
        }
        else if($("#selectadverType").val()=='1') {
            for(var i=0;i<6;i++) {
                $("#adivId"+i).css("display","");
            }
            refresh(1,dateArr);
        }
        else if($("#selectadverType").val()=='2') {
            $("#adivId0").css("display","");
            for(var i=2;i<6;i++) {
                $("#adivId"+i).css("display","");
            }
            refresh(2,dateArr);
        }
        else if($("#selectadverType").val()=='3') {
            $("#adivId0").css("display","");
            $("#adivId6").css("display","");
            $("#adivId7").css("display","");
            refresh(6,dateArr);
        }

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


var redisplayChart = function(n,dateArr) {
    var activeComeArr= new Array(),enterCountArry=new Array(),
        relshowCountArr=new Array(),relclickCountArr=new Array(),
        coverCountArr=new Array(),activeCountArr=new Array(),
        playBeginArr=new Array(),playFinArr=new Array();
    for(var s=0;s<dateArr.length;s++) {
        activeComeArr.push(0),enterCountArry.push(0);
        relshowCountArr.push(0),relclickCountArr.push(0);
        coverCountArr.push(0),activeCountArr.push(0);
        playBeginArr.push(0),playFinArr.push(0);
    }
    $.each(statsData,function(index,value) {
        activeComeArr[$.inArray(value.timed,dateArr)]=parseFloat(value.active_income);
        enterCountArry[$.inArray(value.timed,dateArr)]=parseFloat(value.enter_count);
        relshowCountArr[$.inArray(value.timed,dateArr)]=parseFloat(value.relshow_count);
        relclickCountArr[$.inArray(value.timed,dateArr)]=parseFloat(value.relclick_count);
        coverCountArr[$.inArray(value.timed,dateArr)]=parseFloat(value.cover_count);
        activeCountArr[$.inArray(value.timed,dateArr)]=parseFloat(value.active_count);
        playBeginArr[$.inArray(value.timed,dateArr)]=parseFloat(value.play_begin);
        playFinArr[$.inArray(value.timed,dateArr)]=parseFloat(value.play_finish);
    });
    chartSetting.xAxis.categories = dateArr;
    chartSetting.series=new Array();
    chartSetting.series[0] =new Object();
    chartSetting.series[0].name = '广告激活收入(元)';
    chartSetting.series[0].data = activeComeArr;
    chartSetting.series[0].visible=false;
    chartSetting.series[1] =new Object();
    chartSetting.series[1].name = '入口点击量';
    chartSetting.series[1].data = enterCountArry;
    chartSetting.series[1].visible=false;
    chartSetting.series[2] =new Object();
    chartSetting.series[2].name = '关联展现量';
    chartSetting.series[2].data = relshowCountArr;
    chartSetting.series[2].visible=false;
    chartSetting.series[3] =new Object();
    chartSetting.series[3].name = '关联点击量';
    chartSetting.series[3].data = relclickCountArr;
    chartSetting.series[3].visible=false;
    chartSetting.series[4] =new Object();
    chartSetting.series[4].name = '自推荐激活数量';
    chartSetting.series[4].data = coverCountArr;
    chartSetting.series[4].visible=false;
    chartSetting.series[5] =new Object();
    chartSetting.series[5].name = '广告激活数量';
    chartSetting.series[5].data = activeCountArr;
    chartSetting.series[5].visible=false;
    chartSetting.series[6] =new Object();
    chartSetting.series[6].name = '播放开始数';
    chartSetting.series[6].data = playBeginArr;
    chartSetting.series[6].visible=false;
    chartSetting.series[7] =new Object();
    chartSetting.series[7].name = '播放完成数';
    chartSetting.series[7].data = playFinArr;
    chartSetting.series[7].visible=false;
    chartSetting.yAxis.title.text = $("#adivId"+n).text();
    chartSetting.series[parseInt(n)].visible=true;
    $("#pId"+n).addClass("selected");
    $("#adivId"+n).addClass("selected");
    $('.ow-highchart').highcharts(chartSetting);
};

var redisplayTable = function(){
    $(".trlist").css("display","none");
    $("#listTable"+$("#selectadverType").val()).css("display","");
    var tbody = $('.ow-stats-table tbody').empty();
    var htmls='';
    if($("#selectadverType").val()=='') {
        var sum =0;
        $(statsData).each(function(k, record) {
            htmls+="<tr><td>"+record.timed+"</td>";
            htmls+="<td>"+parseFloat(record.active_income).toFixed(2)+"</td>";
            htmls+="</tr>";
            sum+=parseFloat(record.active_income);
        });
        htmls += '<tr><td>总计</td><td>'+sum.toFixed(2)+'</td></tr>';
        tbody.append(htmls);
    }
    if($("#selectadverType").val()=='1') {
        var enter= 0,relshow= 0,relclick=0,cover= 0,active= 0,allActive=0;
        $(statsData).each(function(k, record) {
            htmls+="<tr><td>"+record.timed+"</td>";
            htmls+="<td>"+record.enter_count+"</td>";
            htmls+="<td>"+record.relshow_count+"</td>";
            htmls+="<td>"+record.relclick_count+"</td>";
            htmls+="<td>"+record.cover_count+"</td>";
            htmls+="<td>"+record.active_count+"</td>";
            htmls+="<td>"+parseFloat(record.active_income).toFixed(2)+"</td>";
            htmls+="</tr>";
            enter+=parseInt(record.enter_count);
            relshow+=parseInt(record.relshow_count);
            relclick+=parseInt(record.relclick_count);
            cover+=parseInt(record.cover_count);
            active+=parseInt(record.active_count);
            allActive+=parseFloat(record.active_income);
        });
        htmls += '<tr><td>总计</td><td>'+enter+'</td><td>'+relshow+'</td><td>'+relclick+'</td><td>'+cover+'</td>';
        htmls += '<td>'+active+'</td><td>'+allActive.toFixed(2)+'</td></tr>';
        tbody.append(htmls);
    }
    if($("#selectadverType").val()=='2') {
        var relshow= 0,relclick=0,cover= 0,active= 0,allActive=0;
        $(statsData).each(function(k, record) {
            htmls+="<tr><td>"+record.timed+"</td>";
            htmls+="<td>"+record.relshow_count+"</td>";
            htmls+="<td>"+record.relclick_count+"</td>";
            htmls+="<td>"+record.cover_count+"</td>";
            htmls+="<td>"+record.active_count+"</td>";
            htmls+="<td>"+parseFloat(record.active_income).toFixed(2)+"</td>";
            htmls+="</tr>";
            relshow+=parseInt(record.relshow_count);
            relclick+=parseInt(record.relclick_count);
            cover+=parseInt(record.cover_count);
            active+=parseInt(record.active_count);
            allActive+=parseFloat(record.active_income);
        });
        htmls += '<tr><td>总计</td><td>'+relshow+'</td><td>'+relclick+'</td><td>'+cover+'</td>';
        htmls += '<td>'+active+'</td><td>'+allActive.toFixed(2)+'</td></tr>';
        tbody.append(htmls);
    }
    if($("#selectadverType").val()=='3') {
        var play= 0,finish=0,allActive=0;
        $(statsData).each(function(k, record) {
            htmls+="<tr><td>"+record.timed+"</td>";
            htmls+="<td>"+record.play_begin+"</td>";
            htmls+="<td>"+record.play_finish+"</td>";
            htmls+="<td>"+parseFloat(record.active_income).toFixed(2)+"</td>";
            htmls+="</tr>";
            play+=parseInt(record.play_begin);
            finish+=parseInt(record.play_finish);
            allActive+=parseFloat(record.active_income);
        });
        htmls += '<tr><td>总计</td><td>'+play+'</td><td>'+finish+'</td><td>'+allActive.toFixed(2)+'</td></tr>';
        tbody.append(htmls);
    }
};

redisplay = function(n,dateArr) {
    redisplayChart(n,dateArr);
    redisplayTable();
};
var refresh = function(n,dateArr) {
    $.ajax({
        url: '/member/intelwal_statics/intelwalstatic',
        data: {
            intel_id: $('#selectPlateform').val(),
            adver_type: $('#selectadverType').val(),
            time: $('#selectDate').val(),
            date:(new Date()).getTime()
        },
        type: 'get',
        dataType: 'json',
        success: function(data) {
            statsData = data;
            redisplay(n,dateArr);
        },
        error: function() {
        }
    });
};

function getDateArr() {
    var endTime = $("#selectDate").val();
    var arrays = createDateBetween(null,endTime);
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


