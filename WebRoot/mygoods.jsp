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

<div class="wrap note-list-page">
	<div class="info-list-wrap">
		<div class="info-title-wrap">
			<h2 id="search-list-title">我的物品</h2>
			<h3 id="serach-list-goodsType">
							</h3>
			<span class="info-list-more fr" id="switchType">
				<a href="user!mythanks">我的感谢信</a>
			</span>
		</div>
		
		<ul class='info-list'><li class='clearfix'><span class='info-goods'>管理操作</span><span class='info-goods'>事件类型</span><span class='info-goods'>物品类别</span><span class='info-goods'>丢失物品</span><span class='info-goods'>丢失地点</span><span class='info-goods'>丢失时间</span><span class='info-title'>标题</span></li>
		<c:forEach items="${list}" var="bean">
		
		<li class='clearfix'>
		<span class='info-goods'><a href="user!goodsedit?id=${bean.id}">修改</a>&nbsp;&nbsp;<a onclick="return confirm('确定删除?')" href="user!goodsdelete?id=${bean.id}">删除</a></span>
		<span class='info-goods'><c:if test="${bean.typename == 'lost'}">寻物信息</c:if><c:if test="${bean.typename == 'find'}">招领信息</c:if></span>
		<span class='info-goods'>${bean.category.cname }</span>
		<span class='info-goods'>${bean.name}</span><span class='info-goods'>${bean.address}</span>
		<span class='info-goods'><fmt:formatDate  value="${bean.happentime}" pattern="yyyy-MM-dd" /></span>
		<span class='info-title'><a href='goods!view?id=${bean.id}'>${bean.title}</a></span>
		
		</c:forEach>
		
		</ul>
		<div class='cmt-pageList-wrap'><div class='cmt-pageList'>${pagerinfo}</div></div>			
	</div>
</div>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
