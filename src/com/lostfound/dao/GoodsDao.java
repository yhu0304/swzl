package com.lostfound.dao;
import java.util.List;

import com.lostfound.model.Goods;

public interface GoodsDao {

	
	//插入新纪录
	public void insertBean(Goods bean);
	
	//根据id删除纪录
	public void deleteBean(Goods bean);
	
	//根据id更新纪录
	public void updateBean(Goods bean);

	//获取信息列表,带查询功能，start 表示当前页，limit表示每页显示的条数 start=1,lmit=10
	public List<Goods> selectBeanList(final int start,final int limit,final String where);
	
	
	//查询记录的总的条数
	public long selectBeanCount(final String where);
	
	//查询用户信息
	public Goods selectBean(String where);
	

}
