<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/views/include/includeSns.jsp" flush="true"/>
<script>

	var snsPageCnt=0;
	$(document).ready(function(){
		
		menuFind(0);
	});
	
	$(function(){
	      
	});

	function page_move(){
		//$("#pageName").val("bbs/insertBbs");
		document.pageMove.pageName.value = "bbs/insertBbs";
		//alert($("#pageName").val());
		$("#pageMove").submit();
	}

	
	function menuFind(pageIdx){
		
		var callback = function(data){
			sns_list_return(data);
		}
		$("#pageStart").val(pageIdx);

		ajax_form_post("/sns/snsFriendList","fForm","FLIST","table",callback,pageIdx);
	}

	function sns_list_return(data){
		
		var dataLen = data.length;
		var friendList = '';
		if(dataLen > 0){

			for(var i=0; i<dataLen; i++){
				
			var dataRe = (i+1) % 2;
			
			//alert(dataRe);

			if(dataRe == 1)
			friendList += '<div style="height:80px;clear:both"> ';
				
			friendList += '<div class="friend_div" style=""> ';
				friendList += ' <div class="col-sm-2 friend_div_img" style=""> ';
				if(data[i].picture_url =="" || data[i].picture_url =="null" || data[i].picture_url ==null)
					friendList += '<img id="picture1" src="/resources/img/bbs/noavatar-blue.png" width="70" height="70"/> ';
				else
					friendList += '<img id="picture1" src="'+data[i].picture_url+'" width="70" height="70"/> ';
				friendList += '</div> ';
				friendList += '<div class="col-sm-10 friend_ul" style=""> ';
					friendList += '<div style="float:left;width:70%"> '; 
						friendList += '<ul> ';
							friendList += '<li>'+data[i].user_name+' ('+data[i].status+')	</li> ';
							friendList += '<li>'+data[i].birthday+'</li> ';
							friendList += '<li>'+data[i].email+'</li> ';
						friendList += '</ul> ';
					friendList += '</div> ';
					friendList += '<div style="float:left;margin-top:3px">버튼</div> ';
				friendList += '</div> ';
			friendList += '</div> ';
			
			if((i+1) == dataLen && dataRe == 1){
				
				friendList += '<div class="friend_div" style=""> ';
				friendList += '</div> ';
			}
			
			if(dataRe == 0)
			friendList += '</div> ';
			
			//alert(friendList);
			}
		}
		
		//alert(friendList);
		$("#snsFriendList").empty();
		$("#snsFriendList").html(friendList);
		
	}

	
	function fn_go(type){
		
		if(type == 1){
			
			document.pageMove.pageName.value = "/sns/listSns";
			//document.pageMove.action="/sns/snsList";
			//alert();
			$("#snsType").val("Y");
			$("#pageMove").submit();
		}
	}
	
</script>
<style type="text/css">
	HTML { 
		height: 100%;
	}
	BODY { 
		height: 100%;
	}
	.top-menu-block{
		height:55px
	}
	.paging-center {
		left:33%
	}
	.div-body {
		height:525px
	}
	.file_input_txt{
		float:left;height:25px;
	}
	.file_input_div{
		position:relative;width:80px;height:80px;overflow:hidden;border:2px dashed #dddfe2;
	}
	.file_input_div2{
		position:relative;width:100px;height:30px;overflow:hidden;border:1px #dddfe2;
	}
	.file_input_btn{
		padding-left:0px
	}
	.file_input_hidden {
	    font-size:50px;
	    position:absolute;
	    right:0px;
	    top:0px;
	    opacity:0;
	    filter: alpha(opacity=0);
	    -ms-filter: alpha(opacity=0);
	    cursor:pointer;
	}
	.slider_preview_div{

		background:url('/resources/img/sns/preview.png') no-repeat center;
		height:300px;
		width:30px
	}
	.slider_next_div{

		background:url('/resources/img/sns/next.png') no-repeat center;
		height:300px;
		width:30px
	}
	.img_max_small{
		width:auto;height:auto;max-width:500px;max-height:500px
	}
	.cover_tab ul{
		border-collapse:collapse;
		border-left:1px solid #e9eaed;
		list-style-type:none;
		margin:0;
		padding:0;
	}
	.cover_tab li{
		/* list-style-type:none; */
		display:list-item;
		border-left:1px solid #e9eaed;
		border-right:1px solid #e9eaed;
		margin: 0 0 0 0;
	    padding: 0 0 0 0;
	    float: left;height:100%
	}
	.cover_tab li a{
		padding:0 17px;
		height:40px;
		position:relative;
		vertical-align:middle;
		line-height:3
	}
	
	
	.friend_div{
		width:50%;height:80px;border:1px solid black;float:left
	}
	.friend_div_img{
		height:80px;margin-top:4px
	}
