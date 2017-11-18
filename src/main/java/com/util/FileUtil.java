package com.util;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.dao.ComDAO;

@Component("fileUtil")
public class FileUtil {
	
	@Autowired
    private ComDAO comdao;
	
	public List<Map<String,Object>> fileUpload(List<MultipartFile> list, int id){
		
		String originFileName = "";

		String filePath = "C:\\spring-tool-suite-3.7.3\\sts-bundle\\workspace\\butterfly\\src\\main\\webapp\\bbsFile\\";
		//String filePath = "/var/lib/tomcat7/webapps/butterfly/bbsFile/";

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
	
	
	public List<Map<String,Object>> fileUploadU(List<MultipartFile> list,Map<String, Object> bbsMap){
		
		String originFileName = "";

		String filePath = "C:\\spring-tool-suite-3.7.3\\sts-bundle\\workspace\\butterfly\\src\\main\\webapp\\bbsFile\\";
		//String filePath = "/var/lib/tomcat7/webapps/butterfly/bbsFile/";

		List<Map<String,Object>> reList = null;
		
		try{

			if(list.size() > 0){
				
				Map<String, Object> maxFileMap = comdao.mysqlComDetail("bbsControlMapper.selectFileMaxSeqU",bbsMap);
				
				System.out.println("maxFileMap ============= " +maxFileMap.toString());
				
				int maxFileSeq =0;
				int maxFileCnt =0;

				reList = new ArrayList<Map<String,Object>>();

				maxFileSeq = Integer.parseInt(maxFileMap.get("maxno").toString());
				maxFileCnt = Integer.parseInt(maxFileMap.get("cnt").toString());

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
		        	
		        	if(maxFileCnt == 1 && maxFileSeq ==2)
						maxFileSeq = 1;
		        	else
		        		maxFileSeq++;
		        	
		        	Map<String,Object> map = new HashMap<String,Object>();	
		        	map.put("orginal_file_nm", mtFile.getOriginalFilename());
		        	map.put("stored_file_nm", mtFile.getOriginalFilename());
		        	map.put("file_size", mtFile.getSize());
		        	map.put("attach_file_no", bbsMap.get("bbsId"));
		        	
		        	map.put("attach_file_seq", maxFileSeq);

		        	reList.add(i, map);
		        	
		        }
			}
			
		}catch(Exception e){
			System.out.println("******************************FAILFILE******************************");
		}
		
		return reList;
	}
	
	public int fileDelete(Map<String, Object> param){
		int imageSeq=0;
		try{
			Map<String, Object> fileDetail = comdao.mysqlComDetail("bbsControlMapper.selectBbsDetailAttachSeq",param);
			
			if(!fileDetail.isEmpty()){

				String fileName = (String)fileDetail.get("stored_file_nm");
				
				String filePath = "C:\\spring-tool-suite-3.7.3\\sts-bundle\\workspace\\butterfly\\src\\main\\webapp\\bbsFile\\";
				//String filePath = "/var/lib/tomcat7/webapps/butterfly/bbsFile/";
				
				File mainFile = new File(filePath + fileName);
				//File thumbFile = new File(filePath+ filePath2 + "thumb_"+fileName);
				if(mainFile.exists()){
					System.out.println("11111111111111111111111111111111111111111111111111111111111111111111111");
					mainFile.delete();
				}else{
					imageSeq = 1;
				}
				
			}
		}catch(Exception e){
			imageSeq = 1;
			
			System.out.println("******************************FAILFILE******************************");
			System.out.println("e"+e);
			return imageSeq;
		}
		return imageSeq;
	}
	
	public List<Map<String,Object>> imageFileUpload(List<MultipartFile> list){
		
		String originFileName = "";
		
		Date now = new Date ();

		DateFormat df = new SimpleDateFormat("yyyy:MM:dd");
		String strDate = df.format(now);
		
		String dateSplit [] = strDate.split(":");
		
		String uniqueID = UUID.randomUUID().toString();
		uniqueID = uniqueID.replaceAll("-", "");
		//uniqueID = uniqueID.substring(0, 6);

		String filePath = "C:\\spring-tool-suite-3.7.3\\sts-bundle\\workspace\\butterfly\\src\\main\\webapp\\snsImage\\"
		//String filePath = "/var/lib/tomcat7/webapps/butterfly/snsImage/"
				
		+dateSplit[0]+"/"
		+dateSplit[1]+"/"+dateSplit[2]+"/"+uniqueID+"/";
		//String filePath = "D:/upload/"+"bbs_"+Str	ing.valueOf(id)+"/";
		String filePath2 = "/snsImage/"+dateSplit[0]+"/"
				+dateSplit[1]+"/"+dateSplit[2]+"/"+uniqueID+"/";
		List<Map<String,Object>> reList = null;

		System.out.println("now.getYear()=="+strDate );
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
		        		
		        		File thumbFile = new File(filePath + "thumb_"+originFileName);
		        		mtFile.transferTo(file);
		        		//mtFile.transferTo(thumbFile);

		        		BufferedImage buffer_original_image = ImageIO.read(file);
		                BufferedImage buffer_thumbnail_image = new BufferedImage(60, 60, BufferedImage.TYPE_3BYTE_BGR);

		                Graphics2D graphic = buffer_thumbnail_image.createGraphics();
		                graphic.drawImage(buffer_original_image, 0, 0, 60, 60, null);
		                ImageIO.write(buffer_thumbnail_image, "jpg", thumbFile);

		        	}
		        	Map<String,Object> map = new HashMap<String,Object>();	
		        	map.put("orginal_file_nm", mtFile.getOriginalFilename());
		        	map.put("stored_file_nm", mtFile.getOriginalFilename());
		        	map.put("file_size", mtFile.getSize());
		        	//map.put("attach_file_no", id);
		        	map.put("attach_file_seq", (i+1));
		        	//filePath = filePath.replaceAll("\\", "\\\\\\");
		        	//filePath = filePath.replaceAll("\\\\", "\\\\\\\\");
		        	map.put("file_path", filePath2);
		        	
