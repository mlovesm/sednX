<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<style>
    .form-scroll {
        height: 200px; overflow-y: auto; overflow-x: hidden;
    }
    .tab-content {
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-top: none;
    }
    .superbox-list{
    	width: 20%;
    	position: relative;
    }
    .superbox-list input {
    	left:10px;
    	right:10px;
    }
    .nav-tabs > li.active > a, .nav-tabs > li.active > a:hover, .nav-tabs > li.active > a:focus {
        color: orange;
    background: none;
    }
    .superbox-img {
        height: 70px;
    }
</style>
<c:set var="resultMap" value="${resultMap}" />
<form role="form" class="form-validation-1" id="contentsForm">
				<div class="tab-container">
                        <ul class="nav tab nav-tabs">
                            <li class="sortTab active"><a href="#vod">VIDEO</a></li>
                            <li class="sortTab"><a href="#photo">PHOTO</a></li>
                            <li class="sortTab"><a href="#file">FILE</a></li>
                            <li class="sortTab"><a href="#live">STREAM URL</a></li>
                        </ul>
                        <div class="tab-content">
                            <div style="text-align: center;"><input type="text" class="main-search" id="content_search" style="width: 220px; border-bottom: 1px solid #fff;" placeholder="키워드를 입력하세요."></div>
                            <div class="tab-pane active" id="vod">
                                <div class="photo-gallery form-scroll" id="vodBody">
                                </div>
                            </div><!-- //vod -->

                            <div class="tab-pane" id="photo">
                                <div class="photo-gallery form-scroll" id="photoBody">
                                </div>
                            </div><!-- //photo -->

                            <div class="tab-pane" id="file">
                                <div class="table-responsive form-scroll">
                                    <table class="table table-hover ">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>그룹명</th>
                                                <th>파일이름</th>
                                                <th>파일명</th>
                                            </tr>
                                        </thead>
                                        <tbody id="fileBody">
                                        </tbody>
                                    </table>
                                </div>
                            </div><!-- //file -->

                            <div class="tab-pane" id="live">
                                <div class="table-responsive form-scroll">
                                    <table class="table table-hover ">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>그룹명</th>
                                                <th>채널명</th>
                                                <th>주소</th>
                                            </tr>
                                        </thead>
                                        <tbody id="liveBody">
                                        </tbody>
                                    </table>
                                </div>
                            </div> <!-- //live -->
						 </div>
                    </div>
                    <div class="checked_from p-t-10" id="viewVod">
                    	<div class="title"><span>선택된 VIDEO</span></div>
                    	<div class="info" id="vodArea">
                    	<c:set var="vodLayout" value="${resultMap.vod_repo}" />
		            	<c:choose>
		            		<c:when test="${vodLayout ne null}">
		            		${hn:getVodLayout(vodLayout)}
		            		</c:when>
		            	</c:choose>
						</div>
                    </div>
                    
                    <div class="checked_from p-t-10" style="display:none;" id="viewLive">
                    	<div class="title"><span>선택된 LIVE</span></div>
                    	<div class="info" id="liveArea">
                    	<c:set var="liveLayout" value="${resultMap.live_repo}" />
                    	<c:choose>
		            		<c:when test="${liveLayout ne null}">
		            		${hn:getLiveLayout(liveLayout)}
		            		</c:when>
		            	</c:choose>
						</div>
                    </div>
                    
                    <div class="checked_from p-t-10" style="display:none;" id="viewFile">
                    	<div class="title"><span>선택된 FILE</span></div>
                    	<div class="info" id="fileArea">
                    	<c:set var="fileLayout" value="${resultMap.file_repo}"/>
		            	<c:choose>
		            		<c:when test="${fileLayout ne null}">
		            		${hn:getFileLayout(fileLayout)}
		            		</c:when>
		            	</c:choose>
		 				</div>
                    </div>
                    
                    <div class="checked_from p-t-10" style="display:none;" id="viewPhoto">
                    	<div class="title"><span>선택된 PHOTO</span></div>
                    	<div class="info" id="photoArea">
                    	<c:set var="photoLayout" value="${resultMap.photo_repo}"/>
                    	<c:choose>
		            		<c:when test="${photoLayout ne null}">
		            		${hn:getPhotoLayout(photoLayout)}
		            		</c:when>
		            	</c:choose>
						</div>
                    </div>
                    
                    <input type="text" id="board_title" class="form-control m-b-10 m-t-10 validate[required,maxSize[20]]" value="${resultMap.board_title}" placeholder="게시글 제목">
                    <div class="wysiwye-editor" >${resultMap.board_content }</div>
                    <input type="text" id="addKeyword" class="form-control m-b-10" id="addKeyword" placeholder="키워드 단어를 입력하시고 엔터키를 치세요.">
                    <div id="wordDiv"></div>
                    <input type="hidden" id="order" value="${order}" />
					<input type="hidden" id="idx" value="${idx}" />
					<input type="hidden" id="vod_repo" value="${resultMap.vod_repo}" />
					<input type="hidden" id="photo_repo" value="${resultMap.photo_repo}" />
					<input type="hidden" id="file_repo" value="${resultMap.file_repo}" />
					<input type="hidden" id="live_repo" value="${resultMap.live_repo}" />
					<input type="hidden" id="keyword" value="${resultMap.board_keyword}"/>
					<input type="hidden" id="board_content"/>
