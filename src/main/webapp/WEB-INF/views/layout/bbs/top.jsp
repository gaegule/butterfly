<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

<script>
	
	$(document).keypress(function(event){
		if(event.which == 13)
			login_check();
	});
	
	function pageMoveTop(pageNm){

		$("#pageName").val(pageNm);
		$("#pageMoveForm").submit();
	}
	
	function imgAjaxUpload_U(){

		var f = document.pageMoveForm;
		f.action="/com/loginPage";
		//f.target="hiddenframe";
		f.submit();
		
	}
	
	
</script>
<title>bootstrap test page</title>
</head>
<body>
<!-- <nav class="navbar navbar-default">
	<div class="container-fluid">
	Brand and toggle get grouped for better mobile display
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Brand</a>
		</div>
	</div>
	
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav navbar">
			<li><a href="#">Link</a></li>
			<li class="dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown <span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#">Action</a></li>
					<li><a href="#">Another action</a></li>
					<li><a href="#">Something else here</a></li>
					<li class="divider"></li>
					<li><a href="#">Separated link</a></li>
				</ul>
			</li>
		</ul>
	</div>

</nav> -->

	<nav style="background:#3b5998;width:100%" class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
        <div class="container topnav" style="">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!-- <a class="navbar-brand topnav" href="/" style="font-size:14px;color:#5e5e5e;background-color:transparent;text-shadow: 0 1px 0;font-weight:300;font-family:Lato,Helvetica Neue,Helvetica,Arial,sans-serif">BUTTERFLY</a> -->
            	<a class="navbar-brand topnav" style="color:white" href="/">BUTTERFLY</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            
            	<!-- <div class="visible-md visible-lg">
            		<ul class="nav navbar-nav">
				        <li class="dropdown">
				          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">menu <span class="caret"></span></a>
				          <ul class="dropdown-menu">
				            <li><a href="javascript:pageMoveTop('bbs/listBbs')">일반게시판</a></li>
				            <li role="separator" class="divider"></li>
				            <li><a href="#">메뉴테스트2</a></li> 
				            <li role="separator" class="divider"></li>
				          </ul>
				        </li>
			    	</ul>
            	</div> -->
            	
            	<div class="visible-md visible-lg col-md-4 col-lg-4">
            		
            	</div>
            	
            	<div class="col-sm-8 col-md-8 col-lg-8">
            		<ul class="nav navbar-nav" style="float:right">
			    		<li>
			    			<form role = "form" id="login_form" name="login_form" action="" method="post">
				    			<table border="0">
				    				<tr >
				    					<td style="">
				    						<font style="font-size:12px;margin-top:3px;color:white">이메일 또는 아이디</font>
				    					</td>
				    					<td style="padding-left:10px">
				    						<font style="font-size:12px;color:white">비밀번호 <c:out value='${sessionScope.loginInfo.user_id}' /></font>
				    					</td>
				    					
				    				</tr>
				    				<tr>
				    					<td>
				    						<input type = "text" style="margin-top:1px;width:120px;height:20px" name="login_id" id = "login_id" value="gaegule@naver.com">
				    					</td>
				    					<td style="padding-left:10px">
				    						<input type = "password" style="margin-top:1px;width:120px;height:20px" name="login_pw" id = "login_pw" >
				    					</td>
				    					<td  onclick="javascript:login_check();" style="cursor:pointer">
				    						<!-- <a href="javascript:login_check();">로그인</a> -->
				    						<label	class="" 
				    						style="background-color:#4267b2;border-color:#29487d;border:1px solid #ced0d4;line-height:18px;margin:1px 0px 0px 10px;font-color:white">
				    							<button type = "button" onclick="login_check()" 
				    									style="background:none;line-height:18px;border:0;padding:0;font-size:12px;line-height:18px;color:#fff;font-weight:bold" 
				    									class = "btn btn-default" value="">
				    									로그인
				    							</button>
				    							
				    						</label>
				    						<!-- 로그인  -->
				    					</td>
				    				</tr>
				    			</table>
			    			</form>
			    		</li>

			    	</ul>
            	</div>

		    </div>

            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
<script>

	function test(){
		alert("dfsdfsd");
	}
	
	function login_return(data){
		
		alert("로그인 되었습니다."+data.loginYn);
		//if(data.loginYn =="N")
		$("#pageName").val("index");
		$("#pageMoveForm").submit();
	}
	
	
	function login_check(){
		
		//alert("11111111111111111");
		
		var callback = function(data){
			
			login_return(data);
		}
	
		ajax_form_post("/com/login/login","login_form","callBack","callBack",callback,"");
	}
	
	
	$(document).ready(function(){
		//alert("ready........");
	});
</script>
<!-- 
<nav class="navbar navbar-default">
  <div class="container-fluid">
    
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">bootstrap</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">menu1 <span class="sr-only">(current)</span></a></li>
        <li><a href="#">menu2	</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">menu3 <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="javascript:pageMoveTop('bbs/listBbs')">메뉴테스트1</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">메뉴테스트2</a></li>
            <li role="separator" class="divider"></li>
          </ul>
        </li>
      </ul>

    </div>
  </div>
</nav> -->

<form role = "form" id="pageMoveForm" name="pageMoveForm" action="/page/move" method="post">
	<input type="hidden" id="pageName" name="pageName" />
	
	<input type="hidden" id="pageType" name="pageType" value="SNS"/>
</form>

</body>
</html>