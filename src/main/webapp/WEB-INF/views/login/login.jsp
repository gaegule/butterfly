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
	var filter = "win16|win32|win64|mac";
	var mobileYn = "";

	$(document).ready(function(){
		var d = new Date();
		
		var yearVal = d.getFullYear();
		
		for(var i=0; i<90; i++){
			
			$('#year').append("<option value="+(yearVal-i)+">"+(yearVal-i)+"</option>");
		}
		
		for(var i=1; i<13; i++){
			
			var monthVal = "";
			
			if(i >= 10)
				monthVal=i;
			else
				monthVal = "0"+i;
			
			$('#month').append("<option value="+monthVal+">"+(monthVal+"월")+"</option>");
		}
		
		for(var i=1; i<32; i++){
			
			var dayVal = "";
			
		if(i >= 10)
				dayVal=i;
			else
				dayVal = "0"+i;
			
			$('#day').append("<option value="+dayVal+">"+(dayVal+"일")+"</option>");
		}
		
		if(navigator.platform){
			if(0 > filter.indexOf(navigator.platform.toLowerCase())){
				mobileYn ="Y";
			}else{
				mobileYn ="N";
			}
		}
		//alert(d.getFullYear());
		//alert(1);
		if(mobileYn == "Y")
			$("#mainImg").css("display","none");
		$('#form').bootstrapValidator({

	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	first_nm: {
	                validators: {
                        stringLength: {
                        	max:5
                    	},
                        notEmpty: {
                        	message: 'Please supply your first name'
                    	}
	                }
	            },
	            email: {
	                validators: {
	                    notEmpty: {
	                        message: 'The email is required and cannot be empty'
	                    },
	                    emailAddress: {
	                        message: 'The input is not a valid email address'
	                    }
	                }
	            },
	            year: {
	                validators: {
                        
                        notEmpty: {
                        	message: 'year empty'
                    	}
	                }
	            },
			}
		});
		
		$(".container-fluid").css("height",$(window).height());
		
		//alert($("#login_div_main").css("top"));
		
	});
	
	function user_insert(){
		
		var callback = function(data){
			user_return(data);
		}
		//alert(user_check());
		if(user_check())
			ajax_form_post("/com/login/userSave","form","callBack","table",callback,"");
	}
	
	function user_check(){
		
		if($("#first_nm").val() == "" || $("#first_nm").length > 5){
			$("#first_nm").focus();
			return false;
		}
		if($("#last_nm").val() == ""){
			$("#last_nm").focus();
			return false;
		}
		if($("#email").val() == ""){
			$("#email").focus();
			return false;
		}
		if($("#password").val() == ""){
			$("#password").focus();
			return false;
		}
		if($("#year").val() == ""){
			$("#year").focus();
			return false;
		}
		if($("#month").val() == ""){
			$("#month").focus();
			return false;
		}
		if($("#day").val() == ""){
			$("#day").focus();
			return false;
		}

		if(!$('input:radio[name=sex]').is(':checked')){
			$("#sex1").focus();
			return false;
		}
		return true;
	}
	
	function user_return(data){

		if(data.detail.saveReMsg =="emailDup"){
			alert("email 중복입니다. 귀찮아서 페이지로 안만든거 아님.");
			$("#email").focus();
		}else{

			//document.pageMove.pageName.value = "bbs/insertBbs";
			//alert($("#pageName").val());
			$("#email1").val($("#email").val());
			$("#name1").val($("#first_nm").val()+" "+$("#first_nm").val());
			$("#pageMove").submit();
		}
			
		
	}
</script>

