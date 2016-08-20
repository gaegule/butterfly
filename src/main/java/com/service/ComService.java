package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ComService {

	List<HashMap<String, String>> comList(Map<String,Object> map) throws Exception;
	
	int misungSave(Map<String, Object> param) throws Exception;
	
	Map<String, Object> comDetail(Map<String, Object> map) throws Exception;
	
	int comListCount(Map<String, Object> param) throws Exception;
}
