package com.navprayas.bidding.template.dao;

import java.util.List;

import com.navprayas.bidding.template.form.Contact;


public interface ContactDAO {
	
	public void addContact(Contact contact);
	public List<Contact> listContact();
	public void removeContact(Integer id);
}
