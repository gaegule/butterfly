<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"href="/resources/bootstrap-336/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bootstrap-table.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bbs.css">
<script type="text/javascript" src="/resources/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="/resources/bootstrap-336/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/bootstrap-336/js/bootstrap-table.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
<script>
	$(document).ready(function(){
		//alert("ready");
		//$('.dropdown-toggle').dropdown()
		menuFind(1);
		
	});

	function page_move(){
		//$("#pageName").val("bbs/insertBbs");
		document.pageMove.pageName.value = "bbs/insertBbs";
		//alert($("#pageName").val());
		$("#pageMove").submit();
	}
	
	function menuFind(pageIdx){
		//alert("첫번째==>" + (Number(pageIdx)-1) * 10);
		$("#pageStart").val((Number(pageIdx)-1) * 10);
		//alert("두번째==>" + $("#pageStart").val());
		
		//$("table tbody").remove();
		ajax_form_post("/bbs/list","form","LIST","table","",pageIdx);
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
</style>
</head>
<body>
	<form role = "form" id="form" name="form" action="" method="post">
		<input type="hidden" name="pageStart" id="pageStart">
	</form>

	<div class="container-fluid" >
		<div class="row" style="border: 1px solid black;">
			<div class="col-xs-12 top-menu-block">
				<jsp:include page="../layout/top.jsp" flush="false"/>
			</div>
		</div>
		<div class="row div-body" style="border: 1px solid black;">
			<div class="col-sm-2" style="border-right:1px solid black;height:525px">
				왼쪽메뉴
			</div>
			<div class="col-sm-10">
				<div class="row">
					<div class="col-sm-9">
						
					</div>
					<div class="col-sm-1" style="padding-bottom:10px;margin-top:15px">
						<button type="button" style="" class="btn btn-sm btn-primary center-block" onclick="page_move()">등록</button>
					</div>
					<div class="col-sm-2">
					</div>
				</div>
				<div class="table-responsive" style="height:413px">
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
				<div class="row">
					<div class="col-sm-10 paging-center" >
						<nav aria-label="Page navigation">
						  <ul class="pagination">
						  </ul>
						</nav>
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