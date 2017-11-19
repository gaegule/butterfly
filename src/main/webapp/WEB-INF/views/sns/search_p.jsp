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
	
	function friend_add(userNo){
		if(!confirm("친구등록 하시겠습니까?"))
			return;
		
		$("#f_user_no").val(userNo);
		var callback = function(data){
			alert("insert callback");
			//sns_list_return(data);
			
			$("#div_user_"+userNo).remove();
		}
		
		ajax_form_post("/sns/friendAdd","friendAdd","SAVE","",callback);
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
				<div class="row"  style="border:1px solid black;width:496px">
					
					<c:if test="${!empty people_s}">
					
						<c:forEach var="peopleArr" items="${people_s}">
						<div style="width:100%;clear:both;" id="div_user_${peopleArr.user_no}">
						
							<div style="float:left;width:110px;height:110px">
								<a href="">
									<c:if test="${empty peopleArr.picture_url}">
									<img src="/resources/img/bbs/noavatar-blue.png"  style="width:100px"/>
									</c:if>
									<c:if test="${!empty peopleArr.picture_url}">
									<img src="${peopleArr.picture_url}" />
									</c:if>
								</a>
							</div>
							<div style="float:left;width:60%">
								<div style="clear:both;font-weight: bold">
									${peopleArr.user_name}
								</div>
								
								<c:if test="${!empty peopleArr.birthday}">
									<div style="clear:both">
										${peopleArr.birthday}
									</div>
								</c:if>
								<c:if test="${!empty peopleArr.city}">
									<div style="clear:both">
										${peopleArr.city}
									</div>
								</c:if>
								<c:if test="${!empty peopleArr.job}">
									<div style="clear:both">
										${peopleArr.job}
									</div>
								</c:if>
								<c:if test="${!empty peopleArr.email}">
									<div style="clear:both">
										${peopleArr.email}
									</div>
								</c:if>
							</div>
							<div>
								<button type="button" class="btn btn-info" onclick="friend_add('${peopleArr.user_no}')">친구추가</button>
							</div>
						</div>
						</c:forEach>
					</c:if>

				</div>
			</div>
			<div class="col-sm-4" style="border: 1px solid black;">
				<div class="row">
				</div>
			</div>
		    
		</div>

	</div>
	
	<form	name="friendAdd" id="friendAdd" action="" method="post">
		<input type="hidden" id="search_user_no" name="user_no" value="<c:out value='${sessionScope.loginInfo.user_no}' />"/>
		<input type="hidden" id="f_user_no" name="f_user_no" value=""/>
	</form>

	<form	name="pageMove" id="pageMove" action="/page/move" method="post">
		<input type="hidden" name="pageName" id="pageName" value="bbs/detailBbs">
		<input type="hidden" name="replyYn" id="replyYn" value="N">
		<input type="hidden" name="bbsNo" id="bbsNo" value="">	
	</form>

</body>
</html>