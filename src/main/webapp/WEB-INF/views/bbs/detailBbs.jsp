<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"href="/resources/bootstrap-336/css/bootstrap.min.css">
<link rel="stylesheet"href="/resources/bootstrap-336/css/bbs.css">
<link rel="stylesheet" href="/resources/bootstrap-336/css/bootstrap-theme.min.css">
<!-- Font-Awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Bootstrap-select -->
<link rel="stylesheet" href="../../assets/plugins/bootstrap-select-1.7.4/css/bootstrap-select.min.css">
<script type="text/javascript" src="/resources/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="/resources/bootstrap-336/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>


<script>
		$(document).ready(function(){
			bbs_detail();
		});

		function bbs_list(){
			$("#pageName").val("bbs/listBbs");
			$("#form").attr('action','/page/move').submit();
		}
		
		function bbs_detail(){
			//alert($("#bbsNo").val());
			
			ajax_form_post("/bbs/detail","form","DETAIL2","","");
		}
		
		function bbs_update(){
			$("#pageName").val("bbs/insertBbs");
			$("#form").attr('action','/page/move').submit();
		}
		
		function bbs_delete(){
			if(!confirm("삭제하시겠습니까?"))return;
			var callback = function(){
				//alert("삭제하고 callback");
				bbs_list();
			}
			ajax_form_post("/bbs/delete","form","DELETE","",callback,"");
		}
		
		function bbs_reply(){

			$("#replyYn").val("Y");
			$("#pageName").val("bbs/insertBbs");
			$("#form").attr('action','/page/move').submit();
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
</style>
</head>
<body>
	<form role = "form" id="form" name="form" action="" method="post">
		<input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value='${reParam.bbsNo}' />">
		<input type="hidden" name="grp" id="grp" value="" />
		<input type="hidden" name="seq" id="seq" value="" />
		<input type="hidden" name="lvl" id="lvl" value="" />
		<input type="hidden" name="replyYn" id="replyYn" value="N">
		<input type="hidden" name="pageName" id="pageName" value="">
	</form>
	<form class="form-horizontal">
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
				
				<div class="container" style="max-width: 830px;width:800px;padding-top:20px">

		            <div class="row">
		                <div class="col-lg-9 col-lg-offset-1">
		
		                    <!-- 템플릿 시작 -->
		                    <section class="rb-bbs rb-bbs-view">
		
		                        <div class="rb-bbs-heading">
		                            <div class="media">
		                                <div class="media-left">
		                                    <a role="button" data-profile="popover">
		                                        <img class="media-object" src="/resources/img/bbs/noavatar-blue.png" alt="...">
		                                    </a>
		                                </div>
		                                <div class="media-body">
		                                    <h4 class="media-heading" id="title"></h4>
		                                    <div class="rb-meta">
		                                        <ul class="list-inline">
		                                            <li id="nm"></li>
		                                            <li class="rb-divider"></li>
		                                            <li id="regist_date"></li>
		                                            <li class="rb-divider"></li>
		                                            <li>조회 <p id="hit"></p></li>
		                                        </ul>
		                                    </div>                                    
		                                    <div class="rb-actions btn-toolbar">
		                                        <div class="btn-group rb-buttons" role="group" aria-label="...">
		                                            <a href="" class="btn btn-link btn-xs"><i class="fa fa-meh-o fa-lg fa-fw"></i> 신고</a>
		                                            <a href="" class="btn btn-link btn-xs"><i class="fa fa-print fa-lg fa-fw"></i> 인쇄</a>
		                                            <a href="" class="btn btn-link btn-xs"><i class="fa fa-star-o fa-lg fa-fw"></i> 스크랩</a>
		                                        </div>
		                                        <!-- <div class="btn-group btn-group-xs rb-resizer" role="group" aria-label="...">
		                                            <a class="rb-small btn btn-default hidden-xs">A</a>
		                                            <a class="rb-medium btn btn-default">A</a>
		                                            <a class="rb-large btn btn-default">A</a>
		                                            <a class="rb-larger btn btn-default">A</a>
		                                        </div> -->
		                                    </div>
		                                </div>
		                            </div>
		
		                        </div>
		
		                        <div class="rb-bbs-body" id="content">
	
		                        </div>
		                        <div class="rb-bbs-footer">
		 
		                            <dl class="dl-horizontal rb-attach">
		                                <dt>첨부</dt>
		                                <dd id="fileAttachList">
		                                    <!-- <ul class="list-unstyled">
		                                        <li>
		                                            <i class="fa fa-floppy-o fa-fw"></i> 
		                                            <a href="">STP-SWOT 분석-2010.05.hwp</a> 
		                                            <span class="rb-size">446.1KB</span>
		                                            <span class="rb-down" data-toggle="tooltip" title="다운로드 수">0</span>
		                                        </li>
		                                        <li>
		                                            <i class="fa fa-floppy-o fa-fw"></i> 
		                                            <a href="">킴스큐 소개서.pdf</a> 
		                                            <span class="rb-size">446.1KB</span>
		                                            <span class="rb-down" data-toggle="tooltip" title="다운로드 수">0</span>
		                                        </li>
		                                    </ul> -->
		                               </dd>
		                            </dl>
		 
		                            <div class="rb-toolbar" role="toolbar">
		                                <div class="rb-share">
		                                    <div class="btn-group btn-group-sm">
		                                        <a href="" class="btn btn-default" data-toggle="tooltip" title="페이스북 공유"><i class="fa fa-facebook fa-lg"></i></a>
		                                        <a href="" class="btn btn-default" data-toggle="tooltip" title="트위터 공유"><i class="fa fa-twitter fa-lg"></i></a>
		                                        <a href="" class="btn btn-default" data-toggle="tooltip" title="구글+ 공유"><i class="fa fa-google-plus fa-lg"></i></a>
		                                        <a href="mailto:?subject=킴스큐 오픈소스 프로젝트 운영 지침&amp;body=Check out this post:%20http://www.abc.com/blog/192680" onclick="return confirm('메일로 본 게시물의 링크를 보내시겠습니까??');" class="btn btn-default" data-toggle="tooltip" title="메일 공유"><i class="fa fa-envelope fa-lg"></i></a>
		                                    </div>
		                                </div>
		                                <div class="rb-buttons">
		                                    <div class="btn-group btn-group-sm">
		                                        <a href="javascript:bbs_list()" class="btn btn-default">목록으로</a>
		                                    </div>
		
		                                    <!-- <div class="btn-group btn-group-sm">
		                                        <a href="" class="btn btn-default">복사</a>
		                                        <a href="" class="btn btn-default">이동</a>
		                                    </div> -->
		                                    <div class="btn-group btn-group-sm">
		                                        <a href="javascript:bbs_update();" class="btn btn-default">수정</a>
		                                        <a href="javascript:bbs_delete();" class="btn btn-default">삭제</a>
		                                    </div>
		                                    <div class="btn-group btn-group-sm">
		                                        <a href="javascript:bbs_reply();" class="btn btn-default">답변</a>
		                                    </div>
		                                </div>
		                            </div>
		
		                            <div class="rb-tabs">
		                                <ul class="nav nav-tabs">
		                                    <li class="active"><a href="#comment" data-toggle="tab">댓글 <span class="badge">0</span></a></li>
		                                    <li><a href="#trackback" data-toggle="tab">엮인글  <span class="badge">0</span></a></li>
		                                </ul>
		                                <div class="tab-content">
		                                    <div class="tab-pane active" id="comment">
		                                        	댓글 목록 
		                                    </div>
		                                    <div class="tab-pane" id="trackback">
		                                        	트래백 목록
		                                    </div>
		                                </div>
		                            </div>
		
		                        </div>
		                    </section>
		                    <!-- 템플릿 끝 -->
		                    
		
		                </div>
		            </div>
		
		            <!-- FOOTER  -->
		            <footer>
		                <hr>
		                <p class="copyright">portfolio by <a href="#">kim tae won</a></p>
		                <!-- <p>Published with <a href="https://pages.github.com">GitHub Pages</a></p> -->
		            </footer>
		
		        </div>
			</div>
			<div class="col-sm-2">
			</div>
			<!-- <div class="col-sm-10 well">
				<div class="row">
					<div class="col-sm-10 well">
							
							<div class = "form-group row">
								<label class="col-sm-2 control-label">제목</label>
								<div class="col-sm-10">
									<p class="form-control-static"  id = "title" > </p>
								</div>
							</div>
							<div class = "form-group row">			   		
								<label class="col-sm-2 control-label">작성자</label>
								<div class="col-sm-10"><p class="form-control-static" id = "nm"></p></div>
							</div>
							<div class = "form-group row">				   		
								<label class="col-sm-2 control-label">내용</label>
								<div class="col-sm-10" style="height:450px" id = "content"></div>
								<textarea  rows=10 cols=60 name="content" id = "content" ></textarea>
							</div>

						   <textarea style="display:none" name="contentVal" id = "contentVal" ></textarea>
						   <div class = "form-group">
						      <label for = "inputfile">File input</label>
						      <input type = "file" id = "inputfile">
						      <p class = "help-block">Example block-level help text here.</p>
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
			</div> -->
		</div>
		<div class="row" style="border: 1px solid black;">
			<div class="col-md-12">bottom</div>
		</div>
	</div>
	</form>
</body>
</html>