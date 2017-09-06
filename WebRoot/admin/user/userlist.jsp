<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>欢迎使用Yourphp企业建站系统 - Powered by Yourphp</title
><link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.artDialog.js?skin=default"></script>
<script type="text/javascript" src="../js/iframeTools.js"></script>
<!--
function confirm_delete(url){
	alert.confirm("确认要删除信息吗?", function(){location.href = url;});
}
//--></head>

<body width="100%"><div id="result" class="result none"></div><div class="mainbox">
<div id="nav" class="mainnav_title">
<ul><a href="method!userlist">用户列表</a> | <a href="method!useradd">添加用户</a>
</ul></div>

 
<table  class="search_table" width="100%">
<tr><td><form action="method!userlist" method="get">
筛选: <input type="text" name="email"  class="input-text" value="${email}"/>
<select name="role"><option value="0" <c:if test="${role==0}">selected</c:if>>普通用户</option><option value="1" <c:if test="${role==1}">selected</c:if>>管理员</option>
</select><input type="submit" value="查询"  class="button" /></form></td></tr></table>

<div class="table-list"><table width="100%" cellspacing="0">
<thead><tr><th width="40">ID</th><th width="100">用户名</th><th width="110">用户组</th><th width="120">邮箱</th><th width="150">注册时间</th><th  width="120">操作</th></tr></thead>
<tbody>

<c:forEach items="${list}" var="bean">
<tr><td align="center">${bean.id}</td>
<td align="center">${bean.username}</td>
<td align="center"><c:if test="${bean.role ==0}">用户</c:if><c:if test="${bean.role ==1}">管理员</c:if></td>
<td align="center">${bean.email}</td>
<td align="center"><fmt:formatDate  value="${bean.createtime}" pattern="yyyy-MM-dd" /></td>
<td align="center"><a href="method!useredit?id=${bean.id}">查看</a> | <a href="method!userdelete?id=${bean.id}" onclick="return confirm('删除用户同时会删除该用户相关的所有数据');">删除</a></td></tr>
</c:forEach>

</tbody></table>

</div></div>

<div style="text-align:center"">${pagerinfo }</div></body></html>
