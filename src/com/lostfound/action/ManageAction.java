package com.lostfound.action;



import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.hibernate.FlushMode;

import com.lostfound.dao.ClaimUserDao;
import com.lostfound.dao.GoodsDao;
import com.lostfound.dao.ReplyDao;
import com.lostfound.dao.ThanksLetterDao;
import com.lostfound.dao.UserDao;
import com.lostfound.model.Category;
import com.lostfound.model.ClaimUser;
import com.lostfound.model.Goods;
import com.lostfound.model.Reply;
import com.lostfound.model.ThanksLetter;
import com.lostfound.model.User;
import com.lostfound.util.Pager;
import com.opensymphony.xwork2.ActionSupport;


public class ManageAction extends ActionSupport{

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
	
	//后台登陆操作
	public void login() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User user = userDao.selectBean(" where email='"+email+"' and password='"+password+"' and  userlock=0 and role=1 ");
		if(user!=null){
			HttpSession session = request.getSession();
			session.setAttribute("admin", user);
			
			writer.print("<script  language='javascript'>alert('登录成功!');window.location.href='admin/index.jsp'; </script>");
		}else{
			
			writer.print("<script  language='javascript'>alert('用户名或者密码错误,或你不是管理员');window.location.href='admin/login.jsp'; </script>");
		}
	}
	
	//后台退出操作
	public void loginout() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("admin");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('退出成功');window.location.href='login.jsp'; </script>");
	}
	
	public String updatepwd() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		this.setUrl("user/updatepwd.jsp");
		return SUCCESS;
	}
	
	//修改密码操作
		public void updatepwdsave() throws IOException{
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setHeader("content-type","text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			
			HttpSession session = request.getSession();
			if(session.getAttribute("admin") == null){
				writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
				return ;
			}
			
			String oldpassword = request.getParameter("oldpassword");
			String password = request.getParameter("password");
			String repassword = request.getParameter("repassword");
			if(!password.equals(repassword)){
				writer.print("<script  language='javascript'>alert('两次密码不一致!!');window.history.go(-1); </script>");
				return;
			}
			
			User user = (User)session.getAttribute("admin");
			User bean = userDao.selectBean(" where email='"+user.getEmail()+"' and password='"+oldpassword+"' ");
			if(bean!=null){
				bean.setPassword(password);
				userDao.updateBean(bean);			
				writer.print("<script  language='javascript'>alert('success!');window.location.href='goods!index'; </script>");
			}else{			
				writer.print("<script  language='javascript'>alert('原密码错误,修改失败!!');window.history.go(-1);</script>");
			}	
		}
		
		public void logout() throws IOException{
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setHeader("content-type","text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			
			HttpSession session = request.getSession();
			session.removeAttribute("admin");		
			writer.print("<script  language='javascript'>alert('退出成功');window.location.href='login.jsp'; </script>");
		}
	
	//用户信息列表
	public String userlist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		
		int currentpage = 1;
		int pagesize = 10;
		String email = request.getParameter("email")==null?"":new String(request.getParameter("email").getBytes("ISO-8859-1"),"UTF-8");
		int role = request.getParameter("role")!=null?Integer.parseInt(request.getParameter("role")):-1;
		//int role = Integer.parseInt(request.getParameter("role"));
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		
		String where =" where 1=1";
		if(!"".equals(email)){where +=" and email='"+email+"'";}

		if(role != -1){where +=" and role="+role;}
		where +=" order by id desc ";
		long total = userDao.selectBeanCount(where);
		List<User> list = userDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "method!yuangonglist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		request.setAttribute("email", email);
		request.setAttribute("role", role);
		this.setUrl("user/userlist.jsp");
		return SUCCESS;
	}
	
	//跳转到添加用户页面
	public String useradd() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		this.setUrl("user/useradd.jsp");
		return SUCCESS;
	}
	
	//跳转到编辑用户页面
	public String useredit() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();	
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		
		int id =Integer.parseInt(request.getParameter("id"));
		User user = userDao.selectBean(" where id=" + id);
		request.setAttribute("user", user);
		this.setUrl("user/userview.jsp");
		return SUCCESS;
	}
	
	//添加编辑用户操作
	public void usersave() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		int role = Integer.parseInt(request.getParameter("role"));
		int id = request.getParameter("id")==null || request.getParameter("id")=="" ?0:Integer.parseInt(request.getParameter("id"));
		
		User bean = userDao.selectBean(" where email='" + email + "' or username ='"+username+"'");
		if(id == 0 && bean != null){			
			writer.print("<script  language='javascript'>alert('邮箱已经存在或者用户名已经存在!!');window.history.go(-1);</script>");	
			return;
		}
		
		bean = new User();
		
		bean.setUsername(username);
		bean.setEmail(email);
		bean.setRole(role);
		bean.setCreatetime(new Date(System.currentTimeMillis()));
		bean.setPassword(password);	

		if(id==0){userDao.insertBean(bean);}
		else{
			bean.setId(id);
			
			userDao.updateBean(bean);
			}
				
		response.setCharacterEncoding("utf-8");

		writer.print("<script  language='javascript'>alert('添加成功!');window.location.href='method!userlist'; </script>");		
	}
	
	public void userdelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		String where = " where uid=" + id;
		int total = (int)goodsDao.selectBeanCount(where);
		List<Goods> goodslist = goodsDao.selectBeanList(0, total, where);		
		for(int i =0; i < goodslist.size(); i++){			
			goodsDao.deleteBean(goodslist.get(i));
		}
		
		total = (int)replyDao.selectBeanCount(where);
		List<Reply> replylist = replyDao.selectBeanList(0, total, where);
		
		for(int i =0; i < replylist.size(); i++){			
			replyDao.deleteBean(replylist.get(i));
		}
		
		total = (int)thanksDao.selectBeanCount(where);
		List<ThanksLetter> thankslist = thanksDao.selectBeanList(0, total, where);
		
		for(int i =0; i < thankslist.size(); i++){			
			thanksDao.deleteBean(thankslist.get(i));
		}
	
		writer.print("<script  language='javascript'>window.location.href='method!userdelete2?id=" +id +"'; </script>");			
	}
	
	public void userdelete2() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		User bean = new User();		
		bean.setId(id);
		userDao.deleteBean(bean);
		
		writer.print("<script  language='javascript'>alert('success!');window.location.href='method!userlist'; </script>");
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

