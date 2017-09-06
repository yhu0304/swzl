package com.lostfound.action;



import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import com.lostfound.dao.GoodsDao;
import com.lostfound.dao.ReplyDao;
import com.lostfound.model.Category;
import com.lostfound.model.Goods;
import com.lostfound.model.Reply;
import com.lostfound.model.User;
import com.lostfound.util.Pager;
import com.opensymphony.xwork2.ActionSupport;


public class GoodsAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	
	
	private String url="./";
	
	
	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}
	
	private GoodsDao goodsDao;

	private ReplyDao replyDao;
	
	public GoodsDao getGoodsDao() {
		return goodsDao;
	}

	//注入对象goodsDao
	public void setGoodsDao(GoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}


	public ReplyDao getReplyDao() {
		return replyDao;
	}

	public void setReplyDao(ReplyDao replyDao) {
		this.replyDao = replyDao;
	}
	
	public String index() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("content-type","text/html;charset=UTF-8");
		List<Goods> lostlist = goodsDao.selectBeanList(0, 10, " where typename='lost' and state=0 order by id desc ");
		request.setAttribute("lostlist", lostlist);
		
		List<Goods> findlist = goodsDao.selectBeanList(0, 10, " where typename='find' and state=0 order by id desc ");
		request.setAttribute("findlist", findlist);
//		response.sendRedirect("index.jsp");
		this.setUrl("main.jsp");
		return SUCCESS;
	}
	
	//发布
	public void publish() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		String type = request.getParameter("type");
		if("find".equals(type)){
			response.sendRedirect("publishfind.jsp");
		}else{
			response.sendRedirect("publishlost.jsp");
		}
	}
	
	//提交
	public void publishsave() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		String name = request.getParameter("name");
		String title = request.getParameter("title");
		String info = request.getParameter("info");
		String remark = request.getParameter("remark");
		String mobile = request.getParameter("mobile");
		String qq = request.getParameter("qq");
		String typename = request.getParameter("type");
		
		int cid =Integer.parseInt(request.getParameter("cid"));
		Category category = new Category();
		category.setId(cid);
		
		Date happentime = request.getParameter("happentime") != null&request.getParameter("happentime") != ""?java.sql.Date.valueOf(request.getParameter("happentime").toString()):new Date(System.currentTimeMillis());
		String address = request.getParameter("address");
		Date createtime = new Date(System.currentTimeMillis());
		User createuser = new User();
		
		createuser =(User)session.getAttribute("user");
		
		Goods goods = new Goods();
		goods.setAddress(address);
		goods.setCategory(category);
		goods.setCrearetime(createtime);
		goods.setHappentime(happentime);
		goods.setInfo(info);
		goods.setMobile(mobile);
		goods.setName(name);
		goods.setQq(qq);
		goods.setRemark(remark);
		goods.setState(0);
		goods.setTitle(title);
		goods.setTypename(typename);
		goods.setCreateuser(createuser);
		
		goodsDao.insertBean(goods);
		PrintWriter writer = response.getWriter();
		
		writer.print("<script  language='javascript'>alert('提交成功!');window.location.href='index.jsp'; </script>");
	}
	
	//寻物
	public String lost() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();  //获取request对象
		HttpServletResponse response = ServletActionContext.getResponse();   //获取response对象
		response.setContentType("text/html;charset=UTF-8");
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String where =" where typename='lost' and state=0  order by id desc ";
		long total = goodsDao.selectBeanCount(where);
		List<Goods> list = goodsDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "goods!lost", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("lost.jsp");
		return SUCCESS;
	}
	
	//招领
	public String find() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String where =" where typename='find' and state=0 order by id desc ";
		long total = goodsDao.selectBeanCount(where);
		List<Goods> list = goodsDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "goods!find", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("find.jsp");
		return SUCCESS;
	}
	
	
	public String success() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String where =" where state='1' order by id desc ";
		long total = goodsDao.selectBeanCount(where);
		List<Goods> list = goodsDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "goods!success", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("success.jsp");
		return SUCCESS;
	}
	
	//搜索
	public String search() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
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
		String address = request.getParameter("address")==null?"":new String(request.getParameter("address").getBytes("ISO-8859-1"),"UTF-8");
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
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "goods!search", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		request.setAttribute("type", typename);
		request.setAttribute("address", address);
		request.setAttribute("starttime", starttime);
		request.setAttribute("endtime", endtime);
		request.setAttribute("key", key);
		request.setAttribute("catid", catid);
		request.setAttribute("size", list.size());
		this.setUrl("search.jsp");
		return SUCCESS;
	}
	
	//查看寻物、招领信息
	public String view() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		Goods goods = goodsDao.selectBean(" where id=" + id);
		request.setAttribute("goods", goods);
		
		List<Reply> replylist = replyDao.selectBeanList(0, 100, " where gid="+ id + " order by id desc");
		request.setAttribute("replylist", replylist);	
		
		
		int islogin = IsLogin();
		request.setAttribute("islogin", islogin);	
		this.setUrl("view.jsp");
		return SUCCESS;
	}
	
	public int IsLogin(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User user = ((User) request.getSession().getAttribute("user")); 
		if(user == null){return 0;}
		return 1;
	}
	
	public void checkLogin() throws IOException
	{
		if(IsLogin() == 0){
			
			
				HttpServletResponse response = ServletActionContext.getResponse();
				PrintWriter writer = response.getWriter();
				writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
				return;
			
		}
	}
	
	//回复
	public void replysave() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
		if(session.getAttribute("user") == null){
			
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		int gid = Integer.parseInt(request.getParameter("gid"));
		String content = request.getParameter("content");
		User user = new User();
		user = (User)request.getSession().getAttribute("user");
		Date createtime = new Date(System.currentTimeMillis());
		
		Reply reply = new Reply();
		reply.setContent(content);
		reply.setCreatetime(createtime);
		reply.setGid(gid);
		reply.setUser(user);
		
		replyDao.insertBean(reply);
		
		writer.print("<script  language='javascript'>alert('回复成功!');window.location.href='goods!view?id="+gid+"'; </script>");
		
	}
	
	//回复列表
	public String replylist() throws IOException{
		return SUCCESS;
	}
}
