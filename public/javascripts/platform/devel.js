$(document).ready(function(){
     $.ajax({
           url:'/platform/deve_nav/carousel',
           type:'get',
           dataType: "json",
           success:function(data){
               var carsouLists = data.carsouList2;
               var hostUrl=data.nginx_url;
               $(carsouLists).each(function(index,obj){
                 $("#pose"+index).css("backgroundImage","url("+hostUrl+obj.background_url+")");
                 $(".topic"+index).attr("src",hostUrl+obj.image_url);
               });
           }
        });
});