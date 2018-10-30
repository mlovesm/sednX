<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles"  uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
	<meta name="format-detection" content="telephone=no">

	<title>SEDN</title>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserCss/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserCss/fonts.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserCss/jquery.bxslider.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserCss/jquery.mCustomScrollbar.css" />


	<script src="${pageContext.request.contextPath}/ibsUserJs/jquery-2.2.1.js"></script>
	<script src="${pageContext.request.contextPath}/ibsUserJs/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/ibsUserJs/jquery.bxslider.min.js"></script>
	<script src="${pageContext.request.contextPath}/ibsUserJs/common.js"></script>

	<script src="${pageContext.request.contextPath}/ibsUserJs/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/ibsUserJs/jquery.cycle2.js"></script>
	

	<!-- vodeo Js -->
	<link href="${pageContext.request.contextPath}/ibsCmsCss/video-js.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/ibsCmsJs/video.js"></script>
	<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-flash.js"></script>
	<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-contrib-hls.js"></script>
	<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-playlists.js"></script>
	
	<!-- Dev Sctipt -->
</head>
<body>
	<div id="wrap">
		<header>
			<div class="top_container">
				<div class="inner">
					<h1><a href="/">SEDN</a><span>VOD</span></h1>
						<tiles:insertAttribute name="top" />
					<div class="login">
						<img src="${pageContext.request.contextPath}/img/login.png" alt="회원사진"/>
						<span>nickname</span>
					</div>
				</div>
			</div>
		</header>
			<tiles:insertAttribute name="body" />
	</div>
<!--######## WARN Modal ######-->
<div id="warnWindow" class="warn modal">
	<div>
		<button type="button" class="windowClose">×</button>
		<span id="warnText"></span>
	</div>
</div>
<div id="fade" class="black_overlay"></div> 
<!--######## WARN  Modal ######-->
<!-- -#############영상보기 모달창 시작  -->
<!-- 팝업창 -->
		<div id="popup">
			<div class="popup_container">
				<h3>상세정보<span class="close" id="modalClose"><a><img src="${pageContext.request.contextPath}/img/img_popup_close.png" alt="닫기" /></a></span></h3>

				<div class="media-form">
	                <div class="video"  id="boardViewArea" style="cursor:pointer;height:323px;"><img id="boardViewMainThumb" src="${pageContext.request.contextPath}/img/img_video.png" alt="샘플" /></div>
	                <a class="play" style="cursor:pointer;" id="boardLetsPlay"><img src="${pageContext.request.contextPath}/img/img_play.png" alt="재생" /></a>
	                <a class="info" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/img/img_info.png" alt="정보"/></a>
	                <div class="infoForm">
	                    <ul>
	                        <li>해상도 : <span id="boardViewResolution">1808 x 920</span></li>
	                        <li>재생시간 :<span id="boardViewRuntime"></span></li>
	                        <li>용량 : <span id="boardViewFilesize"></span></li>
	                    </ul>
	                </div>
	            </div>
	            <div class="contents">
	                <p class="title" id="boardViewTitle"></p>
	                <div class="data">
	                    <p>등록일 : <span id="boardViewDate"></span></p>
	                    <a class="down" href="#"><img src="${pageContext.request.contextPath}/img/btn_download.png" alt="다운로드" /></a>
	                    <div class="downForm">
	                        <div class="triangle"></div>
	                        <a href="#"><img src="${pageContext.request.contextPath}/img/img_close_sm.png" alt="닫기"/></a>
	                        <ul id="downloadUl">
	                            
	                        </ul>
	                    </div>
	                    <p class="hits" id="boardViewCount"></p>
	                </div>
	                <div id="photoList" class="text"></div>
	                <p class="text" id="boardViewText">
	                    
	                </p>
	            </div>				
			</div>
			<!-- 플레이어 히든  -->
				<input type="hidden" class="form-control" id="boardPlay_url"/>
				<input type="hidden" class="form-control" id="boardPlay_thum"/>
				<input type="hidden" class="form-control" id="categoryIdx" value="1"/>
		</div><!-- //팝업창 -->
		<!-- -#############영상보기 모달창   -->
