<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html ng-app="myApp" ng-init="">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/resources/js/angular.min.js"></script>
<jsp:include page="/WEB-INF/views/include/includeSns.jsp" flush="true"/>

<script>

	$(document).ready(function(){

	});
	
</script>
<style type="text/css">
	HTML { 
		height: 100%;
	}
	BODY { 
		height: 100%;
	}

</style>
</head>
<body>

	<div class="container-fluid" style="background-color:#e9ebee">
		<div class="row" style="">
			<div class="col-xs-12 top-menu-block">
				<c:import url="/com/layout/top"></c:import>
			</div>
		</div>
		
		<div class="row" style="height:150px">
			<div class="col-sm-8">
				<div class="row" style="border:1px solid black;height:150px">
				</div>
			</div>
			<div class="col-sm-4" style="">
			</div>
		</div>

		<div class="row div-body" style="">
			
			<div class="col-sm-8"  style="border:1px solid #e5e5e5;background-color:white;border-collapse:collapse">
				<div class="row" style="border:1px solid red;padding:10px 0px 20px 0px">
					<label>Message : </label>
					<input type="text" ng-model="Message" placeholder="Enter the Message">
					<hr>
					<h1>Test > {{Message}} !</h1>

				</div>

			</div>


			
			<div class="col-sm-4" style="border: 1px solid black;">
				<div class="row">
				</div>
			</div>
		    
		</div>

	</div>

</body>
</html>