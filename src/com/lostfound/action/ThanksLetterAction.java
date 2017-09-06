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

import com.lostfound.dao.ThanksLetterDao;
import com.lostfound.dao.UserDao;
import com.lostfound.model.Goods;
import com.lostfound.model.Reply;
import com.lostfound.model.ThanksLetter;
import com.lostfound.model.User;
import com.lostfound.util.Pager;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 写感谢信
 * @author Administrator
 *
 */
public class ThanksLetterAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	
	
	private String url="./";
	
	
	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}
	
	private ThanksLetterDao thanksDao;

	public ThanksLetterDao getThanksDao() {
		return thanksDao;
	}

	public void setThanksDao(ThanksLetterDao thanksDao) {
		this.thanksDao = thanksDao;
	}
	
	/**
	 * 写感谢信
	 * @author Administrator
	 *
	 */
	public void write() throws IOException{		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		
		response.sendRedirect("write.jsp");
		
	}
	
	/**
	 * 保存
	 * @author Administrator
	 *
	 */
	public void writesave() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/html;charset=UTF-8"); 
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null){
			PrintWriter writer = response.getWriter();
			writer.print("<script  language='javascript'>alert('请先登录');window.location.href='login.jsp'; </script>");
			return;
		}
		String info = request.getParameter("info");
		String title = request.getParameter("title");
		
		User user = new User();
		user = (User)request.getSession().getAttribute("user");
		Date createtime = new Date(System.currentTimeMillis());
		
		ThanksLetter thanks = new ThanksLetter();
		thanks.setTitle(title);
		thanks.setInfo(info);
		thanks.setCreateuser(user);
		thanks.setCrearetime(createtime);
		thanksDao.insertBean(thanks);
		
		PrintWriter writer = response.getWriter();
		writer.print("<script  language='javascript'>alert('success!');window.location.href='thanks!list'; </script>");		
	}
	
	/**
	 * 全部感谢信
	 * @author Administrator
	 *
	 */
	public String list() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		int currentpage = 1;
		int pagesize = 10;
		if(request.getParameter("pagenum") != null){
			currentpage = Integer.parseInt(request.getParameter("pagenum"));
		}
		String where ="";
		long total = thanksDao.selectBeanCount(where);
		List<ThanksLetter> list = thanksDao.selectBeanList(currentpage-1, pagesize, where);
		request.setAttribute("list", list);
		String pagerinfo = Pager.getPagerNormal((int)total, pagesize, currentpage, "thanks!list", "共有"+total+"条记录");
		request.setAttribute("pagerinfo", pagerinfo);
		this.setUrl("thanks.jsp");
		return SUCCESS;
	}
	
	public String view() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		ThanksLetter thanks = thanksDao.selectBean(" where id=" + id);
		request.setAttribute("thanks", thanks);
	
		this.setUrl("thanksview.jsp");
		return SUCCESS;
	}
}
