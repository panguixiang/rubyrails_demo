//= require jquery_ujs
//= require jquery.cookie
$(document).ready(function(){
    $('#adform a').on('click',function(){
        var offsetY = document.documentElement.scrollTop||document.body.scrollTop;
        $('#adform .'+this.className+'demo').css('display','block').css('top',offsetY);
        $('#floatingfloor').css('display','block');
    });
    $('#adform .button').on('click',function(){
        this.parentNode.style.display="none";
        $('#floatingfloor').css('display','none');
    });

    var _pose=document.getElementById('pose');
    function StartAnimation(){
        var id = $(".picture_in").attr("id");
        var num = $(".picture").length;
        if(id) {
            $(".picture").removeClass("picture_in");
            $("#"+id).addClass("picture_out");
            if("pose"+(parseInt(num)-1)==id) {
                $("#pose0").removeClass("picture_out");
                $("#pose0").addClass("picture_in");
            } else {
                $("#"+id).next().removeClass("picture_out");
                $("#"+id).next().addClass("picture_in");
            }

        } else {
            $("#pose0").removeClass("picture_out");
            $("#pose0").addClass("picture_in");
        }
    }
    StartAnimation();
    window.setInterval(function() {
        StartAnimation();
    },13000);

    $.ajax({
        url:'/platform/index/carousel',
        type:'get',
        dataType: "json",
        success:function(data){
            var s='';
            var developPicList = data.developPicList;
            $(developPicList).each(function(index,obj){
                if(index==0) {
                    s+="<div id=pose"+index+"  style='background: url("+obj.pic_url+") no-repeat center;' class='picture picture_in' >"
                } else {
                    s+="<div id=pose"+index+"  style='background: url("+obj.pic_url+") no-repeat center;' class='picture picture_out' >"
                }
                s+="</div>";
            });
            _pose.innerHTML=s;
        }
    });



});
