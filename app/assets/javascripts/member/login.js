//= require jquery_ujs
//= require jquery.cookie
$(document).ready(function(){
  function change_input_bg(el,id){
    el.className="input_active";
    var warn=document.getElementById(id);
    var a=el.parentNode;
    a.parentNode.className="inputlist_active inputlist";
    warn.style.visibility="hidden";
  }

  $('#member_email').on('focus',function(){
    change_input_bg(this,'email_warn_box');
  }).on('blur',function(){
    this.parentNode.parentNode.className="inputlist";
  });
  $('#member_password').on('focus',function(){
    change_input_bg(this,'pw_warn_box');
  }).on('blur',function(){
    this.parentNode.parentNode.className="inputlist";
  });

  if(screen.width==1920){
    document.body.className="w1920";
  }
  else if(screen.width>=2560){
    document.body.className="w2560";
  }
  else if(screen.width==1680){
    document.body.className="w1680";
  }
  else if(screen.width<=1440){
    document.body.className="w1440";
  }
  function myResize(){
      if(!('innerWidth' in window)){
        window.innerWidth = document.documentElement.clientWidth;
        window.innerHeight = document.documentElement.clientHeight;
      }
      var tmpHeight = $('.inputarea').height();
      var tmpTop = Math.max(0,(window.innerHeight-tmpHeight)/3);
      $('#page').css('padding-top',tmpTop);
    }
    $(window).resize(myResize);
    myResize();


    $('#loginForm').bind('ajax:success', function(e, data, status, xhr) {
        if(data.success) {
            location.href='/member/login/login';
        } else {
            alert(data.errors);
        }
    });

});
