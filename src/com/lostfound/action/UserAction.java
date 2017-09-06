package com.lostfound.action;



import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.hibernate.FlushMode;

import com.lostfound.dao.ClaimUserDao;
import com.lostfound.dao.GoodsDao;
import com.lostfound.dao.ThanksLetterDao;
import com.lostfound.dao.UserDao;
import com.lostfound.model.Category;
import com.lostfound.model.ClaimUser;
import com.lostfound.model.Goods;
import com.lostfound.model.ThanksLetter;
import com.lostfound.model.User;
import com.lostfound.util.Pager;
import com.opensymphony.xwork2.ActionSupport;


public class UserAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	
	
	private String url="./";
	
	
	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}
	
	private UserDao userDao;

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	//用户登陆操作
	public void login() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User user = userDao.selectBean(" where email='"+email+"' and password='"+password+"' and  userlock=0");
		if(user!=null){
			HttpSession session = request.getSession();
			session.setAttribute("user", user);			
			writer.print("<script  language='javascript'>alert('登陆成功');window.location.href='index.jsp'; </script>");
		}else{
			
			writer.print("<script  language='javascript'>alert('用户名或者密码错误');window.location.href='login.jsp'; </script>");
		}
	}
	
	//用户退出操作
	public void logout() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		session.removeAttribute("user");		
		writer.print("<script  language='javascript'>alert('退出成功');window.location.href='login.jsp'; </script>");
	}
	
	//用户注册
	public void useradd() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setRole(0);
		user.setUserlock(0);
		
		
		//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		user.setCreatetime(new Date(System.currentTimeMillis()));
		User olduser = userDao.selectBean(" where email='" + email + "'");
		if(olduser != null){			
			writer.print("<script  language='javascript'>alert('邮箱已经存在!!');window.history.go(-1);</script>");	
			return;
		}
		userDao.insertBean(user);		
		writer.print("<script  language='javascript'>alert('注册成功');window.location.href='login.jsp'; </script>");
	}	
	
	//修改密码操作
	public void updatepsw() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		String oldpassword = request.getParameter("oldpassword");
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");
		if(!password.equals(repassword)){
			writer.print("<script  language='javascript'>alert('两次密码不一致!!');window.history.go(-1); </script>");
			return;
		}
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(session.getAttribute("user") == null){			
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		
		User bean = userDao.selectBean(" where username='"+user.getUsername()+"' and password='"+oldpassword+"' ");
		if(bean!=null){
			bean.setPassword(password);
			userDao.updateBean(bean);			
			writer.print("<script  language='javascript'>alert('success!');window.location.href='goods!index'; </script>");
		}else{			
			writer.print("<script  language='javascript'>alert('原密码错误,修改失败!!');window.history.go(-1);</script>");
		}	
	}
	
	private GoodsDao goodsDao;
	
	public GoodsDao getGoodsDao() {
		return goodsDao;
	}


	public void setGoodsDao(GoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}

	private ClaimUserDao claimuserDao;
	
	public ClaimUserDao getClaimuserDao() {
		return claimuserDao;
	}


	public void setClaimuserDao(ClaimUserDao claimuserDao) {
		this.claimuserDao = claimuserDao;
	}
	
	public String mygoods() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			this.setUrl("login.jsp");
			return SUCCESS;
		}
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		int uid = ((User)request.getSession().getAttribute("user")).getId();
		String where =" where uid="+uid+" order by id desc ";
		long total = goodsDao.selectBeanCount(where);
		List<Goods> list = goodsDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "user!mygoods", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		
		this.setUrl("mygoods.jsp");
		return SUCCESS;
	}
	
	public String goodsedit() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		int id =Integer.parseInt(request.getParameter("id"));
		Goods goods = goodsDao.selectBean(" where id=" + id);
		request.setAttribute("goods", goods);
		this.setUrl("goodsedit.jsp");
		
		return SUCCESS;
		
	}
	//提交
	public void goodseditsave() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		int id =Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String title = request.getParameter("title");
		String info = request.getParameter("info");
		String remark = request.getParameter("remark");
		String mobile = request.getParameter("mobile");
		String qq = request.getParameter("qq");
		String result = request.getParameter("result");
		int state =Integer.parseInt(request.getParameter("state"));
		
		int cid =Integer.parseInt(request.getParameter("cid"));
		Goods goods = goodsDao.selectBean(" where id=" + id);
		
		Category category = new Category();
		category.setId(cid);
		
		Date happentime = java.sql.Date.valueOf(request.getParameter("happentime").toString());
		String address = request.getParameter("address");
		Date createtime = new Date(System.currentTimeMillis());
