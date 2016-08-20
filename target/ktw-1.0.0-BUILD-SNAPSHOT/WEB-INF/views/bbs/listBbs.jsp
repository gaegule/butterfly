<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"href="/resources/bootstrap-336/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bootstrap-table.css">
<script type="text/javascript" src="/resources/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="/resources/bootstrap-336/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/bootstrap-336/js/bootstrap-table.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
<script>
	$(document).ready(function(){
		//alert("ready");
		//$('.dropdown-toggle').dropdown()
		menuFind();
		
	});
	function page_move(){
		//$("#pageName").val("bbs/insertBbs");
		document.pageMove.pageName.value = "bbs/insertBbs";
		//alert($("#pageName").val());
		$("#pageMove").submit();
	}
	
	function menuFind(){
		ajax_form_post("/bbs/list","form","LIST","table");
	}
	
	function operateFormatter(value, row, index) {
		var marginVal = row["lvl"];
		marginVal = marginVal * 10;
        return [
            '<a class="like" href="javascript:bbs_detail('+row["no"]+')" title="Like" style="margin-left:'+marginVal+'px">',
                value,
            '</a>',
        ].join('');
    }
	
	function bbs_detail(bbsNo){

		$("#bbsNo").val(bbsNo);
		$("#replyYn").val("N");
		$("#pageMove").submit();
	}
    /* window.operateEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .edit': function (e, value, row, index) {
            alert('You click edit icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .remove': function (e, value, row, index) {
            alert('You click remove icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        }
    }; */
</script>
</head>
<body>
	<form role = "form" id="form" name="form" action="" method="post">
		
	</form>

	<div class="container-fluid" >
		<div class="row" style="border: 1px solid black;">
			<div class="col-xs-12">
				<!-- <h2>bootstrap top menu</h2> -->
				<jsp:include page="../layout/top.jsp" flush="false"/>
				
			</div>
		</div>
		<div class="row" style="border: 1px solid black;height:450px">
			<div class="col-sm-2" style="border-right:1px solid black;height:450px">
				왼쪽메뉴
			</div>
			<div class="col-sm-10">
				<div class="row">
					<div class="col-sm-9">
						
					</div>
					<div class="col-sm-1" style="height:55px;padding-top:10px">
						<button type="button" style="" class="btn btn-sm btn-primary center-block" onclick="page_move()">등록</button>
					</div>
					<div class="col-sm-2">
					</div>
				</div>
				<div class="table-responsive">
					<div class="col-sm-10">
						<table id="table" >
							<col width="10%" />
							<col width="50%" />
							<col width="20%" />
							<col width="20%" />
				            <thead>
				                <tr>
				                    <th data-field="no" data-align="center" data-sortable="true">순번</th>
				                    <th data-field="title" data-align="left" data-formatter="operateFormatter" data-events="operateEvents" data-click-to-select="false">제목</th>
				                    <th data-field="nm" data-align="center">등록자</th>
				                    <th data-field="regist_date" data-align="center">등록일</th>
				                </tr>
				            </thead>
				        </table>
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
	<form	name="pageMove" id="pageMove" action="/page/move" method="post">
		<input type="hidden" name="pageName" id="pageName" value="bbs/detailBbs">
		<input type="hidden" name="replyYn" id="replyYn" value="N">
		<input type="hidden" name="bbsNo" id="bbsNo" value="">	
	</form>
</body>
</html>