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

				<div class="row" ng-controller="myCtrl">
					yourName Name: <input type="text" ng-model="yourName"><br>
					Last Name: <input type="text" ng-model="lastName"><br>
					Full Name: {{yourName + " " + lastName}}
					
					<ul ng-show="myVar">
                		<li ng-repeat="tt in names">
	                    	{{tt}}
	                	</li>
	            	</ul>
		
					<button ng-click="count = count + 1">Click1</button>
					<p>{{ count }}</p>
					
					<BR/>
					<button ng-click="test()">Click2</button>
				</div>

			</div>
			<script>
				 var app = angular.module('myApp', []);
				 app.controller('myCtrl', function($scope) {
				     $scope.yourName= "Dimigo";
				     $scope.names= ['Park', 'Jone', 'cheon', 'kim'];
				     $scope.count = 0;
				     $scope.test = function() {
				         $scope.myVar = !$scope.myVar;
				     };

				 });
			</script>

			
			<div class="col-sm-4" style="border: 1px solid black;">
				<div class="row">
				</div>
			</div>
		    
		</div>

	</div>

</body>
</html>