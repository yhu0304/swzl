<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title></title
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

<script>	
	var onurl ='';
	jQuery(document).ready(function(){
		$('#nav ul a ').each(function(i){
		if($('#nav ul a').length>1){
			var thisurl= $(this).attr('href');
			thisurl = thisurl.replace('&menuid=9','');
			if(onurl.indexOf(thisurl) == 0 ) $(this).addClass('on').siblings().removeClass('on');
		}else{
			$('#nav ul').hide();
		}
		});
		if($('#nav ul a ').hasClass('on')==false){
		$('#nav ul a ').eq(0).addClass('on');
		}
	});
	</script>

<table  class="search_table" width="100%">
<tr><td><form action="method!goodslist" method="get">
<input type="hidden" name="g" value="Admin" /><input type="hidden" name="m" value="User" />
<input type="hidden" name="a" value="index" />筛选: <input type="text" name="key"  class="input-text" value="${key}"/>

<select name="catid" id="search-goods-type">
					<option value="0" selected="selected">物品类别</option>
					<option value="1" <c:if test="${catid == 1}">selected</c:if>>卡类证件</option>
					<option value="2" <c:if test="${catid == 2}">selected</c:if>>随身物品</option>
					<option value="3" <c:if test="${catid == 3}">selected</c:if>>电子数码</option>
					<option value="4" <c:if test="${catid == 4}">selected</c:if>>书籍资料</option>
					<option value="5" <c:if test="${catid == 5}">selected</c:if>>衣物饰品</option>
					<option value="6" <c:if test="${catid == 6}">selected</c:if>>其他物品</option>
</select>

<select name="type" id="search-type">
					<option value="" selected="selected">事件类型</option>
					<option value="lost" <c:if test="${type == 'lost'}">selected</c:if>>寻物信息</option>
					<option value="find" <c:if test="${type == 'find'}">selected</c:if>>招领信息</option>
				</select>
<input type="submit" value="查询"  class="button" /></form></td></tr></table>

<div class="table-list"><table width="100%" cellspacing="0">
<thead><tr><th width="40">ID</th><th width="100">结果</th><th width="110">物品名称</th><th width="120">丢失地点</th><th width="150">丢失时间</th><th width="150">标题</th> <th  width="120">操作</th></tr></thead>
<tbody>

<c:forEach items="${list}" var="bean">
<tr><td align="center">${bean.id}</td>
<td align="center"><c:if test="${bean.state == 0}">寻找中</c:if><c:if test="${bean.state == 1}">已找到</c:if></td>
<td align="center">${bean.name}</td>
<td align="center">${bean.address}</td>
<td align="center"><fmt:formatDate  value="${bean.happentime}" pattern="yyyy-MM-dd" /></td>
<td align="center"><a href="../goods!view?id=${bean.id}" target="_blank">${bean.title}</a></td>
<td align="center"><a href="method!goodsedit?id=${bean.id}">修改</a> | <a href="method!goodsdelete?id=${bean.id}" onclick="return confirm('确定删除')">删除</a></td></tr>
</c:forEach>

</tbody></table>

</div></div>

<div style="text-align:center"">${pagerinfo }</div></body></html>
