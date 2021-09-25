package com.myproject.demo.dao;

import org.springframework.data.repository.CrudRepository;

import com.myproject.demo.model.auth_role;

public interface auth_role_repo extends CrudRepository<auth_role,Integer>{
	
}
