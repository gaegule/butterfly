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
<script type="text/javascript" src="/resources/js/common.js"></script>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>

<script>
		$(document).ready(function(){
			//alert("ready");
			//$('.dropdown-toggle').dropdown()
			CKEDITOR.replace("content");

			if($("#bbsNo").val() != ""){

				if($("#replyYn").val() == "N")
					bbs_detail();
				else
					bbs_reply();
			}
			//alert($("#test").val())
		});

		
		function bbs_insert(){
			if(!confirm("등록하시겠습니까?"))return;
			$("#contentVal").val(CKEDITOR.instances.content.getData());
			var callback = function(data){
				insert_callback(data);
			}
			ajax_form_post2("/bbs/save2","insertBbs","SAVE","",callback);
		}
		
		function insert_callback(maxSeq){

			$("#bbsNo").val(maxSeq);

			$("#pageName").val("bbs/detailBbs");
			$("#form").attr('action','/page/move').submit();

		}
		
		function bbs_list(){
			$("#pageName").val("bbs/listBbs");
			$("#form").attr('action','/page/move').submit();
		}
		
		function bbs_detail(){

			ajax_form_post("/bbs/detail","form","DETAIL","");
		}
		
		function reply_callback(data){
			
			
			
			$("#title").val("Re : "+data.title);
			$("#bbsId").val(data.no);
			$("#grp").val(data.grp);
			$("#seq").val(data.seq);
			$("#lvl").val(data.lvl);
			
			//alert(data.no + " // " + data.grp + " // " + data.seq + " // " + data.lvl + " // " );
		}
		
		function bbs_reply(){

			var callback = function(data){
				reply_callback(data);
			}
			ajax_form_post("/bbs/detail","form","REPLY","",callback);
		}
		
		$(document).ajaxStart(function() {
		    //alert("start");
		}).ajaxComplete(function(){
			//alert("end");
		});
		
		function ajax_form_post2(urlA,formId,type,tableNm,callback){
			$.ajax({
			    url : urlA,
			    //dataType : "json",
			    dataType : "text",
			    type : "post",
			    data : $('#'+formId).serializeArray(),
			    //new FormData('form')
			    success: function(data) {

			        if(type == "LIST"){
			        	//alert(JSON.stringify(data));
			        	$(tableNm).bootstrapTable({
			                data: data.list
			            });
			        }else if(type == "SAVE"){
			        	if(typeof callback =="function"){
			        		callback(data.maxSeq);
			        	}
			        }else if(type == "DETAIL" || type == "DETAIL2"){
			        	//alert(Object.keys(data.detail).length);
			        	//alert(JSON.stringify(data.detail));
			        	
			        	$.each(data.detail, function(key, val) {
			        	    //$('#a').html($('#a').html() + "키 : "+key+" , 값 : "+val+"<br>");
			        	    //alert($("#title").val());
			        	    if(type == "DETAIL")
			        	    	$("#"+key).val(val);
			        	    else{
			        	    	if(key == "content")
			        	    		$("#"+key).html(val);
			        	    	else
			        	    		$("#"+key).text(val);
			        	    }
			        	    	
			        	});

			        }else if(type == "DELETE"){
			        	//alert("ajaxDelete===="+data.reVal);
			        	if(typeof callback =="function"){
			        		callback();
			        	}
			        }else if(type == "REPLY"){
			        	
			        	if(typeof callback =="function"){
			        		callback(data.detail);
			        	}
			        	
			        }
			    },
			    error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"error:"+error);
			    }
			 
			});
		}

</script>
</head>
<body>
	<form role = "form" id="form" name="form" action="" method="post">
		<input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value='${reParam.bbsNo}' />">
		<input type="hidden" name="pageName" id="pageName" value="">
	</form>
	<form	name="insertBbs" id="insertBbs" action="/bbs/save" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="replyYn" id="replyYn" value="<c:out value='${reParam.replyYn}' />" />
		<input type="hidden" name="bbsId" id="bbsId" value="<c:out value='${reParam.bbsNo}' />" />
		<input type="hidden" name="grp" id="grp" value="<c:out value='${reParam.grp}' />" />
		<input type="hidden" name="seq" id="seq" value="<c:out value='${reParam.seq}' />" />
		<input type="hidden" name="lvl" id="lvl" value="<c:out value='${reParam.lvl}' />" />
		
		<div class="container-fluid" >
			<div class="row" style="border: 1px solid black;">
				<div class="col-xs-12">
					<!-- <h2>bootstrap top menu</h2> -->
					<jsp:include page="../layout/top.jsp" flush="false"/>
					
				</div>
			</div>
			<div class="row" style="border: 1px solid black;height:650px">
				<div class="col-sm-2" style="border-right:1px solid black;height:450px">
					왼쪽메뉴
				</div>
				<div class="col-sm-10">
	
					<div class="row">
						<div class="col-sm-10 well">

								<div class = "form-group">
									<div class="row">
										<div class="col-sm-12">				   		
											<label for = "winner_nm">제목</label>
											<input type = "text" class = "form-control" name="title" id = "title" placeholder = "제목을 입력하세요.">
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6">				   		
											<label for = "winner_nm">작성자</label>
											<input type = "text" class = "form-control" name="nm" id = "nm" >
										</div>
										<div class="col-sm-6">				   		
											<label for = "winner_nm">비밀번호</label>
											<input type = "password" class = "form-control" name="passw" id = "passw" >
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12">				   		
											<label for = "winner_nm">내용</label>
											<textarea  rows=10 cols=60 name="content" id = "content" ></textarea>
										</div>
									</div>
								</div>
							   <textarea style="display:none" name="contentVal" id = "contentVal" ></textarea>
							   <div class = "form-group">
							      <label for = "inputfile">첨부파일</label>
							      <input type = "file" id = "attachFile">
							      
							   </div>
	
								<div class="row">
									<div class="col-sm-2">
										<button type = "button" onclick="bbs_list()" class = "btn btn-default">목록</button>
									</div>
									<div class="col-sm-8"></div>
									<div class="col-sm-2">
										<button type = "button" onclick="bbs_insert()" class = "btn btn-default">등록</button>
									</div>
								</div>
								
						</div>
						<div class="col-sm-2">
						</div>
	
					</div>
				</div>
			</div>
			<div class="row" style="border: 1px solid black;">
				<div class="col-md-12">bottom</div>
			</div>
		</div>
	</form>

</body>
</html>