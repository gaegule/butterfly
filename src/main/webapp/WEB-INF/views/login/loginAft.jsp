<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/views/include/includeSns.jsp" flush="true"/>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"> </script>
<script>

	$(document).ready(function(){

	});
	
	function user_login(){
		
		$("#form").attr('action','/page/move').submit();
	}
</script>

</head>
<body>

	<div class="container-fluid" style="background-color:#e9ebee">
		<div class="row" style="">
			<div class="col-xs-12 top-menu-block">
				<jsp:include page="/WEB-INF/views/layout/bbs/top.jsp" flush="false"/>
			</div>
		</div>
		<div class="row div-body" style="">
			<div class="col-sm-2" style="height:525px">
				<jsp:include page="/WEB-INF/views/layout/bbs/left.jsp" flush="false"/>
			</div>

			<div class="col-sm-6"  style="border:1px solid #e5e5e5;background-color:white;border-collapse:collapse">
			
				<div class="row" style="border:1px solid red;padding:10px 0px 0px 0px">


					<div class="row">
						<div class="col-sm-1" ></div>
						<div class="col-sm-9" >
							<font style="font-size:30px;font-weight:bold">회원가입 완료!!</font>
						</div>
						<div class="col-sm-2" >
						
						</div>
					</div>	
					
					<div class="row">
						<div class="col-sm-1" ></div>
						<div class="col-sm-9" >
							<font style="font-size:20px;"><c:out value='${reParam.email}' /> 가입을 축하합니다.</font>
						</div>
						<div class="col-sm-2" >
						
						</div>
					</div>

					<div class="row">
						<div class="col-sm-1"></div>
						<div class="col-sm-3"><button type = "button" onclick="user_login()" class = "btn btn-default">login</button></div>
						<div class="col-sm-8" ></div>
					</div>
					</form>
				</div>

				<div class="row">
					<div class="col-sm-1">
						&nbsp;
					</div>

					<div class="col-sm-10">
						<img src="" style="width:100%" />
					</div>
					<div class="col-sm-1">
						&nbsp;
					</div>
				</div>
			</div>
			<div class="col-sm-4" style="border: 1px solid black;">
				<div class="row">
				</div>
			</div>
		    
		</div>

	</div>

	<form	name="pageMove" id="pageMove" action="/page/move" method="post">
		<input type="hidden" name="pageName" id="pageName" value="/com/loginPage">
	
	</form>

</body>
</html>