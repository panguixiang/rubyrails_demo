// 已经将index.html中的所有事件转换成通过js绑定
// 简化了大部分的函数，发现并解决了底部logowall在IE下面切换动画的Bug
// 还需要重构的地方有：
// 1：banner动画
// 2：中间横幅移动动画
// 3：header.htm
// 2014-07-16


// 1.header.htm重构完成
// 2.topbar.htm重构完成
// 3.多盟新闻页面重构完成，根据Url导航的功能也实现了
// 4.帮助中心页面基本重构完成，常见问题、技术文档和规则介绍3个部分的局部导航有Bug,复制粘贴需要重构
// 5.多盟公司页面基本重构完成，加入我们部分的复制粘贴需要重构
// 2014-07-17
$(document).ready(function (){
    partnerArry = new Array();
    mediaArry = new Array();
	var checkEmpty = function(input,warnBoxId){
		var warnBox=document.getElementById(warnBoxId);
		if (input.value){ 
			input.className = 'input_correct';
			warnBox.style.visibility="hidden";
		} 
		else {
			input.className = 'input_error1';
			warnBox.style.visibility="visible";
		}
	};
	$('#member_email').on('focus',function(){
		var warn=document.getElementById('email_warn_box');
		this.className="input_active";
		warn.style.visibility="hidden";
	}).on('blur',function(){
		checkEmpty(this,'email_warn_box');
	});
	$('#member_password').on('focus',function(){
		var warn=document.getElementById('pw_warn_box');
		this.className="input_active";
		warn.style.visibility="hidden";
	}).on('blur',function(){
		checkEmpty(this,'pw_warn_box');
	});
	$('#adformats').on('click',function(){
		$('#adformats_c').css('display','block');
		$('#advantage_c').css('display','none');
		this.className='current';
		document.getElementById('advantage').className='normal';
	}).on('mouseover',function(){
		if(this.className == 'normal'){
			this.className = 'hover';
		}
	}).on('mouseout',function(){
		if(this.className == 'hover'){
			this.className = 'normal';
		}
	});
	$('#advantage').on('click',function(){
		$('#adformats_c').css('display','none');
		$('#advantage_c').css('display','block');
		this.className='current';
		document.getElementById('adformats').className='normal';
	}).on('mouseover',function(){
		if(this.className == 'normal'){
			this.className = 'hover';
		}
	}).on('mouseout',function(){
		if(this.className == 'hover'){
			this.className = 'normal';
		}
	});

	$('#buttonleft1').on('click',function(){
		move('adformats_box','buttonleft1','buttonright1',1,-2720,275,600);
	});
	$('#buttonright1').on('click',function(){
		move('adformats_box','buttonleft1','buttonright1',0,-2720,275,600);
	});
	$('#buttonleft2').on('click',function(){
		move('advantage_box','buttonleft2','buttonright2',1,-1400,0,700);
	});
	$('#buttonright2').on('click',function(){
		move('advantage_box','buttonleft2','buttonright2',0,-1400,0,700);
	});
	var curTabId="tab0";
	$('.news_nav a').on('click',function(){
		document.getElementById(curTabId).className=curTabId+"_n";
		$('#'+curTabId+'_c').css('display','none');
		this.className=this.id+"_a"
		$('#'+this.id+'_c').css('display','block');
		curTabId=this.id;
	}).on('mouseover',function(){
		if(this.className==this.id+"_n"){
			this.className=this.id+"_h";
		}
	}).on('mouseout',function(){
		if(this.className==this.id+"_h"){
			this.className=this.id+"_n";
		}
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
           var pictureList = data.pictureList;
           $(pictureList).each(function(index,obj){
               if(index==0) {
                   s+="<div id=pose"+index+"  style='background: url("+obj.pic_url+") no-repeat center;' class='picture picture_in' >"
               } else {
                   s+="<div id=pose"+index+"  style='background: url("+obj.pic_url+") no-repeat center;' class='picture picture_out' >"
               }
               s+="</div>";
           });
           _pose.innerHTML=s;
           var pictureListOne = data.strongList;
           $("#adformats_box").css("backgroundImage","url("+pictureListOne[0].pic_url+")");
           $("#advantage_box").css("backgroundImage","url("+pictureListOne[1].pic_url+")");
           $(data.partnerList).each(function(index,obj){
               if(index<8) {
                   $("#logWal1Img"+index).attr("src",obj.pic_url);
               }
               //partnerArry.push(obj.pic_url);
           });
           $(data.mediaList).each(function(index,obj){
               if(index<8) {
                   $("#logWal2Img"+index).attr("src",obj.pic_url);
               }
              // mediaArry.push(obj.pic_url);
           });
       }

    });

//    window.setInterval(function() {
//        n = StartLogWall(n);
//    },7000);

    $("#advertisers").click(function(){
        $("#advertisers").removeClass("current");
        $("#developers").removeClass("current");
        $(this).removeClass("normal");
        $(this).addClass("current");
        $("#logowall1").css("display","block");
        $("#logowall2").css("display","none");
        //StartLogWall();
    });
    $("#developers").click(function(){
        $("#advertisers").removeClass("current");
        $("#developers").removeClass("current");
        $(this).removeClass("normal");
        $(this).addClass("current");
        $("#logowall1").css("display","none");
        $("#logowall2").css("display","block");
        //StartLogWall();
    });

    $('#loginForm').bind('ajax:success', function(e, data, status, xhr) {
        if(data.success) {
            location.href='/member/login/login';
        } else {
            alert(data.errors);
        }
    });


});

