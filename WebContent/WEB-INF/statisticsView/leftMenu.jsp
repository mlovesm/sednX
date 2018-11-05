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
			<a href="${pageContext.request.contextPath}/sedn/statistics/vod">Statistics</a>
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

 <!-- ############### Statistics 모달 시작 ######################### -->
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
              <div class="media-contents">
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
              </div>
          </div>
	  </div>
</div><!-- CONTENT VOD Modal -->
<!-- 플레이어 히든  -->
<input type="hidden" class="form-control" id="play_url"/>
<input type="hidden" class="form-control" id="play_thum"/>
				
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
	var searchException = function() {
		$("#warnText").text("검색어를 입력해 주세요.");
		$("#msgModal").modal();
	};
	var checkboxException = function() {
		$("#warnText").text("체크박스를 한개 이상 체크 해 주세요.");
		$("#msgModal").modal();
	};
	var keywordException = function() {
		$("#warnText").text("키워드를 입력해주세요.");
		$("#msgModal").modal();
	};
	return {
		ajaxException : ajaxException,
		loginException : loginException,
		searchException : searchException,
		checkboxException : checkboxException,
		keywordException : keywordException,
	};
}());	//exception

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
	var setDate=function(intData){
		var StringDate=new Date(intData);
        var hh = formatZeroDate(StringDate.getHours(),2);
        var mm = formatZeroDate(StringDate.getMinutes(),2);
        return $.datepicker.formatDate('yy-mm-dd '+hh+':'+mm,StringDate);
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
	};
	var number_to_human_size = function(x) {
		var s = [ 'bytes', 'kB', 'MB', 'GB', 'TB', 'PB' ];
		var e = Math.floor(Math.log(x) / Math.log(1024));
		var se = (x / Math.pow(1024, e)).toFixed(2) + " " + s[e];
		return se.replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
	};	
	return{
		formatZeroDate:formatZeroDate,
		isNotEmpty:isNotEmpty,
		setDate:setDate,
		delCashPlayer : delCashPlayer,
		vodDefault : vodDefault,
		number_to_human_size : number_to_human_size

	};
}());	//common

$('#etcInfo').click(function(){
	$('#etcInfoView').toggle();
	//$('#etcInfoView').css('display','block');
});


</script>