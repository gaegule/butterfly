package com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.AbstractView;

@Component("fileDownload")
public class FilDownload extends AbstractView{
	
	
	public FilDownload() {
        // ��ü�� ������ �� Content Type�� ������ ���� ���� 
        setContentType("application/download; charset=utf-8");
    }

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
			System.out.println("111111111 2222222222 =============="+model.toString());
		 	@SuppressWarnings("unchecked")
	        Map<String, Object> fileInfo = (Map<String, Object>) model.get("downloadFile"); // ���۹��� ��(���� ����)
	        
	        String fileNameKey     = (String) fileInfo.get("fileNameKey");    // ��ȣȭ�� ���ϸ�(���� ����� ���� �̸�)
	        String fileName     = (String) fileInfo.get("fileName");    // ���� ���ϸ�(ȭ�鿡 ǥ�õ� ���� �̸�)
	        ///String filePath     = (String) fileInfo.get("filePath");    // ���� ���
	        String filePath     = "C:\\spring-tool-suite-3.7.3\\sts-bundle\\workspace\\butterfly\\src\\main\\webapp\\bbsFile\\";
	        //String filePath = "/var/lib/tomcat7/webapps/butterfly/bbsFile/";
	         
	        File file = new File(filePath, fileNameKey);
	        
	        System.out.println("fileName 2222222222 =============="+fileName);
	        
	        response.setContentType(getContentType());
	        response.setContentLength((int) file.length());
	 
	        // ������, �ü������
	        String userAgent = request.getHeader("User-Agent");
	        
	        
	        // IE
	        if (userAgent.indexOf("MSIE") > -1) {
	            
	            fileName = URLEncoder.encode(fileName, "UTF-8");
	        }
	         
	        // IE 11
	        if (userAgent.indexOf("Trident") > -1) {
	            fileName = URLEncoder.encode(fileName, "UTF-8");
	        }
	        
	        else {
	            fileName = new String( fileName.getBytes("UTF-8"), "8859_1");
	        }
	 
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        
	        OutputStream out = response.getOutputStream();
	 
	        FileInputStream fis = null;
	 
	        try {
	            
	            fis = new FileInputStream(file);
	            FileCopyUtils.copy(fis, out);
	            
	        } finally {
	            
	            if(fis != null) {
	                fis.close();
	            }
	        }
	        
	        out.flush();

	}

}
