package com.lostfound.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.lostfound.dao.UserDao;
import com.lostfound.model.User;

public class Util {

	//初始化系统
	public static void init(HttpServletRequest request){
		  WebApplicationContext app = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
          UserDao userDao = (UserDao)app.getBean("userDao");
          User user = userDao.selectBean(" where username='admin' and userlock=0  ");
  		if(user==null){
  			user = new User();
  			user.setPassword("111111");
  			user.setRole(1);
  			user.setEmail("admin");
  			user.setUsername("admin");
  			userDao.insertBean(user);
  		}
	}
	
}
