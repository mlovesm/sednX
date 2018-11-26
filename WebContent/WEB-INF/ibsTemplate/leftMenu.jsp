<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<style>
.colorpicker { z-index: 9999; } 
#confirmModal { z-index: 9999; }
.dropdown-menu a.jstree-anchor{color:#fff; background:none;}
.dropdown-menu a:hover, .dropdown-menu a:focus{color:#fff;}
.bell {font-size: 15px; font-weight: normal;}
.modal .thumnail a.close {position: absolute; right: 2px; top: 2px; opacity: 1; background: rgba(0,0,0,0.5); width: 16px; height: 16px; border-radius: 8px !important; }
.modal .thumnail a.close img {margin-top: -1px;}
.form_div.sm {height: 450px;}
.form_div.sm .img_box {width: calc(25% - 10px); height: 105px;}

/**/
.boxLine {border: 2px solid #FFF701 !important;box-sizing: border-box;} 
@media (min-width: 991px) {
	#repositoryList > .modal-dialog {
		width: 1000px;
	}
	#repositoryList .file_list {
		left: 15%;
	}
}
</style>
<!-- Sidebar -->
<aside id="sidebar">
	<!-- Sidbar Widgets -->
	<div class="side-widgets overflow">
		<!-- Profile Menu -->
		<div class="text-center s-widget m-b-25 dropdown" id="profile-menu">
			<a href="" data-toggle="dropdown"> <img
				class="profile-pic animated" id="imageFile_view"
				src="${pageContext.request.contextPath}/REPOSITORY/PROFILE/${sessionScope.member_profile}"
				alt="${sessionScope.member_name }"
				onerror="this.src = '${pageContext.request.contextPath}/REPOSITORY/PROFILE/noimage.png';"
				style="cursor: pointer;">
			</a>
			<ul class="dropdown-menu profile-menu">
				<li><div class="fileupload fileupload-new"
						data-provides="fileupload">
						<span class="btn btn-file btn-sm btn-alt"> <span
							class="fileupload-new">이미지 변경</span> <input type="file"
							id="imageFile" onchange="uploadFile.image(this,'imageFile');" />
							<span class="fileupload-exists">이미지 변경</span>
						</span>
					</div></li>
				<li><a data-toggle="modal" href="#memberEdit">비밀번호 변경</a> <i
					class="icon left">&#61903;</i><i class="icon right">&#61815;</i></li>
				<li><a href="${pageContext.request.contextPath}/cms/logout">로그
						아웃</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i></li>
			</ul>
			<h4 class="m-0">${sessionScope.member_name }</h4>

		</div>
		<!-- Calendar -->
		<div class="s-widget m-b-25">
			<div id="sidebar-calendar"></div>
		</div>
		<!-- Feeds -->
		<!-- <div class="s-widget m-b-25">
			<h2 class="tile-title">Notice</h2>
			<div class="s-widget-body">
				<div id="news-feed">
					<i class="icon">&#61710;</i> 펌웨어 가 업데이트 되었습니다.
				</div>
				<div id="news-feed">
					<i class="icon">&#61710;</i> 새 영상이 있습니다.
				</div>
				<div id="news-feed">
					<i class="icon">&#61710;</i> 라이브방송이 편성 되었습니다.
				</div>
			</div>
		</div> -->
		<!-- Server  Info -->
		<div class="s-widget m-b-25">
			<h2 class="tile-title">SERVER INFO</h2>

			<div class="s-widget-body">
				<div class="side-border">
					<small>HARD DISK</small>
					<div class="progress progress-small">
						<a href="#" data-toggle="tooltip" title=""
							class="progress-bar tooltips progress-bar-danger"
							style="width: 0%;" data-original-title="0%" id="diskSpace"> <span
							class="sr-only" >60% Complete</span>
						</a>
					</div>
				</div>
				<div class="side-border">
					<small>MEMORY</small>
					<div class="progress progress-small">
						<a href="#" data-toggle="tooltip" title=""
							class="tooltips progress-bar progress-bar-info"
							style="width: 0%;" data-original-title="0%" id="memorySpace"> <span
							class="sr-only">43% Complete</span>
						</a>
					</div>
				</div>
				<div class="side-border">
					<small>STB CONNECTION</small>
					<div class="progress progress-small">
						<a href="#" data-toggle="tooltip" title=""
							class="tooltips progress-bar progress-bar-warning"
							style="width: 0%;" data-original-title="0%" id="stbConnection"> <span
							class="sr-only">81% Complete</span>
						</a>
					</div>
				</div>
				<!--  <div class="side-border">
                    <small>VB.Net Software Package</small>
                    <div class="progress progress-small">
                         <a href="#" data-toggle="tooltip" title="" class="tooltips progress-bar progress-bar-success" style="width: 10%;" data-original-title="10%">
                              <span class="sr-only">10% Complete</span>
                         </a>
                    </div>
                </div>
                <div class="side-border">
                    <small>Chrome Extension</small>
                    <div class="progress progress-small">
                         <a href="#" data-toggle="tooltip" title="" class="tooltips progress-bar progress-bar-success" style="width: 95%;" data-original-title="95%">
                              <span class="sr-only">95% Complete</span>
                         </a>
                    </div>
                </div> -->
			</div>
		</div>
	</div>

	<!-- Side Menu -->
	<ul class="list-unstyled side-menu">
		<!-- <li class="active"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/dashboard"> <span
				class="icon">&#61753;</span> <span class="menu-item">DASH BOARD</span>
		</a></li> -->
		<li class="menuLi" id="contentsMenuLi"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/media"> <span
				class="icon">&#61696;</span> <span class="menu-item">CONTENTS</span>
		</a></li>
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/contents"> <span
				class="icon">&#61696;</span> <span class="menu-item">CONTENTS ARCHIVE</span>
		</a></li> -->
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/communicate"> <span
				class="icon">&#61875;</span> <span class="menu-item">CATEGORY</span>
		</a></li> -->
		<li class="menuLi" id="pageMenuLi"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/makepage"> <span
				class="icon">&#61875;</span> <span class="menu-item">PAGE</span>
		</a></li>
		<li class="menuLi" id="liveMenuLi"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/liveManages"> <span
				class="icon">&#61824;</span> <span class="menu-item">LIVE</span>
		</a></li>
		
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/layout"> <span
				class="icon">&#61717;</span> <span class="menu-item">MAIN PAGE EDITOR</span>
		</a></li> -->
		
		<!-- <li class="dropdown"><a class="sa-side" href=""> <span
				class="icon">&#61931;</span> <span class="menu-item">셋탑박스 관리</span>
		</a>
			<ul class="list-unstyled menu-item">
				<li><a
					href="${pageContext.request.contextPath}/sedn/stb/controle">셋탑박스
						제어</a></li>
				<li><a
					href="${pageContext.request.contextPath}/sedn/stb/schedule">셋탑박스
						스케쥴</a></li>
				<li><a href="${pageContext.request.contextPath}/sedn/stb/log">셋탑박스
						로그</a></li>
				<li><a href="${pageContext.request.contextPath}/sedn/stb/ui">셋탑박스
						설정</a></li>
			</ul></li>-->
		<li class="menuLi" id="memberMenuLi"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/managerAccount">
				<span class="icon">&#61887;</span> <span class="menu-item">ACCOUNT</span>
		</a></li>
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/statistics"> <span
				class="icon">&#61721;</span> <span class="menu-item">CONTENTS ANALIZER</span>
		</a></li> -->
		<li class="menuLi" id="ottMenuLi"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/stb/controle"> <span
				class="icon">&#61931;</span> <span class="menu-item">OTT</span>
		</a></li>
		<!-- <li><a class="sa-side"
			href="#"> <span
				class="icon">&#61902;</span> <span class="menu-item">UCC MANAGEMENT</span>
		</a></li> -->
		<!-- <li><a class="sa-side"
			href="#"> <span
				class="icon">&#61782;</span> <span class="menu-item">CONFLUENCE MANAGEMENT</span>
		</a></li> -->
		
		<!-- 추가 by MGS -->
		<li class="menuLi" id="ottMenuLi"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/statistics/vod">
<%-- 			href="#" onclick="window.open('${pageContext.request.contextPath}/sedn/statistics/vod' ,
			'통계', 'width=1300, height=800'); return false">  --%>
			<span class="icon">&#61932;</span> <span class="menu-item">통계</span>
		</a></li>
	</ul>

</aside>
<!--######## WARN Modal ######-->
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="alert alert-danger alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="warnText"></span> <i class="icon">&#61730;</i>
	</div>
</div>
<!--######## WARN  Modal ######-->
<!--######## SUCCESS Modal ######-->
<div class="modal fade" id="sucessModal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="alert alert-success alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="successText"></span> <i class="icon">&#61845;</i>
	</div>
</div>
<!--######## SUCCESS  Modal ######-->
<!--######## CONFIRM Modal ######-->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="alert alert-info alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="confirmText"></span> <span class="label label-primary"
			id="confirm-done"
			style="margin-left: 20px; padding: 10px; cursor: pointer;"> 확
			인 </span> <span class="label label-primary" id="confirm-cancel"
			style="margin-left: 20px; padding: 10px; cursor: pointer;"> 취
			소 </span> <i class="icon">&#61770;</i>
	</div>
</div>
<!--######## CONFIRM  Modal ######-->
<!--######## PLAYER MODAL ######-->
<div class="modal fade" id="playerModel" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div
		style="position: fixed; background: rgba(0, 0, 0, 0.5); top: 0; left: 0; right: 0; bottom: 0;"
		id="bgModal" data-dismiss="modal"></div>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true" onClick="modalLayer.playerClean();">&times;</button>
				<h4 class="modal-title" id="playerTitle"></h4>
			</div>
			<div class="modal-body" id="playerBody" style="height: 300px;">

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sm" aria-hidden="true"
					data-dismiss="modal" onClick="modalLayer.playerClean();">Close</button>
				<input type="hidden" id="playerId" />
			</div>
		</div>
	</div>
</div>

<!--######## PLAYER  MODAL ######-->
<!--######## CHANGE CATEGORY  MODAL ######-->
<div class="modal fade" id="changeCateModel" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="playerTitle">카테고리 변경</h4>
			</div>
			<div class="modal-body">
				<div id="modalTree"></div>
			</div>
			<div class="modal-footer">
				
				<button type="button" class="btn btn-sm" id="cateChangeSubmit">
					변 경</button>
				<button type="button" class="btn btn-sm" data-dismiss="modal">
					닫 기</button>
			</div>
		</div>
	</div>
</div>
<!--######## CHANGE CATEGORY  MODAL ######-->
<!--######## ADD CONTENTS MODAL ######-->
<div class="modal fade" id="contentsAddModel" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="addTitle"></h4>
			</div>
			<div class="modal-body">
				<div id="insertForm"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sm" id="contentsAddSubmit">
					확 인</button>
				<button type="button" class="btn btn-sm" data-dismiss="modal">
					닫 기</button>
			</div>
		</div>
	</div>
</div>
<!--######## ADD CONTENTS   MODAL ######-->
<!--######## MEMBEREIDT MODAL######## -->
<div class="modal fade" id="memberEdit" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">관리자 정보 수정</h4>
			</div>
			<form class="box animated tile form-validation-1" id="member-edit"
				method="post"
				action="${pageContext.request.contextPath}/cms/memberEdit">
				<div class="modal-body">
					<input type="text" name="member_name" id="joinName"
						class="form-control m-b-10 validate[required,maxSize[20],custom[onlyLetterSp]]"
						value="${sessionScope.member_name }" placeholder="이름(소속)">
					<input type="password" id="memberPass"
						class="form-control m-b-10 validate[required,funcCall[loginCheck.checkMemberPass]]"
						placeholder="기존비밀번호"> <input type="password"
						name="member_pass" id="joinPass"
						class="form-control m-b-10 validate[required,maxSize[15],minSize[6],custom[onlyLetterNumber]]"
						placeholder="새 비밀번호"> <input type="password"
						class="form-control m-b-20 validate[required,equals[joinPass]]"
						placeholder="새 비밀번호 확인"> <input type="hidden"
						name="member_email" id="memberEmail"
						value="${sessionScope.member_email}"> <input type="hidden"
						name="idx" id="memberIdx" value="${sessionScope.member_idx}">
				</div>
				<div class="modal-footer">
					<input type="submit" class="btn btn-sm" value="정보변경">
					<button type="button" class="btn btn-sm" data-dismiss="modal">Close</button>
				</div>
			</form>
		</div>
	</div>
