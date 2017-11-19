<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
<script>
	$(document).ready(function(){
		//alert("ready");
		//$('.dropdown-toggle').dropdown()
	});
	
	function pageMoveTop(pageNm){

		$("#pageName").val(pageNm);
		$("#pageMoveForm").submit();
	}
	
	function logout(){

		//alert("11111111111111111");
		if(!confirm("진짜 로그아웃 할껴??")){
			
			return;
			
		}
		var callback = function(data){
			
			logout_return(data);
		}
	
		ajax_form_post("/com/login/logout","login_form","callBack","callBack",callback,"");

	}
	
	function logout_return(data){
		
		//alert(data.logout_yn);
		$("#pageName").val("index");
		$("#pageMoveForm").submit();
	}
	
	function search_friend(){
		document.searchForm.action = "/sns/searchFriend";
		$("#searchForm").submit();
	}
	
	function friend_home(type){
		
		document.pageMoveForm.pageName.value = "/sns/listSns";
		if(type == "1")
			$("#topSnsType").val("Y");
		else
			$("#topSnsType").val("");
		
		$("#pageMoveForm").submit();
	}
	

</script>
<title>bootstrap test page</title>
</head>
<body>

	<nav style="background:#3b5998;" class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
        <div class="container topnav">
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
		    	
				<ul class="nav navbar-nav" style="float:left;">
					<form role = "form" id="search_form" name="search_form" action="/sns/searchPeople" method="post">
					<input type="hidden" id="people_user_no" name="user_no" value="<c:out value='${sessionScope.loginInfo.user_no}' />"/>
		    			<table border="0" style="margin-top:7px;width:100%">
		    				<tr>
		    					<td>
		    						<input type = "text" class = "form-control" name="user_name" style="width:50%px" id = "user_name" placeholder="친구 검색" />
		    					</td>
								<td>
									<button type="submit" class="btn btn-primary" ><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
								</td>
		    				</tr>
		    			</table>
	    			</form>
				</ul>
		    	<ul class="nav navbar-nav" style="float:left;margin-left:100px">
		    		<li>
                        <p style="padding-top:15px"><a href="javascript:friend_home('1');" style="color:white" ><c:out value='${sessionScope.loginInfo.user_name}' /></a></p>
                    </li>
                    
                    <!-- <li>
                        <a href="javascript:logout();">logout</a>
                    </li>
                     -->
		    		<li>
                        <a href="javascript:friend_home('2');" style="color:white" >홈</a>
                    </li>
                    <li>
                        <a href="javascript:search_friend();" style="color:white" >친구찾기</a>
                    </li>
                    <!-- <li>
                        <a href="#contact">Contact</a>
                    </li> -->
		    	</ul>
		    	
		    	<ul class="nav navbar-nav" style="float:left">
			        <li class="dropdown">
			          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
			           <span class="caret"></span>
			           <!-- <img src="/resources/img/sns/triangle.png" width="15" height="15"/> -->
			           </a>
			          <ul class="dropdown-menu">
			            <!-- <li><a href="javascript:pageMoveTop('bbs/listBbs')">일반게시판</a></li>
			            <li role="separator" class="divider"></li> -->
			            <li><a href="javascript:logout();">logout</a></li>
			            <li role="separator" class="divider"></li>
			          </ul>
			        </li>
			        
			        
		    	</ul>
		    </div>

            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
<form role = "form" id="pageMoveForm" name="pageMoveForm" action="/page/move" method="post">
	<input type="hidden" id="pageName" name="pageName" />
	<input type="hidden" name=snsType id="topSnsType" value="">
</form>
<form role = "form" id="searchForm" name="searchForm" action="" method="post">
	<input type="hidden" id="search_user_no" name="user_no" value="<c:out value='${sessionScope.loginInfo.user_no}' />"/>
</form>
<form role = "form" id="login_form" name="login_form" action="" method="post">
	<input type="hidden" id="logout_user_no" name="user_no" value="<c:out value='${sessionScope.loginInfo.user_no}' />"/>
</form>
</body>
</html>