</body>
<script src="${pageContext.request.contextPath}/ibsUserJs/DevImgControle.js"></script>
<script>
var arange={
				photoFactory : function(idx){
					if(idx.length!=0){
						$.ajax({
							url : "${pageContext.request.contextPath}/api/photoFactory",
							cache : false,
							type : 'post',
							data : {"idxArr":idx},
							async : false,
							success : function(responseData){
								var data=JSON.parse(responseData);
								var retHtml='';
								var viewHtml='';
								var downloadHtml='';
								for(var i=0;i<data.imgList.length;i++){
					                viewHtml+='<img src="${pageContext.request.contextPath}'+data.imgList[i].img_url+'" />';
					                downloadHtml+='<li>· <a href="${pageContext.request.contextPath}/sedn/download/photo/'+data.imgList[i].img_url.split('/')[6].split('.')[1]+'/'+data.imgList[i].img_url.split('/')[6].split('.')[0]+'">'+data.imgList[i].img_url.split('/')[6]+'</a></li>'
								}
								$('#photoList').append(viewHtml);
								$('#downloadUl').append(downloadHtml);
								
							},
							error : common.ajaxException
						});
					}
				},
				fileFactory : function(idx){
					if(idx.length!=0){
						$.ajax({
							url : "${pageContext.request.contextPath}/api/fileFactory",
							cache : false,
							type : 'post',
							data : {"fileArr":idx},
							async : false,
							success : function(responseData){
								var data=JSON.parse(responseData);
								var retHtml='';
								var downloadHtml='';
								for(var i=0;i<data.fileList.length;i++){
					               downloadHtml+='<li>· <a href="${pageContext.request.contextPath}/sedn/download/file/'+data.fileList[i].file_url.split('.')[1]+'/'+data.fileList[i].file_url.split('.')[0]+'">'+data.fileList[i].file_url+'</a></li>'
								}
								$('#downloadUl').append(downloadHtml);
							},
							error : common.ajaxException
						});
					}
				}
};
var common={
	ajaxException : function() {
			$("#warnText").text("AJAX EXCEPTION");
			$('#warnWindow').css('display','block');
			$('.black_overlay').css('display','block');
	},
	number_to_human_size : function(x) {
		var s = [ 'bytes', 'kB', 'MB', 'GB', 'TB', 'PB' ];
		var e = Math.floor(Math.log(x) / Math.log(1024));
		var se = (x / Math.pow(1024, e)).toFixed(2) + " " + s[e];
		return se.replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
	},
	vodPlayer : function(url,thumbnail,target){
		common.delCashPlayer('vodPlayer');
		var html = '<video id="vodPlayer" class="video-js"  controls preload="auto"  poster="'+thumbnail+'"  data-setup="{}" style="width: 100% !important; height: 320px !important;">';
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
	},
	delCashPlayer : function(playerName){
		//var playerCash = playerName;
		if (videojs.getPlayers()[playerName]) {
			var myPlayer = videojs(playerName);
			myPlayer.dispose();
			delete videojs.getPlayers()[playerName];
		}
	},
	layoutView : function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/user/layout",
			cache : false,
			type : 'post',
			data : {"categoryIdx":$('#categoryIdx').val()},
			async : false,
			success : function(responseData){
				var data=JSON.parse(responseData);
				$('.main_container').empty();
				$('.thumnail_container').empty();
				
				if(data.layout.length!=0){
					for(var i=0;i<data.layout.length;i++){
						var layoutType=data.layout[i].wl_type
						$.ajax({
							url : "${pageContext.request.contextPath}/user/style",
							cache : false,
							type : 'post',
							data : {"idx": data.layout[i].idx,"wl_title": data.layout[i].wl_title,"wl_link_type": data.layout[i].wl_link_type,"wl_link_idx": data.layout[i].wl_link_idx,"wl_type": data.layout[i].wl_type,"wl_height": data.layout[i].wl_height,"wl_unit": data.layout[i].wl_unit, "wl_categorys": data.layout[i].wl_categorys,"wl_attribute": data.layout[i].wl_attribute,"wl_sort": data.layout[i].wl_sort,"reg_dt": data.layout[i].reg_dt,"edit_dt": data.layout[i].edit_dt,"reg_ip": data.layout[i].reg_ip,"del_flag": data.layout[i].del_flag,"wl_category": $('#category').val()},
							async : false,
							success : function(data){
								if(layoutType=="A"){
									$('.main_container').append(data);
								}else{
									$('.thumnail_container').append(data);
								}
							},
							error : common.ajaxException
						});
					}
				}else{
					$('.main_container').append("<div style='color:#FFFFFF;padding-top:100px;text-align:center;'>데이터가 없습니다.</div>");
				}
				
			},
			error : common.ajaxException
		});
	},
	vodViewModal : function(idx){
		$.ajax({
			url : "${pageContext.request.contextPath}/api/media/board/"+idx,
			cache : false,
			async : false,
			success : function(responseData){
				var data=JSON.parse(responseData);
				$('#boardViewTitle').html(data.info.board_title);
				$('#boardViewDate').html(data.info.reg_dt);
				$('#boardViewCount').html(data.info.view_count);
				$('#boardViewText').html(data.info.board_content);
				$('#boardViewResolution').html(data.vodRelative.resolution);
				$('#boardViewRuntime').html(data.vodRelative.vod_play_time);
				$('#boardViewFilesize').html(common.number_to_human_size(data.vodRelative.file_size));
				$('#boardViewMainThumb').attr('src','${pageContext.request.contextPath}'+data.vodRelative.board_thumnail_path);
				$("#boardPlay_url").val(data.vodRelative.vod_path);
				$("#boardPlay_thum").val('${pageContext.request.contextPath}'+data.vodRelative.board_thumnail_path);
				$('#downloadUl').empty();
				$('#photoList').empty();

				console.log(data.vodRelative.vodFile);
				$('#downloadUl').append('<li>· <a href="${pageContext.request.contextPath}/sedn/download/vod/'+data.vodRelative.vodFile.split('.')[1]+'/'+data.vodRelative.vodFile.split('.')[0]+'">'+data.vodRelative.vodFile+'</a></li>');
				if(data.info.photo_repo.length!=0){
					var imgArr=data.info.photo_repo.split(',');
					$.each(imgArr,function(index,value){
	 					arange.photoFactory(value);
	 				});
				}
				
				if(data.info.file_repo.length!=0){
					var fileArr=data.info.file_repo.split(',');
					$.each(fileArr,function(index,value){
	 					arange.fileFactory(value);
	 				});
				}
				if(data.info.photo_repo.length==0&&data.info.file_repo.length==0&&data.vodRelative.vodFile.length==0){
					$('#downloadUl').append('<li>파일 없음</li>');
				}
			},
			error : common.ajaxException
		});
	},
	viewContents:function(idx){
		common.vodViewModal(idx);
		$('#popup').css('display','block');
	}
};
$.ajax({
	url : "${pageContext.request.contextPath}/api/menu/vod",
	cache : false,
	type : 'post',
	async : false,
	success : function(responseData){
		var data=JSON.parse(responseData);
		var innerHtml="";
		for(var i=0;i<data.mainDepth.length;i++){
			innerHtml+='<li class="mainDepth" id="mainDepth_'+data.mainDepth[i].menu_idx+'" style="cursor:pointer;">';
			innerHtml+='<a>'+data.mainDepth[i].menu_name+'</a>';
			innerHtml+='<ul class="depth2">';
			for(var j=0;j<data.mainDepth[i].subDepth.length;j++){
				innerHtml+='<li class="subDepth" id="subDepth_'+data.mainDepth[i].subDepth[j].menu_idx+'_'+data.mainDepth[i].menu_idx+'"><a>'+data.mainDepth[i].subDepth[j].menu_name+'</a></li>';
			}
			innerHtml+='</ul>';
			innerHtml+='</li>';
		}
	$('#vodMenuUL').html(innerHtml);
	},
	error : common.ajaxException
});
$('.black_overlay').click(function(){
	$(this).css('display','none');
	$('.modal').css('display','none');
});
$('.subDepth').click(function(){
	console.log('#mainDepth_'+$(this).attr('id').split('_')[2]);
	$('.mainDepth').removeClass('liActive');
	$('#mainDepth_'+$(this).attr('id').split('_')[2]).addClass('liActive');
	$('.subDepth a').css('border','none');
	$('.subDepth a').css('border-bottom','0px');
	$('.subDepth a').css('color','#ffffff');
	$('#'+$(this).attr('id')+' a').css('color','#e02828');
	var url="${pageContext.request.contextPath}/user/subList?searchWord=&idxArr="+$(this).attr('id').split('_')[1];
	$(location).attr('href',url);
});


