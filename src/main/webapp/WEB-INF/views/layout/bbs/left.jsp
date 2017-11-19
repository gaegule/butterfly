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
		$("#menu-toggle").click(function(e) {
	        e.preventDefault();
	        $("#wrapper").toggleClass("toggled");
	    });
	});
	
	function pageMoveLeft(pageNm){

		$("#pageName").val(pageNm);
		$("#pageMoveForm").submit();
	}


</script>

</head>
<body>

	<div id="wrapper">

        <!-- Sidebar -->
        <div id="sidebar-wrapper" style="">
            <ul class="sidebar-nav">
                <!-- <li class="sidebar-brand">
                    <a href="#">
                    	게시판
                    </a>
                </li> -->
                <li>
                    <div style="float:left"><img id="picture1" src="/resources/img/bbs/noavatar-blue.png" width="15" height="15"/></div>
                    <div style="float:left;margin-left:0px;align:left"><a href="javascript:friend_home('1')"><c:out value='${sessionScope.loginInfo.user_name}' /></a></div>
                </li>
                <li style="clear:both">
                    <a href="#">메뉴준비중</a>
                </li>
                
            </ul>
        </div>
    </div>

</body>
</html>