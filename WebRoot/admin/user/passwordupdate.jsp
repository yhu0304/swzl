<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>员工信息管理系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript">

function checkpassword(){

var password2 = document.getElementById("password2id").value;	
var password3 = document.getElementById("password3id").value;
if(password2!=password3){

	alert("新密码和确认新密码不一致，提交失败！！");
	return false;
}
return true;

}

</script>

  </head>
  
  <body>
  <center>
  <h1>修改密码</h1>
  
  
  <div>
  <form action="method!passwordupdate2" method="post" onsubmit="return checkpassword()">
  <table>
  
  <tr>
  <td>
  原密码：
  </td>
  <td>
  <input type="password" name="password1">
  </td>
  </tr>
  
  
  <tr>
  <td>
  新密码：
  </td>
  <td>
  <input type="password" name="password2" id="password2id">
  </td>
  </tr>
  
  
  <tr>
  <td>
  确认新密码：
  </td>
  <td>
  <input type="password" name="password3" id="password3id">
  </td>
  </tr>
  
  
  <tr>
  <td>
  操作：
  </td>
  <td>
  <input type="submit" value="提交">
   <input type="reset" value="重置">
  </td>
  </tr>
  
  </table>
  
  </form>
  
  </div>
  
  
  </center>
  
  
  
  </body>
</html>
