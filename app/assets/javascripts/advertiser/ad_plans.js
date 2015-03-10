$(document).ready(function(){
   $(".btn_search").click(function(){
       var planName = $("#planName").val();
       var bill_type = $("#bill_type_id").val();
       location.href='/advertiser/ad_plans?bill_type='+bill_type+"&planName="+planName;
    });
});
function toPage(page) {

    var bill_type = $("#bill_type_id").val();
    location.href='/advertiser/ad_plans?bill_type='+bill_type+"&pageNum="+page;

}