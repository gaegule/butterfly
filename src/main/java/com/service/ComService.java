package com.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface ComService {

	List<HashMap<String, String>> comList(Map<String,Object> map) throws Exception;
	
	int misungSave(Map<String, Object> param) throws Exception;
	
	Map<String, Object> comDetail(Map<String, Object> map) throws Exception;
	
	int comListCount(Map<String, Object> param) throws Exception;
	
	int comSave(Map<String, Object> param) throws Exception;
	
	int comDelete(Map<String, Object> param) throws Exception;
	
	int comUpdate(Map<String, Object> param) throws Exception;
	
	Map<String, Object> comSaveRePk(Map<String, Object> param) throws DataAccessException;
	
	Map<String, Object> userSave(Map<String, Object> param) throws DataAccessException;
}
