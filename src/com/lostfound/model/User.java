package com.lostfound.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

//用户
@Entity
@Table(name="t_User")
public class User implements Serializable{
	
	private static final long serialVersionUID = -117947798302585032L;

	private int id;//主键
	
	private String username;//用户名
	
	private String password;//密码
	
	private String email;//密码
	
//	private String truename;//真实姓名
	
	private Date createtime;//添加时间
	
	private int role;//表示用户的权限，1表示管理员用户，0表示用户
	
	private int userlock;//表示涂改记录是否删除的字段，0表示未删除，1表示删除


	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

//	public String getTruename() {
//		return truename;
//	}
//
//	public void setTruename(String truename) {
//		this.truename = truename;
//	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public int getUserlock() {
		return userlock;
	}

	public void setUserlock(int userlock) {
		this.userlock = userlock;
	}
	
}
