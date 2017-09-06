<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>欢迎使用Yourphp企业建站系统 - Powered by Yourphp</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/MyDate/WdatePicker.js"></script>

</head>

<body width="100%"><div id="loader" >页面加载中...</div><div id="result" class="result none"></div><div class="mainbox"></div>
	<form id="myform" action="method!goodseditsave" method="post">
	<input type="hidden" name="id" value="${goods.id}"/> 
	<table cellpadding=0 cellspacing=0 class="table_form" width="100%">
	<tr>
	<td width="120">标题</td>	<td  colspan='3'><input type="text" class="input-text"  name="title" value="${goods.title}" validate="required:true" /></td>
	</tr>
	
	<tr>
	<td>物品种类：</td><td colspan='3'><select name="cid" id="search-goods-type" validate="required:true">
						<option value="1" <c:if test="${goods.category.id == 1}">selected</c:if>>卡类证件</option>
						<option value="2" <c:if test="${goods.category.id == 2}">selected</c:if>>随身物品</option>
						<option value="3" <c:if test="${goods.category.id == 3}">selected</c:if>>电子数码</option>
						<option value="4" <c:if test="${goods.category.id == 4}">selected</c:if>>书籍资料</option>
						<option value="5" <c:if test="${goods.category.id == 5}">selected</c:if>>衣物饰品</option>
						<option value="6" <c:if test="${goods.category.id == 6}">selected</c:if>>其他物品</option>
					</select></td>
	
	</tr>
	<tr><td>物品名称：</td><td><input type="text" class="input-text"  name="name" value="${goods.name}" validate="required:true"></td>
	<td>备注：</td><td><input type="text" class="input-text"  name="remark" value="${goods.remark}"/>
	</tr>
	
	<tr><td>丢失时间：</td><td><input type="text" class="input-text"  id="datepicker" name="happentime" value="<fmt:formatDate  value="${goods.happentime}" pattern="yyyy-MM-dd" />" validate="required:true"/></td>
	<td>丢失地点：</td><td><input type="text" class="input-text"  name="address" value="${goods.address}" validate="required:true"/>
	</tr>
	
	<tr><td>您的手机：</td><td><input type="text" class="input-text"  name="mobile" value="${goods.mobile}" validate="required:true,mobile:true,minlength:2, maxlength:40"></td>
	<td>您的QQ：</td><td><input type="text" class="input-text"  name="qq"  value="${goods.qq}"/>
	</tr>
	
	<tr><td>详情描述：</td><td colspan='3"'><textarea id="note-content" name="info" cols="100">${goods.info}</textarea></td>
	
	</tr>
	
	<tr><td>状态：</td><td colspan='3"'>
	<select name="state">
		<option value="0" <c:if test="${goods.state == 0}">selected</c:if>>寻找中</option>
		<option value="1" <c:if test="${goods.state == 1}">selected</c:if>>已找到</option>						
	</select>(选择已找到，请填写以下<c:if test="${goods.typename=='lost'}">帮忙找到者</c:if><c:if test="${goods.typename=='find'}">领取人</c:if>信息)</td>
	
	</tr>
	
	<tr><td>姓名：</td><td><input type="text" class="input-text"  name="username" value="${goods.claimuser.username}"/></td>
	<td>Email：</td><td><input type="text" class="input-text"  name="email" value="${goods.claimuser.email}"></td>
	</tr>
	
	<tr>
	<td width="120">手机：</td>	<td  colspan='3'><input type="text" class="input-text"  name="tel" placeholder="请填写手机号码" value="${goods.claimuser.tel}"/></td>
	</tr>
	</table>
	
	<div class="btn"><input type="hidden" name="forward" value="" />
	<INPUT TYPE="submit"  value="提交" class="button" ><input TYPE="reset"  value="取消" class="button"></div></form></body></html>
