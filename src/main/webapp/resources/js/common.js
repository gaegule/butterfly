	/***
	* ajax post
	***/
	function ajax_form_post(urlA,formId,type,tableNm,callback,pageIdx){

		$.ajax({
		    url : urlA,
		    dataType : "json",
		    type : "post",
		    data : $('#'+formId).serializeArray(),
		    success: function(data) {
	
		        if(type == "LIST"){
		        	//alert(JSON.stringify(data));
		        	//$(tableNm).bootstrapTable('refresh');
		        	
		        	
		        	//$(tableNm).init();
		        	//$(tableNm).bootstrapTable();
		        	paging_add(data.cnt,pageIdx);
		        	if(typeof $(tableNm+" tbody").html() == "undefined"){
		        		$(tableNm).bootstrapTable({
			                data: data.list
			            });
		        	}else{
		        		$(tableNm).bootstrapTable('load', data.list);
		        	}
		        	
		        	

		        }else if(type == "SAVE"){
		        	if(typeof callback =="function"){
		        		callback(data.maxSeq);
		        	}
		        }else if(type == "DETAIL" || type == "DETAIL2"){
		        	//alert(Object.keys(data.detail).length);
		        	//alert(JSON.stringify(data.detail));
		        	
		        	$.each(data.detail, function(key, val) {
		        	    //$('#a').html($('#a').html() + "키 : "+key+" , 값 : "+val+"<br>");
		        	    if(type == "DETAIL")
		        	    	$("#"+key).val(val);
		        	    else{
		        	    	if(key == "content")
		        	    		$("#"+key).html(val);
		        	    	else
		        	    		$("#"+key).text(val);
		        	    }
		        	    	
		        	});
		        	
		        	if(type == "DETAIL2"){
		        		if(data.attachList != null && data.attachList != "null"){
		        			var attachList = attachFileList_add(data.attachList);
		        			$("#fileAttachList").html("");
		        			$("#fileAttachList").html(attachList);
		        		}
		        	}
	
		        }else if(type == "DELETE"){
		        	
		        	if(typeof callback =="function")
		        		callback();
		        	
		        }else if(type == "REPLY"){
		        	
		        	if(typeof callback =="function")
		        		callback(data.detail);
		
		        }
		    },
		    error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		 
		});
	
	}
	
	/***
	* ajax insert attach 
	***/
	function ajax_form_post2(urlA,formId,type,tableNm,callback){
	
		var obj = $("#insertBbs");
	
		var data = new FormData();
		$.each($(obj).find("input[type='file']"), function(i, tag) {
	        $.each($(tag)[0].files, function(i, file) {
	        	//alert(file);
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
	
	/**
	 * 첨부파일 html 만들기 
	**/
	function attachFileList_add(data){
	
		var fileHtml = "";
		for(var i=0; i<data.length; i++){
	
			fileHtml += " <li> ";
			fileHtml += " <i class='fa fa-floppy-o fa-fw'></i> ";
			fileHtml += " <a href=''>"+data[i].orginal_file_nm	+"</a> ";
			fileHtml += " <span class='rb-size'>"+data[i].file_size+"KB</span> ";
			fileHtml += " <span class='rb-down' data-toggle='tooltip' title='다운로드 수'>0</span> ";
			fileHtml += " </li> ";
		}
		
		return fileHtml;
	
	}
	
	function paging_add(totalCnt,pageIdx){
		
		//한페이당 표시할 페이지갯수
		var pageCount=10;
		//현재페이지
		//var currentPage=pageIdx;
		//총 게시물수
		//var totalSize=totalCnt;
		//총 페이지 갯수
		var totalPage=Math.ceil(totalCnt/10);
		//한화면에 보여질 페이지 갯수
		var totalPageList=Math.ceil(totalPage/pageCount);
		//페이지리스트가 몇번째 리스트인지 
		var pageList=Math.ceil(pageIdx/pageCount);

		//페이지 리스트가 1보다 작으면 1로 초기화
		if(pageList<1) pageList=1;
		//페이지 리스트가 총 페이지리스트보다 커지면 총 페이지 리스트로 설정
		if(pageList>totalPageList) pageList=totalPageList;
		//시작 페이지
		var startPageList=(pageList-1)*pageCount+1;
		//끝페이지
		var endPageList=startPageList+pageCount-1;
		
		if(startPageList<1) startPageList=1;
		if(endPageList>totalPage) endPageList=totalPage;
		if(endPageList<1) endPageList=1;

		var fileHtml = "";
		
		//페이지 리스트가 처음이 아닐때
		if(pageList!=1){
			
			fileHtml += ' <li class="page-item"> ';
			fileHtml += ' <a class="page-link" href="#" aria-label="Previous"> ';
			fileHtml += ' <span aria-hidden="true">&laquo;</span> ';
			fileHtml += ' <span class="sr-only">Previous</span> ';
			fileHtml += ' </a> ';
			fileHtml += ' </li> ';
		}
		
		
		var pageNum = parseInt(totalCnt/10)+1;

		for(var i=startPageList; i<=endPageList; i++){

			if(i == pageIdx)
				fileHtml += ' <li class="page-item active"><a class="page-link" href="javascript:menuFind('+(i)+')">'+(i)+'<span class="sr-only">(current)</span></a></li> ';
			else
				fileHtml += ' <li class="page-item"><a class="page-link" href="javascript:menuFind('+(i)+')">'+(i)+'</a></li> ';
		}
		/*for(var i=0; i<pageNum; i++){
			fileHtml += ' <li class="page-item"><a class="page-link" href="javascript:menuFind('+(i+1)+')">'+(i+1)+'</a></li> ';
		}*/
		if(totalPageList>pageList){
			fileHtml += ' <li class="page-item"> ';
			fileHtml += ' <a class="page-link" href="#" aria-label="Next"> ';
			fileHtml += ' <span aria-hidden="true">&laquo;</span> ';
			fileHtml += ' <span class="sr-only">Next</span> ';
			fileHtml += ' </a> ';
			fileHtml += ' </li> ';
		}
		$(".pagination").empty();
		$(".pagination").html(fileHtml);
	}

