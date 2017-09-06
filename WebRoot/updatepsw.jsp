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

<div id="post-page">
<div class="info-title-wrap wrap">
	<h2 id="note-title-type">修改密码</h2>
	
	
</div>
<div class="wrap post">

	<form action="user!updatepsw" method="post">
	<div class="post-input-wrap">
		<div class="note-title clearfix">
			<label for="note-title" class="fl">原来密码：</label>
			<input type="password" id="note-title" class="fr" name="oldpassword"/>
		</div>
		<div class="note-title clearfix">
			<label for="note-title" class="fl">新设密码：</label>
			<input type="password" id="note-title" class="fr" name="password"/>
		</div>
		<div class="note-title clearfix">
			<label for="note-title" class="fl">再输一次：</label>
			<input type="password" id="note-title" class="fr" name="repassword"/>
		</div>		
		
		<div class="note-content clearfix" id="content-text">
			
			<p style="padding: 20px 0 10px 540px;" class="tr fr"><button  name="submit" class="btn" id="post-submitBotton" >修改密码</button></p>
		</div>
	
		
	</form>
	

</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