</form>
<script>
var keywordArr=[];
var photoBoxdArr=[];
var fileBoxdArr=[];
$(".sortTab").click(function(){
	$("#content_search").val('');
});
if($("#order").val()=='update'){
	var array=$('#keyword').val().split(',');
	for(i=0;i<array.length;i++){
		keywordArr.push(array[i]);
		$("#wordDiv").append('<span class="label label-default" onClick="keyword.removeWord(this);" title='+array[i]+' style="cursor:pointer;">'+array[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
	}
	if($("#photo_repo").val().length!=0){
		photoBoxdArr=$("#photo_repo").val().split(',');
	}
	if($("#file_repo").val().length!=0){
		fileBoxdArr=$("#file_repo").val().split(',');
	}
	
	if($("#live_repo").val().length!=""){
		$("#liveArea").css("height","300px");
		var options = {};
		if (videojs.getPlayers()['my-player_board']) {
			delete videojs.getPlayers()['my-player_board'];
		}
		var player = videojs('my-player_board', options,
			function onPlayerReady() {
				this.play();
				this.on('ended', function() {
					videojs.log('The End');
				});
			});
	};
	if($("#vod_repo").val().length!=""){
		$("#vodArea").css("height","300px");
		var options = {};
		if (videojs.getPlayers()['my-player_vodBoard']) {
			delete videojs.getPlayers()['my-player_vodBoard'];
		}
		var player = videojs('my-player_vodBoard', options,
			function onPlayerReady() {
				this.play();
				this.on('ended', function() {
					videojs.log('The End');
				});
			});
	};
}
$(function(){
	$("#addKeyword").keydown(function(key){
		if(key.keyCode==13){
			if($("#addKeyword").val()!=""){
				keywordArr.push($("#addKeyword").val());
				$("#wordDiv").append('<span class="label label-default" onClick="keyword.removeWord(this);" title='+$("#addKeyword").val()+' style="cursor:pointer;">'+$("#addKeyword").val()+' <i class="icon"><b>X</b></i></span>&nbsp;');
				$("#addKeyword").val('');
				$("#keyword").val(keywordArr);
				return false;
			}
		}
	});
	$("#content_search").keyup(function(key){
		var sort=$(".nav-tabs > li.active > a, .nav-tabs > li.active > a").attr("href").replace('#','');
		var searchWord=$(this).val();
		$.ajax({
			url : "${pageContext.request.contextPath}/api/smList/"
					+ sort + "?searchWord=" + searchWord,
			success : function(responseData) {
				var data=JSON.parse(responseData);
				var html='';
				switch(data.contents){
					case 'vod':
                    	if(data.lists){
							$.each(data.lists,function(key,value){
								html+='<div class="superbox-list" title="'+value.vod_keyword+'" >';
								html+='<input type="radio" class="checkVodElem" name="vodRadio" id="vod_'+value.idx+'" style="position: absolute;" />';
								html+='<img src="${pageContext.request.contextPath}'+value.main_thumbnail+'" class="superbox-img" alt="'+value.vod_path+'">';
								html+='</div>';
							});
							$("#vodBody").html(html);
							$(".checkVodElem").change(function() {
								$("#viewVod").css('display','block');
								$("#vod_repo").val($(this).attr("id").replace('vod_',''));
								if (videojs.getPlayers()['my-player_vodBoard']) {
									delete videojs.getPlayers()['my-player_vodBoard'];
								}
								var url=$(this).next().attr('alt');
								var videoTag = '<video id="my-player_vodBoard" class="video-js"  controls preload="auto"  poster="${pageContext.request.contextPath}'+$(this).next().attr('src')+'"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
								videoTag += '<source  src="'+url+'"  type="application/x-mpegURL"></source>';
								videoTag += '</video>';
								$("#vodArea").empty();
								$("#vodArea").css("height","300px");
								$("#vodArea").html(videoTag);
								var options = {};
								var player = videojs('my-player_vodBoard', options,
									function onPlayerReady() {
										this.play();
										this.on('ended', function() {
											videojs.log('The End');
										});
									});
								$("#keyword").val($("#keyword").val()+","+$(this).parent().attr("title"));
								if($(this).parent().attr("title").length!=0){
									var textArr=$(this).parent().attr("title").split(',');
									for(var i=0;i<textArr.length;i++){
										keywordArr.push(textArr[i]);
										$("#wordDiv").append('<span class="label label-default" title="'+textArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+textArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
									}
									$("#wordDiv").empty();
									var spanArr=$("#keyword").val().split(',');
									for(var i=0;i<spanArr.length;i++){
										$("#wordDiv").append('<span class="label label-default" title="'+spanArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+spanArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
									}
								}
							
							});
						}
					break;
					case 'photo':
						if(data.lists){
  							$.each(data.lists,function(key,value){
  								html+='<div class="superbox-list" title="'+value.photo_keyword+'">';
  								html+='<input type="checkbox" class="checkPhotoElem"  id="photo_'+value.idx+'" style="position: absolute;" />';
  								html+='<img src="${pageContext.request.contextPath}'+value.photo_path+'" class="superbox-img">';
  								html+='</div>';
  							});
  							$("#photoBody").html(html);
  							$(".checkPhotoElem").click(function(){
  								$("#viewPhoto").css('display','block');
  								if ($(this).is(":checked") == true) {
									photoBoxdArr.push($(this).attr("id").replace('photo_',''));
									$("#photoArea").append('<div class="superbox-list" id="photoSpan_'+$(this).attr("id")+'"><img src="'+$(this).next().attr('src')+'" class="superbox-img" id="photoImg_'+$(this).attr("id").replace('photo_','')+'" onClick="removeSelectedElem.removeImg(this);"/></div>');
									$("#keyword").val($("#keyword").val()+","+$(this).parent().attr("title"));
									if($(this).parent().attr("title").length!=0){
										var textArr=$(this).parent().attr("title").split(',');
										for(var i=0;i<textArr.length;i++){
											keywordArr.push(textArr[i]);
											$("#wordDiv").append('<span class="label label-default" title="'+textArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+textArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
										}
									}
								} else {
									photoBoxdArr.splice($.inArray($(this).attr("id").replace('photo_',''),photoBoxdArr), 1);
									$("#photoSpan_"+$(this).attr("id")).remove();
									if($(this).parent().attr("title").length!=0){
										var textArr=$(this).parent().attr("title").split(',');
										for(var i=0;i<textArr.length;i++){
											keywordArr.splice($.inArray(textArr[i],keywordArr),1);
										}
										$("#keyword").val(keywordArr);
										$("#wordDiv").empty();
										for(var i=0;i<keywordArr.length;i++){
											$("#wordDiv").append('<span class="label label-default" title="'+keywordArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+keywordArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
										}
									}
								}
								$("#photo_repo").val(photoBoxdArr);
  							});
  						}
					break;
					case 'file':
						var labelText="";
						if(data.lists){
							$.each(data.lists,function(key,value){
								html+='<tr>';
								html+='<td title="'+value.file_keyword+'"><input type="checkbox" class="checkFileElem" id="file_'+value.idx+'"/></td>';
								html+='<td>'+value.category_idx+'</td>';
								html+='<td id="fileTitle_"'+value.idx+'>'+value.file_title+'</td>';
								html+='<td>'+value.file_path+'</td>';
								html+='</tr>';
							});
							$("#fileBody").html(html);
							$(".checkFileElem").click(function() {
								$("#viewFile").css('display','block');
								if ($(this).is(":checked") == true) {
									fileBoxdArr.push($(this).attr("id").replace('file_',''));
									$("#fileArea").append('<span class="label label-success" id="fileSpan_'+$(this).attr("id").replace('file_','')+'" onClick="removeSelectedElem.removeFile(this);"> <i class="icon">&#61836;</i> '+$(this).parent().next().next().text()+'</span>&nbsp;');
									$("#keyword").val($("#keyword").val()+","+$(this).parent().attr("title"));
									if($(this).parent().attr("title").length!=0){
										var textArr=$(this).parent().attr("title").split(',');
										for(var i=0;i<textArr.length;i++){
											keywordArr.push(textArr[i]);
											$("#wordDiv").append('<span class="label label-default" title="'+textArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+textArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
										}
									}
								} else {
									fileBoxdArr.splice($.inArray($(this).attr("id").replace('file_',''),fileBoxdArr), 1);
									$("#fileSpan_"+$(this).attr("id")).remove();
									if($(this).parent().attr("title").length!=0){
										var textArr=$(this).parent().attr("title").split(',');
										for(var i=0;i<textArr.length;i++){
											keywordArr.splice($.inArray(textArr[i],keywordArr),1);
										}
										$("#keyword").val(keywordArr);
										$("#wordDiv").empty();
										for(var i=0;i<keywordArr.length;i++){
											$("#wordDiv").append('<span class="label label-default" title="'+keywordArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+keywordArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
										}
									}
								}
								$("#file_repo").val(fileBoxdArr);
							});
							
						}
					break;
					case 'live':
						if(data.lists){
							$.each(data.lists,function(key,value){
								html+='<tr>';
								html+='<td title="live,라이브,'+value.live_title+'"><input type="radio" name="liveRadio" class="checkLiveElem" id="'+value.idx+'"/></td>';
								html+='<td title="'+value.live_path+'">'+value.category_idx+'</td>';
								html+='<td id="liveTitle_"'+value.idx+'>'+value.live_title+'</td>';
								html+='<td>'+value.live_path+'</td>';
								html+='</tr>';
							});
							$("#liveBody").html(html);
							$(".checkLiveElem").change(function() {
									$("#viewLive").css('display','block');
									$("#live_repo").val($(this).attr("id").replace('live_',''));
									if (videojs.getPlayers()['my-player_board']) {
										delete videojs.getPlayers()['my-player_board'];
									}
									var url=$(this).parent().next().attr("title");
									var videoTag = '<video id="my-player_board" class="video-js"  controls preload="auto"  poster="${pageContext.request.contextPath}/img/live.jpg"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
									videoTag += '<source  src="'+url+'"  type="application/x-mpegURL"></source>';
									videoTag += '</video>';
									$("#liveArea").empty();
									$("#liveArea").css("height","300px");
									$("#liveArea").html(videoTag);
									var options = {};
									var player = videojs('my-player_board', options,
										function onPlayerReady() {
											this.play();
											this.on('ended', function() {
												videojs.log('The End');
											});
										});
									$("#keyword").val($("#keyword").val()+","+$(this).parent().attr("title"));
									if($(this).parent().attr("title").length!=0){
										var textArr=$(this).parent().attr("title").split(',');
										for(var i=0;i<textArr.length;i++){
											keywordArr.push(textArr[i]);
										}
										$("#wordDiv").empty();
										var spanArr=$("#keyword").val().split(',');
										for(var i=0;i<spanArr.length;i++){
											$("#wordDiv").append('<span class="label label-default" title="'+spanArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+spanArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
										}
									}
								
							});
						}
					break;
				}
			},
			error : exception.ajaxException
		});
	});
	
});
var removeSelectedElem=(function(){
	var removeImg=function(obj){
		var idx=$(obj).attr('id').replace("photoImg_","");
		photoBoxdArr.splice($.inArray($(obj).attr('id').replace("phptoImg_",""),photoBoxdArr),1);
		$("#photo_"+idx).prop("checked", false);
		$("#photo_repo").val(photoBoxdArr);
		
		var textArr=$("#photo_"+idx).parent().attr("title").split(',');
		for(var i=0;i<textArr.length;i++){
			keywordArr.splice($.inArray(textArr[i],keywordArr),1);
		}
		$("#keyword").val(keywordArr);
		$("#wordDiv").empty();
		for(var i=0;i<keywordArr.length;i++){
			$("#wordDiv").append('<span class="label label-default" title="'+keywordArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+keywordArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
		}
		$(obj).fadeOut('fast');	
	};
	var removeFile=function(obj){
		var idx=$(obj).attr('id').replace("fileSpan_","");
		fileBoxdArr.splice($.inArray($(obj).attr('id').replace("file_",""),fileBoxdArr),1);
		$("#file_"+idx).prop("checked", false);
		$("#file_repo").val(fileBoxdArr);
		
		var textArr=$("#file_"+idx).parent().attr("title").split(',');
		for(var i=0;i<textArr.length;i++){
			keywordArr.splice($.inArray(textArr[i],keywordArr),1);
		}
		$("#keyword").val(keywordArr);
		$("#wordDiv").empty();
		for(var i=0;i<keywordArr.length;i++){
			$("#wordDiv").append('<span class="label label-default" title="'+keywordArr[i]+'" onClick="keyword.removeWord(this);" style="cursor:pointer;">'+keywordArr[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
		}
		$(obj).fadeOut('fast');	
	};
	return{
		removeImg:removeImg,
		removeFile:removeFile
	};
}());
$(".fileSpan").click(function(){
	var idx=$(this).attr('id').replace("fileSpan_","");
	fileBoxdArr.splice($.inArray($(this).attr('id').replace("file_",""),fileBoxdArr),1);
	$("#file_repo").val(fileBoxdArr);
	$(this).fadeOut('fast');	
});
$(".photoSpan").click(function(){
	var idx=$(this).attr('id').replace("photoSpan_","");
	photoBoxdArr.splice($.inArray($(this).attr('id').replace("photoSpan_",""),photoBoxdArr),1);
	$("#photo_repo").val(photoBoxdArr);
	$(this).fadeOut('fast');               
});
$("#contentsForm").submit(function(ev){
	var contentHtml=$(".note-editable").html();
	$("#board_content").val(contentHtml);
	//alert('/cms/excute/'+$("#sort").val()+'/'+$("#order").val());
	$.ajax({
		url : '/cms/excute/'+$("#sort").val()+'/'+$("#order").val(),
		cache : false,
		type : 'post',
		data :{
			"vod_repo":$("#vod_repo").val(),
			"photo_repo":$("#photo_repo").val(),
			"file_repo":$("#file_repo").val(),
			"live_repo":$("#live_repo").val(),
			"board_title" :$("#board_title").val(),
			"board_content":$("#board_content").val(),
			"board_keyword" : $("#keyword").val(),
			"idx": $("#idx").val(),
			"category_idx":$("#categoryIdx").val()
			},
		async : false,
		success : function(result) {
			if($("#order").val()=="insert"){
				menuJs.makeJsTree();
			}
			contents.list($("#treeIdx").val());
			$("#contentsAddModel").modal('hide');
		},
		error : exception.ajaxException
	});
	ev.preventDefault();
});
</script>