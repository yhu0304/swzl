<%@ page language="java" import="java.util.*,com.lostfound.model.User" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
	<meta name="description" content="失物招领网" />
	<meta name="keywords" content="失物招领网" />
	<meta charset="UTF-8" />
	<title></title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" href="public/css/base.css" />
	<link rel="stylesheet" href="public/css/style.css" />
	<link rel="stylesheet" href="public/jquery/jqueryui-1.8.18.css" />
	<script type="text/javascript" src="public/jquery/jquery-1.7.1.min.js"></script>

</head>
<body>


<jsp:include page="header.jsp" flush="true"/>

<div class="note-page">

<div class="clearfix">
 	<div class="fl"></div>
	<div id="note-detail">
		<div class='note-detail-title-wrap clearfix'>
			<h2 class="note-detail-title fl">
			${thanks.title}</h2>
				<span class="fr note-detail-author">
				${thanks.createuser.username} 发表于<fmt:formatDate  value="${thanks.crearetime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
		</div>
		<div class="note-detial-goods">
			${thanks.info}		
		</div>

		
		
		
	</div>

	
</div>
 

</div>

<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>

