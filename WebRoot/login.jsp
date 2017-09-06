<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="失物招领网">
	<meta name="keywords" content="失物招领网">
	<meta charset="UTF-8">
	<title></title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" href="public/css/base.css" />
	<link rel="stylesheet" href="public/css/style.css" />
	<link rel="stylesheet" href="public/jquery/jqueryui-1.8.18.css" />
	<script type="text/javascript" src="public/jquery/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="admin/js/jquery.validate.js"></script>

</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

<div id="login-wrap" class="wrap clearfix">
	
	<div class="login-box fr">
	<div class="info-title-wrap" id="login-title-wrap">
		<h2>登录 | 失物招领</h2>
	</div>
			
		<div id="login-box-inner">
		<form action="user!login" method="post" id="myform">
		
			<ul>
					<!--	<li id="login-notMatch">
							</li>-->
								
				<li class="login-list-item">
					<label for="email">邮箱：</label>
					<input type="text" id="email" name="email" value="" autocomplete="off"  validate="required:true,email:true , minlength:1, maxlength:40"/>
				</li>
				<li class="login-list-item">
					<label for="pwd">密码：</label>
					<input type="password" id="pwd" name="password" autocomplete="off" />
				</li>
				<li class="login-list-item login-list-submitWrap">
					<button type="submit" name="submit" class="btn" id="login-submitBotton">登录</button>
					<span class="fr" style="padding-top: 10px;"><a href="reg.jsp" style="color: #000;">现在就去注册>></a></span>
				</li>
			</ul>
			
		</form>
		</div>
		
		
	</div>
	
</div>

<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
