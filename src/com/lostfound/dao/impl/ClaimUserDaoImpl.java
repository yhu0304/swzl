package com.lostfound.dao.impl;
import java.sql.SQLException;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lostfound.dao.ClaimUserDao;
import com.lostfound.model.ClaimUser;


public class ClaimUserDaoImpl extends HibernateDaoSupport implements ClaimUserDao {

	

	public void deleteBean(ClaimUser bean) {
		this.getHibernateTemplate().delete(bean);
		this.getSession().beginTransaction().commit();
		
	}

	public void insertBean(ClaimUser bean) {
		this.getHibernateTemplate().save(bean);
		this.getSession().beginTransaction().commit();
		
	}

	@SuppressWarnings("unchecked")
	public ClaimUser selectBean(String where) {
		List<ClaimUser> list = this.getHibernateTemplate().find("from ClaimUser "+where);
		if(list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public long selectBeanCount(final String where) {
		long count = (Long)this.getHibernateTemplate().find(" select count(*) from ClaimUser  "+where).get(0);
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<ClaimUser> selectBeanList(final int start,final int limit,final String where) {
		return (List<ClaimUser>)this.getHibernateTemplate().executeFind(new HibernateCallback(){

			public Object doInHibernate(final Session session) throws HibernateException, SQLException {
				List<ClaimUser> list = session.createQuery(" from ClaimUser"+where).setFirstResult(start).setMaxResults(limit).list();
				return list;
			}
		});
		
	}

	public void updateBean(ClaimUser bean) {
		this.getHibernateTemplate().update(bean);
		this.getSession().beginTransaction().commit();
		
	}
	
}