</div>

 <!-- ################# ADD LIVE TARGET MODAL START################### -->
<div class="modal fade in" id="liveTargetAdd" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="top: 30%;">
        <div class="modal-content">
            <div class="modal-body" style="padding: 30px; overflow: -webkit-paged-x;">
                <div class="col-md-12">
                    <div class="m-b-15 col-md-10" style="top: 5px;">
                        <label class="checkbox-inline">
                            채널이름 : <span id="channelName"></span>
                        </label>
                    </div>
                </div>
				<script>
				$(function(){
					$("button.dropdown-toggle").click(function(){
						if($(".dropdown-menu.open").css("display") == "none"){
							$(".dropdown-menu.open").css("display","block");
							$(this).parent().parent().after(
								'<div class="col-md-3 m-b-15">'+
									'<button class="btn btn-sm" id="asd">닫기</button>'+
								'</div>'
							);
						};
						$("#asd").on('click', function(){
							$(".dropdown-menu.open").css("display","none");
							$("#asd").parent("div").remove();
						});
					});
				});
				</script>
                <div class="col-md-12 m-t-20 m-b-15 p-20" style="border: 1px solid rgba(255, 255, 255, 0.5); width: calc(100% - 29px); left: 15px;">
                    <p style="position: absolute; top: -11px; background: #2c3a45; padding: 0 10px;">방송 대상 선택</p>                            
                    <div class="col-md-7 m-b-15">
                        <div class="btn-group bootstrap-select select">
                            <button type="button" class="btn btn-sm form-control dropdown-toggle">
                                <span class="pull-left">타겟 선택</span>
                            </button>
                            <div class="dropdown-menu open" style="max-height: 654px; overflow: hidden; min-height: auto; padding: 0; background:rgb(25, 27, 31);">
                                <div class="dropdown-menu inner" role="menu" style="max-height: 644px; overflow-y: auto; height: auto;" id="stbGroupCheck">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden"/>
                	<div class="col-md-12" id="modelTargetList">
                    	<!-- 20180419 메뉴삭제 -->
                    	
                    </div>
                </div>
            </div>
               
            <div class="modal-footer">
                <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
                <button class="btn btn-sm pull-right" id="targetInsert">확인</button>
            </div>
        </div>
    </div>
</div>
 <!-- ################# ADD LIVE TARGET MODAL END ################### -->   
 
 <!-- ############### 메디아 모달 시작 ######################### -->
 <div class="modal fade in" id="vodViewModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 <div class="allClick" onClick="common.vodDefault();" data-dismiss="modal"></div>
	<div class="modal-dialog"  id="vodMediaView">
          <div class="modal-content mainImgPopup">
              <div class="media-form">
                  <div class="video" style="cursor:pointer;" id="vodViewArea"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플" id="vodViewMainThumb"></div>
                  <a class="play" style="cursor:pointer;" id="letsPlay"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
                  <a class="info" id="etcInfo" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a>
                  <div class="infoForm" id="etcInfoView" style="display:none;z-index: 9999999999;">
                      <ul>
                          <li>해상도 : <span id="vodViewResolution">1808 x 920</span></li>
                          <li>재생시간 : <span id="vodViewRuntime">01:00:24</span></li>
                          <li>용량 : <span id="vodViewFilesize">3.7GB</span></li>
                      </ul>
                  </div>
              </div>
              <div class="contents">
                  <p class="title" id="vodViewTitle"></p>
                  <div class="data">
                      <p>등록일 :<span id="vodViewDate"> 2018.04.10</span></p>
                      <a class="down" id="vodViewDownload" href="#"><img src="${pageContext.request.contextPath}/ibsImg/btn_download.png" alt="다운로드"></a>
                     <!-- <div class="downForm">
                          <div class="triangle"></div>
                          <a href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"></a>
                          <ul>
                              <li>· <a href="#">Sednmanager.ppt (2MB)</a></li>
                          </ul>
                      </div> --> 
                      <p class="hits" id="vodViewCount"></p>
                  </div>
                  <p class="text" id="vodViewText"></p>
              </div>
              <div class="modal-footer">
                  <button class="btn btn-sm cancel"  data-dismiss="modal">닫기</button>
                  <button class="btn btn-sm pull-right" id="vodViewEdit">편집</button>
              </div>
          </div>
	  </div>
	  <!-- 수정 -->
	  <form role="form" class="form-validation-2" id="vodForm">
	  <div class="modal-dialog" id="vodMediaEdit">
	  	<div class="modal-content">
       		
	        <div class="modal-body">
	            <div class="media-form">
	            	<div class="fileupload fileupload-new" data-provides="fileupload" style="height:323px;" id="vodUploadFeild">
	     					<div class="fileupload-preview thumbnail form-control imgSize" id="vodPreview" style="padding:0;height:323px;">
	     					<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="mediaDefaultImg"></div>
	      					<div class="pull-right">
	          					<span class="btn btn-file btn-alt btn-sm blackBtn" style="position: absolute; top: 20px; left: 20px;">
	              					<span class="fileupload-new">영상 업로드</span>
	              					<span class="fileupload-exists">영상 바꾸기</span>
	              					<input type="file" class="fileUpload" id="vodSection"/>
	              				</span>
	          				</div>
	          				<a class="play" style="cursor:pointer;" id="letsEditPlay"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
	          				<input type="text" id="vod_path" class="validate[required,funcCall[uploadFile.checkVodExist]]" style="opacity: 0;width:1px;height:1px;"> 
	  					</div> 
	            </div>
			    
	            <div class="bx-wrapper" style="margin:0px;">
	            	<div class="slideInner">
	                  <div class="slide">
	                  	<ul id="vodSlideShow">
	                  		<!-- 초기화를 위해 비워둠 -->
	                  	</ul>
	                  	
                      </div>
                      <input type="text" class="validate[required]" id="thumnailList" style="opacity: 0;width:1px;height:1px;">
                      <input type="file" id="fromPCPhotoForm" style="display:none">
                      <div>
                          <a class="prev" onClick='slide.prev();'>prev</a>
                          <a class="next" onClick='slide.next();'>next</a>
                      </div>
                  </div>
	            </div>
	            <div class="get" id="thumnailSource" style="position: absolute;z-index:10000000; top: 280px; right: 35px; display: none;">
                     <div class="btn btn-sm pull-left m-b-5 blackBtn" id="photoFromPc">PC에서 썸네일 가져오기</div><br>
                     <div class="btn btn-sm pull-left blackBtn" onclick="common.selectRepoSource('media');">저장소에서 썸네일 가져오기</div>
                 </div>
	            <input type="text" id="vod_title" class="form-control m-b-10 validate[required,maxSize[40]]" placeholder="제목">
	            <textarea id="vod_content" class="form-control m-b-10 validate[required]" placeholder="내용"></textarea>
	            <input type="hidden" class="form-control" id="vodIdx" />
				<input type="hidden" class="form-control" id="keyword" value="동영상"/>
				<input type="hidden" class="form-control" id="file_size"/>
				<input type="hidden" class="form-control" id="vod_play_time"/>
				<input type="hidden" class="form-control" id="main_thumbnail"/>
				<!-- 플레이어 히든  -->
				<input type="hidden" class="form-control" id="play_url"/>
				<input type="hidden" class="form-control" id="play_thum"/>
	        </div>
        <div class="modal-footer">
            <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
            <button class="btn btn-sm" id="mediaConfirm">확인</button>
            <div class="pull-right">
            	<button class="btn btn-sm" id="mediaDel">삭제</button>
            </div>
         </div>
    </div>
	  </div>
	
	</form> 
 </div> 

 <!-- ############### 포토 편집 모달 시작 ######################### -->
 <div class="modal fade in" id="photoViewModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 <div class="allClick"  data-dismiss="modal"></div>
	<div class="modal-dialog"  id="photoMediaView">
          <div class="modal-content mainImgPopup">
              <div class="media-form">
              	 <div class="video" style="cursor:pointer;" id="photoViewArea"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플" id="photoViewMainThumb"></div>
                 <a class="info" id="photoEtcInfo" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a>
                 <div class="infoForm" id="photoEtcInfoView" style="display:none;z-index: 9999999999;">
                      <ul>
                          <li>해상도 : <span id="photoViewResolution">1808 x 920</span></li>
                          <li>용량 : <span id="photoViewFilesize">3.7GB</span></li>
                      </ul>
                  </div>
              </div>
              <div class="contents">
                  <p class="title" id="photoViewTitle"></p>
                  <div class="data">
                      <p>등록일 :<span id="photoViewDate"> 2018.04.10</span></p>
                      <a class="down" id="photoViewDownload" href="#"><img src="${pageContext.request.contextPath}/ibsImg/btn_download.png" alt="다운로드"></a>
                      <p class="hits" id="photoViewCount"></p>
                  </div>
                  <p class="text" id="photoViewText"></p>
              </div>
              <div class="modal-footer">
                  <button class="btn btn-sm cancel"  data-dismiss="modal">닫기</button>
                  <button class="btn btn-sm pull-right" id="photoViewEdit">편집</button>
              </div>
          </div>
	  </div>
	  <!-- 수정 -->
	  <form role="form" class="form-validation-3" id="photoForm">
	  <div class="modal-dialog" id="photoMediaEdit">
	  	<div class="modal-content">
       		
	        <div class="modal-body">
	            <div class="media-form">
	            	<div class="fileupload fileupload-new" data-provides="fileupload" style="height:323px;" id="photoUploadFeild">
	     					<div class="fileupload-preview thumbnail form-control imgSize" id="photoPreview" style="padding:0;height:323px;">
	     					<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="photoDefaultImg"></div>
	      					<div class="pull-right">
	          					<span class="btn btn-file btn-alt btn-sm blackBtn" style="position: absolute; top: 20px; left: 20px;">
	              					<span class="fileupload-new">포토 업로드</span>
	              					<span class="fileupload-exists">포토 바꾸기</span>
	              					<input type="file" class="fileUpload" id="photoSection"/>
	              				</span>
	          				</div>
	          				<input type="text" id="photo_path" class="validate[required,funcCall[uploadFile.checkPhotoExist]]" style="opacity: 0;width:1px;height:1px;"> 
	  					</div> 
	            </div>
	            <input type="text" id="photo_title" class="form-control m-b-10 validate[required,maxSize[40]]" placeholder="제목">
	            <textarea id="photo_content" class="form-control m-b-10 validate[required]" placeholder="내용"></textarea>
	            <input type="hidden" class="form-control" id="photoIdx" />
				<input type="hidden" class="form-control" id="photoKeyword" value="동영상"/>
				<input type="hidden" class="form-control" id="photo_size"/>
	        </div>
        <div class="modal-footer">
            <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
            <button class="btn btn-sm" id="photoConfirm">확인</button>
            <div class="pull-right">
            	<div class="pull-right"><button class="btn btn-sm" id="photoDel">삭제</button></div>
            </div>
        </div>
    </div>
	  </div>
	
	</form> 
 </div> 
 <!--############### 포토 편집 모달 끝  ###############--> 
 
 <!-- ############### 파일 편집 모달 시작 ######################### -->
 <div class="modal fade in" id="fileViewModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 <div class="allClick" onClick="common.fileDefault();" data-dismiss="modal"></div>
	<div class="modal-dialog"  id="fileMediaView">
          <div class="modal-content mainImgPopup">
              <div class="media-form">
                  <div class="video" style="cursor:pointer;" id="fileViewArea"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플" id="fileViewMainThumb"></div>
				  <a class="info" id="fileEtcInfo" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a>
                 <div class="infoForm" id="fileEtcInfoView" style="display:none;z-index: 9999999999;">
                      <ul>
                          <li>파일형태 : <span id="fileViewResolution">1808 x 920</span></li>
                          <li>용량 : <span id="fileViewFilesize">3.7GB</span></li>
                      </ul>
                  </div>              	
              </div>
              <div class="contents">
                  <p class="title" id="fileViewTitle"></p>
                  <div class="data">
                      <p>등록일 :<span id="fileViewDate"> 2018.04.10</span></p>
                      <a class="down" id="fileViewDownload" href="#"><img src="${pageContext.request.contextPath}/ibsImg/btn_download.png" alt="다운로드"></a>
                      <p class="hits" id="fileViewCount"></p>
                  </div>
              </div>
              <div class="modal-footer">
                  <button class="btn btn-sm cancel"  data-dismiss="modal">닫기</button>
                  <button class="btn btn-sm pull-right" id="fileViewEdit">편집</button>
              </div>
          </div>
	  </div>
	  <!-- 수정 -->
	  <form role="form" class="form-validation-4" id="fileForm">
	  <div class="modal-dialog" id="fileMediaEdit">
	  	<div class="modal-content">
       		
	        <div class="modal-body">
	            <div class="media-form">
	            	<div class="fileupload fileupload-new" data-provides="fileupload" style="height:323px;" id="fileUploadFeild">
	     					<div class="fileupload-preview thumbnail form-control imgSize" id="filePreview" style="padding:0;height:323px;">
	     					<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="fileDefaultImg"></div>
	      					<div class="pull-right">
	          					<span class="btn btn-file btn-alt btn-sm blackBtn" style="position: absolute; top: 20px; left: 20px;">
	              					<span class="fileupload-new">파일 업로드</span>
	              					<span class="fileupload-exists">파일바꾸기</span>
	              					<input type="file" class="fileUpload" id="fileSection"/>
	              				</span>
	          				</div>
	          				<input type="text" id="file_path" class="validate[required,funcCall[uploadFile.checkFileExist]]" style="opacity: 0;width:1px;height:1px;"> 
	  					</div> 
	            </div>
	            <input type="text" id="file_title" class="form-control m-b-10 validate[required]" placeholder="파일설명">
	            <input type="hidden" class="form-control" id="fileIdx" />
				<input type="hidden" class="form-control" id="fileKeyword" value="동영상"/>
				<input type="hidden" class="form-control" id="uploadFile_size"/>
				<input type="hidden" id="file_ext" value=""/>
	        </div>
        <div class="modal-footer">
            <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
            <button class="btn btn-sm" id="fileConfirm">확인</button>
            <div class="pull-right">
            	<button class="btn btn-sm" id="fileDel">삭제</button>
            </div>
        </div>
    </div>
	  </div>
	
	</form> 
 </div> 
 <!--############### 파일 편집 모달 끝  ###############--> 

