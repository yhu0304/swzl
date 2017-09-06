<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>欢迎使用Yourphp企业建站系统 - Powered by Yourphp</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.artDialog.js?skin=default"></script>
<script type="text/javascript" src="js/iframeTools.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/MyDate/WdatePicker.js"></script>
<script type="text/javascript" src="js/jquery.colorpicker.js"></script>
<script type="text/javascript" src="js/my.js"></script>
<script type="text/javascript" src="js/swfupload.js">
</script>
</head>

<body width="100%"><div id="loader" >页面加载中...</div><div id="result" class="result none"></div><div class="mainbox"><div id="nav" class="mainnav_title"><ul>
	<a href="#">修改密码</a>|</ul></div><script>	//|str_replace=/yourphpdemo.'/index.php','',###
	var onurl ='/yourphpdemo/index.php?g=Admin&m=User&a=add&menuid=9';
	jQuery(document).ready(function(){
		$('#nav ul a ').each(function(i){
		if($('#nav ul a').length>1){
			var thisurl= $(this).attr('href');
			thisurl = thisurl.replace('&menuid=9','');
			if(onurl.indexOf(thisurl) == 0 ) $(this).addClass('on').siblings().removeClass('on');
		}else{
			$('#nav ul').hide();
		}
		});
		if($('#nav ul a ').hasClass('on')==false){
		$('#nav ul a ').eq(0).addClass('on');
		}
	});
	</script>
	<form id="myform" action="method!updatepwdsave" method="post">
	<input type="hidden" name="id" value="${user.id}"/> 
	<table cellpadding=0 cellspacing=0 class="table_form" width="100%">
	
	<tr><td>旧密码</td><td><input type="password" class="input-text"  name="oldpassword" value="" ></td></tr>
	<tr><td>新密码</td><td><input type="password" class="input-text"  name="password" value="" ></td></tr>
	<tr><td>再次输入</td><td><input type="password" class="input-text"  name="repassword" value="" ></td></tr>
	
	</table>
	
	<div class="btn"><input type="hidden" name="forward" value="" />
	<INPUT TYPE="submit"  value="提交" class="button" ><input TYPE="reset"  value="取消" class="button"></div></form></div></body></html>
