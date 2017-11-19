package sns.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

public interface SnsService {

	//int snsNewSave(Map<String, Object> param) throws Exception;
	List<Map<String, Object>> snsNewImageSave(Map<String, Object> param,List<MultipartFile> list) throws Exception;
	
	List<HashMap<String, String>> snsNewSave(Map<String, Object> param) throws Exception;
	
	int snsUpdate(Map<String, Object> param) throws Exception;
	
	HashMap<String, List> snsSearchFriend(Map<String, Object> param) throws Exception;
	
	HashMap<String, List> snsList(Map<String, Object> param) throws Exception;
	
}