/**
 * 物品管理列表
 * @return
 * @throws IOException
 */
	public String goodslist() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String key = request.getParameter("key")==null?"":new String(request.getParameter("key").getBytes("ISO-8859-1"),"UTF-8");
		
		int catid = 0;
		if(request.getParameter("catid") != null){
			catid = Integer.parseInt(request.getParameter("catid"));
		}
		String typename = request.getParameter("type") == null?"":request.getParameter("type");
		String address = request.getParameter("address")==null?"":request.getParameter("address");
		String starttime = request.getParameter("starttime")==null?"":request.getParameter("starttime");
		String endtime = request.getParameter("endtime")==null?"":request.getParameter("endtime");
		
		String where =" where 1=1";
		if(!"".equals(typename)){where +=" and typename='" + typename + "'";}
		if(!"".equals(key)){where += " and title like '%"+key+"%'";}
		if(catid !=0){where += " and category.id ="+catid;}
		if(!"".equals(address)){where += " and address like '%"+address+"%'";}
		if(!"".equals(starttime)){where += " and happentime >='"+starttime +"'";}
		if(!"".equals(endtime)){where += " and happentime <='"+endtime +"'";}
		where += " order by id desc ";
		request.setAttribute("key", key);
		long total = goodsDao.selectBeanCount(where);
		List<Goods> list = goodsDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "method!goodslist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		request.setAttribute("type", typename);
		request.setAttribute("address", address);
		request.setAttribute("starttime", starttime);
		request.setAttribute("endtime", endtime);
		request.setAttribute("key", key);
		request.setAttribute("catid", catid);
		
		this.setUrl("goods/goodslist.jsp");
		return SUCCESS;
	}
	
	public String goodsedit() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='admin/login.jsp'; </script>");
			return SUCCESS;
		}
		int id =Integer.parseInt(request.getParameter("id"));
		Goods goods = goodsDao.selectBean(" where id=" + id);
		request.setAttribute("goods", goods);
		this.setUrl("goods/goodsedit.jsp");
		
		return SUCCESS;
		
	}
	//提交
	public void goodseditsave() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
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

		goods.setResult(result);
		
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
		writer.print("<script  language='javascript'>alert('提交成功!');window.location.href='method!goodslist'; </script>");
		
	}
	
	public void goodsdelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		Goods bean = new Goods();		
		bean.setId(id);
		goodsDao.deleteBean(bean);
				
		writer.print("<script  language='javascript'>alert('删除成功!');window.location.href='method!goodslist'; </script>");
	}
	
	private ThanksLetterDao thanksDao;
	
	
	public ThanksLetterDao getThanksDao() {
		return thanksDao;
	}


	public void setThanksDao(ThanksLetterDao thanksDao) {
		this.thanksDao = thanksDao;
	}


	public String thankslist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String where ="";
		long total = thanksDao.selectBeanCount(where);
		List<ThanksLetter> list = thanksDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "method!thankslist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("thanks/thankslist.jsp");
		return SUCCESS;
	}
	
	public void thanksdelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		ThanksLetter bean = new ThanksLetter();		
		bean.setId(id);
		thanksDao.deleteBean(bean);
		
		writer.print("<script  language='javascript'>alert('删除成功!');window.location.href='method!thankslist'; </script>");
	}
	
	private ReplyDao replyDao;
	
	public ReplyDao getReplyDao() {
		return replyDao;
	}


	public void setReplyDao(ReplyDao replyDao) {
		this.replyDao = replyDao;
	}

/**
 * 评论列表
 * @return
 * @throws IOException
 */
	public String replylist() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return SUCCESS;
		}
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String where ="";
		long total = replyDao.selectBeanCount(where);
		
		List<Reply> replylist = replyDao.selectBeanList(currentpage-1, pagesize, "");
		request.setAttribute("list", replylist);	
		
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "method!replylist", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		
		this.setUrl("reply/replylist.jsp");
		return SUCCESS;
	}
	
	public void replydelete() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter writer = response.getWriter();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null){
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		Reply bean = new Reply();		
		bean.setId(id);
		replyDao.deleteBean(bean);
		
		writer.print("<script  language='javascript'>alert('success!');window.location.href='method!replylist'; </script>");
	}
}
