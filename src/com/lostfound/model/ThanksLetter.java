package com.lostfound.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="t_ThanksLetter")
public class ThanksLetter implements Serializable{
	private static final long serialVersionUID = -117947798302585032L;
	
	private int id;//主键
	
	private String title; //标题
	
	private String info; //详情描述
	
	private User createuser;
	
	private Date crearetime;//添加时间
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	@ManyToOne
	@JoinColumn(name="uid")
	public User getCreateuser() {
		return createuser;
	}

	public void setCreateuser(User createuser) {
		this.createuser = createuser;
	}

	public Date getCrearetime() {
		return crearetime;
	}

	public void setCrearetime(Date crearetime) {
		this.crearetime = crearetime;
	}

}
