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
 	<div class="fl"><img class="avatar" src="public/image/feng.jpg" alt="ey_flyp" title="ey_flyp" width="50px" height="50px" /></div>
	<div id="note-detail">
		<div class='note-detail-title-wrap clearfix'>
			<h2 class="note-detail-title fl">
	<span id='note-detail-title-pre'>[<c:if test="${goods.typename == 'lost'}">寻物</c:if><c:if test="${goods.typename == 'find'}">招领</c:if>信息]</span>${goods.title}</h2>
				<span class="fr note-detail-author">
				${goods.createuser.username} 发表于 <fmt:formatDate  value="${goods.crearetime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
		</div>
		<div class="note-detial-goods">
		<table class="goods-detail">
			<tbody>
				<tr>
					<td width="80px">捡到物品</td><td width="450px"> ${goods.name}</td>
				</tr>
					
								<tr><td>物品备注</td><td>${goods.remark}</td></tr>
												<tr><td>捡到时间</td><td><fmt:formatDate  value="${goods.happentime}" pattern="yyyy-MM-dd" /></td></tr>
												<tr><td>信息详情</td><td id="Js_share_content">${goods.info}</td></tr>
												<tr><td>结果</td><td id="Js_share_content"><c:if test="${goods.state==0}">寻找中</c:if>
												<c:if test="${goods.state==1}"><c:if test="${goods.typename == 'lost'}">已找到</c:if><c:if test="${goods.typename == 'find'}">已招领</c:if>${goods.result}</c:if></td></tr>
				<tr><td>联系方式</td><td><a id="contact-lz-btn" href="javascript:;">点此</a>获取楼主联系方式。</td></tr>
			</tbody>
		</table>
		
		</div>

		<div id="contact-lz" class="none pr">
			
		<p id="contact-lz-close" class="pa">收起>></p>
						<table>
			<tbody>
				<tr>
					<td>楼主昵称： </td><td>${goods.createuser.username}</td>
				</tr>
								<tr><td>楼主手机： </td><td>${goods.mobile}</td></tr>
												
			</tbody>
		</table>	
		</div><!--contact-lz-->
		
		
	</div>

	
</div>
 
<!--用户没有登录时，显示以下登录信息--> 



<!--评论部分开始-->
<div id="comment-box">
<!--如果用户没有登录，提供以下登录选项-->
<div class="J_comment_box">
<div class="fl">
	
</div>
<script>
function check(islogin){
	if(islogin == 0){alert("请先登录");return false;}
	return true;
	
}
</script>

<form action="goods!replysave" method="POST" onsubmit="return check(${islogin}%>);">
<ul class="comment" class="clearfix">
		<li class="comment-box">
		<textarea name="content" class="comment-textarea J_cmt-content" placeholder="请输入评论内容"></textarea>
		
	</li>
	<input type="hidden" name="gid" value="${goods.id}" />
	<li class="comment-tool">
	<c:if test="${islogin} ==0">你还未登录，请先登录</c:if><input type="submit" value="发表评论" class="btn cmt-btn" />
	</li>
</ul>
</form>
</div>
</div>
<!--评论框结束-->
<!--评论列表开始-->
<!--取出改文章 所有评论-->
<ul class="commnetList">
	
	<c:forEach items="${replylist}" var="bean">
	<li class="commentList-item" id="cid_1">
	<div class="clearfix">
		<div class="fl">
			<img src="public/image/feng.jpg" class="avatar" width="50px" height="50px" alt="freewind" title='freewind' />
		</div>
		<div class="commentList-wrap">
			<p class="commentList-title">
				<span class='commentList-title-author'>${bean.user.username}</span>
				<span class='commentList-title-time'>发表于 <fmt:formatDate  value="${bean.createtime}" pattern="yyyy-MM-dd HH:mm:ss" /></span><span class='commentList-title-num'></span>					
					</p>
			<p class="commentList-content">${bean.content}</p>
		</div>
	</div>
	</li>
	</c:forEach>	
		
</ul>


</div>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>

