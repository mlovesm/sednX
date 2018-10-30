<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="left_container">
	<ul>
		<li class="menu01">
			<a href="${pageContext.request.contextPath}/sednmanager">Contents</a>
			<ul class="depth2">
				<li><a href="sub_01.html">VOD</a></li>
				<li><a href="sub_02.html">LIVE</a></li>
				<li><a href="sub_03.html">OTT</a></li>
				<li><a href="sub_04.html">Conference</a></li>
				<li><a href="sub_05.html">UCC</a></li>
			</ul>
		</li>
		<li class="menu02 on">
			<a href="sub_01.html">Statistics</a>
			<ul class="depth2">
				<li class="on"><a href="${pageContext.request.contextPath}/sedn/statistics/vod">VOD 통계</a></li>
				<li><a href="${pageContext.request.contextPath}/sedn/statistics/live">LIVE 시청 통계</a></li>
				<li><a href="sub_03.html">사용자 이용 통계</a></li>
				<li><a href="sub_04.html">방문자 통계</a></li>
				<li><a href="sub_05.html">서버 통계</a></li>
			</ul>
		</li>
		<li class="menu03"><a href="#">Management</a></li>					
	</ul>
</div>

 <!-- ############### CONTENT VOD 모달 시작 ######################### -->
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
</div><!-- CONTENT VOD Modal -->

<!--######## WARN Modal ######-->
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="alert alert-danger alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="warnText"></span> <i class="icon">&#61730;</i>
	</div>
</div>
<!--######## WARN  Modal ######-->
<!--######## SUCCESS Modal ######-->
<div class="modal fade" id="sucessModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="alert alert-success alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="successText"></span> <i class="icon">&#61845;</i>
	</div>
</div>
<!--######## SUCCESS  Modal ######-->
<!--######## CONFIRM Modal ######-->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-hidden="true">
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

<script>

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
		console.log('닫음');
		var playerCash = $("#playerId").val();
		var myPlayer = videojs(playerCash);
		if (videojs.getPlayers()[eval("'" + playerCash + "'")]) {
			myPlayer.dispose();
			delete videojs.getPlayers()[eval("'" + playerCash + "'")];
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
				this.on('ended', function() {
				});
			});
	};
	return {
		livePlayer : livePlayer,
		playerClean : playerClean,
		vodPlayer:vodPlayer
	};
}());

</script>