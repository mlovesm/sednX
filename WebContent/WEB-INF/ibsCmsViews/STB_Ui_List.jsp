<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
  <!-- -- -->
                <div class="col-md-6">
                	<div class="tab-container tile">
                       <ul class="nav tab nav-tabs">
                            <li class="active"><a href="#imageLogo">이미지 셋탑로고</a></li>
                            <li><a href="#textLogo">텍스트 셋탑로고</a></li>
                        </ul>
                       <div class="tab-content">
                       		<div class="tab-pane active" id="imageLogo">
                       			<p>로고 사이즈는 높이 80픽셀을 권장합니다.</p>
                                <p>파일 확장자는 png만 가능합니다. 예)logo.png</p>
                       			<div class="fileupload fileupload-new" data-provides="fileupload">
                       				<div class="fileupload-preview thumbnail form-control">로고 이미지를 업로드하세요</div>
                        			<div class="pull-right">
                            			<span class="btn btn-file btn-alt btn-sm">
                                			<span class="fileupload-new">이미지 선택</span>
                                			<span class="fileupload-exists">이미지 바꾸기</span>
                                			<input type="file" />
                                		</span>
                            		</div>
                    			</div>
                          	</div>
                       		<div class="tab-pane" id="textLogo">
                       			<p>로고 이미지가 없을 경우, 텍스트로 직접 입력합니다.</p>
								<p>글자 수 '14자 이내'로 입력 가능합니다.</p>
                       			<form class="form-inline" role="form">
                       				<input class="form-control input-focused" style="width:calc(100% - 120px);" type="text" placeholder="택스트">
                       				<button type="submit" class="btn btn-default">텍스트 로고 등록</button>
                       			</form>
                   			</div>
                   			<div class="clearfix"></div>
                     	</div>
                   </div>

                	<div class="tile">
                       <h2 class="tile-title">미디어 서버 설정</h2>
                       <form class="form-inline p-10" role="form">
           				<input class="form-control input-focused mask-ip_address" autocomplete="off" style="width:calc(60% - 50px);" type="text" placeholder="아이피">
           				<input class="form-control input-focused mask-port_address" autocomplete="off" style="width:calc(40% - 50px);" type="text" placeholder="포트">
           					<button type="submit" class="btn btn-default">아이피 등록</button>
           				</form>
                   </div>

                	<div class="tile">
                       <h2 class="tile-title">동기화 시작 시간 설정</h2>
                       <form class="form-inline p-10" role="form">
           				<input class="form-control input-focused mask-time" autocomplete="off" style="width:calc(100% - 150px);" type="text" placeholder="00:00">
           					<button type="submit" class="btn btn-default">동기화 시간 등록</button>
           				</form>
                   </div>

                	<div class="tile">
                       <h2 class="tile-title">펌웨어 업데이트</h2>
                      	<div class="p-10">
                      		<p>펌웨어 버전: 1.0.18</p>
							<p>최종 등록일: 2017-11-21</p>
							<div class="fileupload fileupload-new" data-provides="fileupload">
	                        	<span class="btn btn-file btn-sm btn-alt">
	                            	<span class="fileupload-new">APK 업로드</span>
	                            	<span class="fileupload-exists">다시 업로드</span>
	                            		<input type="file" />
	                        	</span>
	                        	<span class="fileupload-preview"></span>
	                        	<a href="#" class="close close-pic fileupload-exists" data-dismiss="fileupload">
	                            	<i class="fa fa-times"></i>
	                        	</a>
	                    	</div>
	                    </div>
                   </div>
	           </div>
	            <!--  -->
	            <div class="col-md-6">    
					<div class="tab-container tile">
                       <ul class="nav tab nav-tabs">
                            <li class="active"><a href="#imageBg">이미지 셋탑배경</a></li>
                            <li><a href="#vodBg">동영상 셋탑 배경</a></li>
                        </ul>
                       <div class="tab-content">
                       		<div class="tab-pane active" id="imageBg">
                       			<p>배경 이미지사이즈는 가로 1920px,세로 1080px를 권장합니다.</p>
                       			<div class="fileupload fileupload-new" data-provides="fileupload">
                       				<div class="fileupload-preview thumbnail form-control">배경 이미지를 업로드하세요</div>
                        			<div class="pull-right">
                            			<span class="btn btn-file btn-alt btn-sm">
                                			<span class="fileupload-new">배경 이미지 업로드</span>
                                			<span class="fileupload-exists">배경 이미지 바꾸기</span>
                                			<input type="file" />
                                		</span>
                            		</div>
                    			</div>
                          	</div>
                       		<div class="tab-pane" id="vodBg">
                       			<p>영상사이즈 가로 1920px,세로 1080px를 권장합니다.</p>
                       			<div id="JWplayer" class="fileupload-preview thumbnail form-control"></div>
                       			<div class="fileupload fileupload-new " data-provides="fileupload" style="margin-top:10px;">
			                        <div class="input-group col-md-12">
			                            <div class="uneditable-input form-control">
			                                <i class="fa fa-file m-r-5 fileupload-exists"></i>
			                                <span class="fileupload-preview"></span>
			                            </div>
			                            <div class="input-group-btn">
			                                <span class="btn btn-file btn-alt btn-sm">
			                                	<span class="fileupload-new">동영상 선택</span>
			                                	<span class="fileupload-exists">바꾸기</span>
			                                	<input type="file" />
			                            	</span>
			                            </div>
			                        </div>
			                    </div>
                   			</div>
                   			<div class="clearfix"></div>
                     	</div>
                   </div>
	
               		<div class="tile">
                      <h2 class="tile-title">상단배너</h2>
                      <div class="p-10">
                      	  <p>상단배너 사이즈는 520 x 153로 자동으로 조정됩니다.</p>
	                      <p>파일 확장자는 png만 가능합니다. 예)banner.png</p>
	             		  <div class="fileupload fileupload-new" data-provides="fileupload">
	             				<div class="fileupload-preview thumbnail form-control">상단배너 이미지를 업로드하세요</div>
	              					<div class="pull-right">
	                  				<span class="btn btn-file btn-alt btn-sm">
	                      				<span class="fileupload-new">상단 배너 업로드</span>
	                      				<span class="fileupload-exists">이미지 바꾸기</span>
	                      				<input type="file" />
	                      			</span>
	                  			</div>
	          				</div>
	          				<div class="clearfix"></div>
                      </div>
                  	</div>
                  	
                  	<div class="tile">
                      <h2 class="tile-title">하단배너</h2>
                      <div class="p-10">
                      	  <p>하단배너 사이즈는 520 x 238로 자동으로 조정됩니다</p>
	                      <p>파일 확장자는 png만 가능합니다. 예)banner.png</p>
	             		  <div class="fileupload fileupload-new" data-provides="fileupload">
	             				<div class="fileupload-preview thumbnail form-control">하단배너 이미지를 업로드하세요</div>
	              					<div class="pull-right">
	                  				<span class="btn btn-file btn-alt btn-sm">
	                      				<span class="fileupload-new">하단배너 업로드 선택</span>
	                      				<span class="fileupload-exists">이미지 바꾸기</span>
	                      				<input type="file" />
	                      			</span>
	                  			</div>
	          				</div>
	          				<div class="clearfix"></div>
                      </div>
                  	</div>
                  </div>
	             <!--  --> 
	             <script>
$(function(){
 	jwplayer("JWplayer").setup({
		file:"rtmp://27.101.43.31:1935/vod/mp4:2010201608021142.mp4",
		image:"",
		width:"100%",
		height:"100%",
    	aspectratio:"16:9",
    	autostart:"true"
	});
 	(function(){
		$('.mask-ip_address').mask('0ZZ.0ZZ.0ZZ.0ZZ', {translation: {'Z': {pattern: /[0-9]/, optional: true}}});
        $('.mask-ip_address').mask('099.099.099.099');
        $('.mask-port_address').mask(':0ZZZZ', {translation: {'Z': {pattern: /[0-9]/, optional: true}}});
        $('.mask-port_number').mask(':09999');
        $('.mask-time').mask('00:00');
	})();
});
</script>