</head>
<body>

	<div style="background-color:#e9ebee;height:100%" class="container-fluid">
		<div class="row" style="">
			<div class="col-xs-12 top-menu-block" style="">
				<jsp:include page="/WEB-INF/views/layout/bbs/top.jsp" flush="false"/>
				<%-- <c:import url="/com/layout/top"></c:import> --%>
			</div>
		</div>
		<div class="row div-body" style="height:100%">
		<!-- <div class="row div-body" style="width:980px;margin:auto"> -->
			<div class="visible-md visible-lg col-md-5">
				<%-- <jsp:include page="/WEB-INF/views/layout/bbs/left.jsp" flush="false"/> --%>
				<div id="mainImg" style="margin-left:50px">
					<!-- <img src="/resources/img/sns/loginMain.png" /> -->

					<ul style="list-style-type:none;margin-top:20px">
						<li style="display:list-item;">
							<p style="font-size:38px;font-weight:bold">환영합니다.</p>
						</li>
						<li style="">
							<p style="font-size:25px;">회원가입을 해주세요.</p>
						</li>
					</ul>

				</div>
				
				
			</div>
			
			<div class="visible-sm col-sm-1"></div>
			<div class="col-sm-10 col-md-6" id="login_div_main" style="border-collapse:collapse">
			
				<div class="row" style="padding:10px 0px 0px 0px">
				<!-- <div class="row" style="border:1px solid red;padding:10px 0px 0px 0px"> -->

					<div class="row">
						<div class="col-md-1" ></div>
						<div class="col-md-9" >
							<font style="font-size:30px;font-weight:bold">새 계정 만들기</font>
						</div>
						<div class="col-md-2" >
						
						</div>
					</div>	
					
					<div class="row">
						<div class="col-md-1" ></div>
						<div class="col-md-9" >
							<font style="font-size:20px;">항상 지금처럼 무료로 즐길 수 있습니다.</font>
						</div>
						<div class="col-md-2" >
						
						</div>
					</div>
					
					<form role = "form" id="form" name="form" action="" method="post">
					
					<div class="row" style="margin-top:15px">
						<div class="visible-xs col-xs-1"></div>
						<div class="col-xs-10 col-md-10" >
							<div class="row">
								<div class="col-md-1"></div>
								<div class="col-md-4 col-sm-12 col-xs-12">
									<input type = "text" class = "form-control" name="first_nm" id = "first_nm" placeholder="성" />
								</div>
								<div class="col-md-4 col-sm-12 col-xs-12">
									<input type = "text" class = "form-control" name="last_nm" id = "last_nm" placeholder="이름" />
								</div>
								<div class="col-md-1"></div>
							</div>
						</div>
						<div class="col-xs-1 col-md-2">
							
						</div>
					</div>
					
					<div class="row" style="margin-top:15px">
						<div class="visible-xs col-xs-1"></div>
						<div class="col-xs-10 col-md-10" >
							<div class="row">
								<div class="col-md-1"></div>
								<div class="col-md-8">
									<input type = "text" style="ime-mode:disable;" class = "form-control" name="email" id = "email"  placeholder="이메일" />
								</div>
								<div class="col-md-1"></div>
							</div>
						</div>
						<div class="col-xs-1 col-md-2">
							
						</div>
					</div>

					<div class="row" style="margin-top:15px">
						<div class="visible-xs col-xs-1"></div>
						<div class="col-xs-10 col-md-10" >
							<div class="row">
								<div class="col-md-1"></div>
								<div class="col-md-8">
									<input type = "password" class = "form-control" name="password" id = "password" placeholder="새 비밀번호">
								</div>
								<div class="col-md-1"></div>
							</div>
						</div>
						<div class="col-xs-1 col-md-2">
						</div>
					</div>

					<div class="row" style="margin-top:10px">
						<div class="visible-xs col-xs-1"></div>
						<div class="col-xs-10 col-sm-10 col-md-10" >
							<font style="font-size:15px;">생일</font>
						</div>
						<div class="col-xs-1 col-sm-2 col-md-2" >
						
						</div>
					</div>
					
					<div class="row" style="margin-top:10px">
						<div class="visible-xs col-xs-1" ></div>
						<div class="col-md-4 col-xs-4" >
							<select name="year" style="width:50px" id="year">
								<option value="">년도</option>
							</select>
							<select name="month" style="width:50px" id="month">
								<option value="">월</option>
							</select>
							<select name="day" style="width:50px" id="day">
								<option value="">일</option>
							</select>
						</div>
						<div class="col-md-4 col-xs-5" >
							왜 생년월일을 입력해야 하나요?
						</div>
						<div class="col-md-3 col-xs-2" >
							
						</div>
					</div>
					<div class="row">
						<div class="visible-xs col-xs-1" ></div>
						<div class="col-md-4 col-xs-4" >
							<input type="radio" name="sex" id="sex1" value="1"><font style="font-size:15px;">남자</font></input>
							<input type="radio" name="sex" id="sex2" value="2"><font style="font-size:15px;">여자</font></input>
						</div>
						<div class="col-md-7 col-xs-7" ></div>
					</div>
					<div class="row" style="padding-top:5px">
						<div class="visible-xs col-xs-1"></div>
						<div class="col-md-3 col-xs-3"><button type = "button" onclick="user_insert()" class = "btn btn-primary">계정만들기</button></div>
						<div class="col-md-8 col-xs-8" ></div>
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
			<div class="visible-sm col-sm-1"></div>
<!-- 			<div class="col-md-1" style="border: 1px solid black;">
				<div class="row">
				</div>
			</div> -->
		    
		</div>

	</div>

	<form	name="pageMove" id="pageMove" action="/com/login/loginAft" method="post">
		<input type="hidden" name="pageName" id="pageName" value="bbs/detailBbs">
		<input type="hidden" name="email" id="email1" value="">
		<input type="hidden" name="name" id="name1" value="">	
	</form>

</body>
</html>