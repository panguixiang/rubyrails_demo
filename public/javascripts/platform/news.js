

$(document).ready(function(){
    if($("#newsType").val()=='1'){
        getNews($("#offset").val(),$("#newsType").val(),"");
    } else {
        getNews($("#offset").val(),$("#newsType").val(),"10");
    }
    $(".showmore").click(function(){
        if($("#newsType").val()=='1'){
            getNews($("#offset").val(),$("#newsType").val(),"");
        } else {
            getNews($("#offset").val(),$("#newsType").val(),"10");
        }
    })
});

function getNews(offset,newsType,information) {
    $.ajax({
        url:'/platform/news/getNews',
        type:'get',
        data:{offset:offset,newsType:newsType,information:information},
        success:function(data) {
            var newsList=data.newsList;
            var offset = data.offset;
            var informationList = data.informationList;
            for (var i=0;i<newsList.length;i++) {
                htmlStr = createNewsTr(newsList[i]);
                $("#newsType").after(htmlStr);
            }
            if(information.length>0) {
                for (var i=0;i<informationList.length;i++) {
                    htmlStr = createNews5Tr(informationList[i]);
                    if(i<=(informationList.length/2)) {
                        $("#leftN").after(htmlStr);
                    } else {
                        $("#rightN").after(htmlStr);
                    }
                }
            }
        },
        error:function(a,b) {
            alert("系统异常！")
        }
    });
}
function createNewsTr(data) {
    var htmlStr=" <div><h1 class='fhei'><span class='share'> <div class='share' style='width: 118px; float: left; z-index: 99; margin-left: -30px;'> <a style='display:block; width:118px; height:32px;'></a>";
    htmlStr+="<ul class='hidden'> <li> <a target='_blank' class='l1' href='http://v.t.sina.com.cn/share/share.php?title=多盟助阵阿里云“聚无线”百万资金扶持项目http://www.domob.cn/news/media/0_20141209.htm'>新浪微博</a></li>";
    htmlStr+="<li> <a target='_blank' class='l2' href='http://share.v.t.qq.com/index.php?c=share&amp;a=index&amp;f=q2&amp;url=http://www.domob.cn/news/media/0_20141209.htm&amp;title=多盟助阵阿里云“聚无线”百万资金扶持项目'>腾讯微博</a></li>";
    htmlStr+="<li> <a target='_blank' class='l3' href='http://widget.renren.com/dialog/share?resourceUrl=http://www.domob.cn/news/media/0_20141209.htm&amp;title=多盟助阵阿里云“聚无线”百万资金扶持项目&amp;charset=UTF-8'>人人网</a></li>";
    htmlStr+="<li> <a target='_blank' class='l4' href='http://www.douban.com/recommend/?url=http://www.domob.cn/news/media/0_20141209.htm&amp;title=多盟助阵阿里云“聚无线”百万资金扶持项目'>豆瓣网</a></li></ul></div></span>";
    htmlStr+="<a class='blue' target='_blank' href='/"+data.url+"'>"+data.title+"</a></h1>"
    htmlStr+="<p class='origin'>发表于&nbsp;&nbsp;<span>"+data.created_at+"</span>&nbsp;&nbsp;|&nbsp;&nbsp;来自&nbsp;&nbsp;<span>"+data.comefrom+"</span></p>";
    htmlStr+="<p>"+data.introduction+"</p></div>"
    return htmlStr;
}
function createNews5Tr(data) {
    var htmlStr="<p><a class='blue' target='_blank'  href=/"+data.url+">"+data.title+"</a></p>"
    return htmlStr;
}