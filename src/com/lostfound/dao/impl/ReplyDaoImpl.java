package com.lostfound.dao.impl;
import java.sql.SQLException;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lostfound.dao.ReplyDao;
import com.lostfound.model.Reply;


public class ReplyDaoImpl extends HibernateDaoSupport implements ReplyDao {

	

	public void deleteBean(Reply bean) {
		this.getHibernateTemplate().delete(bean);
		this.getSession().beginTransaction().commit();
	}

	public void insertBean(Reply bean) {
		this.getHibernateTemplate().save(bean);
		this.getSession().beginTransaction().commit();
	}

	@SuppressWarnings("unchecked")
	public Reply selectBean(String where) {
		List<Reply> list = this.getHibernateTemplate().find("from Reply "+where);
		if(list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public long selectBeanCount(final String where) {
		long count = (Long)this.getHibernateTemplate().find(" select count(*) from Reply  "+where).get(0);
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<Reply> selectBeanList(final int start,final int limit,final String where) {
		return (List<Reply>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<Reply> list = session.createQuery(" from Reply"+where).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});
		
	}

	public void updateBean(Reply bean) {
		this.getHibernateTemplate().update(bean);
		this.getSession().beginTransaction().commit();
	}
	
	
	
	
	
	
	
}
