package com.lostfound.dao.impl;
import java.sql.SQLException;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lostfound.dao.ThanksLetterDao;
import com.lostfound.model.ThanksLetter;

public class ThanksLetterDaoImpl extends HibernateDaoSupport implements ThanksLetterDao {

	

	public void deleteBean(ThanksLetter bean) {
		this.getHibernateTemplate().delete(bean);
		this.getSession().beginTransaction().commit();
	}

	public void insertBean(ThanksLetter bean) {
		this.getHibernateTemplate().save(bean);
		this.getSession().beginTransaction().commit();
	}

	@SuppressWarnings("unchecked")
	public ThanksLetter selectBean(String where) {
		List<ThanksLetter> list = this.getHibernateTemplate().find(" from ThanksLetter "+where);
		if(list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public long selectBeanCount(final String where) {
		long count = (Long)this.getHibernateTemplate().find(" select count(*) from ThanksLetter  "+where).get(0);
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<ThanksLetter> selectBeanList(final int start,final int limit,final String where) {
		return (List<ThanksLetter>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<ThanksLetter> list = session.createQuery(" from ThanksLetter "+where).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});
		
	}

	public void updateBean(ThanksLetter bean) {
		this.getHibernateTemplate().update(bean);
		this.getSession().beginTransaction().commit();
	}	
}
