package com.navprayas.bidding.admin.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.admin.dao.ManageUserDAO;
import com.navprayas.bidding.admin.form.ManageUser;

@Service
public class ManageUserServiceImpl implements ManageUserService  {

	@Autowired
	private ManageUserDAO manageuserDAO;
	@Transactional
	public List<ManageUser> listMangeUser(){
		return manageuserDAO.listManageUser();
	}

}
