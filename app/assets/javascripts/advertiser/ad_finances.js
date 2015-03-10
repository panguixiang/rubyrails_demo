$(document).ready(function() {
    $('#updateStat').daterangepicker({
        rangeStartTitle: '起始日期',
        rangeEndTitle: '结束日期',
        nextLinkText: '下月',
        prevLinkText: '上月',
        doneButtonText: '确定',
        cancelButtonText: '取消',
        earliestDate: '',
        latestDate: Date.parse('today'),
        constrainDates: true,
        rangeSplitter: '-',
        dateFormat: 'yy-mm-dd',
        closeOnSelect: true,
        onChange: function(){
            $("#adverFinanceId").submit();
        }
    });
});
