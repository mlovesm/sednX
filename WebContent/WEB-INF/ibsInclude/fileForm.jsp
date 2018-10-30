<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<c:set var="resultMap" value="${resultMap}" />
<!-- All JS functions -->

<form role="form" class="form-validation-1" id="contentsForm">
	<div class="fileupload fileupload-new row" data-provides="fileupload" style="padding-left:8px;" id="uploadFeild">
        <div class="input-group col-md-6">
            <div class="uneditable-input form-control" style="height:30px;">
                <i class="fa fa-file m-r-5 fileupload-exists"></i>
                <span class="fileupload-preview"></span>
            </div>
            <div class="input-group-btn">
                <span class="btn btn-file btn-alt" style="height:30px">
                <span class="fileupload-new">파일 업로드</span>
                <span class="fileupload-exists">바꾸기</span>
                <input type="file" class="fileUpload" id="fileSection"/>
              </span>
            </div>
            <input type="text" id="file_path" class="validate[required,funcCall[uploadFile.checkFileExist]]" value="${resultMap.file_path}" style="width:1px;height:30px;opacity:0;float:right;"/>
		</div>
	 </div>
   	 <div class="progress progress-striped active" id="progressBarLayout" style="display:none;">
         <div class="progress-bar"  role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="progressBar">
             <span class="sr-only" id="barText">45% Complete</span>
         </div>
     </div>
     <h4><span id="uploadedFile" class="label label-primary" style="display:none;">업로드 된 파일 : ${resultMap.file_path}</span></h4>
   
	<input type="text" id="file_title"
		class="form-control m-b-10 validate[required,maxSize[10]]"
		value="${resultMap.file_title}" placeholder="파일제목">
	<input type="text" id="addKeyword"
		class="form-control m-b-10"
		value="${resultMap.live_title}" id="addKeyword" placeholder="키워드 단어를 입력하시고 엔터키를 치세요.">
		<div id="wordDiv"></div>
		<input type="hidden" id="order" value="${order}" />
		<input type="hidden" id="idx" value="${idx}" />
		<input type="hidden" id="keyword" value="${resultMap.file_keyword}"/>
		<input type="hidden" id="file_size" value="${resultMap.file_size}" />
		<input type="hidden" id="resolution" value="${resultMap.resolution}"/>
</form>
<script>

var keywordArr=[];

if($("#order").val()=='update'){
	$("#uploadedFile").css('display','block');
	var array=$('#keyword').val().split(',');
	for(i=0;i<array.length;i++){
		keywordArr.push(array[i]);
		$("#wordDiv").append('<span class="label label-default" onClick="keyword.removeWord(this);" title='+array[i]+' style="cursor:pointer;">'+array[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
	}
	console.log(keywordArr);
}
$("#contentsForm").submit(function(ev){
	$.ajax({
		url : '/cms/excute/'+$("#sort").val()+'/'+$("#order").val(),
		cache : false,
		type : 'post',
		data :{"file_title" :$("#file_title").val(),"file_path" : $("#file_path").val(),"file_keyword" : $("#keyword").val(),"file_size" : $("#file_size").val(),"resolution":$("#resolution").val(),"idx": $("#idx").val(),"category_idx":$("#categoryIdx").val()},
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
$(".fileUpload").change(function(){
	jQuery('#file_path').validationEngine('hide')
	//용량
	var file=this.files;
	if (file[0].size > 30 * 1048 * 1024) {
		jQuery('#file_path').validationEngine('showPrompt', '30MB 이하 파일만 업로드 하세요.', 'pass')
		return;
	}
	$("#file_size").val(file[0].size);
	//확장자
	var localPath = $(this).val();
	var ext = localPath.split('.').pop().toLowerCase();
	if ($.inArray(ext, [ 'zip','rar','hwp','doc','ppt','xls','ai','pdf','psd','mp3','xlsx','docx','pptx','txt']) == -1) {
		jQuery('#file_path').validationEngine('showPrompt', 'zip,rar,hwp,doc,ppt,xls,ai,pdf,psd,mp3,xlsx,docx,pptx,txt 파일만 업로드 가능합니다.', 'pass')
		return;
	}
	$("#resolution").val(ext);
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
			$("#uploadFeild").css('display','none');
			$("#progressBarLayout").css('display','block');
		},
		success : function(responseData) {
			var data=JSON.parse(responseData);
			$("#uploadedFile").text("업로드된 파일 : "+data.fileName);
			$("#uploadedFile").fadeIn('slow');
			$("#file_path").val(data.fileName);
		},
		complete : function() {
			console.log('complete');
		},
		error : function() {
			exception.fileUpdateException();
		}
	});
});
</script>