package sns.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.dao.ComDAO;
import com.util.FileUtil;

@Service("snsService")
public class SnsServiceImpl implements SnsService{
	
	@Autowired
    private ComDAO comdao;
	
	@Resource(name="fileUtil")
	private FileUtil fileUtil;
	
	@Override
	public List<Map<String,Object>> snsNewImageSave(Map<String, Object> param,List<MultipartFile> list) throws Exception{
		
		List<Map<String,Object>> fileList= null;
		
		List<Map<String,Object>> fileListRe = new ArrayList<Map<String,Object>>();

		String attachFileNo = "";
		
		if(list != null && list.size() != 0){
			fileList = fileUtil.imageFileUpload(list);
		}
		
		attachFileNo = (String)param.get("attach_file_no");
		
		int snsSeqS = 0;
		
		try{
			
			if(fileList != null){

				if(attachFileNo == null || "".equals(attachFileNo)){
					int snsSeq = comdao.mysqlComPkInt("snsControlMapper.selectSnsFileMaxSeq",param); 
					attachFileNo = String.valueOf(snsSeq);
				}else{
					snsSeqS = comdao.mysqlComPkInt("snsControlMapper.selectSnsFileMaxSeqS",param); 
				}

				for(int i=0; i<fileList.size(); i++){
					//System.out.println("fileList=================================="+fileList.toString());
					Map<String, Object> map = fileList.get(i);
					map.put("attach_file_no", attachFileNo);
					if(snsSeqS > 0)
						map.put("attach_file_seq", (snsSeqS+i));
					else
						map.put("attach_file_seq", (i+1));
					
					int reFileVal = comdao.mysqlComSave("snsControlMapper.insertImageFile",map);
					//fileList.add(i, map);
					fileList.set(i, map);
				}
	
			}
			
			System.out.println("22222222222222222");
		}catch(Exception e){
			System.out.println("******************************FAILFILE******************************");
			System.out.println("e"+e);
		}
		return fileList;
	}
	
	public List<HashMap<String, String>> snsNewSave(Map<String, Object> param) throws Exception {
		
		//List<HashMap<String, String>> list =null;

		int reVal = comdao.mysqlComSave("snsControlMapper.insertNewSns",param);

		//list = comdao.mysqlComList("bbsControlMapper.selectSnsProFileList",param);
		return comdao.mysqlComList("snsControlMapper.selectSnsProFileList",param);
	}

	public int snsUpdate(Map<String, Object> param) throws Exception {
		
		//List<HashMap<String, String>> list =null;
		
		String snsSeq = (String)param.get("attach_file_seq");
		String snsSeqArr [] = null;
		
		System.out.println("sns_profile_no=="+param.get("sns_profile_no"));
		int reFileVal = 0;
		if(snsSeq != null && !"".equals(snsSeq)){
			
			snsSeqArr = snsSeq.split("@@");
			
			int seq =1;
			
			comdao.mysqlComUpdate("snsControlMapper.updateSns",param);
			
			for(int i=0; i<snsSeqArr.length; i++){
				System.out.println("snsSeqArr=="+snsSeqArr[i]);
				String seqStr = snsSeqArr[i];
				if(seqStr != null && "block".equals(seqStr)){
					
					param.put("attach_file_seq", i+1);
					
					int reFile = fileUtil.imageDelete(param);
					
					System.out.println("reFile========================== "+reFile);
					
					if(reFile == 0)
						reFileVal = comdao.mysqlComDelete("snsControlMapper.deleteImageFile",param);
					
					System.out.println("reFileVal111111111=="+reFileVal);	
					
				}else{
					param.put("attach_file_seq", i+1);
					param.put("attach_file_seqU", seq);
					reFileVal = comdao.mysqlComUpdate("snsControlMapper.updateImageFileSeq",param);
					System.out.println("reFileVal2222222222=="+reFileVal);
					seq++;
				}
			}
		}

		return reFileVal;
	}
	
	// 模备 茫扁
	public HashMap<String, List> snsSearchFriend(Map<String, Object> param) throws Exception {
		
		//List<HashMap<String, String>> list =null;
		HashMap<String, List> friendMap = new HashMap<String, List>();

		// 模备夸没 status R
		param.put("status", "R");
		
		// add
		List<HashMap<String, String>> aFriend = comdao.mysqlComList("snsControlMapper.selectFriendRequest",param);
		friendMap.put("aFriend", aFriend);
		
		// request
		List<HashMap<String, String>> rFriend = comdao.mysqlComList("snsControlMapper.selectMayFriendSearch",param);
		friendMap.put("rFriend", rFriend);
		
		
		//list = comdao.mysqlComList("bbsControlMapper.selectSnsProFileList",param);
		return friendMap;
	}
	
	// sns 格废
	public HashMap<String, List> snsList(Map<String, Object> param) throws Exception {
		
		//List<HashMap<String, String>> list =null;
		HashMap<String, List> friendMap = new HashMap<String, List>();

		
		String snsType = (String) param.get("snsType");
		
		String snsListNm = "snsControlMapper.selectSnsProFileList";

		if(snsType==null || "".equals(snsType) || "N".equals(snsType))
			snsListNm = "snsControlMapper.selectSnsFriendProFileList";

		// add
		List<HashMap<String, String>> aFriend = comdao.mysqlComList(snsListNm,param);
		friendMap.put("snsList", aFriend);
		
		param.put("status", "S");
		
		System.out.println("snsType========================"+snsType);
		
		if(snsType==null || "".equals(snsType) || "N".equals(snsType)){
		// request
			List<HashMap<String, String>> rFriend = comdao.mysqlComList("snsControlMapper.selectFriendRequest",param);
			friendMap.put("friendList", rFriend);
		}
		
		
		//list = comdao.mysqlComList("bbsControlMapper.selectSnsProFileList",param);
		return friendMap;
	}
}
