<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/views/include/includeSns.jsp" flush="true"/>
<script>
	$(document).ready(function(){
		
		
	});
	
	$(function(){
		
			var result = new Array();

			<c:forEach items="${fileList}" var="attach">
			
				var fileInfo = new Object();

				fileInfo.orginal_file_nm = "${attach.orginal_file_nm}";
				fileInfo.file_size = "${attach.file_size}";
				fileInfo.file_path = "${attach.file_path}";
				fileInfo.attach_file_no = "${attach.attach_file_no}";
				//fileInfo.filePath = "";

				//alert("555555555555555555");
				
				result.push(fileInfo);
			</c:forEach>
			
			var reType = "${type}";
			
			//alert(reType);
			
			if(reType == "update")
				parent.iframe_return_u(result);
			else
				parent.iframe_return(result);
		}
			
	)
	
	//alert("11111111");
	//parent.alert("frame ready");
	
	

</script>

</head>
<body>
	<input type='hidden' id='filePath' value='<c:out value="${attach.file_path}" escapeXml="false"/>'>
</body>
</html>