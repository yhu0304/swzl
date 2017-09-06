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

</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

<div id="reg-container">
	<div id="reg-container-wrap">
	<div id="reg-login" class="clearfix">
		<p class="fl">已有本站账户？请<a href="login.jsp" target="_self">登录</a>。</p>
		
	</div>
	<div id="reg-form">
		<p class="reg-info">注册为本站会员，以下信息均为必填。<p>
		
		<form action="user!useradd" method="post" id="myform">
		
			<ul>
				<li class="reg-list-item clearfix" id="J_email">
					<div class="reg-input-box">
						<label for="reg-email"><em class="red">*</em>邮箱：</label>
						<input type="text" id="reg-email" placeholder="您的常用邮箱" name="email" value="" autocomplete="off" />
					</div>
					<div class="reg-msg" id="J_email_msg">
												<p class="error none">邮箱格式不正确。</p>
												
						<p class="ok none"> </p>
					</div>
				</li>
				<li class="reg-list-item clearfix">
					<div class="reg-input-box">
						<label for="reg-username"><em class="red">*</em>昵称：</label>
						<input type="text" id="reg-username" name="username" placeholder="起个名儿 4个字符以上" value="" autocomplete="off" />
					</div>
					<div class="reg-msg" id="J_username_msg"> 
						<p class="error none">会员名不能为空。</p>
						<p class="ok none"> </p>
					</div>
				</li>
				<li class="reg-list-item clearfix">
					<div class="reg-input-box">
						<label for="reg-pwd"><em class="red">*</em>登录密码：</label>
						<input type="password" id="reg-pwd" placeholder="请输入6位以上密码" name="password" autocomplete="off" />
					</div>
					<div class="reg-msg" id="J_pwd_msg">
						<p class="error none">密码不能为空。</p>
						<p class="ok none"> </p>
					</div>
				</li>
				<li class="reg-list-item" style="padding-left: 108px;">
					<button type="submit" name="submit" id="J_reg_submit" class="btn">注册为本站会员</button>
				</li>
				
			</ul>
			
		</form>
</div>

</div>
</div>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>


