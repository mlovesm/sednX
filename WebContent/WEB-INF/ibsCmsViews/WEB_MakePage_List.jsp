<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
 <div class="photo-gallery clearfix">
     <div class="photo photoForm">
         <div class="form_div col-md-12">
              <c:choose>
				<c:when test="${empty lists }">
					<div style="height: 100px;">데이타가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${lists}" var="list" varStatus="loop">
			             <div class="img_box" id="layer_${list.idx}" style="background: url(${list.vod_repo}) no-repeat center; background-size: cover;">
			                 <input class="pull-left m-l-5 boardCheck" type="checkbox" value="${list.idx}"/>
							<div class="imgPopup" id="${list.idx}"  style="left:30px;width:90%;height:100%;position:relative;"></div>
			                 <!-- <label class="checkbox-inline m-10 pull-left checkMode" style="display:none;">
			                     <span class="checkableBox">
			                         <input type="checkbox" id="inlineCheckbox1"> 
			                     </span>
			                 </label> -->
			             </div>
             		</c:forEach>
				</c:otherwise>
			</c:choose>
         </div>
     </div>
 </div>
 <div class="tile col-md-12 p-5">
     <div class="col-md-6">
     	 <button class="btn btn-alt col-md-2 m-b-5 defaultBtns" id="changeMode">편집</button>
         <button class="btn btn-alt col-md-2 m-r-10 m-b-5 editBtns" id="selectAllChk" style="display:none;">전체선택</button>
         <button class="btn btn-alt col-md-2 m-r-10 m-b-5 editBtns" id="checkDel" style="display:none;">삭제</button>
         <button class="btn btn-alt col-md-2 m-b-5 editBtns" id="checkMove" style="display:none;">이동</button>                                        
     </div>
     <div class="col-md-6">
     	<button class="btn btn-alt col-md-2 m-b-5 pull-right defaultBtns" id="boardAdd">추가</button>
        <button class="btn btn-alt col-md-2 m-b-5 pull-right editBtns" style="display:none;" id="editComplete">완료</button>
     </div>
 </div>
