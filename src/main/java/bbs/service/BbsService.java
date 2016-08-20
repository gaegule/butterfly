package bbs.service;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

public interface BbsService {

	int bbsNewSave(Map<String, Object> param) throws Exception;
	int bbsNewSave(Map<String, Object> param,List<MultipartFile> list) throws Exception;
	
	int bbsReplySave(Map<String, Object> param) throws Exception;
	int bbsReplySave(Map<String, Object> param,List<MultipartFile> list) throws Exception;
	
	int bbsUpdate(Map<String, Object> param) throws Exception;
	int bbsUpdate(Map<String, Object> param,List<MultipartFile> list) throws Exception;
	
	int bbsDelete(Map<String, Object> param) throws Exception;
}