//		User createuser = goodsold.getCreateuser();
		
		goods.setAddress(address);
		goods.setCategory(category);
		goods.setCrearetime(createtime);
		goods.setHappentime(happentime);
		goods.setInfo(info);
		goods.setMobile(mobile);
		goods.setName(name);
		goods.setQq(qq);
		goods.setRemark(remark);
		goods.setState(state);
		goods.setTitle(title);
//		goods.setCreateuser(createuser);
//		goods.setTypename(goodsold.getTypename());
		goods.setResult(result);
//		goods.setId(id);
		
		if(state == 1){
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String tel = request.getParameter("tel");
			
			ClaimUser claimUser = new ClaimUser();
			claimUser.setEmail(email);
			claimUser.setTel(tel);
			claimUser.setUsername(username);
			claimuserDao.insertBean(claimUser);
			goods.setClaimuser(claimUser);
		}
		
		goodsDao.updateBean(goods);
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('success!');window.location.href='user!mygoods'; </script>");
		
	}
	
	public void goodsdelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		Goods bean = new Goods();		
		bean.setId(id);
		goodsDao.deleteBean(bean);
		PrintWriter writer = response.getWriter();
		
		writer.print("<script  language='javascript'>alert('success!');window.location.href='user!mygoods'; </script>");
	}
	
	private ThanksLetterDao thanksDao;
	
	public ThanksLetterDao getThanksDao() {
		return thanksDao;
	}


	public void setThanksDao(ThanksLetterDao thanksDao) {
		this.thanksDao = thanksDao;
	}


	public String mythanks() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		int uid = ((User)request.getSession().getAttribute("user")).getId();
		
		String where =" where uid=" + uid;
		long total = thanksDao.selectBeanCount(where);
		List<ThanksLetter> list = thanksDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "user!mythanks", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		
		this.setUrl("mythanks.jsp");
		return SUCCESS;
	}
	
	public String thanksedit() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		int id =Integer.parseInt(request.getParameter("id"));
		
		ThanksLetter thanks = thanksDao.selectBean(" where id=" + id);
		request.setAttribute("thanks", thanks);
		this.setUrl("thanksedit.jsp");
		
		return SUCCESS;
		
	}
	
	public void thankseditsave() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		String info = request.getParameter("info");
		String title = request.getParameter("title");
		
//		User user = new User();
//		user = (User)request.getSession().getAttribute("user");
		Date createtime = new Date(System.currentTimeMillis());
		
		ThanksLetter thanks = thanksDao.selectBean(" where id=" + id);
		thanks.setTitle(title);
		thanks.setInfo(info);
//		thanks.setCreateuser(user);
		thanks.setCrearetime(createtime);
		thanksDao.insertBean(thanks);
		writer.print("<script  language='javascript'>alert('success!');window.location.href='user!mythanks'; </script>");		
		
	}
	
	public void thanksdelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		ThanksLetter bean = new ThanksLetter();		
		bean.setId(id);
		thanksDao.deleteBean(bean);
		PrintWriter writer = response.getWriter();
		
		writer.print("<script  language='javascript'>alert('success!');window.location.href='user!mythanks'; </script>");
	}
}
