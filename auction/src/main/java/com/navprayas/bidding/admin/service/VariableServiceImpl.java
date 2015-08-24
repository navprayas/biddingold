package com.navprayas.bidding.admin.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.admin.dao.VariableDAO;
import com.navprayas.bidding.admin.form.Variable;


@Service
public class VariableServiceImpl implements VariableService {

	@Autowired
	private VariableDAO variableDAO;
	@Transactional
	public void addVariable(Variable variable) {
		variableDAO.addVariable(variable);
	}

}
