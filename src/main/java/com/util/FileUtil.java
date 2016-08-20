package com.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component("fileUtil")
public class FileUtil {
	
	public List<Map<String,Object>> fileUpload(List<MultipartFile> list, int id){
		
		String originFileName = "";
		
		String filePath = "D:\\upload\\"+"bbs_"+String.valueOf(id)+"\\";
		//String filePath = "D:/upload/"+"bbs_"+String.valueOf(id)+"/";

		List<Map<String,Object>> reList = null;
		
		try{
			if(list.size() > 0){

				reList = new ArrayList<Map<String,Object>>();
				
				File file = new File(filePath);
		        if(file.exists() == false){
		            file.mkdirs();
		        }

		        for(int i=0; i<list.size(); i++){

		        	MultipartFile mtFile = list.get(i);
		        	
		        	System.out.println("FILEUTIL mtFile.isEmpty()========"+mtFile.isEmpty());
		        	if(mtFile.isEmpty()==false){

		        		originFileName =mtFile.getOriginalFilename();
		        		System.out.println("FILEUTIL mtFile.getOriginalFilename()==="+mtFile.getOriginalFilename());
		        		//originFileName.substring(originFileName.lastIndexOf("."));
		        		file = new File(filePath + originFileName);
		        		mtFile.transferTo(file);

		        	}
		        	Map<String,Object> map = new HashMap<String,Object>();	
		        	map.put("orginal_file_nm", mtFile.getOriginalFilename());
		        	map.put("stored_file_nm", mtFile.getOriginalFilename());
		        	map.put("file_size", mtFile.getSize());
		        	map.put("attach_file_no", id);
		        	map.put("attach_file_seq", (i+1));

		        	reList.add(i, map);
		        	
		        }
			}
			
		}catch(Exception e){
			System.out.println("******************************FAILFILE******************************");
		}
		
		return reList;
	}
	
}
