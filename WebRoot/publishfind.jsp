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
	<h2 id="note-title-type">发布招领信息</h2>
	<span class="fr info-list-more" id="switchType">
			<a href="goods!publish?type=lost">发布寻物信息</a>
	</span>
	
	
</div>
<div class="wrap post">

	<form action="goods!publishsave" method="post" id="myform">
	
	<div class="post-input-wrap">
		<div class="note-title clearfix">
			<label for="note-title" class="fl">标题：</label>
			<input type="text" id="note-title" class="fr" name="title"  validate="required:true"/>
		</div>
		<div class="note-info">
			<ul class="clearfix">
				<li class="note-info-item">
					<label for="note-info-goods">物品种类：</label>
					<select name="cid" id="search-goods-type" validate="required:true">
						<option value="1" selected="selected">卡类证件</option>
						<option value="2">随身物品</option>
						<option value="3">电子数码</option>
						<option value="4">书籍资料</option>
						<option value="5">衣物饰品</option>
						<option value="6">其他物品</option>
					</select>
				</li>
				<li class="note-info-item fl">
					<label for="note-info-goods">物品名称：</label>
					<input type="text" style="width:160px;" id="note-info-goods" name="name" validate="required:true"/>
				</li>
				<li class="note-info-item fr">	
					<label for="note-info-extra">备注：</label>

					<input type="text" id="note-info-extra" name="remark">
				</li>				
				<li class="note-info-item clearfix fl pr">
					<label for="datepicker">捡到时间：</label>

					<input type="text" style="width:160px;" class="input-icon" id="datepicker" name="happentime" readonly="readonly"/>
				</li>
				<li class="note-info-item fr pr">				
					<label for="note-info-address">捡到地点：</label>

					<input type="text" class="input-icon" id="note-info-address" name="address" validate="required:true"/>
				</li>
			</ul>
		</div>
		<div class="note-contact">
		<ul class="clearfix">
			<li class="note-contact-item fl">
				<label for="note-contact-phone">您的手机：</label>

				<input type="text" style="width:85px;" id="note-contact-phone" name="mobile" validate="required:true,mobile:true,minlength:2, maxlength:40"/>
			</li>
			<li class="note-info-item fr">			
				<label for="note-contact-qq">您的QQ：</label>

				<input type="text" id="note-contact-qq" name="qq" />
			</li>
			
		</ul>
			
		<input type='hidden' id='type' name='type' value='find' />			
		
		<div class="note-content clearfix" id="content-text">
			<label for="note-content">详情描述：</label>
			<textarea id="note-content" name="info" class="fr"></textarea>
			<p style="padding: 20px 0 10px 540px;" class="tr fr"><button  type="submit" class="btn" id="post-submitBotton" >发布信息</button></p>

		</div>
	
		
	</form>
	

</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
