package com.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Override
	public int comSave(Map<String, Object> param) throws SQLException{
		return comdao.mysqlComSave((String)param.get("queryId"),param);
	}
	
	@Override
	public Map<String, Object> comSaveRePk(Map<String, Object> param) throws DataAccessException{
		return (Map<String, Object>)comdao.mysqlComSaveRePk((String)param.get("queryId"),param);
	}
	
	@Override
	public int comDelete(Map<String, Object> param) throws SQLException{
		return comdao.mysqlComDelete((String)param.get("queryId"),param);
	}
	
	@Override
	public int comUpdate(Map<String, Object> param) throws SQLException{
		return comdao.mysqlComUpdate((String)param.get("queryId"),param);
	}
	
	@Override
	public Map<String, Object> userSave(Map<String, Object> param) throws DataAccessException{
		
		int reSave =0;

		int emailCheck = comdao.mysqlComPkInt("userControlMapper.login_check",param);

		if(emailCheck > 0){
			param.put("saveReMsg", "emailDup");
			return param;
		}
		param.put("queryId", "userControlMapper.insertUser");

		Map<String, Object> reSaveMap = comdao.mysqlComSaveRePk((String)param.get("queryId"),param);
		
		param.put("user_no", reSaveMap.get("idx"));
		//param.put("user_no", 1);
		
		System.out.println("idx===================="+reSaveMap.get("idx"));
		
		param.put("queryId", "userControlMapper.insertUserFrofile");
		reSave = comdao.mysqlComSave((String)param.get("queryId"),param);
		
		param.put("saveReMsg", "success");
		
		return param;
	}
	
}
