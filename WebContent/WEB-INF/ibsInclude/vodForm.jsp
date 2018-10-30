<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<style>
.boxLine img{border: 2px solid red;box-sizing: border-box;} 
</style>

<c:set var="resultMap" value="${resultMap}" />
<!-- All JS functions -->
<form role="form" class="form-validation-1" id="contentsForm">

	<div class="fileupload fileupload-new" data-provides="fileupload" id="uploadFeild">
    	<div class="fileupload-preview thumbnail form-control" id="preview" style="width:570px;height:320px;"></div>
    	<div>
        	<span class="btn btn-file btn-alt btn-sm">
            	<span class="fileupload-new">영상 선택</span>
            	<span class="fileupload-exists">바꾸기</span>
            	<input type="file" class="fileUpload" id="fileSection"/>
        	</span>
        <a href="#" class="btn fileupload-exists btn-sm" data-dismiss="fileupload">지우기</a>
    	</div>
    	<input type="text" id="vod_path" class="validate[required,funcCall[uploadFile.checkVodExist]]" value="${resultMap.vod_path}" style="width:1px;height:30px;opacity:0;float:right;"/>
	</div>
	
   	<div class="progress progress-striped active" id="progressBarLayout" style="display:none;" >
         <div class="progress-bar"  role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="progressBar">
             <span class="sr-only" id="barText">45% Complete</span>
         </div>
    </div>
	<div class="progress progress-striped active  progress-alt" id="encodingBarLayout" style="display:none;">
        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="encodingBar"></div>
        <div style="position:  absolute;margin-top: -26px;left: 50%;margin-left: -50px;" id="encodginText">인코딩 준비 중입니다.</div>
    </div>
    
   <div id="thumbnailList"></div>
	<input type="text" id="vod_title"
		class="form-control m-b-10 validate[required,maxSize[20]]"
		value="${resultMap.vod_title}" placeholder="영상 제목">
	<div id="thumbnailList"></div>
	<textarea  class="form-control m-b-10 validate[required]" id="vod_content" placeholder="영상 내용">${resultMap.vod_content}</textarea>
	<input type="text" id="addKeyword"
		class="form-control m-b-10" id="addKeyword" placeholder="키워드 단어를 입력하시고 엔터키를 치세요.">
		<div id="wordDiv"></div>
		<input type="hidden" id="order" value="${order}" />
		<input type="hidden" id="idx" value="${idx}" />
		<input type="hidden" id="keyword" value="${resultMap.vod_keyword}"/>
		<input type="hidden" id="file_size" value="${resultMap.file_size}" />
		<input type="hidden" id="vod_play_time" value="${resultMap.vod_play_time}" />
		<input type="hidden" id="main_thumbnail" value="${resultMap.main_thumbnail}" />

</form>
<script>
var keywordArr=[];
if($("#order").val()=='update'){
	var array=$('#keyword').val().split(',');
	for(i=0;i<array.length;i++){
		keywordArr.push(array[i]);
		$("#wordDiv").append('<span class="label label-default" onClick="keyword.removeWord(this);" title='+array[i]+' style="cursor:pointer;">'+array[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
	}
	var fileHead="${resultMap.vod_path}".split('.');
	$("#thumbnailList").empty();
	for(var i=0;i<10;i++){
		var imgDiv="";
		var imgName=fileHead[0]+'_'+i+'.jpg';
		var style="";
		if($("#main_thumbnail").val()==imgName){
			style="boxLine";
		}
		imgDiv='<div class="col-xs-3 thumb '+style+'" style="width:23.2%; padding:0; margin:4px; max-height: 74px;" onClick="thumbnail.changeMain(this);" id="'+fileHead[0]+'_'+i+'.jpg">'
		imgDiv+='<img src="${pageContext.request.contextPath}/REPOSITORY/THUMBNAIL${resultMap.datePath}'+fileHead[0]+'_'+i+'.jpg" ></div>'
		$("#thumbnailList").append(imgDiv);
	}
	modalLayer.vodPlayer("${resultMap.vod_url}","${resultMap.thumbnail_url}");
}
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


$("#contentsForm").submit(function(ev){
	$.ajax({
		url : '/cms/excute/'+$("#sort").val()+'/'+$("#order").val(),
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

$(".fileUpload").change(function(){
	if (videojs.getPlayers()['my-player_modal']) {
		delete videojs.getPlayers()['my-player_modal'];
	}
	jQuery('#vod_path').validationEngine('hide')
	//용량
	var file=this.files;
	if (file[0].size > 3000*1024 * 1024) {
		jQuery('#vod_path').validationEngine('showPrompt', '3GB 이하 파일만 업로드 하세요.', 'pass')
		return;
	}
	$("#file_size").val(file[0].size);
	//확장자
	var localPath = $(this).val();
	var ext = localPath.split('.').pop().toLowerCase();
	if ($.inArray(ext, [ 'wmv','avi','mov','flv','mp4','mpg','mpeg']) == -1) {
		jQuery('#vod_path').validationEngine('showPrompt', 'wmv,avi,mov,flv,mp4,mpg,mpeg 파일만 업로드 가능합니다.', 'pass')
		return;
	}
	var formData = new FormData();
	formData.append("uploadFile", file[0]);
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
		url : '${pageContext.request.contextPath}/SEQ/UPLOAD/'+$("#sort").val().toUpperCase(),
		processData : false,
		contentType : false,
		data : formData,
		type : 'POST',
		beforeSend : function() {
			$("#progressBarLayout").css('display','block');
		},
		success : function(responseData) {
			var data=JSON.parse(responseData);
				$("#uploadedFile").attr("src",data.fileName);
				$("#uploadedFile").fadeIn('slow');
				$("#vod_path").val(data.fileName);
				$("#encodingBarLayout").css('display','block');
				uploadFile.mediaEncoding(data.fileName);
		},
		complete : function(responseData) {
			console.log('complete');

		},
		error : function() {
			exception.fileUpdateException();
		}
	});
});
</script>