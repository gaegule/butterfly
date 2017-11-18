package com.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository("comDAO")
public class ComDAO{

	@Autowired
	@Resource(name="sqlSession")
    private SqlSession sqlSession;
	
	public List<HashMap<String, String>> mysqlComList(String queryId,Map<String,Object> map) throws SQLException{
		return sqlSession.selectList(queryId, map);
	}
	
	public int mysqlComSave(String queryId,Map<String,Object> map) throws DataAccessException{
		return sqlSession.insert(queryId, map);
	}
	
	public Map<String, Object> mysqlComSaveRePk(String queryId,Map<String,Object> map) throws DataAccessException{
		sqlSession.insert(queryId, map);
		return map;
	}
	
	public int mysqlComListSave(String queryId,List<Map<String,Object>> map) throws SQLException{
		return sqlSession.insert(queryId, map);
	}
	
	public int mysqlComUpdate(String queryId,Map<String,Object> map) throws SQLException{
		return sqlSession.update(queryId, map);
	}
	
	public int mysqlComDelete(String queryId,Map<String,Object> map) throws SQLException{
		return sqlSession.delete(queryId, map);
	}
	
	public List<HashMap<String, String>> mysqlComList(String queryId) throws SQLException{
		return sqlSession.selectList(queryId);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> mysqlComDetail(String queryId,Map<String,Object> map) throws SQLException{
		return (Map<String, Object>)sqlSession.selectOne(queryId, map);
				//selectMap(queryId, map);
	}

	public int mysqlComPkInt(String queryId,Map<String,Object> map) throws DataAccessException{
		return sqlSession.selectOne(queryId, map);
	}
	
	public String mysqlComPkString(String queryId,Map<String,Object> map) throws SQLException{
		return (String)sqlSession.selectOne(queryId, map);
	}
}
