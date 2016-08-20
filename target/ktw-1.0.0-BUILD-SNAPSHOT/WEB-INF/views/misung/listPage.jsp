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
		$("#pageMove").submit();
	}
	
	function menuFind(){
		ajax_form_post("/misung/list","form","LIST","table");
	}
	
	
</script>
</head>
<body>
	<form role = "form" id="form" name="form" action="" method="post"></form>

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
						<table id="table">
				            <thead>
				                <tr>
				                    <th data-field="seq" data-sortable="true">회차</th>
				                    <th data-field="winner_nm" >우승자</th>
				                    <th data-field="regist_date">등록시간</th>
				                </tr>
				            </thead>
				        </table>
			        </div>
			        <div class="col-sm-2">
			        </div>
				</div>
				<%-- <div class="row">
					<div class="col-sm-10 well">
						<div class="row">
							<div class="col-sm-1" data-field="seq" >
								회차
							</div>
							<div class="col-sm-8" data-field="winner_nm" >
								우승자
							</div>
							<div class="col-sm-3" data-field="regist_date">
								등록 시간
							</div>
						</div>
					</div>
					<div class="col-sm-2">
					</div>

				</div>
				
				<c:forEach var="x" items="${list}">
			        <div class="row">
			        	<div class="col-sm-10">
							<div class="row">
								<div class="col-sm-1">
									${x.seq}
								</div>
								<div class="col-sm-8">
									${x.winner_nm}
								</div>
								<div class="col-sm-3">
									${x.regist_date}
								</div>
							</div>
						</div>
						<div class="col-sm-2">
						</div>
			        </div>
			    </c:forEach>
 --%>
			</div>
		</div>
		<div class="row" style="border: 1px solid black;">
			<div class="col-md-12">bottom</div>
		</div>
	</div>
	<form	name="pageMove" id="pageMove" action="/page/move" method="post">
		<input type="hidden" name="pageName" id="pageName" value="misung/insertPage">
		<input type="hidden" name="retryYn" id="retryYn" value="N">	
	</form>
</body>
</html>