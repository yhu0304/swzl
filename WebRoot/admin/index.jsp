<%@ page language="java" import="java.util.*,com.lostfound.model.User" pageEncoding="UTF-8"%>
<% 

User user = (User) session.getAttribute("admin");
if (user==null){
	response.sendRedirect("login.jsp"); 
	return;
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>欢迎使用失物招领</TITLE>
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<SCRIPT type=text/javascript src="js/jquery.min.js"></SCRIPT>


<LINK rel=stylesheet type=text/css href="css/style.css">
<META name=GENERATOR content="MSHTML 8.00.7601.17998"></HEAD>

<BODY style="BACKGROUND: #e2e9ea">
<DIV id=header class=header>
<DIV class=logo>
	<a href="http://www.jlxy.nju.edu.cn/">
		<img src="css/logo.jpg">
	</a>
</DIV>

<DIV class=nav></DIV>

<DIV class=topmenu>
<UL>
  <LI id=menu_1><SPAN><A onclick=sethighlight(1); 
  href="javascript:void(0);">后台首页</A></SPAN></LI>
  <LI id=menu_2><SPAN><A onclick=sethighlight(2); 
  href="javascript:void(0);">用户管理</A></SPAN></LI>
  <LI id=menu_3><SPAN><A onclick=sethighlight(3); 
  href="javascript:void(0);">物品管理</A></SPAN></LI>
  <LI id=menu_4><SPAN><A onclick=sethighlight(4); 
  href="javascript:void(0);">感谢信管理</A></SPAN></LI>
   <LI id=menu_5><SPAN><A onclick=sethighlight(5); 
  href="javascript:void(0);">评论管理</A></SPAN></LI>
   <LI id=menu_6><SPAN><A onclick=sethighlight(5); 
  href="method!logout" target=_top>&nbsp;&nbsp;退&nbsp;&nbsp;出&nbsp;&nbsp;</A></SPAN></LI>
  </UL></DIV>

<DIV class=header_footer></DIV></DIV>

<DIV id=Main_content>
<DIV id=MainBox>
<DIV class=main_box><IFRAME id=Main height=auto src="http://www.baidu.com&amp;menuid=42" 
frameBorder=false width="100%" allowTransparency name=main 
scrolling=auto></IFRAME></DIV></DIV>
<DIV id=leftMenuBox>
<DIV id=leftMenu>
<DIV style="PADDING-LEFT: 12px; _padding-left: 10px">
<DL id=nav_1>
  <DT>后台首页</DT>
  <DD id=nav_42><SPAN 
  onclick="javascript:gourl('42','main.jsp')"><A 
  href="main.jsp" target=main>后台首页</A></SPAN></DD>
  <DD id=nav_40><SPAN 
  onclick="javascript:gourl('40','method!updatepwd')"><A 
  href="method!updatepwd" 
  target=main>修改密码</A></SPAN></DD>
  </DL>
<DL id=nav_2>
  <DT>用户管理</DT>
  <DD id=nav_50><SPAN 
  onclick="javascript:gourl('50','method!userlist')"><A 
  href="method!userlist" 
  target=main>用户列表</A></SPAN></DD>
  <DD id=nav_40><SPAN 
  onclick="javascript:gourl('41','method!useradd')"><A 
  href="method!useradd" 
  target=main>添加用户</A></SPAN></DD>
  </DL>
<DL id=nav_3>
  <DT>物品管理</DT>
  <DD id=nav_17><SPAN 
  onclick="javascript:gourl('17','method!goodslist')"><A 
  href="method!goodslist" 
  target=main>物品列表</A></SPAN></DD>
  </DL>
<DL id=nav_4>
  <DT>感谢信管理</DT>
  <DD id=nav_51><SPAN 
  onclick="javascript:gourl('51','method!thankslist')"><A 
  href="method!thankslist" 
  target=main>感谢信列表</A></SPAN></DD>
  </DL>
  
  <DL id=nav_5>
  <DT>评论管理</DT>
  <DD id=nav_61><SPAN 
  onclick="javascript:gourl('61','method!replylist')"><A 
  href="method!replylist" 
  target=main>评论列表</A></SPAN></DD>
  </DL>
</DIV></DIV>

<DIV id=Main_drop><A class=on href="javascript:toggleMenu(1);"><IMG border=0 
src="images/admin_barclose.gif" width=11 height=60></A><A 
style="DISPLAY: none" class=off href="javascript:toggleMenu(0);"><IMG border=0 
src="images/admin_baropen.gif" width=11 height=60></A></DIV></DIV></DIV>
<DIV id=footer class=footer>
	<div> Copyright © 2017 版权所有：南京大学金陵学院 </div>
	</div>
<SPAN id=run></SPAN></DIV>
<SCRIPT language=JavaScript>if(!Array.prototype.map)
Array.prototype.map = function(fn,scope) {
  var result = [],ri = 0;
  for (var i = 0,n = this.length; i < n; i++){
	if(i in this){
	  result[ri++]  = fn.call(scope ,this[i],i,this);
	}
  }
return result;
};
var getWindowWH = function(){
	  return ["Height","Width"].map(function(name){
	  return window["inner"+name] ||
		document.compatMode === "CSS1Compat" && document.documentElement[ "client" + name ] || document.body[ "client" + name ]
	});
}
window.onload = function (){
	if(!+"\v1" && !document.querySelector) { //IE6 IE7
	 document.body.onresize = resize;
	} else { 
	  window.onresize = resize;
	}
	function resize() {
		wSize();
		return false;
	}
}
function wSize(){
	var str=getWindowWH();
	var strs= new Array();
	strs=str.toString().split(","); //字符串分割
	var h = strs[0] - 95-30;
	$('#leftMenu').height(h);
	$('#Main').height(h); 
}
wSize();


function sethighlight(n) {
	 $('.topmenu li span').removeClass('current');
	 $('#menu_'+n+' span').addClass('current');
	 $('#leftMenu dl').hide();
	 $('#nav_'+n).show();
	 $('#leftMenu dl dd').removeClass('on');
	 $('#nav_'+n+' dd').eq(0).addClass('on');
	 url = $('#nav_'+n+' dd a').eq(0).attr('href');
	 window.main.location.href= url;
}
sethighlight(1);

function gourl(n,url){
	$('#leftMenu dl dd').removeClass('on');
	$('#nav_'+n).addClass('on');
	window.main.location.href=url;
}

function gocacheurl(){
	mainurl = window.main.location.href;
	window.main.location.href= "/yourphpdemo/index.php?g=Admin&m=Index&a=cache&forward="+encodeURIComponent(mainurl);
}

function toggleMenu(doit){
	if(doit==1){
		$('#Main_drop a.on').hide();
		$('#Main_drop a.off').show();
		$('#MainBox .main_box').css('margin-left','24px');
		$('#leftMenu').hide();
	}else{
		$('#Main_drop a.off').hide();
		$('#Main_drop a.on').show();
		$('#leftMenu').show();
		$('#MainBox .main_box').css('margin-left','224px');
	}
}	
</SCRIPT>
</BODY></HTML>