<!-- ###############스트림 편집 모달 시작 ######################### -->
<div class="modal fade in" id="streamViewModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 <div class="allClick" onClick="common.delCashPlayer('vodPlayer');" data-dismiss="modal"></div>
	<div class="modal-dialog"  id="streamMediaView">
          <div class="modal-content mainImgPopup">
              <div class="media-form">
                  <div class="video" style="cursor:pointer;" id="streamViewArea"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플" id="streamViewMainThumb"></div>
              </div>
              <div class="contents">
                  <p class="title" id="streamViewTitle"></p>
                  <div class="data">
                     <p>등록일 :<span id="streamViewDate">2018.04.10</span>&nbsp;&nbsp;</p>
                     <p class="hits"> <span id="streamViewCount"></span></p>
                  </div>
                  <p class="text" id="streamViewAddress"></p>
              </div>
              <div class="modal-footer">
                  <button class="btn btn-sm cancel"  data-dismiss="modal">닫기</button>
                  <button class="btn btn-sm pull-right" id="streamViewEdit">편집</button>
              </div>
          </div>
	  </div>
	  <!-- 수정 -->
	  <form role="form" class="form-validation-5" id="streamForm">
		<div class="modal-dialog" style="width:500px; margin-top: 100px;" id="streamMediaEdit">
            <div class="modal-content">                            
                <div class="modal-body" style="text-align: center;">
                    <p class="p-10">LIVE 정보를 입력하세요.</p>
                    <input type="text" id="streamTitle" class="form-control m-b-10 validate[required,maxSize[40],custom[onlyLetterSp]]" placeholder="채널명" />
                    <input type="text" id="streamAddress" class="form-control validate[required,maxSize[100],custom[url]]" placeholder="주소" />
                    <input type="hidden" class="form-control" id="streamIdx" />
                </div>
                <div class="modal-footer" style="text-align: center;">
                    <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
            		<button class="btn btn-sm" id="streamConfirm">확인</button>
            		<div class="pull-right">
            			<button class="btn btn-sm" id="streamDel">삭제</button>
            		</div>
                </div>
            </div>
        </div>
	  </form> 
 </div> 
<!-- ###############스트림 편집  모달 끝 ######################### --> 
 
 <!-- ###############게시물 편 모달 시작 ######################### -->
 <div class="modal fade in" id="boardViewModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 <div class="allClick" onClick="common.boardDefault();" data-dismiss="modal"></div>
	<div class="modal-dialog"  id="boardMediaView">
          <div class="modal-content mainImgPopup">
              <div class="media-form">
                  <div class="video" style="cursor:pointer;" id="boardViewArea"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플" id="boardViewMainThumb"></div>
                  <a class="play" style="cursor:pointer;" id="boardLetsPlay"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
                  <a class="info" id="boardEtcInfo" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a>
                  <div class="infoForm" id="boardEtcInfoView" style="display:none;z-index: 9999999999;">
                      <ul>
                          <li>해상도 : <span id="boardViewResolution">1808 x 920</span></li>
                          <li>재생시간 : <span id="boardViewRuntime">01:00:24</span></li>
                          <li>용량 : <span id="boardViewFilesize">3.7GB</span></li>
                      </ul>
                  </div>
              </div>
              <div class="contents">
                  <p class="title" id="boardViewTitle"></p>
                  <div class="data">
                      <p>등록일 :<span id="boardViewDate"> 2018.04.10</span></p>
                      <a class="down" id="boardViewDownload"><img src="${pageContext.request.contextPath}/ibsImg/btn_download.png" alt="다운로드"></a>
                     <div class="downForm" id="downloadList">
                          <div class="triangle"></div>
                          <a href=""><img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"></a>
                          <ul id="downloadUl">
                          </ul>
                      </div> 
                      <p class="hits" id="boardViewCount">aaa</p>
                  </div>
                  <div id="photoList"></div>
                  <p class="text" id="boardViewText"></p>
              </div>
              <div class="modal-footer">
                  <button class="btn btn-sm cancel"  data-dismiss="modal">닫기</button>
                  <button class="btn btn-sm pull-right" id="boardViewEdit">편집</button>
              </div>
          </div>
	  </div>
	  <!-- 수정 -->
	  <form role="form" class="form-validation-6" id="boardForm">
	  <div class="modal-dialog" id="boardMediaEdit">
	  	<div class="modal-content">
       		
	        <div class="modal-body">
	            <div class="media-form">
	            	<div style="height:323px;" id="boardUploadFeild">
	     					<div id="boardPreview" style="padding:0;height:323px;">
	     					<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="boardDefaultImg"></div>
	      					<div class="pull-right" onclick="common.selectRepoSource('vod');">
	          					<span class="btn btn-file btn-alt btn-sm blackBtn" style="position: absolute; top: 20px; left: 20px;" >
	              					<span >영상 가져오기</span>
	              				</span>
	          				</div>
	          				<a class="play" style="cursor:pointer;" id="boardLetsEditPlay"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
	          				
	  				</div> 
	            	<input type="text" id="vodRepo"  class="validate[required]" style="opacity: 0;width:1px;height:1px;"/>
	            </div>
			    
	            <div class="bx-wrapper" style="margin:0px;">
	            	<div class="slideInner">
	                  <div class="slide">
	                  	<ul id="boardSlideShow">
	                  		<!-- 초기화를 위해 비워둠 -->
	                  		<li><a class="add" onclick="arange.selectRepoSource('photo');"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>
	                  	</ul>
	                  	
                      </div>
                      <div>
                          <a class="prev" onClick='slide.prev();'>prev</a>
                          <a class="next" onClick='slide.next();'>next</a>
                      </div>
                  </div>
	            </div>
	            
	            <input type="text" id="board_title" class="form-control m-b-10 validate[required,maxSize[100]]" placeholder="제목">
	            <textarea id="board_content" class="form-control m-b-10 validate[required]" placeholder="내용"></textarea>
	            <div id="saveFileList"></div>
	            <input type="hidden" class="form-control" id="boardIdx" />
				<input type="hidden" class="form-control" id="boardKeyword" value="동영상"/>
				<input type="hidden" class="form-control" id="boardFile_size"/>
				<input type="hidden" class="form-control" id="photoRepo"/>
				<input type="hidden" class="form-control" id="fileRepo"/>
				<!-- 플레이어 히든  -->
				<input type="hidden" class="form-control" id="boardPlay_url"/>
				<input type="hidden" class="form-control" id="boardPlay_thum"/>
	        </div>
        <div class="modal-footer">
            <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
            <button class="btn btn-sm" id="boardConfirm">확인</button>
            <div class="pull-right">
            	 <button class="btn btn-sm" id="boardDel">삭제</button>
            </div>
        </div>
    </div>
	  </div>
	</form> 
 </div> 
 <!-- ###############게시물 편집 모달  끝 ######################### --> 

 <!-- ###############스케쥴 모달 시작 ######################### -->
 <div class="modal fade in" id="addNew-event" tabindex="-1" role="dialog" aria-hidden="false"> 
 	<div class="allClick" onClick="arange.delJsPlayer();" data-dismiss="modal"></div>
 	<div class="modal-dialog" id="scheduleView" style="display:none;">
        <div class="modal-content mainImgPopup" id="thumbnailView">
            <div class="media-form" id="defaultPlayer">
                <div class="video"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" id="liveViewImg" alt="샘플"></div>
                <a class="play" ><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" id="playArrow" alt="재생"></a>
            </div>
            <div class="media-form video" id="liveJsPlayer" style="display:none;height:320px;">
                
            </div>
            <div class="contents">
               
                <p class="title" id="scheduleTitle">VOD 방송 #1</p>
                <div class="data">
                    <p class="bell"><i class="fa fa-bell"></i> <span id="scheduleTime">2018.4.10 13:30~15:00</span></p>
                </div>
                <p class="text" id="liveDesc"></p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm cancel" onClick="arange.delJsPlayer();"  data-dismiss="modal">취소</button>
                <button class="btn btn-sm pull-right" id="scheduleEditCancel">편집</button>
            </div>
        </div>
    </div> 
	 	

	<div class="modal-dialog" id="scheduleEdit">
         <div class="modal-content mainImgPopup">
         	     
             <div class="modal-body" style="overflow:hidden;">
              <form class="form-validation">
                 <div class="media-form">
                 	<div class="fileupload fileupload-new" data-provides="fileupload" style="height:323px;">
     					<div class="fileupload-preview thumbnail form-control imgSize" id="imgName_view" style="padding:0;height:323px;">
     					<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="liveDefaultImg" class="upImageSize"></div>
      					<div class="pull-right">
          					<span class="btn btn-file btn-alt btn-sm blackBtn" style="position: absolute; top: 20px; left: 20px;">
              					<span class="fileupload-new">대표 이미지</span>
              					<span class="fileupload-exists">이미지 바꾸기</span>
              					<input type="file" id="imgName" onchange="uploadFile.scheduleImg(this,'imgName');" />
              				</span>
          				</div>
          				<input type="text" id="image_path" class="validate[required]" style="opacity: 0;width:1px;height:1px;"> 
  					</div> 
                 </div>
                 <div class="slideInner">
	                  <div class="slide">
	                  	<ul id="slideShow">
	                  		<!-- 초기화를 위해 비워둠 -->
	                  	</ul>
                      </div>
                      <div>
                          <a class="prev" onClick='slide.prev();'>prev</a>
                          <a class="next" onClick='slide.next();'>next</a>
                      </div>
                  </div>
                  <input type="hidden" class="form-control" id="live_stream_url"/>
                  <input type="hidden" class="form-control" id="tmpStreamName"/>
                  <input type="hidden" class="form-control" id="color" value="#9FD5EF">
                  <input type="hidden" id="vodArr" class="form-control"/>
                  <input type="hidden" id="groupArr" class="form-control"/>
                  <input type="hidden" class="form-control" id="idx"/>
                  <input type="hidden" class="form-control" id="source_type"  value="VOD"/>
              	  <input type="hidden" class="form-control" id="live_ch_idx" class="form-control"/>
                  <input type="hidden" class="form-control" id="captionYn" value="N">
                  <input type="hidden" class="form-control" id="order" value="insert">
                 <div class="col-md-9 m-b-10">
                     <input type="text" class="form-control validate[required]" id="eventName" placeholder="제목" value="" placeholder="방송 제목">
                 </div>
                 <div class="col-md-3 m-b-10" id="check">
	             	<div class="icheckbox_minimal">
	             		<div aria-checked="false" aria-disabled="false" style="position: relative;">
                       		<input type="checkbox" id="forceLive"/>
                         		강제방송 설정
                     	</div>
                 	</div>
                 </div>
                 <div class="col-md-6 m-b-10">
                     <input type="text" class="form-control validate[required]" id="getStart" value="" placeholder="예)2018-01-01 23:12:06:49">
                 </div>
                 <div class="col-md-6 m-b-10">
                     <input type="text" class="form-control validate[required,funcCall[uploadFile.checkSchedule]]" id="getEnd"  value="" placeholder="예)2018-01-01 23:12:06:49">
                 </div>
                 <div class="col-md-12 m-b-10"><textarea class="form-control m-b-10 validate[required]" id="desc_text" placeholder="내용"></textarea></div>
             	</form>
             </div> 
                                 
             <div class="modal-footer" style="margin-top:0;">
                 <button type="button" class="btn btn-sm" data-dismiss="modal">취소</button>
                 <button type="button" class="btn btn-sm" id="scheduleDel">삭제</button>
                 <input type="button"  class="btn btn-sm pull-right" id="addEvent" value="확인">
             </div>
             
         
         </div>
         
     </div>
 </div> 
 <!-- ###############스케쥴 편집 모달 끝 ######################## -->
 <!-- ################## content list modal start####################--> 
 <div class="modal fade in" id="repositoryList" tabindex="-1" role="dialog" aria-hidden="false"> 
    <div class="modal-dialog" style="margin-top: 10%;">
        <div class="modal-content"> 
            <div class="modal-header" style="overflow: hidden;">
                <h5 class="pull-left">저장소에서 가져오기</h5>
                <div class="pull-right">
                    <div class="col-md-4 p-r-20 m-t-5">
                        <select id="repoType" class="form-control input-sm">
                           
                        </select>
                    </div>
                    <div class="col-md-8 p-0">                                        
                        <input type="text" class="main-search" id="schedule-contents-search" style="border-bottom: 1px solid #fff; width: 100%;" placeholder="검색어를 입력하세요." />                               
                    	<input type="hidden" class="form-control" id="searchIdx"   >
                    </div>
                </div>
            </div>                           
            <div class="modal-body" style="text-align: center;">
               <div class="col-md-12">
                   <div class="col-md-4" style="width:13%;">
                   <!-- TREE START-->
					<div  id="video" style="position:relative; left:-25px;"></div>
					<!-- TREE END-->
          		</div>
                   
                   <div class="col-md-8 file_list" style="padding:0;">
                       <div class="tile">
                           <div class="photo-gallery clearfix">
                               <div class="photo">
                                   <div class="form_div sm col-md-12" style="margin:0; padding:0; width:100%;" id="repoListPage">
                                   <!-- 리스트 뿌려지는곳  -->    
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>                        
               </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
                <button class="btn btn-sm pull-right" id="selectIdxArr">확인</button>
            </div>
        </div>
    </div>
