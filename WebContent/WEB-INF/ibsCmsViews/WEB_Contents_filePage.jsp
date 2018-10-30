<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<c:choose>
	<c:when test="${empty lists }">
		<div style="height: 100px;"><h1>데이터가 없습니다.</h1></div>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="loop">
			<div class="img_box" id="layer_${list.idx}"  style="background: url(${pageContext.request.contextPath}/ibsImg/doc_icon2_${list.resolution}.png) no-repeat 50% 40%; cursor: pointer;">
                 <input class="pull-left m-l-5 fileCheck" type="checkbox" value="${list.idx}"/>
                 <p class="text-center imgPopup" id="${list.idx}" style="margin-top: 110px; font-size:12px;">${list.file_title}<br/>[${list.file_path}]</p>
             </div>
		</c:forEach>
	</c:otherwise>
</c:choose>
<input type="hidden" class="form-control" id="allcheck" />
<input type="hidden" class="form-control" id="selectedIdxs" />
<input type="hidden" class="form-control" id="changeCateIdx" />
<input type="hidden" class="form-control" id="changeCateProperty" />
<script>
if($('#requestRepo').val()=='media'){
	$('.fileCheck').css('display','none');
	$('.imgPopup').click(function(){
		common.fileDefault();
		$('#fileMediaView').css('display','block');
		$('#fileMediaEdit').css('display','none');
		$('#fileOrder').val('update');
		$('#fileViewModal').modal();
		$.ajax({
			url : "${pageContext.request.contextPath}/api/media/"+ $("#sort").val() + "/"+$(this).attr('id'),
			cache : false,
			async : false,
			success : function(responseData){
				var data=JSON.parse(responseData);
				$('#fileViewTitle').html(data.info.file_title);
				$('#fileViewDate').html(data.info.reg_dt);
				$('#fileViewDownload').attr('href','${pageContext.request.contextPath}/sedn/download/file/'+data.info.fileFile.split('.')[1]+'/'+data.info.fileFile.split('.')[0]);
				$('#fileViewCount').html(data.info.view_count);
				$('#fileViewResolution').html(data.info.resolution);
				$('#fileViewFilesize').html(common.number_to_human_size(data.info.file_size));
				$('#fileViewMainThumb').attr('src','${pageContext.request.contextPath}'+'/ibsImg/doc_icon_'+data.info.resolution+".png");
				
				
				$('#fileDefaultImg').attr('src','${pageContext.request.contextPath}'+'/ibsImg/doc_icon_'+data.info.resolution+".png");
				$("#file_title").val(data.info.file_title);
				$("#file_path").val(data.info.fileFile);
				$("#fileKeyword").val(data.info.file_keyword);
				$("#uploadFile_size").val(data.info.file_size);
				$("#fileIdx").val(data.info.idx);
				$("#file_ext").val(data.info.fileFile.split('.')[1]);
			},
			error : exception.ajaxException
		});
	});
	$('#fileSection').change(function(){
		//용량
		var file=this.files;
		if (file[0].size > 30 * 1048 * 1024) {
			jQuery('#file_path').validationEngine('showPrompt', '30MB 이하 파일만 업로드 하세요.', 'pass')
			return false;
		}
		$("#uploadFile_size").val(file[0].size);
		//확장자
		var localPath = $(this).val();
		var ext = localPath.split('.').pop().toLowerCase();
		if ($.inArray(ext, [ 'zip','rar','hwp','doc','ppt','xls','ai','pdf','psd','mp3','xlsx','docx','pptx','txt']) == -1) {
			jQuery('#file_path').validationEngine('showPrompt', 'zip,rar,hwp,doc,ppt,xls,ai,pdf,psd,mp3,xlsx,docx,pptx,txt 파일만 업로드 가능합니다.', 'pass')
			return false;
		}
		$("#file_ext").val(ext);
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
				$('#progressLayout').modal();
				$("#progressBarLayout").css('display','block');
			},
			success : function(responseData) {
				var data=JSON.parse(responseData);
				$("#filePreview").html('<img src="${pageContext.request.contextPath}'+'/ibsImg/doc_icon_'+data.fileName.split('.')[1]+'.png">');
				$("#fileDefaultImg").fadeIn('slow');
				$("#file_path").val(data.fileName);
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
	var arr=[];
	$(".fileCheck").click(function(){
		if($(this).is(":checked")==true){
			arr.push($(this).val());
		}else{
			arr.splice($.inArray($(this).val(),arr),1);
		}
		$("#selectedIdxs").val(arr);
	});
}else{
	var arr=[];
	$('.fileCheck').click(function(){
		if ($(this).is(":checked") == true) {
			arr.push($(this).val());
		} else {
			arr.splice($.inArray($(this).val(), arr), 1);
		}
		$('#tempFileList').val(arr);
	});
}
</script>
<input type="hidden" id="tempFileList" />
                                  