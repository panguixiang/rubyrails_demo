$(function(){
    chartSetting = {
        chart: {
            renderTo: 'ajaxflash',
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
    $('#ajaxflash').html('正在加载 ...');
    $.ajax({
        url: '/advertiser/indexs/reportWeek',
        type: 'get',
        data: {
            date:(new Date()).getTime()
        },
        dataType: 'json',
        success: function(data) {
            var dateArr = createDateBetween(null,data.weekDate);
            var dataArr = new Array();
            for(var s=0;s<dateArr.length;s++) {
                dataArr.push(0);
            }
            $.each(data.costArr,function(index,value) {
                dataArr[$.inArray(getLocalTime2(value.created_at),dateArr)]
                    =parseFloat(value.consumday);
            });
            chartSetting.xAxis.categories = dateArr;
            chartSetting.series[0].data = dataArr; // dont forget the index 0
            chartSetting.series[0].name = '金额（RMB）'; // dont forget the index 0
            chartSetting.yAxis.title.text = "金额（RMB）";
            $('#ajaxflash').highcharts(chartSetting);
        },
        error: function() {
        }
    });
});