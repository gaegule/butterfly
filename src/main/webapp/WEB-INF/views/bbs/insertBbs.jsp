<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="/WEB-INF/views/include/includeBbs.jsp" flush="true"/>
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
			
			//alert("maxSeq === "+maxSeq);

			$("#bbsNo").val(maxSeq);

			$("#pageName").val("bbs/detailBbs");
			$("#form").attr('action','/page/move').submit();

		}
		
		function bbs_list(){
			$("#pageName").val("bbs/listBbs");
			$("#form").attr('action','/page/move').submit();
		}
		
		function bbs_detail(){

			ajax_form_post("/bbs/detail","form","DETAIL","","");
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
			ajax_form_post("/bbs/detail","form","REPLY","",callback,"");
		}
		
		$(document).ajaxStart(function() {
		    //alert("start");
		}).ajaxComplete(function(){
			//alert("end");
		});
		
		function attachFileDetail_add(data){
			
			var fileHtml = "";

			//var attachPath="C:/spring-tool-suite-3.7.3/sts-bundle/workspace/butterfly/src/main/webapp/bbsFile/";
			for(var i=0; i<data.length; i++){
				fileHtml = "";
				fileHtml += " <li> ";
				fileHtml += " <i class='fa fa-floppy-o fa-fw'></i> ";
				fileHtml += " <a href='/com/fileDownload?fileName="+data[i].orginal_file_nm+"' target='_blank' download>"+data[i].orginal_file_nm	+"</a> ";
				fileHtml += " <span class='rb-size'>"+data[i].file_size+"KB</span> ";
				fileHtml += " <mark onclick=x_mark_click('"+data[i].orginal_file_nm+"','"+data[i].attach_file_no+"','"+data[i].attach_file_seq+"','"+(i+1)+"') style=cursor:pointer>X</mark> ";
				fileHtml += " </li> ";

				$("#attachDiv"+(i+1)).html(fileHtml);
				$("#attachFlieDiv"+(i+1)).empty();

			}
			
			return fileHtml;
		
		}
		
		function x_mark_click(name,num,seq,sun){
			//alert(name+" // "+num+" // "+seq);
			if(confirm(name+" 을 삭제하시겠습니까.")){
				attach_delete(name,num,seq,sun);
			}
		}
		
		function attach_delete(name,num,seq,sun){
			var callback = function(data){
				//attachDel_callback(data);
				alert(data.reVal);
				if(data.reVal == 0){
					alert("파일을 삭제하였습니다.");
					$("#attachDiv"+(sun)).empty();
					$("#attachFlieDiv"+sun).html("<input type='file' name='attachFile' >");
					
				}else
					alert("파일을 삭제하지 못하였습니다.");
			}
			
			$("#attachFileNoDel").val("");
			$("#attachFileSeqDel").val("");
			
			$("#attachFileNoDel").val(num);
			$("#attachFileSeqDel").val(seq);
			ajax_form_post("/bbs/attachDelete","attachForm","callBack","",callback,"");
		}
		
		function attach_click1(){
			
			//alert("click");
			//return false;
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
			<div class="row" style="border: 0px solid black;">
			<div class="col-xs-12 top-menu-block">
				<c:import url="/com/layout/top"></c:import>
			</div>
		</div>
		<div class="row div-body" style="border: 0px solid black;">
			<div class="col-sm-2" style="border-right:1px solid black;height:525px">
					<jsp:include page="/WEB-INF/views/layout/bbs/left.jsp" flush="false"/>
				</div>
				<div class="col-sm-10">
	
					<div class="row">
						<div class="col-sm-1">
						</div>
						<div class="col-sm-9 well">

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
							   <div style="clear:both">
							   	<div id="attachDiv1" style="float:left;width:250px"></div>
							   	<div id="attachFlieDiv1" style="float:left"><input type="file" name="attachFile"></div>
							   </div>
							   <div style="clear:both">
							   	<div id="attachDiv2" style="float:left;width:250px"></div>
							   	<div id="attachFlieDiv2" style="float:left"><input type="file" name="attachFile"></div>
							   </div>
							   
							</div>
							<div class="row">&nbsp;</div>
							<div class="row">
								<div class="col-sm-2 col-md-2 col-lg-2"">
									<button type = "button" onclick="bbs_list()" class = "btn btn-default">목록</button>
								</div>
								<div class="col-sm-8 col-md-8 col-lg-8"">&nbsp;</div>
								<div class="col-sm-2 col-md-2 col-lg-2"">
									<button type = "button" onclick="bbs_insert()" class = "btn btn-default">등록</button>
								</div>
							</div>
								
						</div>
						<div class="col-sm-2">
						</div>
	
					</div>
				</div>
			</div>
			<div class="row" style="border: 0px solid black;">
				<div class="col-md-12">bottom</div>
			</div>
		</div>
	</form>

	<form role = "form" id="attachForm" name="attachForm" action="" method="post">
		<input type="hidden" name="attach_file_no" id="attachFileNoDel" value="">
		<input type="hidden" name="attach_file_seq" id="attachFileSeqDel" value="">
	</form>
</body>
</html>