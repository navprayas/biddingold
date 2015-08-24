package com.navprayas.bidding.admin.dao;

import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.admin.form.ManageUser;

@Repository
public class ManageUserDAOImpl implements ManageUserDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	public List<ManageUser> listManageUser() {
		// TODO Auto-generated method stub
		return  sessionFactory.getCurrentSession().createQuery("from ManageUser")
		.list();
	}
	
}