</style>
</head>
<body>

	<div class="container-fluid" style="background-color:#e9ebee">
		<div class="row" style="">
			<div class="col-xs-12 top-menu-block">
				<%-- <jsp:include page="/WEB-INF/views/layout/bbs/top.jsp" flush="false"/> --%>
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
		<div style="position:absolute;top:80px;left:30px">
			<img id="picture1" src="/snsImage/2016/11/01/47b31f88-cb45-4eb0-a152-d2efa69eedb6/thumb_2014-12-04_093B473B15.jpg" width="140" height="140"/>
		</div>
		<div style="position:absolute;top:150px;left:140px">
			<ul style="font-size:24px;line-height:30px">
				<li>
					<c:out value='${sessionScope.loginInfo.user_name}' /> <c:out value='${reParam.snsType}' />
				</li>
			</ul>
		</div>
		<div class="row" style="height:50px">
			<div class="col-sm-8" style="background-color:white">
				<div class="row" style="border:1px solid black;height:50px">
					<div class="col-sm-3">
						
					</div>
					
					<div class="col-sm-6 cover_tab">
						<ul style="">
							<li style=""><a href="javascript:fn_go(1)" style="">타임라인</a></li>
							<li style=""><a href="javascript:fn_go(2)" style="">친구</a></li>
							<li style=""><a href="javascript:fn_go(3)" style="">사진</a></li>
							<li style=""><a href="javascript:fn_go(4)" style="">이벤트</a></li>
						</ul>
					</div>
					
					<div class="col-sm-3">
						
					</div>
				</div>
				
			</div>
			<div class="col-sm-4" style="">
			</div>
		</div>
		<div class="row div-body" style="">
			
			<div class="col-sm-8"  style="border:1px solid #e5e5e5;background-color:white;border-collapse:collapse">
				<div class="row" style="border:1px solid red;padding:10px 0px 20px 0px">
					
				</div>

				<div class="row" id="snsFriendList">
					<!--<div style="height:80px;clear:both">
						 <div class="friend_div" style="">
							 <div class="col-sm-2 friend_div_img" style="">
								<img id="picture1" src="/snsImage/2016/11/01/47b31f88-cb45-4eb0-a152-d2efa69eedb6/thumb_2014-12-04_093B473B15.jpg" width="70" height="70"/>
							</div>
							<div class="col-sm-10 friend_ul" style="">
								<div style="float:left;width:70%"> 
									<ul>
										<li>김태원</li>
										<li>친구11명</li>
									</ul> 
								</div>
								<div style="float:left;margin-top:3px">버튼</div>
							</div>
						</div>
						<div style="width:50%;height:80px;border:1px solid black;float:left">
							 <div class="col-sm-4" style="height:80px">
								<img id="picture1" src="/snsImage/2016/11/01/47b31f88-cb45-4eb0-a152-d2efa69eedb6/thumb_2014-12-04_093B473B15.jpg" width="70" height="70"/>
							</div>
							<div class="col-sm-8" style="">
								<div style="float:left"> 김태원 </div>
								<div style="float:right">버튼</div>
							</div> 
						</div> 
					</div>-->
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
	<form role = "form" id="fForm" name="fForm" action="" method="post">
		<input type="hidden" name="snsType" id="snsType2" value="<c:out value='${reParam.snsType}' />">
		<input type="hidden" name="user_no" id="user_no" value="<c:out value='${sessionScope.loginInfo.user_no}' />"/>
	</form>
	<form	name="pageMove" id="pageMove" action="/page/move" method="post">
		<input type="hidden" name="pageName" id="pageName" value="bbs/detailBbs">
		<input type="hidden" name="replyYn" id="replyYn" value="N">
		<input type="hidden" name="snsType" id="snsType" value="<c:out value='${reParam.snsType}' />">	
	</form>

</body>
</html>