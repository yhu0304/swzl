<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title
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
<!-- 
<table  class="search_table" width="100%">
<tr><td><form action="/yourphpdemo/index.php?g=Admin&m=User&a=index" method="get">
<input type="hidden" name="g" value="Admin" /><input type="hidden" name="m" value="User" />
<input type="hidden" name="a" value="index" />筛选: <input type="text" name="keyword"  class="input-text" value=""/>

<select name="groupid"><option value="0" >普通用户</option><option value="1" >管理员</option>
</select><input type="submit" value="查询"  class="button" /><input type="reset" value="重置" class="button"  /></form></td></tr></table>
 -->
<div class="table-list"><table width="100%" cellspacing="0">
<thead><tr><th width="40">ID</th><th width="100">用户</th><th width="110">评论内容</th><th  width="120">操作</th></tr></thead>
<tbody>

<c:forEach items="${list}" var="bean">
<tr><td align="center">${bean.id}</td>
<td align="center">${bean.user.username}</td>
<td align="center"><a href="../goods!view?id=${bean.gid}" target="_blank">${bean.content}</a></td>

<td align="center">
<!--<a href="method!goodsedit?id=${bean.id}">修改</a> | --><a href="method!replydelete?id=${bean.id}" onclick="return confirm('确定删除')">删除</a></td></tr>
</c:forEach>

</tbody></table>

</div></div>

<div style="text-align:center"">${pagerinfo }</div></body></html>
