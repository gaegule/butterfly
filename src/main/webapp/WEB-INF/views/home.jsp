<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"href="/resources/bootstrap-336/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bootstrap-theme.min.css">
<script type="text/javascript" src="/resources/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="/resources/bootstrap-336/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function(){
		//alert("ready");
		
	});
	function list_move(){
		
		document.form.action = "/page/move";
		
		$("#form").submit();
		
	}
	
</script>
<title>bootstrap test page</title>
</head>
<body>
	
	<form role = "form" id="form" name="form" action="" method="post">
		<input type="hidden" name="pageName" id="pageName" value="misung/listPage">
	</form>
	<div class="container-fluid" >
		<div class="row" style="border: 1px solid black;">
			<div class="col-xs-12">
				<!-- <h2>bootstrap top menu</h2> -->
				<jsp:include page="layout/top.jsp" flush="false"/>
				
			</div>
		</div>
		<div class="row" style="border: 1px solid black;height:450px">
			<div class="col-sm-2" style="border-right:1px solid black;height:450px">
				왼쪽메뉴
			</div>
			<div class="col-sm-10">
				<a href="javascript:list_move();"> 미성푸드배 목록</a>
			</div>
		</div>
		<div class="row" style="border: 1px solid black;">
			<div class="col-md-12">bottom</div>
		</div>
	</div>
</body>
</html>