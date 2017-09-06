package com.lostfound.dao.impl;
import java.sql.SQLException;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lostfound.dao.GoodsDao;
import com.lostfound.model.Goods;


public class GoodsDaoImpl extends HibernateDaoSupport implements GoodsDao {

	

	public void deleteBean(Goods bean) {
		this.getHibernateTemplate().delete(bean);
		this.getSession().beginTransaction().commit();
	}

	public void insertBean(Goods bean) {
		this.getHibernateTemplate().save(bean);
		this.getSession().beginTransaction().commit();
	}

	@SuppressWarnings("unchecked")
	public Goods selectBean(String where) {
		List<Goods> list = this.getHibernateTemplate().find("from Goods "+where);
		if(list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public long selectBeanCount(final String where) {
		long count = (Long)this.getHibernateTemplate().find(" select count(*) from Goods  "+where).get(0);
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<Goods> selectBeanList(final int start,final int limit,final String where) {
		return (List<Goods>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Goods> list = session.createQuery(" from Goods"+where).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});
		
	}

	public void updateBean(Goods bean) {
		this.getHibernateTemplate().update(bean);
		this.getSession().beginTransaction().commit();
	}
	
	
	
	
	
	
	
}
