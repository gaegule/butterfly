package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("comDAO")
public class ComDAO{

	@Autowired
	@Resource(name="sqlSession")
    private SqlSession sqlSession;
	
	public List<HashMap<String, String>> mysqlComList(String queryId,Map<String,Object> map) throws Exception{
		return sqlSession.selectList(queryId, map);
	}
	
	public int mysqlComSave(String queryId,Map<String,Object> map) throws Exception{
		return sqlSession.insert(queryId, map);
	}
	
	public int mysqlComListSave(String queryId,List<Map<String,Object>> map) throws Exception{
		return sqlSession.insert(queryId, map);
	}
	
	public int mysqlComUpdate(String queryId,Map<String,Object> map) throws Exception{
		return sqlSession.update(queryId, map);
	}
	
	public int mysqlComDelete(String queryId,Map<String,Object> map) throws Exception{
		return sqlSession.delete(queryId, map);
	}
	
	public List<HashMap<String, String>> mysqlComList(String queryId) throws Exception{
		return sqlSession.selectList(queryId);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> mysqlComDetail(String queryId,Map<String,Object> map) throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(queryId, map);
				//selectMap(queryId, map);
	}

	public int mysqlComPkInt(String queryId,Map<String,Object> map) throws Exception{
		return sqlSession.selectOne(queryId, map);
	}
	
	public String mysqlComPkString(String queryId,Map<String,Object> map) throws Exception{
		return (String)sqlSession.selectOne(queryId, map);
	}
}
