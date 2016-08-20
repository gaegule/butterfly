function ajax_form_post(urlA,formId,type,tableNm,callback){
	$.ajax({
	    url : urlA,
	    enctype: 'multipart/form-data',
	    contentType: 'application/json',
	    dataType : "json",
	    type : "post",
	    data : $('#'+formId).serializeArray(),
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

