<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.lostfound.util.Util"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Util.init(request);
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="失物招领网">
	<meta name="keywords" content="失物招领网">
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="public/css/base.css">
	<link rel="stylesheet" href="public/css/style.css">	
	<script type="text/javascript" src="public/jquery/jquery-1.7.1.min.js"></script>
</head>
<body>
<script>this.location.href="goods!index";</script>
</body></html>