<input type="hidden" class="form-control" id="allcheck" />
<input type="hidden" class="form-control" id="selectedIdxs" />
<input type="hidden" class="form-control" id="changeCateIdx" />
<input type="hidden" class="form-control" id="changeCateProperty" />
 <script>
	$('.boardCheck').css('display','none');
	$('.imgPopup').click(function(){
		$('#boardDel').css('display','block');
		$('#boardMediaView').css('display','block');
		$('#boardMediaEdit').css('display','none');
		$('#boardOrder').val('update');
		common.delCashPlayer('vodPlayer');
		common.boardDefault();
		$('#saveFileList').empty();
		$('#boardSlideShow').empty();
		$('#boardViewModal').modal();
		$.ajax({
			url : "${pageContext.request.contextPath}/api/media/"+ $("#sort").val() + "/"+$(this).attr('id'),
			cache : false,
			async : false,
			success : function(responseData){
				var data=JSON.parse(responseData);
				$('#boardViewTitle').html(data.info.board_title);
				$('#boardViewDate').html(data.info.reg_dt);
				//$('#boardViewDownload').attr('href','${pageContext.request.contextPath}/sedn/download/vod/'+data.info.vodFile.split('.')[1]+'/'+data.info.vodFile.split('.')[0]);
				$('#boardViewCount').html(data.info.view_count);
				$('#boardViewText').html(data.info.board_content);
				$('#boardViewResolution').html(data.vodRelative.resolution);
				$('#boardViewRuntime').html(data.vodRelative.vod_play_time);
				$('#boardViewFilesize').html(common.number_to_human_size(data.vodRelative.file_size));
				$('#boardViewMainThumb').attr('src','${pageContext.request.contextPath}'+data.vodRelative.board_thumnail_path);
				
				//$('#boardDefaultImg').attr('src','${pageContext.request.contextPath}'+data.vodRelative.board_thumnail_path);
				$("#board_title").val(data.info.board_title);
				$("#board_content").val(data.info.board_content);
				//$("#board_path").val(data.info.vodFile);
				$("#board_keyword").val(data.info.board_keyword);
				//$("#board_main_thumbnail").val(data.info.board_main_thumbnail);
				$("#boardIdx").val(data.info.idx);
				//$("#photoList").val(data.thumb);
				$("#categoryIdx").val(data.info.category_idx);
				$('#vodRepo').val(data.info.vod_repo);
				$('#photoRepo').val(data.info.photo_repo);
				$('#fileRepo').val(data.info.file_repo);
				$('#downloadUl').empty();
				$('#photoList').empty();
				if($('#photoRepo').val().length!=0){
					var imgArr=$('#photoRepo').val().split(',');
					$.each(imgArr,function(index,value){
	 					arange.photoFactory(value);
	 				});
				}
				if($('#fileRepo').val().length!=0){
					var fileArr=$('#fileRepo').val().split(',');
					$.each(fileArr,function(index,value){
	 					arange.fileFactory(value);
	 				});
				}
				if($('#photoRepo').val().length==0&&$('#fileRepo').val().length==0){
					$('#downloadUl').append('<li>파일 없음</li>');
				}
				$('#saveFileList').append('&nbsp;&nbsp;&nbsp;&nbsp;<div class="btn btn-sm" onclick="common.selectRepoSource(\'file\');">파일추가</div>');
				$('#boardSlideShow').append('<li ><a class="add" onclick="common.selectRepoSource(\'photo\');"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
				$("#boardPlay_url").val(data.vodRelative.vod_path);
				$("#boardPlay_thum").val('${pageContext.request.contextPath}'+data.vodRelative.board_thumnail_path);
				
				$('#boardViewArea').empty();
				$('#boardPreview').empty();
				$('#boardViewArea').html('<img src="${pageContext.request.contextPath}'+$('#boardPlay_thum').val()+'" alt="샘플" id="boardViewMainThumb">');
				$('#boardPreview').html('<img src="${pageContext.request.contextPath}'+$('#boardPlay_thum').val()+'" alt="샘플" id="boardDefaultImg">');
				$('#boardLetsPlay').css('display','block');
				$('#boardLetsEditPlay').css('display','block');
				
				$('#boardDefaultImg').attr('src',"${pageContext.request.contextPath}"+$('#boardPlay_thum').val());
				slide.init();
			},
			error : exception.ajaxException
		});
	});
	$('#boardLetsPlay').click(function(){
		//common.boardDefault();
		$('#boardViewArea').empty();
		$('#boardPreview').empty();
		$('#boardViewArea').html('<img src="${pageContext.request.contextPath}'+$('#boardPlay_thum').val()+'" alt="샘플" id="boardViewMainThumb">');
		$('#boardPreview').html('<img src="${pageContext.request.contextPath}'+$('#boardPlay_thum').val()+'" alt="샘플" id="boardDefaultImg">');
		$('#boardLetsPlay').css('display','block');
		$('#boardLetsEditPlay').css('display','block');
		$('#boardLetsPlay').css('display','none');
		$('#boardDefaultImg').attr('src',"${pageContext.request.contextPath}"+$('#boardPlay_thum').val());
		modalLayer.vodPlayer($('#boardPlay_url').val(),$('#boardPlay_thum').val(),"boardViewArea");
	});
	$('#boardLetsEditPlay').click(function(){
		//common.boardDefault();
		common.delCashPlayer('vodPlayer');
		$('#boardViewArea').empty();
		$('#boardPreview').empty();
		$('#boardViewArea').html('<img src="${pageContext.request.contextPath}'+$('#boardPlay_thum').val()+'" alt="샘플" id="boardViewMainThumb">');
		$('#boardPreview').html('<img src="${pageContext.request.contextPath}'+$('#boardPlay_thum').val()+'" alt="샘플" id="boardDefaultImg">');
		$('#boardLetsPlay').css('display','block');
		$('#boardLetsEditPlay').css('display','block');
		$('#boardLetsEditPlay').css('display','none');
		$('#boardViewMainThumb').attr('src',"${pageContext.request.contextPath}"+$('#boardPlay_thum').val());
		modalLayer.vodPlayer($('#boardPlay_url').val(),$('#boardPlay_thum').val(),"boardPreview");
	});
 	$('#changeMode').click(function(){
 		arange.changeMode();
 	});
 	$('#editComplete').click(function(){
 		arange.returnMode();
 	});
 	var arr=[];
	$(".boardCheck").click(function(){
		if($(this).is(":checked")==true){
			arr.push($(this).val());
		}else{
			arr.splice($.inArray($(this).val(),arr),1);
		}
		$("#selectedIdxs").val(arr);
	});
	$('#checkMove').click(function(){
		var checkValArr = $("#selectedIdxs").val();
		if (checkValArr.length == 0) {
			exception.checkboxException();
		} else {
			menuJs.makeSelJstree();
		}
	});
	$('#checkDel').click(function(){
		var checkValArr=$("#selectedIdxs").val();
		if(checkValArr.length==0){
			exception.checkboxException();
		}else{
			$("#confirmText").text("선택 파일을 삭제하시겠습니까?.");
			$("#confirmModal").modal();
			exception.delConfirm(function(confirm){
				if(confirm){
					common.deleteByIdxArr(checkValArr);
					$("#setting").css('display','none');
					$("#contents-search").css('display','block');
					$('#preview').css('display','none');
				}
			});
		}
	});
	$('#selectAllChk').click(function(){
		var chkbox=$(".boardCheck");
		if($("#allcheck").val().length==0){
			$("#allcheck").val("checked");
			chkbox.prop("checked",true);
			arr=[];
			for(i=0;i<chkbox.length;i++){
				arr.push(chkbox[i].value);
			}
			$("#selectedIdxs").val(arr);
		}else{
			arr=[];
			$("#allcheck").val('');
			chkbox.prop("checked",false);
			$("#selectedIdxs").val('');
		}
	});
	$('#boardAdd').click(function(){
		$('#boardDel').css('display','none');
		$('#boardMediaView').css('display','none');
		$('#boardMediaEdit').css('display','block');
		common.boardDefault();
		$('#saveFileList').empty();
		$('#saveFileList').append('&nbsp;&nbsp;&nbsp;&nbsp;<div class="btn btn-sm" onclick="common.selectRepoSource(\'file\');">파일추가</div>');
		$('#boardSlideShow').empty();
		$('#boardSlideShow').append('<li ><a class="add" onclick="common.selectRepoSource(\'photo\');"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
		$('#boardLetsEditPlay').css('display','none');
		$('#boardOrder').val('insert');
		$('#boardViewModal').modal();
	});
	
 </script>