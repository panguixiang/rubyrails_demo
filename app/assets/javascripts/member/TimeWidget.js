function $i(id){
 return document.getElementById(id);
}
function findPosX(obj){
 var curleft = 0;
 if (obj.offsetParent){
  while (obj.offsetParent){
   curleft += obj.offsetLeft;
   obj = obj.offsetParent;
  }
 } else if (obj.x){
  curleft += obj.x;
 }
 return curleft;
}
function findPosY(obj){
 var curtop = 0;
 if (obj.offsetParent){
  while (obj.offsetParent){
   curtop += obj.offsetTop;
   obj = obj.offsetParent;
  }
 } else if (obj.y){
  curtop += obj.y;
 }
 return curtop;
}
/*-----------e-global----------*/
var curDate={
 year:0,
 month:0,
 date:0
};
var selDate={
 year:0,
 month:0,
 date:0
};
var oldDate={
 year:0,
 month:0,
 date:0
};
var calWrap = null;
var outObj = null;
var outTxt = null;
var outBtn = null;
function calShow(txt, btn){
 if(typeof txt == 'string'){
  outTxt = $i(txt);
 }else{
  outTxt = txt;
 }
 outBtn = (arguments.length == 1)? null : btn;
 outObj = outBtn || outTxt;
 calWrap.style.display = "block";
 var posx = findPosX(outObj);
 var posy = findPosY(outObj);
 var objHeight = outObj.offsetHeight;
 calWrap.style.left = posx + "px";
 calWrap.style.top = (posy+objHeight) + "px";
 
 var selectedDate = outTxt.value;
 var d = null;
 if (selectedDate!=null&&selectedDate!=""){
  selectedDate =  selectedDate.replace(/-/g,"/");
  d = new Date(selectedDate);
 }else{
  d = new Date();
 }
 
 selDate.year = d.getFullYear();
 selDate.month = d.getMonth();
 selDate.date=d.getDate();
 
 oldDate.year = d.getFullYear();
 oldDate.month = d.getMonth();
 oldDate.date=d.getDate();
 
 //alert(selDate.date);
 createCalendar();
}
function calHide(){
 calWrap.style.display = "none";
}
function moveHide() {//清空--panguixiang
	outObj.value = "";

}
function meizzToday()  //今天--panguixiang
  {
	var today;
    meizzTheYear = new Date().getFullYear();
    meizzTheMonth = new Date().getMonth()+1;
    today=new Date().getDate();
    //meizzSetDay(meizzTheYear,meizzTheMonth);
    if(outObj){
    //	alert(meizzTheMonth);
    	if(meizzTheMonth<10){
    		meizzTheMonth = "0"+meizzTheMonth;
    	} 
    	if(today<10) {
    		today = "0"+today;
    	}
    	outObj.value=meizzTheYear + "-" + meizzTheMonth + "-" + today;
    }
   
  }

function preYear(){
 if( selDate.year <= 1900) return;
 selDate.year--;
 createCalendar();
}
function nextYear(){
 if( selDate.year >= 99999) return;
 selDate.year++;
 createCalendar();
}
function preMonth(){
 if( selDate.month <=0 ){
  selDate.year--;
  selDate.month = 11;
 }else{
  selDate.month--;
 }
 createCalendar();
}
function nextMonth(){
 if( selDate.month >=11 ){
  selDate.year++;
  selDate.month = 0;
 }else{
  selDate.month++;
 }
 createCalendar();
}
function setdate(j){
 var month, date;
 if( selDate.month < 9 ){
  month="0"+(selDate.month+1);
 }else{
  month=(selDate.month+1);
 }
 if( j < 10){
  date="0"+j;
 }else{
  date=j;
 }
 var str=selDate.year+"-"+month+"-"+date;
 outTxt.value = str;
 calHide();
 return false;
}

function createCalendar(){ 
 var selDay = new Date(selDate.year, selDate.month, 1).getDay();
 var selNum = new Date(selDate.year, selDate.month+1, 0).getDate();
 $i("selYear").innerHTML = selDate.year;
 $i("selMonth").innerHTML = selDate.month+1;
 var dateA = $i("cal").getElementsByTagName("a");
 for(var i=0,j=1; i<42; i++){
  dateA[i].className = "";
  if( i>=selDay && j<=selNum){
   if(selDate.year==oldDate.year&&selDate.month==oldDate.month&&j==oldDate.date){
    dateA[i].className = "curDate";
   }
   dateA[i].num = dateA[i].innerHTML = j;
   dateA[i].onclick = function(){ setdate(this.num);};
   j++;
  }else{
   dateA[i].innerHTML = "";
   dateA[i].onclick = function() {};//移除innerHTML的同时也要移除上个月可能绑定的事件
  }
  
 }
}
function init(){
 var cur = new Date();
 selDate.year = curDate.year = cur.getFullYear();
 selDate.month = curDate.month = cur.getMonth();
 selDate.date = curDate.date = cur.getDate();
 calWrap = document.createElement("div");
 calWrap.id = "calWrap";
 document.body.appendChild(calWrap);
 var str;
 str = "<div class='tool'>"+
 "<span id='preYear' class='btn' onclick='preYear()'><<</span>"+
 "<span id='preMonth' class='btn' onclick='preMonth()'><</span>"+
 "<span id='selYear'></span>"+
 "<span id='selMonth'></span>"+
 "<span id='nextMonth' class='btn' onclick='nextMonth()'>></span>"+
 "<span id='nextYear' class='btn' onclick='nextYear()'>>></span>"+
 "</div>"+
 "<div class='week'>"+
 "<span>日</span><span>一</span><span>二</span><span>三</span><span>四</span><span>五</span><span>六</span>"+
 "</div>";
 str += "<div id='cal'>";
 for(var i=0,j=1; i<42; i++){
        str += "<a href='javascript:void(0)'></a>";
 }
 str += "</div>"+
 "<div class='close'><a href='javascript:;' onclick='moveHide()'>清空</a>&nbsp;&nbsp;&nbsp;"+
"<a href='javascript:;' onclick='meizzToday()'>今天</a>" +
     "&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='calHide()'>关闭</a></div>";
 calWrap.innerHTML = str; 
 createCalendar(); 
 document.onclick = function(e){
  var e = e || window.event;
  var srcElement = e.srcElement || e.target;
  if( srcElement != outTxt && srcElement != outBtn && srcElement.className != "btn" ){
   calHide();
  }
 };
}
window.onload = init;