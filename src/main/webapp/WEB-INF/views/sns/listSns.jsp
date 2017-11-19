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
		//alert("ready");
		//$('.dropdown-toggle').dropdown()
		/* $('#snsFile').change(function(){
			imgAjaxUpload();
		}); */
		//$('#snsFile').on("change", function(){ imgAjaxUpload(); });
		
		/* $("img[name='pic']").click(function(){
			alert("click");
		}); */

		$('.h-max-div').css('height', $(document).height()-56)
		
		$(window).resize(function() { 
			$('.h-max-div').css('height', $(window).height()-56)
		});
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
	
	function imgAjaxUpload(){

		/* var callback = function(data){
			image_callback(data);
		}
	
		ajax_form_post3("/sns/imageTemp","imgForm","SAVE","",callback) */
		
		//try {
			var f = document.imgForm;
			f.action="/sns/imageTemp";
			f.target="hiddenframe";
			f.submit();
		//}catch(e){
		//	alert(e);
		//}
		
	}
	
	function imgAjaxUpload_U(){

		var f = document.imgUpd;
		f.action="/sns/imageUpd";
		f.target="hiddenframe";
		f.submit();
		
		
		/*
		var imageName = "";

		imageName = "/snsImage/2017/04/04/fbaf388b37a34dbbbcab557f28c67f5f/thumb__미녀와얏.jpg";

		var divImageVal= "";

		var imageCnt = 0;
		var imageId = 0;
		$('#modalImgBody .tet1').each(function(idx,item) {
			imageCnt++;
			var imageIdTmp = $(item).attr("id");
			console.log("imageIdTmp =========== "+ imageIdTmp);
			imageId = imageIdTmp.replace("img_","");
			console.log("imageId =========== "+ imageId);
			imageId = parseInt(imageId)+1;
		});
		*/
		/*divImageVal='<div class="tet1" id="img_1" style="float:left;width:82px;height:80px;border:1px solid #e5e5e5;">';
		divImageVal+='<div style="float:left;width:60px;">';
		divImageVal+='<img id="picture1" src="'+imageName+'" />';
		divImageVal+='</div>';
		divImageVal+='<div style="float:left;width:20px;">';
		divImageVal+='<img width="18px" name="pic" src="/resources/img/main/xicon.png" onclick="delete_img(1);"/>';
		divImageVal+='</div>';
		divImageVal+='</div>';
		*/
		/*
		divImageVal='<div class="tet1" id="img_'+imageId+'" style="float:left;width:82px;height:80px;border:1px solid #e5e5e5;">';
		divImageVal+='<div style="float:left;width:60px;">';
		divImageVal+='<img id="picture1" src="'+imageName+'" />';
		divImageVal+='</div>';
		divImageVal+='<div style="float:left;width:20px;">';
		divImageVal+='<img width="18px" name="pic" src="/resources/img/main/xicon.png" onclick="delete_img('+imageId+');"/>';
		divImageVal+='</div>';
		divImageVal+='</div>';

		if(typeof $("#modalImgBody div").html() == "undefined"){

			$("#modalImgBody").html(divImageVal);
		}else{
			//alert($("#divPicture .tet1").html());
			
			$("#modalImgBody .tet1").last().after(divImageVal);
			//alert($("#divPicture .tet1").html());
		}
		*/
	}
	
	
	function image_callback(data){
		alert("image 111");
	}
	
	function menuFind(pageIdx){
		
		var callback = function(data){
			sns_list_return(data);
		}
		$("#pageStart").val(pageIdx);

		ajax_form_post("/sns/snsList","form","SNSLIST","table",callback,pageIdx);
	}

	
	/***
	* ajax insert attach 
	***/
	function ajax_form_post3(urlA,formId,type,tableNm,callback){
	
		alert("ajax2");
		
		var obj = $("#imgForm");
	
		var data = new FormData();
		
		alert("ajax3"+obj);
		
		$.each($(obj).find("input[type='file']"), function(i, tag) {
			alert(i);
	        $.each($(tag)[0].files, function(i, file) {
	        	alert(file);
	        	data.append(tag.name, file);
	        });
	        //data.append(tag.name,$("input[name="+tag.name+"]")[i].files[0]);
	    });
		
		var dataParam = $(obj).serializeArray();
	    $.each(dataParam, function (i, val) {
	    	data.append(val.name, val.value);
	    });
		
	    $.ajax({
	        url: urlA,
	        type: "post",
	        dataType: "text",
	        data: data,
	        // cache: false,
	        processData: false,
	        contentType: false,
	        success: function(data, textStatus, jqXHR) {
	        	if(typeof callback =="function"){
	        		alert(data);
	        		callback(data);
	        	}
	        }, error: function(jqXHR, textStatus, errorThrown) {}
	    });
	}
	
	
	
	
	function iframe_return(rePicVal){
		
		var attachFileNoVal = "";
		for(var i=0; i < rePicVal.length; i++){
			var imageName = "";

			imageName = rePicVal[i].file_path+"thumb_"+rePicVal[i].orginal_file_nm

			var divImageVal= "";

			var imageCnt = 0;
			var imageId = 0;
			$('#divPicture .tet1').each(function(idx,item) {
				imageCnt++;
				var imageIdTmp = $(item).attr("id");
				console.log("imageIdTmp =========== "+ imageIdTmp);
				imageId = imageIdTmp.replace("img_","");
				console.log("imageId =========== "+ imageId);
				imageId = parseInt(imageId)+1;
			});

			divImageVal='<div class="tet1" id="img_'+imageId+'" style="float:left;width:82px;height:80px;border:1px solid #e5e5e5;">';
			divImageVal+='<div style="float:left;width:60px;">';
			divImageVal+=imageId+'<img id="picture1" src="'+imageName+'" />';
			divImageVal+='</div>';
			divImageVal+='<div style="float:left;width:20px;">';
			divImageVal+='<img width="18px" name="pic" src="/resources/img/main/xicon.png" onclick="delete_img('+imageId+');"/>';
			divImageVal+='</div>';
			divImageVal+='</div>';

			if(typeof $("#divPicture div").html() == "undefined"){

				$("#divPicture").html(divImageVal);
			}else{
				//alert($("#divPicture .tet1").html());
				
				$("#divPicture .tet1").last().after(divImageVal);
				//alert($("#divPicture .tet1").html());
			}
			attachFileNoVal = rePicVal[i].attach_file_no;
			
			/*
			var imageCnt =0;
			$('#divPicture .tet1').each(function() {
				imageCnt++;
			});
			
			divImageVal='<div class="tet1" id="imgDiv'+imageCnt+'" style="float:left;width:82px;height:80px;border:1px solid #e5e5e5;">';
			divImageVal+='<div style="float:left;width:60px;">';
			divImageVal+='<img id="picture1" src="'+imageName+'" />';
			divImageVal+='</div>';
			divImageVal+='<div style="float:left;width:20px;">';
			divImageVal+='<img width="18px" id="pic" src="/resources/img/main/xicon.png" onclick="delete_img('+rePicVal[i].attachFileNo+', '+imageCnt+');"/>';
			divImageVal+='</div>';
			divImageVal+='</div>';

			alert(typeof $("#divPicture div").html());
			
			if(typeof $("#divPicture div").html() == "undefined")
				$("#divPicture").html(divImageVal);
			else
				$("#divPicture div").last().after(divImageVal);;
			
			//$("#divPicture").last().after(divImageVal);
			attachFileNoVal = rePicVal[i].attachFileNo;
			*/
		}
		//alert(imageName);
		$("#attachFileNo").val(attachFileNoVal);
		
	}
	
	
	function iframe_return_u(rePicVal){
		
		alert("111111");
		var attachFileNoVal = "";
		alert("22222222");
		alert("rePicVal.length=="+rePicVal.length);
		for(var i=0; i < rePicVal.length; i++){
			
			alert(rePicVal[i].file_path + " // " +rePicVal[i].orginal_file_nm);
			
			var imageName = "";

			imageName = rePicVal[i].file_path+"/"+"thumb_"+rePicVal[i].orginal_file_nm

			var divImageVal= "";

			var imageCnt = 0;
			var imageId = 0;
			$('#modalImgBody .tet1').each(function(idx,item) {
				imageCnt++;
				var imageIdTmp = $(item).attr("id");
				console.log("imageIdTmp =========== "+ imageIdTmp);
				imageId = imageIdTmp.replace("img_","");
				console.log("imageId =========== "+ imageId);
				imageId = parseInt(imageId)+1;
			});

			divImageVal='<div class="tet1" id="img_'+imageId+'" style="float:left;width:82px;height:80px;border:1px solid #e5e5e5;">';
			divImageVal+='<div style="float:left;width:60px;">';
			divImageVal+=imageId+'<img id="picture1" src="'+imageName+'" />';
			divImageVal+='</div>';
			divImageVal+='<div style="float:left;width:20px;">';
			divImageVal+='<img width="18px" name="pic" src="/resources/img/main/xicon.png" onclick="delete_img('+imageId+');"/>';
			divImageVal+='</div>';
			divImageVal+='</div>';

			if(typeof $("#modalImgBody div").html() == "undefined"){

				$("#modalImgBody").html(divImageVal);
			}else{
				//alert($("#divPicture .tet1").html());
				
				$("#modalImgBody .tet1").last().after(divImageVal);
				//alert($("#divPicture .tet1").html());
			}
			attachFileNoVal = rePicVal[i].attach_file_no;
		}
		$("#attachFileNo_u").val(attachFileNoVal);
		
	}
	
	function sns_detail_attach(rePicVal){
		
		var attachFileNoVal = "";
		//alert(rePicVal.length);
		var picCnt=0;
		picCnt=rePicVal.length;
		picCnt=picCnt-1;
		for(var i=0; i < rePicVal.length; i++){
			var imageName = "";

			imageName = rePicVal[i].file_path+"/"+"thumb_"+rePicVal[i].orginal_file_nm

			var divImageVal= "";

			var imageCnt = 0;
			var imageId = 0;
			$('#divPicture .tet1').each(function(idx,item) {
				imageCnt++;
				var imageIdTmp = $(item).attr("id");
				console.log("imageIdTmp =========== "+ imageIdTmp);
				imageId = imageIdTmp.replace("img_","");
				console.log("imageId =========== "+ imageId);
				imageId = parseInt(imageId)+1;
			});

			divImageVal='<div class="tet1" id="img_'+i+'" style="float:left;width:84px;height:80px;border:1px solid #e5e5e5;">';
			divImageVal+='<div style="float:left;width:60px;">';
			divImageVal+='&nbsp; <img style="" id="picture1" src="'+imageName+'" />';
			divImageVal+='</div>';
			divImageVal+='<div style="float:left;width:20px;">';
			divImageVal+='<img width="18px"  name="pic" src="/resources/img/main/xicon.png" onclick="delete_img_u('+i+');"/>';
			divImageVal+='</div>';
			divImageVal+='<div id="del_img_'+i+'" style="display:none;width:60px;height:60px;position:relative; top:18px;background-image:url(/resources/img/main/xback.png);opacity:0.6;" />';
			divImageVal+='</div>';
			
			if(picCnt == i){
				
				divImageVal+='<div style="float:left;width:80px;padding-left:5px">';
				divImageVal+='<div class="file_input_div">';
				divImageVal+='<img src="/resources/img/main/img_btn.png" class="file_input_btn" alt="open" />';
				divImageVal+='<input type="file" name="snsFile_u" class="file_input_hidden"  onchange="imgAjaxUpload_U();"/>';
				divImageVal+='</div>';
				divImageVal+='</div>';
			}
			

			if(i ==0)
				$("#modalImgBody").empty();

			if(typeof $("#modalImgBody div").html() == "undefined"){
				
				$("#modalImgBody").html(divImageVal);
			}else{
				
				$("#modalImgBody .tet1").last().after(divImageVal);
			}
			attachFileNoVal = rePicVal[i].attach_file_no;

		}

		$("#snsAttachFileNo_u").val(attachFileNoVal);
		
		$("#attach_file_no_d").val(attachFileNoVal);
		
		
	}
	

	function sns_insert(){
		
		if($("#profile_msg_div").text() == ""){
			
			alert("글을 등록해주세요. 제바~알!");
			$("#profile_msg_div").focus();
			return;
		}

		$("#snsAttachFileNo").val($("#attachFileNo").val());
		$("#profile_msg").val($("#profile_msg_div").html());
		
		$("#pageStart").val(0);
		var callback = function(data){
			//alert("insert callback");
			sns_list_return(data);
		}
		
		ajax_form_post("/sns/save","form","SNSSAVE","",callback);

	}
	
	function delete_img(val){
		
		alert("testetsetsetsetestts=="+imgNo + " // "+ seq);
		
		console.log("val =========== "+ val);
		console.log($("#img_"+val).html());
		$("#img_"+val).remove();
	}
	
	function delete_img_u(val){
		
		//alert("display=="+" // " +val+$("#del_img_"+val).css("display"));

		if($("#del_img_"+val).css("display") == "none"){
			$("#del_img_"+val).show();
		}else{
			$("#del_img_"+val).hide();
		}
	}
	
	
	function imgDelete_callback(){
		
		
	}
	
	// 등록 후 목록 못 불러오는 문제 부터 해야함.
	function sns_list_return(dataList){
		
		var snsListHtml ='';
		
		var snsNumMax = 0;
		
		var data = dataList.list;
		
		///alert("data=="+typeof data);

		$("#attachFileNo").val("");
		$("#snsFile").val("");
		$("#profile_msg_div").text("");
		$("#profile_msg").text("");
		$("#divPicture").html("");

		//alert("data.length=="+data.length);
		
		for(var i=0; i<data.length; i++){

			var imgFileLoc = data[i].sns_img_file;
			var imgArr= null;
			var imgCnt = 0;

			if("" != imgFileLoc){
				
				imgArr = imgFileLoc.split(",");
				imgCnt = imgArr.length;
			}

			snsListHtml += ' <div class="row" > ';
				snsListHtml += ' <div style="width:10%;float:left">&nbsp;</div>';
				snsListHtml += ' <div style="width:10%;float:left">';
				snsListHtml += ' 	<img src="/resources/img/bbs/noavatar-blue.png" style="width:35px;margin-top:20px" /> ';
				snsListHtml += ' </div> ';
				snsListHtml += ' <div style=";margin-top:20px;width:70%;float:left;font-size:18px">'+data[i].user_name+'</div>';
				snsListHtml += ' <div  style="width:10%;float:left">&nbsp;</div>';
			snsListHtml += ' </div> ';
			snsListHtml += ' <div class="row" > ';
				snsListHtml += ' <div class="col-md-1 col-lg-1 visible-md visible-lg">&nbsp;</div>';
				snsListHtml += ' <div class="col-sm-3 col-md-1 col-lg-1">';
				//if(imgCnt > 1)
					//snsListHtml += ' <div class="slider_preview_div" onclick="preview_click('+data[i].sns_profile_no+')"></div>	';
				snsListHtml += ' </div> ';
				snsListHtml += ' <div class="col-sm-6 col-md-8 col-lg-8" style="margin:20px 10px 5px 0px;overflow:hidden;word-wrap:break-word"> ';
				snsListHtml += ' 	<div class="row" > ';

			//alert(imgArr.length);
				if(imgCnt > 1){
				//snsListHtml += ' <div class="col-sm-1" style="margin:0px 10px 0px 0px;"> ';
					
					snsListHtml += ' <div style="width:10%;float:left"> <label class="slider_preview_div" onclick="preview_click('+data[i].sns_profile_no+')">&#x2039;</label> </div>';			
					snsListHtml += ' <div style="width:80%;float:left" id="div_img_'+data[i].sns_profile_no+'"> ';
					for(var t=0; t<imgCnt; t++){
					
						if(t==0)
						snsListHtml += ' <div id="div_img_'+data[i].sns_profile_no+'_'+t+'" style="margin-right:10px;align:center"> ';
						else
						snsListHtml += ' <div id="div_img_'+data[i].sns_profile_no+'_'+t+'" style="margin-right:10px;display:none;align:center"> ';
					//alert(imgArr[t]);	
					snsListHtml += ' 		<img src="'+imgArr[t]+'" class="img_max_small" style="align:center" onclick="javascript:view_msg('+data[i].sns_profile_no+')"/> ';
						snsListHtml += ' </div> ';
					
				}
					snsListHtml += ' </div> ';
					//snsListHtml += ' <div style="width:10%;float:left"> <label class="slider_next_div" onclick="next_click('+data[i].sns_profile_no+')">&#x2039;</label> </div>';
					snsListHtml += ' <div style="width:10%;float:left;height:100%;max-height:500px"  > <label class="slider_next_div" onclick="next_click('+data[i].sns_profile_no+')">&#x2039;</label> </div>';
					//snsListHtml += '<label class="slider_next_div" onclick="next_click('+data[i].sns_profile_no+')">&#x2039;</label>';
				//snsListHtml += ' </div> ';
				
				// image slider 관련하여 css 다시 해야함.
			}else
				snsListHtml += ' 		<img src="'+imgFileLoc+'" class="img_max_small" onclick="javascript:view_msg('+data[i].sns_profile_no+')"/> ';
				
				//alert(imgFileLoc);
			snsListHtml += ' 	</div> ';
		//alert("111111111111111111111111111 "+imgFileLoc);
		if("" != imgFileLoc)
			snsListHtml += ' 	<div class="row" style="margin-top:10px"> ';
		else
			snsListHtml += ' 	<div class="row" style="padding-top:10px"> ';
			snsListHtml += '      <div class="col-sm-12" onclick="javascript:view_msg('+data[i].sns_profile_no+')"> ';	
			snsListHtml += ' 	    <div id="edit_msg_'+i+'" style="display:block;font-size:20px;font-family:Helvetica, Arial, sans-serif" contentEditable="false">'+data[i].profile_msg+'</div> ';
			snsListHtml += '      </div> ';

			snsListHtml += ' 	</div> ';
			
			
			snsListHtml += ' 	<div class="row" style="padding-top:10px"> ';
			
			snsListHtml += '      <div class="col-sm-8" onclick="javascript:view_msg('+data[i].sns_profile_no+')"> ';	
			snsListHtml += '      </div> ';
			snsListHtml += '      <div class="col-sm-4" style="font-size:13px"> <a href="javascript:edit_msg('+data[i].sns_profile_no+')">수정</a> / <a href="javascript:delete_msg('+data[i].sns_profile_no+' , '+data[i].attach_file_no+')">삭제</a>';
			snsListHtml += ' 	  </div> ';
			snsListHtml += ' 	</div> ';
			
			
			snsListHtml += ' </div> ';
			snsListHtml += ' <div class="col-sm-3 col-md-1 col-lg-1">';
			//if(imgCnt > 1)
				//snsListHtml += ' <div class="slider_next_div" onclick="next_click('+data[i].sns_profile_no+')"></div>	';
			snsListHtml += ' </div> ';
			snsListHtml += ' <div class="col-md-1 col-lg-1 visible-md visible-lg"></div> ';
		snsListHtml += ' </div> ';
		snsListHtml += ' <div class="row" style="margin-bottom:10px;"> ';
			snsListHtml += ' <div class="col-sm-1 "></div>';
			snsListHtml += ' <div class="col-sm-10" style="border-bottom:1px solid rgba(0, 0, 0, .4)"></div>';
			snsListHtml += ' <div class="col-sm-1 "></div>';
		snsListHtml += ' </div>';

			if(i==0)
				snsNumMax = data[i].sns_profile_no;
			else{
				if(snsNumMax < data[i].sns_profile_no)
					snsNumMax = data[i].sns_profile_no;
			}
			//alert("222222222222222222222222 ");
				
		}
		
		$("#snsMainList").empty();
		$("#snsMainList").html(snsListHtml);
		

		if(typeof dataList.fList != "undefined"){
			
			var fData = dataList.fList;
			
			var friendList = "";
			
			for(var i=0; i<fData.length; i++){
				friendList += '<div style="height:40px;clear:both"> ';
				
				friendList += '<div class="friend_div" style=""> ';
					friendList += ' <div class="col-md-2 col-lg-2 col-sm-4 friend_div_img" style=""> ';
					if(fData[i].picture_url =="" || fData[i].picture_url =="null" || fData[i].picture_url ==null)
						friendList += '<img id="picture1" src="/resources/img/bbs/noavatar-blue.png" width="30" height="30"/> ';
					else
						friendList += '<img id="picture1" src="'+fData[i].picture_url+'" width="30" height="30"/> ';
					friendList += '</div> ';
					friendList += '<div class="col-md-9 col-lg-10 col-sm-8 friend_ul" style=""> ';
						friendList += '<div style=""> '; 
							friendList += '<ul style="float:left;"> ';
								friendList += '<li style="margin:0px;padding:0px;display:inline-block;">'+fData[i].user_name+' ('+fData[i].status+')</li> ';
							friendList += '</ul> ';
						friendList += '</div> ';
						//friendList += '<div style="float:left;margin-top:3px"></div> ';
					friendList += '</div> ';
				friendList += '</div> ';
				friendList += '</div> ';
			}
			
			$("#friendList").empty();
			$("#friendList").html(friendList);
		}
		
		
		/*
		
		*/
		
		
		
		
		
		
		
		
		
		
		
		/*alert("snsPageCnt==="+snsPageCnt);
		if(snsPageCnt==0){
			alert(1);
			
			alert($("#snsMainList").html());
			$("#snsMainList").empty();
			$("#snsMainList").html(snsListHtml);
		}else{
			alert("snsMainList=="+$("#snsMainList").html());
			
			if($("#snsMainList").html() == ""){
				alert("공백");
				$("#snsMainList").html(snsListHtml);
			}else{
				alert("공백아님");
				$("#snsMainList .row").last().after(snsListHtml);
			}

		}
		*/
		snsPageCnt = snsNumMax+1;
		
	}
	
	// 상세 화면 보는 html
	function view_msg(no){

		var callback = function(data){

			var div_html = "";
			var div_img_html = "";
	
			//alert("data == "+data.detail.profile_msg);
			
			div_html += ' <div class="row" > ' ;
			div_html += '  <div class="col-sm-1" /> ' ;
			div_html += '   <div class="col-sm-10"> ' ;
			div_html += data.detail.profile_msg;
			div_html += '   </div>' ;
			div_html += '  <div class="col-sm-1" /> ' ;
			div_html += ' </div>' ;
			if(typeof data.attachList != "undefined"){
				div_img_html += ' <div class="row" > ' ;
				div_img_html += '  <div class="col-sm-1" style="padding-left:0px;padding-right:0px"/> ' ;
				div_img_html += '   <div class="col-sm-10" style="padding-left:0px;padding-right:0px"> ' ;
				var attachListTmp =data.attachList;
				
				for(var i=0; i<attachListTmp.length; i++){
					
					var imgFileLoc = attachListTmp[i].file_path + "" + attachListTmp[i].orginal_file_nm;

					if("" != imgFileLoc){
						div_img_html += '<div style="height:370px;"> ' + '<img src="'+imgFileLoc+'" style="height:370px;" onclick="javascript:view_msg('+data.detail.sns_profile_no+')"/> '+ '</div>';

					}
				}
				div_img_html += '   </div>' ;
				div_img_html += '  <div class="col-sm-1" /> ' ;
				div_img_html += ' </div>' ;
			}
			$("#modalBody").html("");
			$("#modalImgBody").html("");
			$("#modalImgBody").attr("style","height:400px");
			$("#modalBody").prop("contentEditable",false);
			$("#modalBody").css("word-break","");
			$("#modalBody").css("border","");
			//alert("view msg");
			
			$("#modalBody").html(div_html);
			
			$("#modalImgBody").html(div_img_html);
			//$("#modalFooter").html();
			
			$('div.modal').modal();
			
		}
		$("#sns_profile_no").val(no);

		ajax_form_post("/sns/snsDetail","detailForm","callBack","",callback,"");

	}
	
	// 수정버튼 클릭시에 html
	function edit_msg(edit_no){

		var callback = function(data){

			init_modal();
			
			$("#modalBody").html(data.detail.profile_msg);
			$("#modalBody").prop("contentEditable",true);
			$("#modalBody").css("word-break","break-all");
			$("#modalBody").css("border","1px solid red");
			
			if(typeof data.attachList != "undefined"){
				sns_detail_attach(data.attachList);
				
				//alert(1);
				$("#modalImgBody").attr("style","height:100px");
			}
			
			
			$("#modalHeader").text(data.detail.user_name);
			$('div.modal').modal();
			
		}
		$("#sns_profile_no").val(edit_no);
		$("#sns_profile_no_u").val(edit_no);

		ajax_form_post("/sns/snsDetail","detailForm","callBack","",callback,"");

	}
	
	function init_modal(){

		$("#modalBody").html("");
		$("#modalImgBody").attr("style","height:0px");
		$("#modalImgBody").html("");
	}
	
	function sns_update(){
		var callback = function(data){
			//alert(data.reVal);
			//edit_msg(data.attach_file_no);
			$('div.modal').modal('hide');
			menuFind(0);
		}
		
		var attachDelType = "";

		$('#modalImgBody .tet1').each(function(idx,item) {

			attachDelType += ($('#del_img_'+idx).css("display")+"@@" );
		});
		
		//attachDelType = attachDelType.replace("@@","@");
		//alert(attachDelType);
		$('#attach_file_seq').val(attachDelType);
		$('#attach_file_no').val(attachDelType);
		$("#profile_msg_u").val($("#modalBody").html());
		ajax_form_post("/sns/snsUpdate","detailForm","callBack","",callback,"");
	}
	
	function preview_click(previewId){

		var divImgCnt =0;
		var divImgBlockNum;
		$('#div_img_'+previewId+' div').each(function(idx,item) {
			//alert($('#div_img_'+previewId+'_'+idx).css("display"));
			if($('#div_img_'+previewId+'_'+idx).css("display")=="block"){
				divImgBlockNum=idx;
			}
			
			divImgCnt++;
		});
		
		//alert(divImgCnt + " // " +divImgBlockNum);
		$('#div_img_'+previewId+'_'+divImgBlockNum).css("display","none");
		//divImgCnt = divImgCnt-1;
		if(divImgBlockNum == 0){
			$('#div_img_'+previewId+'_'+(divImgCnt-1)).css("display","block");
		}else{
			$('#div_img_'+previewId+'_'+(divImgBlockNum-1)).css("display","block");
		}
			
	}
	
	function next_click(nextId){
		var divImgCnt =0;
		var divImgBlockNum;
		$('#div_img_'+nextId+' div').each(function(idx,item) {
			//alert($('#div_img_'+previewId+'_'+idx).css("display"));
			if($('#div_img_'+nextId+'_'+idx).css("display")=="block"){
				divImgBlockNum=idx;
			}
			
			divImgCnt++;
		});
		//alert(1);
		//alert(nextId+""+divImgCnt + " // " +divImgBlockNum);
		$('#div_img_'+nextId+'_'+divImgBlockNum).css("display","none");
		divImgCnt = divImgCnt-1;
		if(divImgCnt == divImgBlockNum){
			
			$('#div_img_'+nextId+'_0').css("display","block");
		}else{
			$('#div_img_'+nextId+'_'+(divImgBlockNum+1)).css("display","block");
		}
	}
	
	function fn_go(type){
		
		if(type == 1){
			
			document.pageMove.pageName.value = "/sns/listSns";
			//document.pageMove.action="/sns/snsList";
			//alert();
			$("#snsType").val("Y");
			$("#pageMove").submit();
		}else if(type == 2){
			
			document.pageMove.pageName.value = "/sns/listFriend";
			//document.pageMove.action="/sns/snsList";

			$("#snsType").val("Y");
			$("#pageMove").submit();
		}
	}
	
	function delete_msg(edit_no,attach_no){
		
		var callback = function(data){
			menuFind(0);
			alert("삭제되었습니다.");
		}
		if(!confirm("삭제하시겠습니까?"))
			return;
		
		$("#sns_profile_no").val(edit_no);
		$("#attach_file_no_d").val(attach_no);

		ajax_form_post("/sns/deleteSns","detailForm","callBack","",callback,"");
	}
