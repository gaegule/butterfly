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

		//menuFind(0);
	});

	function page_move(){
		document.pageMove.pageName.value = "bbs/insertBbs";
		$("#pageMove").submit();
	}

	function friend_cofirm(userNo){
		if(!confirm("친구등록 하시겠습니까?"))
			return;
		
		$("#t_user_no").val(userNo);
		var callback = function(data){
			alert("insert callback");
			//sns_list_return(data);
			
			$("#div_user_"+userNo).remove();
		}
		
		ajax_form_post("/sns/friendConfirm","friendAdd","SAVE","",callback);
	}
</script>
<style type="text/css">
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
		<div class="row div-body" style="">
			<%-- <div class="col-sm-2" style="height:525px">
				<jsp:include page="/WEB-INF/views/layout/bbs/left.jsp" flush="false"/>
			</div> --%>
			<div class="col-sm-1" >&nbsp;</div>
			<div class="col-sm-7"  style="border:1px solid #e5e5e5;background-color:white;border-collapse:collapse;min-height:500px">
			
					
					
					
	
						<c:if test="${!empty aFriend}">
						
							<div class="row" style="clear:both;padding-top:0px">
									<div class = "panel panel-success">
									   <div class = "panel-heading">
											<h3 class = "panel-title">친구요청에 답하기</h3>
									   </div>
									</div>
								</div>
						
							<div class="row"  style="border:1px solid red;">

							<c:forEach var="friendArr" items="${aFriend}">
							
								<div style="width:100%;clear:both;border-top:1px solid black;" id="div_user_<c:out value='${friendArr.user_no}' />">
								
									<div style="float:left;width:110px;height:110px;margin-top:3px">
										<a href="">
											<c:if test="${empty friendArr.picture_url}">
											<img src="/resources/img/bbs/noavatar-blue.png"  style="width:100px"/>
											</c:if>
											<c:if test="${!empty friendArr.picture_url}">
											<img src="${friendArr.picture_url}" />
											</c:if>
										</a>
									</div>
									<div style="float:left;width:60%;margin-top:3px">
										<div style="clear:both;font-weight: bold">
											${friendArr.user_name}
										</div>
										
										<c:if test="${!empty friendArr.birthday}">
											<div style="clear:both">
												${friendArr.birthday}
											</div>
										</c:if>
										<c:if test="${!empty friendArr.city}">
											<div style="clear:both">
												${friendArr.city}
											</div>
										</c:if>
										<c:if test="${!empty friendArr.job}">
											<div style="clear:both">
												${friendArr.job}
											</div>
										</c:if>
										<c:if test="${!empty friendArr.email}">
											<div style="clear:both">
												${friendArr.email}
											</div>
										</c:if>
									</div>
									<div style="float:left;margin-top:3px">
										<button type="button" class="btn btn-info" onclick="friend_cofirm('${friendArr.user_no}')">친구요청수락</button>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:if>
				
				<div class="row" style="clear:both;padding-top:15px">
					<div class = "panel panel-default">
					   <div class = "panel-heading">
							친구일지도 모르는..		
					   </div>
					</div>
				</div>
				
					
					<c:if test="${!empty rFriend}">
					<div class="row"  style="border:1px solid red;padding-top:10px">
						<c:forEach var="rFriendArr" items="${rFriend}">
						<div style="width:100%;clear:both;" id="r_div_user_${rFriendArr.user_no}">
						
							<div style="float:left;width:110px;height:110px">
								<a href="">
									<c:if test="${empty rFriendArr.picture_url}">
									<img src="/resources/img/bbs/noavatar-blue.png"  style="width:100px"/>
									</c:if>
									<c:if test="${!empty rFriendArr.picture_url}">
									<img src="${rFriendArr.picture_url}" />
									</c:if>
								</a>
							</div>
							<div style="float:left;width:60%">
								<div style="clear:both;font-weight: bold">
									${rFriendArr.user_name}
								</div>
								
								<c:if test="${!empty rFriendArr.birthday}">
									<div style="clear:both">
										${rFriendArr.birthday}
									</div>
								</c:if>
								<c:if test="${!empty rFriendArr.city}">
									<div style="clear:both">
										${rFriendArr.city}
									</div>
								</c:if>
								<c:if test="${!empty rFriendArr.job}">
									<div style="clear:both">
										${rFriendArr.job}
									</div>
								</c:if>
								<c:if test="${!empty rFriendArr.email}">
									<div style="clear:both">
										${rFriendArr.email}
									</div>
								</c:if>
							</div>
							<div>
								<button type="button" class="btn btn-info" onclick="friend_add('${rFriendArr.user_no}')">친구요청</button>
							</div>
						</div>
						</c:forEach>
						</div>
					</c:if>
				
			</div>
			<div class="col-sm-4" style="border: 1px solid black;">
				<div class="row">
				</div>
			</div>
		    
		</div>

	</div>

	<form	name="friendAdd" id="friendAdd" action="" method="post">
		<input type="hidden" id="search_user_no" name="user_no" value="<c:out value='${sessionScope.loginInfo.user_no}' />"/>
		<input type="hidden" id="t_user_no" name="t_user_no" value=""/>
	</form>
	
	<form	name="pageMove" id="pageMove" action="/page/move" method="post">
		<input type="hidden" name="pageName" id="pageName" value="bbs/detailBbs">
		<input type="hidden" name="replyYn" id="replyYn" value="N">
		<input type="hidden" name="bbsNo" id="bbsNo" value="">	
	</form>

</body>
</html>