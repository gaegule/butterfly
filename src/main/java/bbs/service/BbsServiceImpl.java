package bbs.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.dao.ComDAO;
import com.util.FileUtil;

@Service("bbsService")
public class BbsServiceImpl implements BbsService{
	
	@Autowired
    private ComDAO comdao;
	
	@Resource(name="fileUtil")
	private FileUtil fileUtil;
	
	@Override
	public int bbsNewSave(Map<String, Object> param,List<MultipartFile> list) throws Exception{
		
		List<Map<String,Object>> fileList= null;
		
		int maxSeq = comdao.mysqlComPkInt("bbsControlMapper.selectBbsMaxSeq",param);
		
		param.put("no", maxSeq);
		
		System.out.println("list============"+list);
		
		if(list != null && list.size() != 0){

			fileList = fileUtil.fileUpload(list, maxSeq);
		}
		
		int maxFileSeq = comdao.mysqlComPkInt("bbsControlMapper.selectBbsMaxSeq",param);
		
		int reVal = 0;
		reVal = comdao.mysqlComSave("bbsControlMapper.insertNewBBS",param);

		if(fileList != null){

			for(int i=0; i<fileList.size(); i++){
				
				Map<String, Object> map = fileList.get(i);
				int reFileVal = comdao.mysqlComSave("bbsControlMapper.insertFile",map);
			}

		}
		
		return maxSeq;
	}
	
	@Override
	public int bbsReplySave(Map<String, Object> param,List<MultipartFile> list) throws Exception{
		
		int maxSeq = comdao.mysqlComPkInt("bbsControlMapper.selectBbsMaxSeq",param);

		param.put("no", maxSeq);
		
		int no = nvlInt((String)param.get("bbsId"));
		int grp = nvlInt((String)param.get("grp"));
		int seq = nvlInt((String)param.get("seq"));
		int lvl = nvlInt((String)param.get("lvl"));

		int updateVal = comdao.mysqlComUpdate("bbsControlMapper.updateReplyBBS",param);

		lvl = lvl + 1;
		seq = seq + 1;
		
		param.put("bbsId", no);
		param.put("grp", grp);
		param.put("lvl", lvl);
		param.put("seq", seq);
		
		int reVal = comdao.mysqlComSave("bbsControlMapper.insertReplyBBS",param);
		return maxSeq;
	}
	
	@Override
	public int bbsUpdate(Map<String, Object> param,List<MultipartFile> list) throws Exception{

		int reVal = 0;
		comdao.mysqlComUpdate("bbsControlMapper.updateBBS",param);
		reVal = Integer.parseInt(param.get("bbsId").toString());
		return reVal;
	}
	
	@Override
	public int bbsDelete(Map<String, Object> param) throws Exception{
		
		int reVal = comdao.mysqlComDelete((String)param.get("queryId"),param);
		
		return reVal;
	}
	
	public int nvlInt(String param){
		int nvl=0;
		if(param != null && !"".equals(param)){
			nvl = Integer.parseInt(param);
		}
		return nvl;
	}

	@Override
	public int bbsNewSave(Map<String, Object> param) throws Exception {
		int maxSeq = comdao.mysqlComPkInt("bbsControlMapper.selectBbsMaxSeq",param);

		param.put("no", maxSeq);
		
		int reVal = comdao.mysqlComSave("bbsControlMapper.insertNewBBS",param);
		return maxSeq;
	}

	@Override
	public int bbsReplySave(Map<String, Object> param) throws Exception {
		int maxSeq = comdao.mysqlComPkInt("bbsControlMapper.selectBbsMaxSeq",param);

		param.put("no", maxSeq);
		
		int no = nvlInt((String)param.get("bbsId"));
		int grp = nvlInt((String)param.get("grp"));
		int seq = nvlInt((String)param.get("seq"));
		int lvl = nvlInt((String)param.get("lvl"));

		int updateVal = comdao.mysqlComUpdate("bbsControlMapper.updateReplyBBS",param);

		lvl = lvl + 1;
		seq = seq + 1;
		
		param.put("bbsId", no);
		param.put("grp", grp);
		param.put("lvl", lvl);
		param.put("seq", seq);
		
		int reVal = comdao.mysqlComSave("bbsControlMapper.insertReplyBBS",param);
		return maxSeq;
	}

	@Override
	public int bbsUpdate(Map<String, Object> param) throws Exception {
		int reVal = 0;
		comdao.mysqlComUpdate("bbsControlMapper.updateBBS",param);
		reVal = Integer.parseInt(param.get("bbsId").toString());
		return reVal;
	}
}