		        	System.out.println("mtFile.getOriginalFilename()=="+mtFile.getOriginalFilename());
		        	System.out.println("mtFile.getSize()=="+mtFile.getSize());
		        	System.out.println("filePath=="+filePath2);

		        	reList.add(i, map);
		        	
		        }
			}
			
		}catch(Exception e){
			System.out.println("************imageFileUpload***********imageFileUpload***********imageFileUpload**********");
			System.out.println("e222=="+e);
		}
		
		return reList;
	}
	
	
	public int imageDelete(Map<String, Object> param){
		int imageSeq=0;
		try{
			Map<String, Object> fileDetail = comdao.mysqlComDetail("snsControlMapper.selectSnsAttachSeq",param);
			
			if(!fileDetail.isEmpty()){
				
				String filePath2 = (String)fileDetail.get("file_path");
				String fileName = (String)fileDetail.get("stored_file_nm");
				
				String filePath = "C:\\spring-tool-suite-3.7.3\\sts-bundle\\workspace\\butterfly\\src\\main\\webapp\\snsImage\\";
				//String filePath = "/var/lib/tomcat7/webapps/butterfly/snsImage/";
				
				File mainFile = new File(filePath+ filePath2 + fileName);
				File thumbFile = new File(filePath+ filePath2 + "thumb_"+fileName);
				if(mainFile.exists()){
					System.out.println("11111111111111111111111111111111111111111111111111111111111111111111111");
					mainFile.delete();
					if(thumbFile.exists()){
						thumbFile.delete();
					}
				}else{
					
					System.out.println("22222222222222222222222222222222222222222222222222222222222222");
					
					imageSeq = 1;
				}
				
			}
		}catch(Exception e){
			imageSeq = 1;
			
			System.out.println("******************************FAILFILE******************************");
			System.out.println("e"+e);
			return imageSeq;
		}
		return imageSeq;
	}
	
	
	public int imageDeleteAll(Map<String, Object> param){
		int imageSeq=0;
		try{
			List<HashMap<String, String>> fileList = comdao.mysqlComList("snsControlMapper.selectSnsAttach",param);
			
			if(fileList.size() > 0){
				
				for(int i=0;i<fileList.size();i++){
					
					HashMap<String, String> fileDetail = fileList.get(i);
					
					if(!fileDetail.isEmpty()){
						
						String filePath2 = (String)fileDetail.get("file_path");
						String fileName = (String)fileDetail.get("stored_file_nm");
						String filePath = "C:\\spring-tool-suite-3.7.3\\sts-bundle\\workspace\\butterfly\\src\\main\\webapp\\";
						File mainFile = new File(filePath+ filePath2 + fileName);
						File thumbFile = new File(filePath+ filePath2 + "thumb_"+fileName);
						if(mainFile.exists()){
							System.out.println("11111111111111111111111111111111111111111111111111111111111111111111111");
							mainFile.delete();
							if(thumbFile.exists()){
								//thumbFile.delete();
								System.out.println("delete delete delete delete delete delete delete delete delete delete delete delete ");
							}
						}else{
							
							System.out.println("22222222222222222222222222222222222222222222222222222222222222");
							
							imageSeq = 1;
						}
						
					}
				}
			}
			
			
		}catch(Exception e){
			imageSeq = 1;
			
			System.out.println("******************************FAILFILE******************************");
			System.out.println("e"+e);
			return imageSeq;
		}
		return imageSeq;
	}
	
	public static String generateSessionKey(int length){
		String alphabet = 
		        new String("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"); //9
		int n = alphabet.length(); //10

		String result = new String(); 
		Random r = new Random(); //11

		for (int i=0; i<length; i++) //12
		    result = result + alphabet.charAt(r.nextInt(n)); //13

		return result;
	}
	
}
