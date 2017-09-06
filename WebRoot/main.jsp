<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
com.lostfound.util.Util.init(request);
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
<jsp:include page="header.jsp" flush="true"/>

<div id="main" class="wrap clearfix">
<div id="content" class="fr">
	<div class="info-list-wrap clearfix" id="info-list-lost">
		<div class="info-title-wrap">
			<h2><a href="goods!lost">最新信息</a></h2>

		</div>
		<ul class="info-list">
			<li class="clearfix">
				<span class="event-goods-type">物品类别</span>
				<span class="event-goods">物品名称</span>
				<span class="event-time">时间</span>
				<span class="event-address">地点</span>
				<span class="event-title">标题</span>
			</li>
			<c:forEach items="${lostlist}" var="bean">
			<li class="clearfix"><span class="event-goods-type">${bean.category.cname }</span><span class="event-goods">${bean.name}</span><span class="event-time"><fmt:formatDate  value="${bean.happentime}" pattern="yyyy-MM-dd" /></span><span class="event-address">${bean.address}</span><span class="event-title"><a href="goods!view?id=${bean.id}">${fn:substring(bean.title,0,18)}<c:if test="${fn:length(bean.title)>18 }">...</c:if></a></span></li>
			</c:forEach>
			<c:forEach items="${findlist}" var="bean">
			<li class="clearfix"><span class="event-goods-type">${bean.category.cname }</span><span class="event-goods">${bean.name}</span><span class="event-time"><fmt:formatDate  value="${bean.happentime}" pattern="yyyy-MM-dd" /></span><span class="event-address">${bean.address}</span><span class="event-title"><a href="goods!view?id=${bean.id}">${fn:substring(bean.title,0,18)}<c:if test="${fn:length(bean.title)>18 }">...</c:if></a></span></li>		
			</c:forEach>
			</ul>
	</div>
	<div class="info-list-wrap clearfix" id="info-list-found">

</div>
 </div>
<div id="sidebar" class="fl">
	<div id="office" class="side-box">
		<div class="clearfix" id="office-title-wrap">
			<h3 id="office-title">失物招领地点</h3>
			
		</div>
		
		<ul id="office-content">
			<li class="office-item">
				保卫处：101&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话：812345678
			</li>
			<li class="office-item">
				俊才楼：保安室
			</li>
			<li class="office-item">
				浦二：201	
			</li>
			<li class="office-item">
				西平：西平12
			</li>
			<li class="office-item">
				玉辉楼：A201
			</li>
			<li class="office-item">
				宿舍：21栋，19栋，11栋，6栋，1栋宿管室
			</li>
		</ul>
	</div>
	
	
	<div>
		
	</div>
	
	
 </div>

</div>
<jsp:include page="footer.jsp" flush="true"/>
</body></html>