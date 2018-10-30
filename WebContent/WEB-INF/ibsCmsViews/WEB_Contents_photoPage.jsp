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
			<div class="img_box" id="layer_${list.idx}" style="background: url('${pageContext.request.contextPath}${list.photo_path}') no-repeat center; background-size: cover;">
				<input class="pull-left m-l-5 photoCheck" type="checkbox" value="${list.idx}"/>
				<div class="imgPopup" id="${list.idx}"  style="left:30px;width:90%;height:100%;position:relative;"></div>
			</div>
		</c:forEach>
	</c:otherwise>
</c:choose>
<input type="hidden" class="form-control" id="allcheck" />
<input type="hidden" class="form-control" id="selectedIdxs" />
<input type="hidden" class="form-control" id="changeCateIdx" />
<input type="hidden" class="form-control" id="changeCateProperty" />
<script>
if($('#requestRepo').val()=='media'&&$('#repoOrder').val()==""){
	$('.photoCheck').css('display','none');
	$('.imgPopup').click(function(){
		common.photoDefault();
		$('#photoMediaView').css('display','block');
		$('#photoMediaEdit').css('display','none');
		$('#photoOrder').val('update');
		$('#photoViewModal').modal();
		$.ajax({
			url : "${pageContext.request.contextPath}/api/media/"+ $("#sort").val() + "/"+$(this).attr('id'),
			cache : false,
			async : false,
			success : function(responseData){
				var data=JSON.parse(responseData);
				$('#photoViewTitle').html(data.info.photo_title);
				$('#photoViewDate').html(data.info.reg_dt);
				$('#photoViewDownload').attr('href','${pageContext.request.contextPath}/sedn/download/photo/'+data.info.photoFile.split('.')[1]+'/'+data.info.photoFile.split('.')[0]);
				$('#photoViewCount').html(data.info.view_count);
				$('#photoViewResolution').html(data.info.resolution);
				$('#photoViewFilesize').html(common.number_to_human_size(data.info.file_size));
				$('#photoViewText').html(data.info.photo_content);
				$('#photoViewMainThumb').attr('src','${pageContext.request.contextPath}'+data.info.photo_path);
				
				$('#photoDefaultImg').attr('src','${pageContext.request.contextPath}'+data.info.photo_path);
				$("#photo_title").val(data.info.photo_title);
				$("#photo_content").val(data.info.photo_content);
				$("#photo_path").val(data.info.photoFile);
				$("#photoKeyword").val(data.info.photo_keyword);
				$("#photo_size").val(data.info.file_size);
				$("#photoIdx").val(data.info.idx);
			},
			error : exception.ajaxException
		});
	});
	$('#photoSection').change(function(){
		//용량
		var file=this.files;
		if (file[0].size > 5048 * 1024) {
			jQuery('#photo_path').validationEngine('showPrompt', '5MB 이하 파일만 업로드 하세요.', 'pass')
			return;
		}
		$("#photo_size").val(file[0].size);
		//확장자
		var localPath = $(this).val();
		var ext = localPath.split('.').pop().toLowerCase();
		if ($.inArray(ext, [ 'jpg','jpeg','png','gif']) == -1) {
			jQuery('#photo_path').validationEngine('showPrompt', 'jpg,jpeg,png,gif 파일만 업로드 가능합니다.', 'pass')
			return;
		}
		var reader = new FileReader();
		reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
			$("#photoDefaultImg").attr("src", rst.target.result);
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
				$('#progressLayout').modal();
				$("#progressBarLayout").css('display','block');
			},
			success : function(responseData) {
				var data=JSON.parse(responseData);
				$("#photoDefaultImg").attr("src",data.fileName);
				$("#photoDefaultImg").fadeIn('slow');
				$("#photo_path").val(data.fileName);
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
	$(".photoCheck").click(function(){
		if($(this).is(":checked")==true){
			arr.push($(this).val());
		}else{
			arr.splice($.inArray($(this).val(),arr),1);
		}
		$("#selectedIdxs").val(arr);
	});
}else{
	var arr=[];
	$('.photoCheck').css('display','block');
	$('.photoCheck').click(function(){
		if ($(this).is(":checked") == true) {
			arr.push($(this).val());
		} else {
			arr.splice($.inArray($(this).val(), arr), 1);
		}
		$('#tempPhotoList').val(arr);
	});
}
</script>
<input type="hidden" id="tempPhotoList" />
                                  