</script>
<style type="text/css">
	HTML { 
		height: 100%;
	}
	BODY { 
		height: 100%;
		background-color:#e9ebee
	}
	.container_div_top{
		height: 100%;
	}
	.sns_main_div{
		height: 100%;
	}
	.top-menu-block{
		height:55px
	}
	.paging-center {
		left:33%
	}
	.div-body {
		
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
		height:100%;
		position: relative;
		top:200px;
		width:25px
	}
	.slider_next_div{

		background:url('/resources/img/sns/next.png') no-repeat center;
		height:100%;
		position: relative;
		top:50%;
		min-height: 100%;
		height:100%;
		width:25px

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
	
</style>
</head>
<body>

	<div class="container-fluid container_div_top" style="background-color:#e9ebee;">
		<div class="row" style="">
			<div class="col-xs-12 top-menu-block">
				<%-- <jsp:include page="/WEB-INF/views/layout/bbs/top.jsp" flush="false"/> --%>
				<c:import url="/com/layout/top"></c:import>
			</div>
		</div>
		
		<c:if test="${reParam.snsType == 'Y'}">
		<div class="row" style="height:150px">
			<div class="col-sm-12 col-md-8 col-lg-8">
				<div class="row" style="border:1px solid black;height:150px">
					
				</div>
				
			</div>
			<div class="col-md-4 col-lg-4" style="">
			</div>
		</div>
		<div style="position:absolute;top:80px;left:30px">
			<img id="picture1" src="/snsImage/2016/11/01/47b31f88-cb45-4eb0-a152-d2efa69eedb6/thumb_2014-12-04_093B473B15.jpg" width="140" height="140"/>
		</div>
		
		<div style="position:absolute;top:150px;left:140px">
			<ul style="font-size:24px;line-height:30px">
				<li>
					<c:out value='${sessionScope.loginInfo.user_name}' />
				</li>
			</ul>
		</div>
		
		<div class="row" style="height:50px">
			<div class="col-sm-12 col-md-8 col-lg-8" style="background-color:white">
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
						<!-- <div class="col-sm-3" style="border-collapse:collapse;border-left:1px solid #e9eaed;">
							타임라인
						</div>
						<div class="col-sm-3">
							친구
						</div>
						<div class="col-sm-3">
							사진
						</div>
						<div class="col-sm-3">
							이벤트
						</div> -->
					</div>
					
					<div class="col-sm-3">
						
					</div>
				</div>
				
			</div>
			<div class="col-md-4 col-lg-4" style="">
			</div>
		</div>
		</c:if>
		<div class="row div-body" style="">
			<div class="col-md-2 col-lg-2 visible-md visible-lg" style="height:100%">
				<c:if test="${reParam.snsType != 'Y'}">
					<jsp:include page="/WEB-INF/views/layout/bbs/left.jsp" flush="false"/>
				</c:if>
			</div>
			
			<div class="col-sm-12 col-md-6 col-lg-6 div-body-div"  style="border:1px solid #e5e5e5;background-color:white;border-collapse:collapse;">
				<div class="row" style="border:1px solid red;padding:10px 0px 20px 0px">
					<div class="row" style="padding-bottom:20px">
						<div class="col-sm-1"></div>
						<div class="col-sm-3" style="">
							<form name="imgForm" id="imgForm" method="post" enctype="multipart/form-data" target="hiddenframe" action="/sns/imageTemp">
								<input type="hidden" name="attachFileNo" id="attachFileNo" />
								<!-- <input type="file" name="snsFile" id="snsFile" onchange="imgAjaxUpload();" accept=".jpg,.png,jpeg,.gif"/> -->

								<div class="file_input_div2">
								    <img src="/resources/img/sns/img_c_btn.png" class="file_input_btn" alt="open" />
								    <input type="file" name="snsFile" id="snsFile" onchange="imgAjaxUpload();" class="file_input_hidden"/>
								</div>

							</form>
						</div>
						<div class="col-sm-7" style="height:30px"> &nbsp;</div>
						<div class="col-sm-1"> &nbsp;</div>
					</div>
					
					<div class="row" style="padding-bottom:20px">
						<div class="col-sm-1"></div>
						
						<form role = "form" id="form" name="form" action="" method="post">
							<input type="hidden" name="attach_file_no" id="snsAttachFileNo" />
							<input type="hidden" name="pageStart" id="pageStart" />
							<input type="hidden" name="user_no" id="user_no" value="<c:out value='${sessionScope.loginInfo.user_no}' />"/>
							<input type="hidden" name="snsType" id="friendSnsType" value="<c:out value='${reParam.snsType}' />">
							<div class="col-sm-10">
								<div id="profile_msg_div" style="word-break:break-all;border:1px solid red" contentEditable="true" >
								
								</div>
								
								<textarea id="profile_msg" name="profile_msg" style="display:none"></textarea>

							</div>
						</form>
						<div class="col-sm-1"></div>
					</div>
					<div class="row">
						<div class="col-sm-1"></div>
						<div id="divPicture" class="col-sm-10" >
							
						</div>
						<!-- <div style="float:left;width:80px;height:80px;border:1px solid #e5e5e5;">
								<img id="picture1" src="/snsImage/2016/11/01/47b31f88-cb45-4eb0-a152-d2efa69eedb6/thumb_2014-12-04_093B473B15.jpg" />
							</div> -->
						<div class="col-sm-1">

						</div>
					</div>
					<div class="row">
						<div id="divPicture" class="col-sm-10" >
							
						</div>
						<div class="col-sm-2">
							<button type = "button" onclick="sns_insert()" class = "btn btn-default">등록</button>
						</div>
					</div>
				</div>

				<div class="row sns_main_div" id="snsMainList">
				</div>
					<!-- <div class="row" >
						<div class="col-sm-1">&nbsp;</div>
						<div class="col-sm-1">
							<img src="/resources/img/bbs/noavatar-blue.png" style="width:35px;margin-top:20px" />
						</div>
						<div class="col-sm-8" style="margin:20px 10px 5px 0px;overflow:hidden;word-wrap:break-word">
							<p style="display:block">글의 제목 adddddddddddddddddddddd</p>
						</div>
						<div class="col-sm-2"></div>
					</div> -->

			</div>
			<div class="col-md-2 col-lg-2 h-max-div visible-md visible-lg" style="border:1px solid #dddfe2;position:fixed;float:right;right:16.5%;top:55px ">
				<div class="row" style="height:100%;background-color:#fff;width:99%;margin-left:1px">
					ad
					${pageContext.request.contextPath}
				</div>
			</div>
			<div class="col-md-2 col-lg-2 h-max-div visible-md visible-lg" style="border: 1px solid rgba(0, 0, 0, .4);position:fixed;right:0px;top:55px ">
				<div class="row" id="friendList">
				</div>
			</div>
		</div>
		
		<iframe width=0 height=0 src="/sns/iframe" name='hiddenframe' style='display:none;'></iframe>
	</div>

<div class="modal fade" id="layerpop" >
  <div class="modal-dialog">
  <!-- <div class="modal-sm">
  <div class="modal-lg">
  -->
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
        <div class="col-sm-1">
        	<img src="/resources/img/bbs/noavatar-blue.png" style="width:35px;margin-top:20px" />
        </div>
        <div class="col-sm-11">
        	<h4 class="modal-title" id="modalHeader"></h4>
        </div>
      </div>
      <!-- body -->
      <div class="modal-body" id="modalBody">
            Body
      </div>
<form name="imgUpd" id="imgUpd" action="/sns/imageUpd" enctype="multipart/form-data" target="hiddenframe"  method="post">
<input type="hidden" name="attach_file_no_u" id="snsAttachFileNo_u" />
      <div class="modal-body" id="modalImgBody">
            Body
      </div>
</form>
      <!-- Footer -->
      <div class="modal-footer" id="modalFooter">
<form role = "form" id="form" name="form" action="" method="post">
<input type="hidden" name="sns_profile_no" id="sns_profile_no_u" />        
        <button type="button" class="btn btn-default" onClick="sns_update()">저장</button>
</form>
      </div>
    </div>
  </div>
</div>

	<form	name="pageMove" id="pageMove" action="/page/move" method="post">
		<input type="hidden" name="pageName" id="pageName" value="bbs/detailBbs">
		<input type="hidden" name="replyYn" id="replyYn" value="N">
		<input type="hidden" name="snsType" id="snsType" value="<c:out value='${reParam.snsType}' />">	
	</form>
	
	<form	name="detailForm" id="detailForm" action="" method="post">
		<input type="hidden" name="sns_profile_no" id="sns_profile_no" value="N">
		<input type="hidden" name="attach_file_seq" id="attach_file_seq" value="N">
		<input type="hidden" name="attach_file_no" id="attach_file_no_d" value="">
		<textarea id="profile_msg_u" name="profile_msg" style="display:none" height="0"></textarea>
	</form>
	
</body>
</html>