</div><!-- //저장소 -->
            
  <!-- ################## content list modal end####################-->   
  <!-- --업로드 프로그래스 바 시작  -->
<div class="modal fade in" id="progressLayout" tabindex="-1" role="dialog" aria-hidden="false"> 
     <div class="modal-dialog" style="width:500px; margin-top: 10%;">
         <div class="modal-content">
         	<div class="modal-header">업로드 </div> 
             <div class="modal-body" style="text-align: center;">
             	
                 <p style="left: 50%;" id="encodingText" style="display:none;">파일 업로드 중 입니다.</p>
                 <!-- <div class="progress progress-small">
                     <a href="#" class="tooltips progress-bar progress-bar-info" style="width: 78%;"></a>
                 </div> -->
                 <div class="progress progress-small active" id="progressBarLayout" style="display:none;" >
			         <div class="progress-bar"  role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="progressBar">
			             <span class="sr-only" id="barText">0% Complete</span>
			         </div>
			    </div>
				<div class="progress progress-smalls active  progress-alt" id="encodingBarLayout" style="display:none;">
			        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="encodingBar"></div>
			    </div>
             </div>
             <div class="modal-footer" style="text-align: center;">
                 <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
             </div>
         </div>
     </div>
 </div>
<!-- 업로드 프로그래스 바 끝 -->                          
<script>
$(function(){
	system.nowInfo();
	String.prototype.lines = function() { return this.split(/\r*\n/); }
	String.prototype.lineCount = function() { return this.lines().length; }
	$('#caption').keyup(function(){
		if($('#caption').val().length>255||$('#caption').val().lineCount()>3){
			jQuery('#caption').validationEngine('showPrompt', '자막은 255자 이하 3줄이하 입니다.', 'pass')
			return false;
		}else{
			jQuery('#vodSource').validationEngine('hideAll');
			$('#nowLetter').text($('#caption').val().length);
		}
	});
	$('#captionView').click(function(ev){
		if($("#captionForm").css('display')=='block'){
			$("#caption").val('');
			$("#caption_size").val('');
			$("#caption_text_color").val('');
			$("#captionForm").css('display','none');
			$('#captionYn').val('N');
			$(this).html('자 막 설 정 열 기');
		}else{
			$("#captionForm").css('display','block');
			$(this).html('자 막 설 정 닫 기');
			$('#captionYn').val('Y');
		}
		ev.preventDefault();
	});
});

	/**Login Check JS**/
	var loginCheck = (function() {
		var catText = "EXIST";
		var catPass = "EXIST";
		var catExist = "NOT_EXIST";
		var checkMemberEmail = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="
								+ $("#memberEmail").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catText = data.msg;
						},
						error : exception.ajaxException
					});
			if (catText != "EXIST") {
				return options.allrules.validate2fields.alertEmail;
			}
		};
		var checkLostEmail = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="
								+ $("#lostEmail").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catText = data.msg;
						},
						error : exception.ajaxException
					});
			if (catText != "EXIST") {
				return options.allrules.validate2fields.alertEmail;
			}
		};
		var checkMemberPass = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberPass?member_email="
								+ $("#memberEmail").val()
								+ "&member_pass="
								+ $("#memberPass").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catPass = data.msg;
						},
						error : exception.ajaxException
					});
			if (catPass != "EXIST") {
				return options.allrules.validate2fields.alertPass;
			}
		};
		var checkEmailExist = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="
								+ $("#joinEmail").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catExist = data.msg;
						},
						error : exception.ajaxException
					});
			if (catExist != "NOT_EXIST") {
				return options.allrules.validate2fields.alertExist;
			}
		};
		var checkImageExist = function(field, rules, i, options) {
			if ($("#imageFile").val().length == 0) {
				return options.allrules.validate2fields.alertImage;
			}
		};
		return {
			checkMemberEmail : checkMemberEmail,
			checkMemberPass : checkMemberPass,
			checkEmailExist : checkEmailExist,
			checkImageExist : checkImageExist,
			checkLostEmail : checkLostEmail
		};
	}());
	
	/***Exception JS****/
	var exception = (function() {
		var ajaxException = function(data) {
			$("#warnText").text("AJAX EXCEPTION:" + data);
			$("#msgModal").modal();
		};
		var loginException = function() {
			$("#warnText").text("LOGIN ERROR:로그인에 오류가 있습니니다.");
			$("#msgModal").modal();
		};
		var imageFileSizeException = function() {
			$("#warnText").text("2MB 이하 이미지만 업로드 가능합니다. ");
			$("#msgModal").modal();
		};
		var etcFileSizeException = function() {
			$("#warnText").text("30MB 이하 파일만 업로드 가능합니다. ");
			$("#msgModal").modal();
		};
		var imageFileExtException = function() {
			$("#warnText").text("jpg,jpeg,gif,png 파일만 업로드 가능합니다.");
			$("#msgModal").modal();
		};
		var etcFileExtException = function() {
			$("#warnText").text("zip,rar,hwp,doc,ppt,xlx,ai,pdf,pds,mp3 파일만 업로드 가능합니다.");
			$("#msgModal").modal();
		};
		var imageFileUpdateException = function() {
			$("#warnText").text("이미지 업데이트에 실패했습니다.");
			$("#msgModal").modal();
		};
		var fileUpdateException = function() {
			$("#warnText").text("이미지 업로드에 실패했습니다.");
			$("#msgModal").modal();
		};
		var searchException = function() {
			$("#warnText").text("검색어를 입력해 주세요.");
			$("#msgModal").modal();
		};
		var checkboxException = function() {
			$("#warnText").text("체크박스를 한개 이상 체크 해 주세요.");
			$("#msgModal").modal();
		};
		var liveException = function(){
			$("#warnText").text("방송중인 스케쥴은 수정할수 없습니다.");
			$("#msgModal").modal();
		};
		var delConfirm = function(callback) {
			$("#confirm-done").on("click", function() {
				callback(true);
				$("#confirmModal").modal('hide');
			});
			$("#confirm-cancel").on("click", function() {
				callback(false);
				$("#confirmModal").modal('hide');
			});
		};
		var scheduleDelConfirm = function(callback) {
			$("#confirm-done").on("click", function() {
				callback(true);
				$("#confirmModal").modal('hide');
				$('#addNew-event').modal('hide');
			});
			$("#confirm-cancel").on("click", function() {
				callback(false);
				$("#confirmModal").modal('hide');
				$('#addNew-event').modal('hide');
			});
		};
		var addGroupException = function() {
			$("#warnText").text("그룹 추가에 실패하였습니다.");
			$("#msgModal").modal();
		};
		var rootException = function() {
			$("#warnText").text("루트 그룹은 변경이 불가합니다.");
			$("#msgModal").modal();
		};
		var renameException = function() {
			$("#warnText").text("그룹이름 변경에 실패했습니다.");
			$("#msgModal").modal();
		};
		var moveException = function() {
			$("#warnText").text("그룹 이동에 실패했습니다.");
			$("#msgModal").modal();
		};
		var delGroupException = function() {
			$("#warnText").text("그룹 삭제에 실패했습니다.");
			$("#msgModal").modal();
		};
		var keywordException = function() {
			$("#warnText").text("키워드를 입력해주세요.");
			$("#msgModal").modal();
		};
		var menuMakeException = function() {
			$("#warnText").text("생성된 메뉴의 하위메뉴를 만들 수 없습니다.");
			$("#msgModal").modal();
		};
		var contentsAddException = function() {
			$("#warnText").text("하위 메뉴가 있는 메뉴에는 컨텐츠를 추가 할 수 없습니다.");
			$("#msgModal").modal();
		};
		var beforeSelectException=function(){
			$("#warnText").text("트리 메뉴를 하나 선택하세요.");
			$("#msgModal").modal();
		};
		var subMainException=function(){
			$("#warnText").text("서브 메인 메뉴를 먼저 만드세요.");
			$("#msgModal").modal();
		}
		return {
			ajaxException : ajaxException,
			loginException : loginException,
			imageFileSizeException : imageFileSizeException,
			etcFileSizeException : etcFileSizeException,
			imageFileExtException : imageFileExtException,
			etcFileExtException : etcFileExtException,
			imageFileUpdateException : imageFileUpdateException,
			searchException : searchException,
			checkboxException : checkboxException,
			delConfirm : delConfirm,
			scheduleDelConfirm :scheduleDelConfirm,
			addGroupException : addGroupException,
			rootException : rootException,
			renameException : renameException,
			moveException : moveException,
			delGroupException : delGroupException,
			keywordException : keywordException,
			fileUpdateException :fileUpdateException,
			liveException : liveException,
			menuMakeException :menuMakeException,
			contentsAddException : contentsAddException,
			beforeSelectException: beforeSelectException,
			subMainException : subMainException
		};
	}());
	/***file upload JS***/
	var uploadFile = (function() {
		var image = function(f, section) {
			var file = f.files;
			if (file[0].size > 2048 * 1024) {
				exception.imageFileSizeException();
				return;
			}
			var localPath = $("#" + section).val();
			var ext = localPath.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				exception.imageFileExtException();
				return false;
			}
			var reader = new FileReader();
			reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
				$("#" + section + "_view").attr("src", rst.target.result);
			}
			reader.readAsDataURL(file[0]); // 파일을 읽는다
			var formData = new FormData();
			formData.append("uploadFile", f.files[0]);
			formData.append("member_idx", "${sessionScope.member_idx }");
			$
					.ajax({
						url : '${pageContext.request.contextPath}/SEQ/UPLOAD/PROFILE',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						success : function(responseData) {
							var data = JSON.parse(responseData);
							$
									.ajax({
										url : "${pageContext.request.contextPath}/api/web/profileUpdate?member_idx=${sessionScope.member_idx }&member_email=${sessionScope.member_email }&member_profile="
												+ data.fileName,
										success : function(data) {
											console.log("success");
										},
										error : exception.imageFileUpdateException
									});
						}
					});
		};
		var mainImage = function(f, section) {
			var file = f.files;
			if (file[0].size > 4048 * 1024) {
				exception.imageFileSizeException();
				return;
			}
			var localPath = $("#" + section).val();
			var ext = localPath.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				exception.imageFileExtException();
				return false;
			}
			var reader = new FileReader();
			reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
				$("#" + section + "_view").attr("src", rst.target.result);
			}
			reader.readAsDataURL(file[0]); // 파일을 읽는다
			var formData = new FormData();
			formData.append("uploadFile", f.files[0]);
			$
					.ajax({
						url : '${pageContext.request.contextPath}/SEQ/UPLOAD/CAROUSEL',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						success : function(responseData) {
							var data = JSON.parse(responseData);
							$("#img_name").val(data.fileName);
						}
					});
		};
		var scheduleImg=function(f,section){
			var file = f.files;
			if (file[0].size > 4048 * 1024) {
				exception.imageFileSizeException();
				return;
			}
			var localPath = $("#" + section).val();
			var ext = localPath.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				exception.imageFileExtException();
				return false;
			}
			var reader = new FileReader();
			reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
				$("#" + section + "_view").attr("src", rst.target.result);
			}
			reader.readAsDataURL(file[0]); // 파일을 읽는다
			var formData = new FormData();
			formData.append("uploadFile", f.files[0]);
			$
			.ajax({
				url : '${pageContext.request.contextPath}/SEQ/UPLOAD/SCHIMG',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				success : function(responseData) {
					var data = JSON.parse(responseData);
					$("#image_path").val(data.fileName);
				}
			});
		};
		var checkFileExist = function(field, rules, i, options) {
			if ($("#file_path").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkPhotoExist = function(field, rules, i, options) {
			if ($("#photo_path").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkMainImgExist = function(field, rules, i, options) {
			if ($("#img_name").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkVodExist = function(field, rules, i, options) {
			if ($("#vod_path").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkSchedule=function(field, rules, i, options){
			var start=new Date(Date.parse($("#getStart").val()));
			var end=new Date(Date.parse($("#getEnd").val()));
			if(start>=end){
				return options.allrules.validate2fields.alertSchedule;
			}
		};
		/**인코딩이 100% 될때까지 호출실제 동작하는 함수 */
		var mediaEncoding=function(file){
			var trans_rate=0;
			$.ajax({
				url : "${pageContext.request.contextPath}/api/web/mediaEncodingRate?file="
						+ file,
				beforeSend : function() {
					$("#encodingText").text('인코딩이 진행 중 입니다.');
				},
				success : function(responseData) {
					var data = JSON.parse(responseData);
					var trans_rate=0;
					console.log('mediaEncoding', data);
					trans_rate =data.rate;
					if(trans_rate<100){
						setTimeout(function(){
							$("#encodingBar").css('width',trans_rate+'%');
							if(trans_rate>0){
								$("#encodingText").text('인코딩 '+trans_rate+'% 완료');
							}
							mediaEncoding(data.file);
						},500);
					}else{
						$("#encodingBarLayout").css('display','none');
						$("#encodingBar").css('width',0+'%');
						$("#vod_path").val(data.file);
						//runtime&thubnail
						$("#vod_play_time").val(data.vod_play_time);
						$("#main_thumbnail").val(data.main_thumbnail);
						$("#file_size").val(data.file_size);
						//올린 영상 보여주기.
						modalLayer.vodPlayer(data.url,"${pageContext.request.contextPath}/REPOSITORY/THUMBNAIL"+data.main_thumbnail_url,"vodPreview");
						//썸네일 보여주기
						var fileHead=data.file.split('.');
						//슬라이드 셋팅
						$("#vodSlideShow").empty();
						var retHtml="";
						var thumbnailArr=[];
						for(var i=0;i<10;i++){
							$("#vodSlideShow").css("display","none");
							retHtml="";
							thumbnailArr.push(fileHead[0]+'_'+i+".jpg");
							var backgroundUrl="${pageContext.request.contextPath}/REPOSITORY/THUMBNAIL"+data.datePath+fileHead[0]+'_'+i+".jpg";
							var fileIdx=fileHead[0]+'_'+i+'.jpg';
							retHtml+='<li class="thum" style="float:left;background: url('+backgroundUrl
							+') no-repeat center; background-size: cover;" id="thumbLi_'+fileIdx.split('.')[0]+'" onClick="arange.makeMainThumb(\''+fileIdx.split('.')[0]+'\',\''+fileIdx.split('.')[1]+'\')">'
                  			+'<a class="close" onClick="arange.removeThumbLi(\''+fileIdx.split('.')[0]+'\',\''+fileIdx.split('.')[1]+'\');"><img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"/></a>'
                  			+'</li>'
							$("#vodSlideShow").append(retHtml);
							if(i==0){
								$('.thum').addClass('boxLine');
							}
						}
						$('#progressLayout').modal('hide');
						setTimeout(function(){
							$("#thumnailList").val(thumbnailArr);
							$("#vodSlideShow").css("display","block");
						},5000);
						$('#vodSlideShow').append('<li id="addLi"><a class="add" onclick="arange.selectSource();"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
						slide.init();
					}
				}
			});
		};
		return {
			image : image,
			checkFileExist:checkFileExist,
			checkPhotoExist:checkPhotoExist,
			checkMainImgExist:checkMainImgExist,
			checkVodExist:checkVodExist,
			mediaEncoding:mediaEncoding,
			mainImage:mainImage,
			checkSchedule:checkSchedule,
			scheduleImg:scheduleImg
		};
	}());

	var modalLayer = (function() {
		var livePlayer = function(idx, group, name, url) {
			if (videojs.getPlayers()['my-player_' + idx]) {
				delete videojs.getPlayers()['my-player_' + idx];
			}
			$("#playerBody").html('');
			$("#playerTitle").html(group + "/" + name)
			var html = '<video id="my-player_'
					+ idx
					+ '" class="video-js"  controls preload="auto"  poster="${pageContext.request.contextPath}/img/live.jpg"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
			html += '<source  src="'+url+'"  type="application/x-mpegURL"></source>';
			html += '</video>';
			$("#playerId").val('my-player_' + idx);
			$("#playerBody").html(html);
			$("#playerModel").modal();
			var options = {};
			var player = videojs('my-player_' + idx, options,
					function onPlayerReady() {
						this.play();
						this.on('ended', function() {
							videojs.log(' so soon?!');
						});
					});
		};
		var playerClean = function() {
			var playerCash = $("#playerId").val();
			var myPlayer = videojs(playerCash);
			if (videojs.getPlayers()[eval("'" + playerCash + "'")]) {
				myPlayer.dispose();
				delete videojs.getPlayers()[eval("'" + playerCash + "'")];
				console.log('playerClean');
			}
		};
		var vodPlayer=function(url,thumbnail,target){
			common.delCashPlayer('vodPlayer');
			var html = '<video id="vodPlayer" class="video-js"  controls preload="auto"  poster="'+thumbnail+'"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
			html += '<source  src="'+url+'"  type="application/x-mpegURL"></source>';
			html += '</video>';
			$("#"+target).empty();
			$("#"+target).html(html);
			var options = {};
			var player = videojs('vodPlayer', options,
				function onPlayerReady() {
					this.play();
					console.log('path: /sen/web play');
					//VOD 재생 조회
					var vod_idx = '';
					var isHis = false;
					if(target === 'vodViewArea') {
						vod_idx= $("#vodIdx").val();
						isHis = true;
					}else if(target === 'boardViewArea') {
						vod_idx= $('#vodRepo').val();
						isHis = true;
					}else{
						
					}
					if(isHis) {
	 					$.ajax({
							url : "${pageContext.request.contextPath}/api/vod/insertHistory",
							type : 'post',
							data : {
								"vod_idx": vod_idx,
								"play_time": player.currentTime()
							},
							success : function(responseData){
								console.log(responseData.response);
							},
							error : common.ajaxException
						});
					}
					this.on('play', function() {
						
					});
					this.on('ended', function() {
						console.log('The End');
					});
				});
		};
		return {
			livePlayer : livePlayer,
			playerClean : playerClean,
			vodPlayer:vodPlayer
		};
	}());
	$(function() {
		
		$("#cateChangeSubmit").click(function() {
			if($('#changeCateProperty').val()!='0'){
				var targetIdx="";
				var selectIdx="";
				if($("#sort").val()=="stb-controle"){
					targetIdx=$("#changeCateIdx").val();
					selectIdx=$("#selectedIdx").val();
				}else{
					targetIdx=$("#changeCateIdx").val();
					selectIdx=$("#selectedIdxs").val();
				}
				$.ajax({
					url : '/cms/update/elemCategory',
					type : 'post',
					data : {
						"updateIdx" : targetIdx,
						"selectedIdx" : selectIdx,
						"sort" : $("#sort").val()
					},
					async : false,
					success : function(result) {
						if($("#sort").val()=="stb-controle"){
							contents.list(targetIdx);
						}else{
							arange.contentsView(targetIdx);
						}
						menuJs.makeJsTree(targetIdx);
						var data=JSON.parse(result);
						$('#navibar').html(data.oneDepth+'<i class="fa fa-angle-right m-r-10 m-l-10"></i><i class="fa fa-list-alt m-r-10"></i>'+data.twoDepth);
						$("#changeCateModel").modal('hide');
						if($('#selectSort').val()=="vod"){
							$('.vodCheck').css('display','none');
						}else if($('#selectSort').val()=="stream"){
							$('.streamCheck').css('display','none');
						}else if($('#selectSort').val()=="photo"){
							$('.photoCheck').css('display','none');
						}else if($('#selectSort').val()=="file"){
							$('.fileCheck').css('display','none');
						}
						$('#addBtns').css('display','block');
						$('#editBtns').css('display','none');
					},
					error : exception.ajaxException
				});
			}else{
				exception.contentsAddException();
			}
			
		});

		$("#cateChangeBtn").click(function() {
			var checkValArr = $("#selectedIdx").val();
			if (checkValArr.length == 0) {
				exception.checkboxException();
			} else {
				menuJs.makeSelJstree();
			}
		});
		$("#bgModal").click(function() {
			modalLayer.playerClean();
		});
		var frm = $("#member-edit");
		frm
				.submit(function(ev) {
					var eventForm =  $(this).closest('.modal').find('.form-validation-1');
				      eventForm.validationEngine('validate');
					     if (!(eventForm).find('.formErrorContent')[0]) {
						$
								.ajax({
									type : frm.attr("method"),
									url : frm.attr("action"),
									data : frm.serialize(),
									success : function(data) {
										$("#memberEdit").modal('hide');
										if (data == "success") {
											$(location)
													.attr('href',
															'${pageContext.request.contextPath}/sednmanager');
										}
									}
								});
					}
					ev.preventDefault();
				});
		
	});
	var keyword=(function(){
		var removeWord=function(obj){
			keywordArr.splice($.inArray($(obj).attr("title"),keywordArr),1);
			$(obj).fadeOut('fast');	
			$("#keyword").val(keywordArr);
		}
		return{
			removeWord:removeWord
		};
	}());
	var thumbnail=(function(){
		var changeMain=function(obj){
			$("#main_thumbnail").val($(obj).attr("id"));
			$(".thumb").removeClass('boxLine');
			$(obj).addClass('boxLine');
		};
		return{
			changeMain:changeMain
		};
	}());
	var system=(function(){
		var nowInfo=function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/system/current",
				success : function(responseData) {
					var data = JSON.parse(responseData);
					$("#diskSpace").css("width",data.diskPercent+'%');
					$("#diskSpace").attr("data-original-title",data.diskPercent+'%');
					$("#diskSpace").children().text(data.diskPercent);
					$("#memorySpace").css("width",data.memoryPercent+'%');
					$("#memorySpace").attr("data-original-title",data.memoryPercent+'%');
					$("#memorySpace").children().text(data.memoryPercent);
					$("#stbConnection").css("width",data.stbPercent+'%');
					$("#stbConnection").attr("data-original-title",data.stbPercent+'%');
					$("#stbConnection").children().text(data.stbPercent);
				},
				error : exception.ajaxException
			});
		};
		return{
			nowInfo:nowInfo
		};
	}());
	var common=(function(){
		var formatZeroDate=function(n, digits){
			 var zero = '';
			    n = n.toString();
			    if (digits > n.length) {
			        for (var i = 0; digits - n.length > i; i++) {
			            zero += '0';
			        }
			    }
			    return zero + n;
		};
		var isNotEmpty=function(value){
			return value!="";
		};
		var runtimeToSecond=function(runtime){
			var ts = runtime.split(':');
		    return Date.UTC(1970, 0, 1, ts[0], ts[1], ts[2]) / 1000;
		};
		var setDate=function(intData){
			var StringDate=new Date(intData);
            var hh = formatZeroDate(StringDate.getHours(),2);
            var mm = formatZeroDate(StringDate.getMinutes(),2);
            return $.datepicker.formatDate('yy-mm-dd '+hh+':'+mm,StringDate);
		};
		var removeOverlap=function(array){
			var result = [];
		    $.each(array, function(index, element) {   // 배열의 원소수만큼 반복
		 		if ($.inArray(element, result) == -1) {  // result 에서 값을 찾는다.  //값이 없을경우(-1)
		            result.push(element);              // result 배열에 값을 넣는다.
		        }
		    });
		    return result;
		};
		var removeElementToArray=function(array,element){
			var elementIndex=$.inArray(element.toString(),array);
			if(elementIndex>=0){
				array.splice(elementIndex,1);
			}
			return array;
		};
		var setHourSecond=function(intDate){
			var StringDate=new Date(intDate);
            var hh = formatZeroDate(StringDate.getHours(),2);
            var mm = formatZeroDate(StringDate.getMinutes(),2);
            return $.datepicker.formatDate(hh+':'+mm,StringDate);
		};
		var setScheduleDate=function(start,end){
			var viewDate=setDate(start)+" ~ "+ setHourSecond(end);
			return viewDate;
		};
		var delCashPlayer=function(playerName){
			//var playerCash = playerName;
			if (videojs.getPlayers()[playerName]) {
				var myPlayer = videojs(playerName);
				myPlayer.dispose();
				delete videojs.getPlayers()[playerName];
				console.log('path:web/media delCashPlayer', '닫음');
			}
		};
		var vodDefault=function(){
			common.delCashPlayer('vodPlayer');
			$('#vodViewArea').empty();
			$('#vodPreview').empty();
			$('#vodViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="vodViewMainThumb">');
			$('#vodPreview').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="vodDefaultImg">');
			$('#letsPlay').css('display','block');
			$('#letsEditPlay').css('display','block');
			$('#vodForm')[0].reset();
			$('#vodSlideShow').empty();
		};
		var photoDefault=function(){
			$('#photoViewArea').empty();
			$('#photoPreview').empty();
			$('#photoViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="photoViewMainThumb">');
			$('#photoPreview').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="photoDefaultImg">');
			$('#photoForm')[0].reset();
		};
		var fileDefault=function(){
			$('#fileViewArea').empty();
			$('#filePreview').empty();
			$('#fileViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="fileViewMainThumb">');
			$('#filePreview').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="fileDefaultImg">');
			$('#fileForm')[0].reset();
		};
		var streamDefault=function(){
			common.delCashPlayer('vodPlayer');
			$('#streamViewArea').empty();
			$('#streamPreview').empty();
			$('#streamViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="streamViewMainThumb">');
			$('#streamPreview').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="streamDefaultImg">');
			$('#streamForm')[0].reset();
		};
		var boardDefault=function(){
			common.delCashPlayer('vodPlayer');
			$('#boardViewArea').empty();
			$('#boardPreview').empty();
			$('#photoRepo').val('');
			$('#fileRepo').val('');
			$('#boardViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="boardViewMainThumb">');
			$('#boardPreview').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="boardDefaultImg">');
			$('#boardLetsPlay').css('display','block');
			$('#boardLetsEditPlay').css('display','block');
			$('#boardSlideShow').empty();
			$('#boardForm')[0].reset();
		};
		var repolist=function(childIdx) {	//common.repolist
			var vodListUrl = "${pageContext.request.contextPath}/cms/list/"
				+ $("#repoOrder").val() + "?childIdx=" + childIdx+"&searchWord="+$('#schedule-contents-search').val()
			// if($("#sort").val() === 'board') vodListUrl+= "&innerData=true";
			$.ajax({
				url : vodListUrl,
				success : function(data) {
					$("#repoListPage").empty();
					$("#repoListPage").html(data);
				},
				error : exception.ajaxException
			});
		};
		var number_to_human_size = function(x) {
			var s = [ 'bytes', 'kB', 'MB', 'GB', 'TB', 'PB' ];
			var e = Math.floor(Math.log(x) / Math.log(1024));
			var se = (x / Math.pow(1024, e)).toFixed(2) + " " + s[e];
			return se.replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
		};
		var deleteByIdxArr=function(idxArr){
			if (idxArr.length == 0)
				return false;
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/delete/"
						+ $("#sort").val() + "?checkValArr="
						+ idxArr,
				async : false,
				success : function(responseData) {
					var data = JSON.parse(responseData);
					if (data.result == "success") {
						$("#successText").text("컨텐츠 삭제에 성공했습니다.");
						$("#sucessModal").modal();
						var array = idxArr.split(',');
						for (i = 0; i < array.length; i++) {
							$('#layer_'+array[i]).fadeOut('slow');
						}
						menuJs.makeJsTree();
						/*if(array.length>1){
							$(".checkElem").prop("checked", false);
						}*/
					}
				},
				error : exception.ajaxException
			});
		};
		var selectRepoSource=function(sort){
			$('#requestRepo').val(sort);
			var html="";
			if($('#requestRepo').val()=="schedule"){	// LIVE 스케줄 추가 선택 모달
		  		if($('#repoOrder').val()=='vod'){
    	  			html+='<option value="VOD" selected>VOD</option>';
                	html+='<option value="LIVE">LIVE</option>';
    	  		}else{
    	  			html+='<option value="VOD">VOD</option>';
                    html+='<option value="LIVE" selected>LIVE</option>';
    	  		}
	            $('#repoType').empty();
	            $('#repoType').html(html);
		  	}else if($('#requestRepo').val()=="media"){	// CONTENTS 추가 > 저장소에서 썸네일 가져오기
		  		html+='<option value="PHOTO">PHOTO</option>';
		  		$('#repoType').empty();
		  		$('#repoType').html(html);
		  		$('#repoOrder').val('photo');
		  	}else if($('#requestRepo').val()=="photo"){
		  		html+='<option value="PHOTO">PHOTO</option>';
		  		$('#repoType').empty();
		  		$('#repoType').html(html);
		  		$('#repoOrder').val('photo');
		  	}else if($('#requestRepo').val()=="file"){
		  		html+='<option value="FILE">FILE</option>';
		  		$('#repoType').empty();
		  		$('#repoType').html(html);
		  		$('#repoOrder').val('file');
		  	}else if($('#requestRepo').val()=="vod"){	// PAGE 추가 > 영상 가져오기 선택 모달
		  		html+='<option value="VOD">VOD</option>';
		  		$('#repoType').empty();
		  		$('#repoType').html(html);
		  		$('#repoOrder').val('vod');
		  	}
			
			menuJs.vodScheduleJstree();
			common.repolist('');
			$('#repositoryList').modal();
		};
		var settopCmd=function(message, topic){
			jQuery.ajaxSettings.traditional = true;
			$.ajax({
				url : '/api/web/changeToAllSTB',
				type : 'post',
				data:{'message':message, "topic":topic},
				success : function(result) {
					console.log('schedule send to OTT');
				},
				error : exception.ajaxException
			});
		};
		return{
			formatZeroDate:formatZeroDate,
			isNotEmpty:isNotEmpty,
			runtimeToSecond:runtimeToSecond,
			setDate:setDate,
			removeOverlap : removeOverlap,
			removeElementToArray :removeElementToArray,
			setScheduleDate : setScheduleDate,
			setHourSecond : setHourSecond,
			delCashPlayer : delCashPlayer,
			vodDefault : vodDefault,
			photoDefault : photoDefault,
			fileDefault : fileDefault,
			streamDefault : streamDefault,
			boardDefault : boardDefault,
			repolist : repolist,
			number_to_human_size : number_to_human_size,
			deleteByIdxArr : deleteByIdxArr,
			selectRepoSource : selectRepoSource,
			settopCmd : settopCmd
		};
	}());
	var current = 0;
	var max = 0;
	var container;
	var slide={
		init:function(){
			container = $(".slide ul");
	        max = container.children().length;
		},
		prev:function(e){
			 current--;
	         if( current < 0 ) current = max-1;
	         slide.animate();
		},
		next:function(e){
			current++;
	        if( current > max-1 ) current = 0;
	        slide.animate();
		},
		animate:function(){
			var moveX = current * 135;
	        TweenMax.to( container, 0.1, { marginLeft:-moveX, ease:Expo.easeOut } );
		}
	};
	$(function(){
		$(".sourceTab").click(function(){
			$('#source_type').val($(this).attr('value'));
		});
		$("#selectLive").change(function(){
			$("#live_stream_url").val($(this).val());
			$("#live_ch_idx").val($('#selectLive > option:eq('+this.selectedIndex+')').attr('title'));
		});
	});
	String.prototype.toHHMMSS = function () {
	    var myNum = parseInt(this, 10);
	    var hours   = Math.floor(myNum / 3600);
	    var minutes = Math.floor((myNum - (hours * 3600)) / 60);
	    var seconds = myNum - (hours * 3600) - (minutes * 60);

	    if (hours   < 10) {hours   = "0"+hours;}
	    if (minutes < 10) {minutes = "0"+minutes;}
	    if (seconds < 10) {seconds = "0"+seconds;}
	    return hours+':'+minutes+':'+seconds;
	}
	
</script>

<script>
  $(function () {
      $(".slide a.add").click(function () {
          $(".get").css("display","block");
      });
      $("#getForm").click(function () {
          $("#popupGetForm").show();
      }); //저장소
      $('.repositoryAdd').click(function(){
    	  	var html=""; 
    		//선택박스 셋팅 
    	  	if($('#requestRepo').val()=="schedule"){
    	  		 if($('#repoOrder').val()=='vod'){
    	  			html+='<option value="VOD" selected>VOD</option>';
                	html+='<option value="LIVE">LIVE</option>';
    	  		}else{
    	  			html+='<option value="VOD">VOD</option>';
                    html+='<option value="LIVE" selected>LIVE</option>';
    	  		}
                 $('#repoType').empty();
                 $('#repoType').html(html);
    	  	}else if($('#requestRepo').val()=="media"){
    	  		html+='<option value="PHOTO">PHOTO</option>';
    	  		$('#repoType').empty();
    	  		$('#repoType').html(html);
    	  		$('#repoOrder').val('photo');
    	  	}else if($('#requestRepo').val()=="photo"){
    	  		html+='<option value="PHOTO">PHOTO</option>';
    	  		$('#repoType').empty();
    	  		$('#repoType').html(html);
    	  		$('#repoOrder').val('photo');
    	  	}else if($('#requestRepo').val()=="file"){
    	  		html+='<option value="FILE">FILE</option>';
    	  		$('#repoType').empty();
    	  		$('#repoType').html(html);
    	  		$('#repoOrder').val('file');
    	  	}else if($('#requestRepo').val()=="vod"){
    	  		html+='<option value="VOD">VOD</option>';
    	  		$('#repoType').empty();
    	  		$('#repoType').html(html);
    	  		$('#repoOrder').val('vod');
    	  	}
    	  	menuJs.vodScheduleJstree();
    		common.repolist('');
    		$('#repositoryList').modal();
    });
     $('#repoType').change(function(){
   		if($(this).val()=="VOD"){
   			$('#repoOrder').val('vod');
   			menuJs.vodScheduleJstree();
   		}else{
   			$('#repoOrder').val('stream');
   			menuJs.vodScheduleJstree();
   		}
   		$('#schedule-contents-search').val('');
   		common.repolist('');
   		
   	}); 
     $('#selectIdxArr').click(function(){
    	 //저장소 불러오기 라이브 일경우  
		if($('#requestRepo').val()=="schedule"){	// LIVE > 스케줄 추가 > 영상 선택 > 확인
		   	 if($('#repoOrder').val()=="vod"){	// VOD
		   			$("#source_type").val("VOD");
		   			$('#live_stream_url').val('');
		   			$('#live_ch_idx').val('');
		   			if($('#vodArr').val().length==0){
		   				if($('#tempVodList').val()!="") $('#vodArr').val($('#tempVodList').val());
		   			}else{
		   				if($('#tempVodList').val()!="") $('#vodArr').val($('#vodArr').val()+","+$('#tempVodList').val());
		   			}
		   			$("#slideShow").empty();
		   			if($('#tempVodList').val()!="") {
		   				arange.vodImgFactory($('#vodArr').val());
		   			}
		   		}else{	// LIVE
		   			$("#slideShow").empty();
		   			$("#vodArr").val('');
		   			$("#source_type").val("LIVE");
		   			var retHtml='<li style="float:left; background: url(${pageContext.request.contextPath}/img/live.jpg'
		   			+') no-repeat center; background-size: cover;padding-top:70px;">'+$('#tmpStreamName').val()+'</li>'
		   			$("#slideShow").html(retHtml);	
		   		}
		   		$('#slideShow').append('<li>'
          			+'<a class="add" onclick="common.selectRepoSource(\'schedule\');"><img src="${pageContext.request.contextPath}/ibsImg/img_add.png" alt="추가"   style="cursor:pointer;"/></a>'
              		+'</li>');
		   		slide.init();
		   		$('#repositoryList').modal('hide');
		   		
		}else if($('#requestRepo').val()=="media"){	// CONTENTS > 추가 > 저장소에서 썸네일 가져오기 > 확인
			//저장소 미디어일 경우 사진 추가 라이브 일경우 
			if($('#tempPhotoList').val()!=""){
				//이미지 옮겨놓는다. 
				$.ajax({
					url : "${pageContext.request.contextPath}/api/photoAddToThumnail",
					cache : false,
					type : 'get',
					data : {"photoIdx":$('#tempPhotoList').val(),"orginName":$('#main_thumbnail').val()},
					async : false,
					success : function(responseData){
						var data = JSON.parse(responseData);
						var retHtml="";
						var thumbnailArr=$('#thumnailList').val().split(',');
						$.each(data,function(i,value){
							var fullPath=value.url;
							var dbFileName=fullPath.substring(fullPath.lastIndexOf("/")+1,fullPath.length);
							thumbnailArr.push(dbFileName);
							retHtml+='<li class="thum" style="float:left;background: url(${pageContext.request.contextPath}'+value.url+') no-repeat center; background-size: cover;" id="thumbLi_'+dbFileName.split('.')[0]+'" onClick="arange.makeMainThumb(\''+dbFileName.split('.')[0]+'\',\''+dbFileName.split('.')[1]+'\')">'
							+'<a class="close" onclick="arange.removeThumbLi(\''+dbFileName.split('.')[0]+'\',\''+dbFileName.split('.')[1]+'\');">'
							+'<img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"></a></li>';
						});
						$('#addLi').remove();
						setTimeout(function(){
							$('#vodSlideShow').append(retHtml);
							$('#vodSlideShow').append('<li id="addLi"><a class="add" onclick="arange.selectSource();"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
						},3000);
						$('#thumnailList').val(thumbnailArr);
						$('#repositoryList').modal('hide');
					},
					error : exception.ajaxException
				});
			} 
		//보드의 포토일 경우 
		}else if($('#requestRepo').val()=="photo"){
			if($('#tempPhotoList').val()!=""){
				var totalPhoto="";
				if($('#photoRepo').val().length!=0){
					totalPhoto=$('#photoRepo').val()+","+$('#tempPhotoList').val();
				}else{
					totalPhoto=$('#tempPhotoList').val();
				}
				var totalPhotoArr=totalPhoto.split(',');
				$('#boardSlideShow').empty();
				$('#photoList').empty();
				$.each(totalPhotoArr,function(index,value){
					arange.photoFactory(value);
 					slide.init();
 				});
				$('#boardSlideShow').append('<li ><a class="add" onclick="common.selectRepoSource(\'photo\');"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
				$('#photoRepo').val(totalPhotoArr);
				$('#repositoryList').modal('hide');
			}
		}else if($('#requestRepo').val()=="file"){
			if($('#tempFileList').val()!=""){
				var totalFile="";
				if($('#fileRepo').val().length!=0){
					totalFile=$('#fileRepo').val()+","+$('#tempFileList').val();
				}else{
					totalFile=$('#tempFileList').val();
				}
				
				var totalFileArr=totalFile.split(',');
				$('#saveFileList').empty();
				$.each(totalFileArr,function(index,value){
					console.log(value);
 					arange.fileFactory(value);
 				});
				$('#saveFileList').append('&nbsp;&nbsp;&nbsp;&nbsp;<div class="btn btn-sm" onclick="common.selectRepoSource(\'file\');">파일추가</div>');
				$('#fileRepo').val(totalFileArr);
				$('#repositoryList').modal('hide');
			}
			
		}else if($('#requestRepo').val()=="vod"){	//PAGE 영상 추가 정보 자동 입력 by MGS
			if($('#tempVodList').val()!=""){
				$('#vodRepo').val($('#tempVodList').val());
				$.ajax({
					url : '/cms/page/getVodContents',
					cache : false,
					type : 'post',
					data :{
						"idx": $("#vodRepo").val()
					},
					success : function(result) {
						if (result.msg) {
							$("#board_title").val(result.map.vod_title);
							$("#board_content").val(result.map.vod_content);
						}
						$('#repositoryList').modal('hide');
					},error : exception.ajaxException
				});
			}
		}  		
	});
	$('#mediaConfirm').click(function(ev){
		 var eventForm =  $(this).closest('.modal').find('.form-validation-2');
	      eventForm.validationEngine('validate');
	     if (!(eventForm).find('.formErrorContent')[0]) {
		      $.ajax({
				url : '/cms/excute/'+$("#sort").val()+'/'+$("#vodOrder").val(),
				cache : false,
				type : 'post',
				data :{
					"vod_title" :$("#vod_title").val(),
					"vod_content":$("#vod_content").val(),
					"vod_path" : $("#vod_path").val(),
					"vod_keyword" : $("#keyword").val(),
					"vod_play_time" : $("#vod_play_time").val(),
					"main_thumbnail":$("#main_thumbnail").val(),
					"file_size" : $("#file_size").val(),
					"idx": $("#vodIdx").val(),
					"category_idx":$("#categoryIdx").val(),
					"thumnailList" : $("#thumnailList").val()
					},
				async : false,
				success : function(result) {
					if($("#vodOrder").val()=="insert"){
						menuJs.makeJsTree($('#categoryIdx').val());
					}
					arange.contentsView($("#categoryIdx").val());
					common.delCashPlayer('vodPlayer');
					$("#vodViewModal").modal('hide');
				},
				error : exception.ajaxException
			});
		  }
	     ev.preventDefault();
		});
	});
  $("#photoConfirm").click(function(ev){
	  var eventForm =  $(this).closest('.modal').find('.form-validation-3');
      eventForm.validationEngine('validate');
	     if (!(eventForm).find('.formErrorContent')[0]) {
			$.ajax({
				url : '/cms/excute/'+$("#sort").val()+'/'+$("#photoOrder").val(),
				cache : false,
				type : 'post',
				data :{"photo_title" :$("#photo_title").val(),"photo_content":$("#photo_content").val(),"photo_path" : $("#photo_path").val(),"photo_keyword" : $("#keyword").val(),"file_size" : $("#photo_size").val(),"idx": $("#photoIdx").val(),"category_idx":$("#categoryIdx").val()},
				async : false,
				success : function(result) {
					if($("#photoOrder").val()=="insert"){
						menuJs.makeJsTree($('#categoryIdx').val());
					}
					arange.contentsView($("#categoryIdx").val());
					$("#photoViewModal").modal('hide');
				},
				error : exception.ajaxException
			});
	     }
		ev.preventDefault();
	});
  $("#fileConfirm").click(function(ev){
	  var eventForm =  $(this).closest('.modal').find('.form-validation-4');
      eventForm.validationEngine('validate');
      if (!(eventForm).find('.formErrorContent')[0]) {
		  $.ajax({
				url : '/cms/excute/'+$("#sort").val()+'/'+$("#fileOrder").val(),
				cache : false,
				type : 'post',
				data :{"file_title" :$("#file_title").val(),"file_path" : $("#file_path").val(),"file_keyword" : $("#fileKeyword").val(),"file_size" : $("#uploadFile_size").val(),"resolution":$("#file_ext").val(),"idx": $("#fileIdx").val(),"category_idx":$("#categoryIdx").val()},
				async : false,
				success : function(result) {
					if($("#fileOrder").val()=="insert"){
						menuJs.makeJsTree($('#categoryIdx').val());
					}
					arange.contentsView($("#categoryIdx").val());
					$("#fileViewModal").modal('hide');
				},
				error : exception.ajaxException
			});
  		}
		ev.preventDefault();
  });
  $("#streamConfirm").click(function(ev){
	  var eventForm =  $(this).closest('.modal').find('.form-validation-5');
      eventForm.validationEngine('validate');
      if (!(eventForm).find('.formErrorContent')[0]) {
    	  $.ajax({
    			url : '/cms/excute/'+$("#sort").val()+'/'+$("#streamOrder").val(),
    			cache : false,
    			type : 'post',
    			data :{"live_title" :$("#streamTitle").val(),"live_path" : $("#streamAddress").val(),"idx": $("#streamIdx").val(),"category_idx":$("#categoryIdx").val()},
    			async : false,
    			success : function(result) {
    				if($("#streamOrder").val()=="insert"){
    					menuJs.makeJsTree($('#categoryIdx').val());
    				}
    				arange.contentsView($("#categoryIdx").val());
    				$("#streamViewModal").modal('hide');
    			},
    			error : exception.ajaxException
    		});
      }
      ev.preventDefault();
  });
  $("#boardConfirm").click(function(ev){	//PAGE 영상 추가, 수정
	  var eventForm =  $(this).closest('.modal').find('.form-validation-6');
      eventForm.validationEngine('validate');
      if (!(eventForm).find('.formErrorContent')[0]) {
    	  $.ajax({
    		  	url : '/cms/excute/'+$("#sort").val()+'/'+$("#boardOrder").val(),	//board, {insert, update}
    			data :{
    				"vod_repo":$("#vodRepo").val(),
    				"photo_repo":$("#photoRepo").val(),
    				"file_repo":$("#fileRepo").val(),
    				"live_repo":"",
    				"board_title" :$("#board_title").val(),
    				"board_content":$("#board_content").val(),
    				"board_keyword" : $("#boardKeyword").val(),
    				"idx": $("#boardIdx").val(),
    				"category_idx":$("#categoryIdx").val()
    				},
    			cache : false,
    			type : 'post',
    			async : false,
    			success : function(result) {
    				if($("#boardOrder").val()=="insert"){
    					menuJs.makeJsTree($('#categoryIdx').val());
    				}
    				common.delCashPlayer('vodPlayer');
    				arange.contentsView($("#categoryIdx").val());
    				$("#boardViewModal").modal('hide');
    				common.settopCmd('vod_update', 'broadcast');
    			},
    			error : exception.ajaxException
    		});
      }
      ev.preventDefault();
  });
  $("#mediaDel").click(function(){	// CONTENTS VOD 삭제
		var idx=$('#vodIdx').val();
		$("#confirmText").text("선택한 동영상을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		exception.delConfirm(function(confirm) {
			if (confirm) {
				common.deleteByIdxArr(idx);
				$('#vodViewModal').modal('hide');
			}
		});
		return false;
	});
  $("#photoDel").click(function(){	// CONTENTS PHOTO 삭제
		var idx=$('#photoIdx').val();
		$("#confirmText").text("선택한 사진을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		exception.delConfirm(function(confirm) {
			if (confirm) {
				common.deleteByIdxArr(idx);
				$('#photoViewModal').modal('hide');
			}
		});
		return false;
	});
  $("#fileDel").click(function(){	// CONTENTS FILE 삭제
		var idx=$('#fileIdx').val();
		$("#confirmText").text("선택한 파일을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		exception.delConfirm(function(confirm) {
			if (confirm) {
				common.deleteByIdxArr(idx);
				$('#fileViewModal').modal('hide');
			}
		});
		return false;
	});
  $("#streamDel").click(function(){	// CONTENTS STREMING 삭제
		var idx=$('#streamIdx').val();
		$("#confirmText").text("선택한 파일을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		exception.delConfirm(function(confirm) {
			if (confirm) {
				common.deleteByIdxArr(idx);
				$('#streamViewModal').modal('hide');
			}
		});
		return false;
	});
  $("#boardDel").click(function(){	// PAGE 영상 삭제
		var idx=$('#boardIdx').val();
		$("#confirmText").text("선택한 파일을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		exception.delConfirm(function(confirm) {
			if (confirm) {
				common.deleteByIdxArr(idx);
				common.settopCmd('vod_update', 'broadcast');
				$('#boardViewModal').modal('hide');
			}
		});
		return false;
	});
  $('#etcInfo').click(function(){
		$('#etcInfoView').toggle();
		//$('#etcInfoView').css('display','block');
	});
  $('#photoEtcInfo').click(function(){
		$('#photoEtcInfoView').toggle();
  });
  $('#fileEtcInfo').click(function(){
		$('#fileEtcInfoView').toggle();
  });
  $('#boardEtcInfo').click(function(){
		$('#boardEtcInfoView').toggle();
  });
  $('.cancel').click(function(){
	  common.delCashPlayer('vodPlayer');
  });
  $('#boardViewDownload').click(function(){
	  $("#downloadList").toggle();
  });
  $('#schedule-contents-search').keyup(function(key){
		var regExp =/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		var retString=$('#schedule-contents-search').val();
		if(regExp.test(retString)){
			$('#schedule-contents-search').val(retString.replace(regExp,""));	
		}
		if($('#schedule-contents-search').val().length!=0){
			common.repolist($('#searchIdx').val());
		}
	});
  $('#boardViewEdit').click(function(){
		$('#boardMediaView').css('display','none');
		$('#boardMediaEdit').css('display','block');
	});
  $('#photoFromPc').click(function(){
	  $("#fromPCPhotoForm").click();
  });
  $("#fromPCPhotoForm").change(function(){
	  var file=this.files;
		if (file[0].size > 5048 * 1024) {
			jQuery('#fromPCPhotoForm').validationEngine('showPrompt', '5MB 이하 파일만 업로드 하세요.', 'pass')
			return;
		}
		var file_size=file[0].size;
		var localPath = $(this).val();
		var ext = localPath.split('.').pop().toLowerCase();
		if ($.inArray(ext, [ 'jpg','jpeg','png','gif']) == -1) {
			jQuery('#fromPCPhotoForm').validationEngine('showPrompt', 'jpg,jpeg,png,gif 파일만 업로드 가능합니다.', 'pass')
			return;
		}
		var formData = new FormData();
		formData.append("uploadFile", file[0]);
		//파일 업로드
		$.ajax({
			xhr: function() {
			    	var xhr = new window.XMLHttpRequest();
					xhr.upload.addEventListener("progress", function(evt) {
			      	if (evt.lengthComputable) {
			        	var percentComplete = evt.loaded / evt.total;
			        	percentComplete = parseInt(percentComplete * 100);
			        	$("#progressBar").css("width",percentComplete+"%");
			        	$("#barText").text(percentComplete+"% Complete");
						if (percentComplete === 100) {
							$("#progressBarLayout").css('display','none');
			        	}
					}
			 }, false);
				return xhr;
			},
			url : '${pageContext.request.contextPath}/SEQ/UPLOAD/PHOTO',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			beforeSend : function() {
				$('#progressLayout').modal();
				$("#progressBarLayout").css('display','block');
			},
			success : function(responseData) {
				var data=JSON.parse(responseData);
				var uploadFile=data.fileName;
				//photo repository save
				$.ajax({
					url : '/cms/excute/photo/insert',
					cache : false,
					type : 'post',
					data :{"photo_title" :"PC 업로드","photo_content":"PC 업로드","photo_path" :uploadFile,"photo_keyword" : "photo","file_size" : file_size,"idx": '',"category_idx":$("#categoryIdx").val()},
					async : false,
					success : function(result) {
						var insertIdx=result;
						$.ajax({
							url : "${pageContext.request.contextPath}/api/photoAddToThumnail",
							cache : false,
							type : 'get',
							data : {"photoIdx":insertIdx,"orginName":$('#main_thumbnail').val()},
							async : false,
							success : function(responseData){
								var data = JSON.parse(responseData);
								var retHtml="";
								var thumbnailArr=$('#thumnailList').val().split(',');
								$.each(data,function(i,value){
									var fullPath=value.url;
									var dbFileName=fullPath.substring(fullPath.lastIndexOf("/")+1,fullPath.length);
									thumbnailArr.push(dbFileName);
									retHtml+='<li class="thum" style="float:left;background: url(${pageContext.request.contextPath}'+value.url+') no-repeat center; background-size: cover;" id="thumbLi_'+dbFileName.split('.')[0]+'" onClick="arange.makeMainThumb(\''+dbFileName.split('.')[0]+'\',\''+dbFileName.split('.')[1]+'\')">'
									+'<a class="close" onclick="arange.removeThumbLi(\''+dbFileName.split('.')[0]+'\',\''+dbFileName.split('.')[1]+'\');">'
									+'<img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"></a></li>';
								});
								$('#addLi').remove();
								setTimeout(function(){
									$('#vodSlideShow').append(retHtml);
									$('#vodSlideShow').append('<li id="addLi"><a class="add" onclick="arange.selectSource();"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
								},2000);
								$('#thumnailList').val(thumbnailArr);
							},
							error : exception.ajaxException
						});
						$("#photoViewModal").modal('hide');
					},
					error : exception.ajaxException
				});
				$('#progressLayout').modal('hide');
			},
			complete : function() {
				console.log('complete');
			},
			error : function() {
				exception.fileUpdateException();
			}
		});
  });
  $("#vodSection").change(function(){	// CONTENTS > 영상 업로드
		//용량
		$('#thumnailSource').css('display','none')
		var file=this.files;
		if (file[0].size > 6000*1024 * 1024) {
			$('#vod_path').validationEngine('showPrompt', '6GB 이하 파일만 업로드 하세요.', 'pass')
			return;
		}
		$("#file_size").val(file[0].size);
		//확장자
		var localPath = $(this).val();
		var ext = localPath.split('.').pop().toLowerCase();
		if ($.inArray(ext, [ 'wmv','avi','mov','flv','mp4','mpg','mpeg','mkv','3gp']) == -1) {
			$('#vod_path').validationEngine('showPrompt', 'wmv,avi,mov,flv,mp4,mpg,mpeg 파일만 업로드 가능합니다.', 'pass');
			return;
		}
		var formData = new FormData();
		formData.append("uploadFile", file[0]);
		$.ajax({
			xhr: function() {
			    	var xhr = new window.XMLHttpRequest();
			    	var barValue=0;
					xhr.upload.addEventListener("progress", function(evt) {
				      	if (evt.lengthComputable) {
				      		var percentComplete = evt.loaded / evt.total;
				        	percentComplete = parseInt(percentComplete * 100);
				        	if(percentComplete>parseInt(barValue)){
				        		$("#progressBar").css("width",percentComplete+"%");
				        		barValue=percentComplete;
				        		console.log(barValue);
				        	}
				        	$("#barText").text(percentComplete+"% Complete");

						}
			 		}, false);
					xhr.addEventListener("load", function(evt) {
						console.log('load 100%');
						$("#progressBar").css("width","100%");
						$("#progressBarLayout").css('display','none');
					}, false);
				return xhr;
			},
			url : '${pageContext.request.contextPath}/SEQ/UPLOAD/'+$("#sort").val().toUpperCase(),
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			beforeSend : function() {
				$('#progressLayout').modal();
				$("#progressBarLayout").css('display','block');
			},
			success : function(responseData) {
				var data=JSON.parse(responseData);
					$("#vod_path").val(data.fileName);
					$("#encodingBarLayout").css('display','block');
					uploadFile.mediaEncoding(data.fileName);
			},
			complete : function(responseData) {
				console.log('complete');
			},
			error : function() {
				//exception.fileUpdateException();
			}
		});
	});
</script>

