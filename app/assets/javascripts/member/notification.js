$(document).ready(function(){
    $(".flip").click(function(){
        $(this).toggleClass("superstrong");
        $(this).next().slideToggle("slow");
    });
});

function setStatus(id) {
    $.ajax({
        url:'/member/notification/saveStatus',
        type:'get',
        data:{id:id},
        success:function(data) {
            $("#abc"+id).removeClass("unread");
        }
    });
}