//function StartLogWall() {
//    var s=0;
//    if($("#advertisers").attr("class")=='current') {
//        for(var i=0;i<8;i++) {
//            $("#logWal1Img"+i).removeAttr("src");
//            if(partnerArry[n]) {
//                $("#logWal1Img"+i).attr("src",partnerArry[n]);
//                $("#logWal1Img"+i).fadeIn(1000+i*20);
//            }
//            if(n==partnerArry.length-1) {
//                break;
//            }
//        }
//    } else {
//        for(var i=0;i<8;i++) {
//            $("#logWal2Img"+i).removeAttr("src");
//
//            if(mediaArry[n]) {
//                $("#logWal2Img"+i).attr("src",mediaArry[n]);
//                $("#logWal2Img"+i).fadeIn(1000+i*20);
//            }
//            if(n==mediaArry.length-1) {
//                break;
//            }
//        }
//    }
//}
var playing=false;
function move(id1,id2,id3,direction,m,n,l){
    var el=document.getElementById(id1);
    var origin=parseInt(el.style.marginLeft);
    var _buttonleft=document.getElementById(id2);
    var _buttonright=document.getElementById(id3);
    if(window.html5){
        if(direction==0){
            _buttonleft.className="button bl_nor";
            var curTransform = el.style.webkitTransform;
            var curX = parseInt(curTransform.split('(')[1].split('px')[0]);
            if(origin+curX<=m){
                return false;
            }
            else{
                var dx = curX-l;
                el.style.webkitTransform = 'translate3d('+dx+'px,0,0)';
                if(dx+origin<=m){
                    _buttonright.className="button br_unable";
                }
            }
        }
        else{
            _buttonright.className="button br_nor";
            var curTransform = el.style.webkitTransform;
            var curX = parseInt(curTransform.split('(')[1].split('px')[0]);
            if(origin+curX>=n){
                return false;
            }
            else{
                var dx = curX+l;
                el.style.webkitTransform = 'translate3d('+dx+'px,0,0)';
                if(origin+dx>=n){
                    _buttonleft.className="button bl_unable";
                }
            }
        }
        return;
    }
    if(playing==false){
        if(direction==0){
            _buttonleft.className="button bl_nor";
            if(origin<=m){
                return false;
            }
            else{
                playing=true;
                var animate = function(){
                    var curMarginLeft=parseInt(el.style.marginLeft);
                    var dx = 50;
                    var newMargin = Math.max(curMarginLeft-dx,origin-l);
                    el.style.marginLeft = newMargin+'px';
                    if(newMargin<=m){
                        _buttonright.className="button br_unable";
                    }
                    if(newMargin<=(origin-l)){
                        playing=false;
                    }
                    else{
                        window.rAF(animate);
                    }
                };
                animate();
            }
        }
        else{
            _buttonright.className="button br_nor";
            if(origin>=n){
                return false;
            }
            else{
                playing=true;
                var animate = function(){
                    var curMarginLeft=parseInt(el.style.marginLeft);
                    var dx = 50;
                    var newMargin = Math.min(curMarginLeft+dx,origin+l);
                    el.style.marginLeft = newMargin+'px';
                    if(newMargin>=(n)){
                        _buttonleft.className="button bl_unable";
                    }
                    if(newMargin>=(origin+l)){
                        playing=false;
                    }
                    else{
                        window.rAF(animate);
                    }
                };
                animate();
            }
        }
    }
}