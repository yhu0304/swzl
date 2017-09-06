<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>管理员登陆</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
<body  marginheight="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#666666" bgcolor="#fff">
  <table align="center">
    <tr>
      <td align="center" height="400" valign="middle">
      <form action="method!login" method="post" id="myform">
      <table background="admin/css/login.jpg" width="500" height="300" border="0" cellspacing="0" cellpadding="0" style="margin-top:90" align="center">
          <tr>
            <th height="130" colspan="2" class="" scope="col"></th>
		  </tr>
          <tr>
            <th width="45%" height="30" align="right" scope="row" class="">用户名:</th>
            <td width="55%" height="30" align="left">&nbsp;<input type="text" name="email" validate="required:true,email:true , minlength:1, maxlength:40"></td>
          </tr>
          <tr>
            <th width="40%" height="30" align="right" scope="row" class="">密&nbsp;&nbsp;码:</th>
            <td height="30" align="left">&nbsp;<input type="password" name="password"></td>
          </tr>
         
          <tr>
            <th height="35" colspan="2" scope="row" class="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="登陆">  &nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置"></th>
		</tr>
        </table>
      </form>
      </td>
    </tr>
  </table>
</body>
</html>
