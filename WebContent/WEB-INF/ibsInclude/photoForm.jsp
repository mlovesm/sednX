<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<c:set var="resultMap" value="${resultMap}" />
<!-- All JS functions -->
<form role="form" class="form-validation-1" id="contentsForm">

	<div class="fileupload fileupload-new" data-provides="fileupload" id="uploadFeild">
    	<div class="fileupload-preview thumbnail form-control"><img id="uploadedFile" /></div>
    	<div>
        	<span class="btn btn-file btn-alt btn-sm">
            	<span class="fileupload-new">사진 선택</span>
            	<span class="fileupload-exists">바꾸기</span>
            	<input type="file" class="fileUpload" id="fileSection"/>
        	</span>
        <a href="#" class="btn fileupload-exists btn-sm" data-dismiss="fileupload">지우기</a>
    	</div>
    	<input type="text" id="photo_path" class="validate[required,funcCall[uploadFile.checkPhotoExist]]" value="${resultMap.photo_path}" style="width:1px;height:30px;opacity:0;float:right;"/>
	</div>
	
   	<div class="progress progress-striped active" id="progressBarLayout" style="display:none;">
         <div class="progress-bar"  role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="progressBar">
             <span class="sr-only" id="barText">45% Complete</span>
         </div>
    </div>

   
	<input type="text" id="photo_title"
		class="form-control m-b-10 validate[required,maxSize[10]]"
		value="${resultMap.photo_title}" placeholder="사진제목">
	<textarea  class="form-control m-b-10" id="photo_content" placeholder="사진내용">${resultMap.photo_title}</textarea>
	<input type="text" id="addKeyword"
		class="form-control m-b-10" id="addKeyword" placeholder="키워드 단어를 입력하시고 엔터키를 치세요.">
		<div id="wordDiv"></div>
		<input type="hidden" id="order" value="${order}" />
		<input type="hidden" id="idx" value="${idx}" />
		<input type="hidden" id="keyword" value="${resultMap.photo_keyword}"/>
		<input type="hidden" id="file_size" value="${resultMap.file_size}" />
</form>
<script>

var keywordArr=[];

if($("#order").val()=='update'){
	var array=$('#keyword').val().split(',');
	for(i=0;i<array.length;i++){
		keywordArr.push(array[i]);
		$("#wordDiv").append('<span class="label label-default" onClick="keyword.removeWord(this);" title='+array[i]+' style="cursor:pointer;">'+array[i]+' <i class="icon"><b>X</b></i></span>&nbsp;');
	}
	$("#uploadedFile").attr('src','${pageContext.request.contextPath}${resultMap.photo_url}${resultMap.photo_path}');
	console.log(keywordArr);
}
$("#contentsForm").submit(function(ev){
	$.ajax({
		url : '/cms/excute/'+$("#sort").val()+'/'+$("#order").val(),
		cache : false,
		type : 'post',
		data :{"photo_title" :$("#photo_title").val(),"photo_content":$("#photo_content").val(),"photo_path" : $("#photo_path").val(),"photo_keyword" : $("#keyword").val(),"file_size" : $("#file_size").val(),"idx": $("#idx").val(),"category_idx":$("#categoryIdx").val()},
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
		}
	}
});
$(".fileUpload").change(function(){
	jQuery('#photo_path').validationEngine('hide')
	//용량
	var file=this.files;
	if (file[0].size > 5048 * 1024) {
		jQuery('#photo_path').validationEngine('showPrompt', '5MB 이하 파일만 업로드 하세요.', 'pass')
		return;
	}
	$("#file_size").val(file[0].size);
	//확장자
	var localPath = $(this).val();
	var ext = localPath.split('.').pop().toLowerCase();
	if ($.inArray(ext, [ 'jpg','jpeg','png','gif']) == -1) {
		jQuery('#photo_path').validationEngine('showPrompt', 'jpg,jpeg,png,gif 파일만 업로드 가능합니다.', 'pass')
		return;
	}
	var reader = new FileReader();
	reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
		$("#uploadedFile").attr("src", rst.target.result);
	}
	reader.readAsDataURL(file[0]); // 파일을 읽는다
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
			$("#photo_path").val(data.fileName);
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