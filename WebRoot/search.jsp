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

	<div class="wrap">
	<div class="search-form">
	<form action="goods!search" method="get">
		<ul>
			<li class="search-form-item">
				<label for="search-type">事件类型：</label>
				<select name="type" id="search-type">
					<option value="" selected="selected">请选择</option>
					<option value="lost" <c:if test="${type == 'lost'}">selected</c:if>>寻物信息</option>
					<option value="find" <c:if test="${type == 'find'}">selected</c:if>>招领信息</option>
				</select>
				<label for="search-goods-type">物品种类：</label>
				<select name="catid" id="search-goods-type">
					<option value="0" selected="selected">请选择</option>
					<option value="1" <c:if test="${catid == 1}">selected</c:if>>卡类证件</option>
					<option value="2" <c:if test="${catid == 2}">selected</c:if>>随身物品</option>
					<option value="3" <c:if test="${catid == 3}">selected</c:if>>电子数码</option>
					<option value="4" <c:if test="${catid == 4}">selected</c:if>>书籍资料</option>
					<option value="5" <c:if test="${catid == 5}">selected</c:if>>衣物饰品</option>
					<option value="6" <c:if test="${catid == 6}">selected</c:if>>其他物品</option>
				</select>
				
			</li class="search-form-item">
			<li class="search-form-item">
				<label for="search-key" class="red">关键词：</label>
				<input type="text" name="key" id="search-key" value="${key}" />
				<label for="">事件地点：</label>
				<input type="text" name="address" id=""  value="${address}" />
				
			</li>
			<li class="search-form-item">
				<label for="search-startTime-datepicker">开始时间：</label>
				<input type="text" name="starttime" id="search-startTime-datepicker" class="input-icon" value="${starttime}" />
				<label for="search-endTime-datepicker">结束时间：</label>
				<input type="text" name="endtime" id="search-endTime-datepicker"  value="${endtime}" />
				
				
			</li>
			<li class="search-form-item" id="search-form-button">
				
				
				<button class="btn" value="1">开始搜索</button>
			</li>
		</ul>
	</form>
	</div>
	</div>
<div class="wrap search-list">
<div class="info-title-wrap">
	<h2>搜索结果</h2>
</div>
		<ul class='info-list'><li class='clearfix'><span class='info-goods-type'>物品类别</span><span class='info-goods'>丢失物品</span><span class='info-goods'>丢失地点</span><span class='info-goods'>丢失时间</span><span class='info-title'>标题</span></li>
		<c:if test="${size == 0}">没有找到相关信息</c:if>
		<c:forEach items="${list}" var="bean">
		<li class='clearfix'><span class='info-goods-type'>${bean.category.cname }</span><span class='info-goods'>${bean.name}</span><span class='info-goods'>${bean.address}</span><span class='info-goods'><fmt:formatDate  value="${bean.happentime}" pattern="yyyy-MM-dd" /></span><span class='info-title'><a href='goods!view?id=${bean.id}'>${bean.title}</a></span></li>
		</c:forEach>
		</ul>
		<div class='cmt-pageList-wrap'><div class='cmt-pageList'>${pagerinfo}</div></div>
</div>
<jsp:include page="footer.jsp" flush="true"/>

</body>
</html>