$('.mainDepth').removeClass('liActive');
$('#mainDepth_${parentIdx }').addClass('liActive');
$('.subDepth a').css('border','none');
$('.subDepth a').css('border-bottom','0px');
$('.subDepth a').css('color','#ffffff');
$('#subDepth_${categoryIdx }_${parentIdx } a').css('color','#e02828');
$('.contents_form').click(function(){
	common.delCashPlayer('vodPlayer');
	$('#boardViewArea').empty();
	$('#boardViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="boardViewMainThumb">');
	$('#boardLetsPlay').css('display','block');
	var idx=$(this).attr('id').split('_')[1];
	common.vodViewModal(idx);
});
$('#boardLetsPlay').click(function(){
	//common.boardDefault();
	$('#boardViewArea').empty();
	$('#boardLetsPlay').css('display','none');
	common.vodPlayer($('#boardPlay_url').val(),$('#boardPlay_thum').val(),"boardViewArea");
});
$('#modalClose').click(function(){
	common.delCashPlayer('vodPlayer');
	$('#boardViewArea').html('<img id="boardViewMainThumb" src="${pageContext.request.contextPath}/img/img_video.png" alt="샘플" />');
	$('#boardLetsPlay').css('display','block');
});
$('.mainDepth').click(function(){
	$('#categoryIdx').val($(this).attr('id').split('_')[1]);
	$('.mainDepth').removeClass('liActive');
	$('#mainDepth_'+$(this).attr('id').split('_')[1]).addClass('liActive');
	common.layoutView();
});

</script>
</html>

