<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"href="/resources/bootstrap-336/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bootstrap-theme.min.css">
<script type="text/javascript" src="/resources/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="/resources/bootstrap-336/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
<script>
		$(document).ready(function(){
			//alert("ready");
			//$('.dropdown-toggle').dropdown()
		});

		function misung_insert(){

			ajax_form_post("/misung/save2","form");
		}
</script>
</head>
<body>

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
				<div class="row" style="height:55px">
					<div class="col-sm-9">
						
					</div>
					<div class="col-sm-1" style="height:55px;padding-top:10px">
						<button type="button" style="" class="btn btn-sm btn-primary center-block" onclick="page_move()">등록</button>
					</div>
					<div class="col-sm-2">
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10 well">
					
						<form role = "form" id="form" name="form" action="/misung/save" method="post">

							<div class = "form-group">
								<div class="row">
									<div class="col-sm-6">				   		
										<label for = "winner_nm">우승자</label>
										<input type = "text" class = "form-control" name="winner_nm" id = "winner_nm" placeholder = "Enter Name">
									</div>
									<div class="col-sm-6">
										<label for = "seq">회차</label>
										<select id="seq" name="seq" class = "form-control">
										   <option>1</option>
										   <option>2</option>
										   <option>3</option>
										   <option>4</option>
										   <option>5</option>
										</select>
									</div>
								</div>
							</div>
						   
						   <!-- <div class = "form-group">
						      <label for = "inputfile">File input</label>
						      <input type = "file" id = "inputfile">
						      <p class = "help-block">Example block-level help text here.</p>
						   </div> -->

							<div class="row">
								<div class="col-sm-10"></div>
								<div class="col-sm-2">
									<button type = "button" onclick="misung_insert()" class = "btn btn-default">등록</button>
								</div>
							</div>
							
						</form>
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

</body>
</html>