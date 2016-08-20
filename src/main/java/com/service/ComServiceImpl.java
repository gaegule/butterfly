package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ComDAO;

@Service("comService")
public class ComServiceImpl implements ComService{
	
	@Autowired
    private ComDAO comdao;
	
	@Override
	public List<HashMap<String, String>> comList(Map<String,Object> map) throws Exception{
		System.out.println("11111111111111111111111111==========="+(String)map.get("queryId"));
		return comdao.mysqlComList((String)map.get("queryId"),map);
	}
	
	@Override
	public int misungSave(Map<String, Object> param) throws Exception{
		return comdao.mysqlComSave((String)param.get("queryId"),param);
	}
	
	@Override
	public Map<String, Object>  comDetail(Map<String, Object> param) throws Exception{
		
		Map<String, Object> comDetail = comdao.mysqlComDetail((String)param.get("queryId"),param);

		return comDetail;
	}
	
	@Override
	public int  comListCount(Map<String, Object> param) throws Exception{
		
		int comDetail = comdao.mysqlComPkInt((String)param.get("queryId"),param);

		return comDetail;
	}
}
