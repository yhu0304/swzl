package com.lostfound.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import javax.persistence.Table;

//物品
@Entity
@Table(name="t_Goods")
public class Goods implements Serializable{
	private static final long serialVersionUID = -117947798302585032L;
	
	private int id;//主键
	
	private String name; //物品名称
	
	private String title; //标题
	
	private String info; //详情描述
	
	private String remark; //备注
	
	private String result; //结果 比如谁领走了
	
	private String mobile; 
	
	private String qq; 
	
	private String typename; //失物  / 招领
	
	private Category category; //物品类别
	
	private Date happentime;//丢失时间 / 捡到时间
	
	private String address; //丢失地点 / 捡到地点
	
	private Date crearetime;//添加时间
	
	private User createuser;
	
	private ClaimUser claimuser;
	
	private int state = 0; //0-提交，1-找到/认领

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	@ManyToOne
	@JoinColumn(name="cid")
	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Date getHappentime() {
		return happentime;
	}

	public void setHappentime(Date happentime) {
		this.happentime = happentime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getCrearetime() {
		return crearetime;
	}

	public void setCrearetime(Date crearetime) {
		this.crearetime = crearetime;
	}
	
	@ManyToOne
	@JoinColumn(name="uid")
	public User getCreateuser() {
		return createuser;
	}

	public void setCreateuser(User createuser) {
		this.createuser = createuser;
	}

	@ManyToOne
	@JoinColumn(name="claimuid")
	public ClaimUser getClaimuser() {
		return claimuser;
	}

	public void setClaimuser(ClaimUser claimuser) {
		this.claimuser = claimuser;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
}
