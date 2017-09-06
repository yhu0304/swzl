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

<div id="post-page">
<div class="info-title-wrap wrap">
	<h2 id="note-title-type">修改信息</h2>	
	<span class="fr info-list-more" id="switchType">
			<a href="user!mygoods">我的物品</a>
	</span>
</div>
<div class="wrap post">

	<form action="user!goodseditsave" method="post" id="myform">
	<input type="hidden" value="${goods.id}" name="id" />
	<div class="post-input-wrap">
		<div class="note-title clearfix">
			<label for="note-title" class="fl">标题：</label>
			<input type="text" id="note-title" class="fr" name="title"  validate="required:true" value="${goods.title}"/>
		</div>
		<div class="note-info">
			<ul class="clearfix">
				<li class="note-info-item">
					<label for="note-info-goods">物品种类：</label>
					<select name="cid" id="search-goods-type" validate="required:true">
						<option value="1" <c:if test="${goods.category.id == 1}">selected</c:if>>卡类证件</option>
						<option value="2" <c:if test="${goods.category.id == 2}">selected</c:if>>随身物品</option>
						<option value="3" <c:if test="${goods.category.id == 3}">selected</c:if>>电子数码</option>
						<option value="4" <c:if test="${goods.category.id == 4}">selected</c:if>>书籍资料</option>
						<option value="5" <c:if test="${goods.category.id == 5}">selected</c:if>>衣物饰品</option>
						<option value="6" <c:if test="${goods.category.id == 6}">selected</c:if>>其他物品</option>
					</select>
				</li>
				<li class="note-info-item fl">
					<label for="note-info-goods">物品名称：</label>
					<input type="text" style="width:160px;" id="note-info-goods" name="name" validate="required:true" value="${goods.name}"/>
				</li>
				<li class="note-info-item fr">	
					<label for="note-info-extra">备注：</label>

					<input type="text" id="note-info-extra" name="remark" value="${goods.remark}"/>
				</li>				
				<li class="note-info-item clearfix fl pr">
					<label for="datepicker"><c:if test="${goods.typename=='lost'}">丢失时间：</c:if><c:if test="${goods.typename=='find'}">捡到时间：</c:if></label>
				<input type="text" style="width:160px;" class="input-icon" id="datepicker" name="happentime" validate="required:true"  value="<fmt:formatDate  value="${goods.happentime}" pattern="yyyy-MM-dd" />"/>
				</li>
				<li class="note-info-item fr pr">				
					<label for="note-info-address"><c:if test="${goods.typename=='lost'}">丢失地点：</c:if><c:if test="${goods.typename=='find'}">捡到地点：</c:if></label>

					<input type="text" class="input-icon" id="note-info-address" name="address" value="${goods.address}" validate="required:true"/>
				</li>
			</ul>
		</div>
		<div class="note-contact">
		<ul class="clearfix">
			<li class="note-contact-item fl">
				<label for="note-contact-phone">您的手机：</label>

				<input type="text" style="width:85px;" id="note-contact-phone" name="mobile" value="${goods.mobile}" placeholder="请填写手机号码" validate="required:true,mobile:true,minlength:2, maxlength:40"/>
			</li>
			<li class="note-info-item fr">			
				<label for="note-contact-qq">您的QQ：</label>

				<input type="text" id="note-contact-qq" name="qq"  value="${goods.qq}" placeholder="qq、手机请至少填写一个"/>
			</li>
			
		</ul>
		</div>
		<div class="note-content clearfix" id="content-text">
			<label for="note-content">详情描述：</label>
			<textarea id="note-content" name="info" class="fr">${goods.info}</textarea>
		</div>
		<div class="note-info">
			<ul class="clearfix">
				<li class="note-info-item">
					<label for="note-info-goods">状态：</label>
					<select name="state">
						<option value="0" <c:if test="${goods.state == 0}">selected</c:if>>寻找中</option>
						<option value="1" <c:if test="${goods.state == 1}">selected</c:if>>已找到</option>						
					</select>(选择已找到，请填写以下<c:if test="${goods.typename=='lost'}">帮忙找到者</c:if><c:if test="${goods.typename=='find'}">领取人</c:if>信息)
				</li>
				<li class="note-info-item fl">
					<label for="note-info-goods">姓名：</label>
					<input type="text" id="note-info-goods" name="username" value="${goods.claimuser.username}"/>
				</li>
				<li class="note-info-item fr">	
					<label for="note-info-extra">email：</label>

					<input type="text" id="note-info-extra" name="email" value="${goods.claimuser.email}">
				</li>				
				<li class="note-contact-item fl">
				<label for="note-contact-phone">手机：</label>

				<input type="text" id="note-contact-phone" name="tel" placeholder="请填写手机号码" value="${goods.claimuser.tel}"/>
			</li>
				
			</ul>
		</div>
		
		<div class="note-content clearfix" id="content-text">
			<label for="note-content">领取结果：</label>
			<textarea id="note-content" name="result" class="fr">${goods.result}</textarea>
		</div>
		
		<div class="note-content clearfix" id="content-text">
			
			<p style="padding: 20px 0 10px 540px;" class="tr fr"><button  name="submit" class="btn" id="post-submitBotton" >发布文章</button></p>

		</div>
	
		
	</form>
	

</div>
</div>
<jsp:include page="footer.jsp" flush="true"/>

</body>
</html>
