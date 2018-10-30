<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<style>
	.text-center tr th, .text-center tr td, .text-center {text-align: center;}
	.orange {background-color: #f0ad4e;}
	.ygreen {background-color: #5cb85c;}
	.blue {background-color: #428bca;}
	.sky {background-color: #5bc0de;}
	.yellow {background-color: #c59b5c;}
	.pink {background-color: #ce6fb4;}
	.puple {background-color: #806fdc;}
	.green {background-color: #3f8441;}
	.checked_from .title { border-bottom: 1px solid rgba(255, 255, 255, 0.31); border-left: 1px solid rgba(255, 255, 255, 0.31); height: 30px; line-height: 27px;}
	.checked_from .title span {
		border-top: 1px solid rgba(255, 255, 255, 0.31); border-right: 1px solid rgba(255, 255, 255, 0.31); padding: 0px 20px 0 10px; display: inline-block;
	}
	.checked_from .info {
		padding: 10px;
	}
</style>
<style>
.jstree-rename-input {
	color: #26120C;
}
</style>
<!-- Content -->
<section id="content" class="container">
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
   			<div class="tile-dark col-md-3">
   				<div class="text-right" style="position:absolute;right:10px;top:10px;">
                    <img src="${pageContext.request.contextPath}/ibsImg/menu_add.png" id="createMenu" alt="메뉴" style="cursor:pointer;">
                    <img src="${pageContext.request.contextPath}/ibsImg/list_add.png" id="createBoard" alt="리스트" style="cursor:pointer;">
                </div>
	   			<!-- TREE START-->
				<div id="menuTree" style="margin:10px;"></div>
				<!-- TREE END-->
			</div>
			<div class="col-md-9">
			<!--TITLE START-->
				<div class="tile">
					<div class="tile-title tile-dark">
	                   <h5 class="pull-left">
	                       <i class="fa fa-bars m-r-10"></i><span id="navibar">메인 페이지</span>
	                   </h5>
	                   <div class="pull-right">
	                   		<input type="text" class="main-search" id="contents-search" style="border-bottom: 1px solid #fff; width: 100%;display:none;" placeholder="검색어를 입력하세요.">
	                   		<a id="setting" style="cursor:pointer;"><span class="icon" >&#61886;</span> 설정</a>
	                   		<a id="preview" style="display:none;cursor:pointer;"><span class="icon m-r-10">&#61723;</span>미리보기</a>
	                   </div>	
	                 </div>
	                 <div id="pageView">
	                	<img src="${pageContext.request.contextPath}/img/A.jpg" style="margin-bottom:10px;"/>
	                	<img src="${pageContext.request.contextPath}/img/B.jpg" style="margin-bottom:10px;"/>
	                	<img src="${pageContext.request.contextPath}/img/C.jpg" style="margin-bottom:10px;"/>
	                	<img src="${pageContext.request.contextPath}/img/D.jpg" style="margin-bottom:10px;"/>
	                	<img src="${pageContext.request.contextPath}/img/E.jpg" style="margin-bottom:10px;"/>
	                	<img src="${pageContext.request.contextPath}/img/F.jpg" style="margin-bottom:10px;"/>
	                	<img src="${pageContext.request.contextPath}/img/G.jpg" style="margin-bottom:10px;"/>
	                	<img src="${pageContext.request.contextPath}/img/H.jpg" style="margin-bottom:10px;"/>	 
	                 </div>
	                 
                 </div>
                 
			<!--TITLE END-->
			<!-- CONTENTS START -->
			<input type="hidden" class="form-control" id="boardOrder" value="insert">
			<input type="hidden" class="form-control" id="sort" value="board">
			<input type="hidden" class="form-control" id="categoryIdx" />
			<input type="hidden" class="form-control" id="categoryName"/>
			<input type="hidden" class="form-control" id="treeIdx" >
			<input type="hidden" class="form-control" id="treeProperty" value="0">
			<input id="repoOrder" type="hidden" class="form-control" value="photo"/>
			<input id="requestRepo" type="hidden" class="form-control" value="vod">
			<input id="optionText" type="hidden" value="">
			<!-- CONTENTS END -->	
			</div>
	    </div>
   	</div>
</section>
<script>
$('#categoryIdx').val('1');
$('#categoryName').val('메인페이지');
var option='${hn:getBoardSelect()}';
$('#optionText').val(option);
var menuJs={
		makeJsTree:function(idx){
			$.ajax({
				url : "${pageContext.request.contextPath}/api/advenceTree/"
						+ $("#sort").val()+"/"+idx,
				async : false,
				success : function(data) {
					$("#menuTree").empty();
					$("#menuTree").html(data);
				},
				error : exception.ajaxException
			});
		},
	makeSelJstree : function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/api/selJstreeAdvence/"
					+ $("#sort").val(),
			async : true,
			success : function(data) {
				$("#modalTree").empty();
				$("#modalTree").html(data);
				$("#changeCateModel").modal();
			},
			error : exception.ajaxException
		});
	},
	vodScheduleJstree : function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/api/vodSchedule/"+$('#repoOrder').val(),
			async : false,
			success : function(data) {
				$("#video").empty();
				$("#video").html(data);
			},
			error : exception.ajaxException
		});
	}
};
var arange=(function(){
	var naviBar=function(){
		$("#sort").val(arguments[0]);
		$("#treeIdx").val(arguments[1]);
		$("#navibar").html(arguments[2]);
	};
	var list=function(idx,property){
		if(property=="1"){
			contentsView(idx);
		}else{
			makePage(idx);
		}
	};
	var contentsView=function(idx){
		$("#setting").css('display','none');
		$("#contents-search").css('display','block');
		$('#preview').css('display','none');
		$("#pageView").empty();
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/list/"+ $("#sort").val() + "?childIdx="+idx+"&searchWord="+$('#contents-search').val(),
			success : function(data){
				$('#pageView').html(data);
			},
			error : exception.ajaxException
		});
	};
	var makePage=function(idx){
		$("#setting").css('display','block');
		$("#contents-search").css('display','none');
		$('#preview').css('display','none');
		movePreview($('#categoryIdx').val());
	};
	var moveSetting=function(idx){
		$("#setting").css('display','none');
		$('#preview').css('display','block');
		$("#pageView").empty();
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/makepage/setting/"+idx,
			success : function(data){
				$('#pageView').html(data);
			},
			error : exception.ajaxException
		});
	};
	var movePreview=function(idx){
		$('#preview').css('display','none');
		$('#setting').css('display','block');
		$("#pageView").empty();
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/makepage/preview/"+idx,
			success : function(data){
				$('#pageView').html(data);
			},
			error : exception.ajaxException
		});
	};
	var changeMode=function(idx){
		$('#selectedIdxs').val('');
		$('.editBtns').css('display','block');
		$('.defaultBtns').css('display','none');
		$('.boardCheck').css('display','block');
	};
	var returnMode=function(){
		$('.editBtns').css('display','none');
		$('.defaultBtns').css('display','block');
		$('.boardCheck').css('display','none');
	};
	var photoFactory=function(idx){
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
		                retHtml+='<li style="float:left; background: url(${pageContext.request.contextPath}'+data.imgList[i].img_url
								+') no-repeat center; background-size: cover;" id="boardImgLi_'+data.imgList[i].img_idx+'">'
	                  			+'<a class="close" onClick="arange.removeBoardLi('+data.imgList[i].img_idx+')"><img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"/></a>'
	                  			+'</li>';
		                viewHtml+='<img src="${pageContext.request.contextPath}'+data.imgList[i].img_url+'" />';
		                downloadHtml+='<li>· <a href="${pageContext.request.contextPath}/sedn/download/photo/'+data.imgList[i].img_url.split('/')[6].split('.')[1]+'/'+data.imgList[i].img_url.split('/')[6].split('.')[0]+'">'+data.imgList[i].img_url.split('/')[6]+'</a></li>'
					}
					$('#boardSlideShow').append(retHtml);
					$('#photoList').append(viewHtml);
					$('#downloadUl').append(downloadHtml);
					
				},
				error : exception.ajaxException
			});
		}
	};
	var fileFactory=function(idx){
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
						retHtml+='<div class="btn btn-sm delfileList" id="boardFile_'+data.fileList[i].file_idx+'" onClick="arange.removeBoardFile('+data.fileList[i].file_idx+')">'+data.fileList[i].file_url+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</div>';
		               downloadHtml+='<li>· <a href="${pageContext.request.contextPath}/sedn/download/file/'+data.fileList[i].file_url.split('.')[1]+'/'+data.fileList[i].file_url.split('.')[0]+'">'+data.fileList[i].file_url+'</a></li>'
					}
					$('#saveFileList').append(retHtml);
					$('#downloadUl').append(downloadHtml);
					
				},
				error : exception.ajaxException
			});
		}
	};
	var removeBoardFile=function(imgId){
		$('#boardFile_'+imgId).remove();
		//배열삭제 
		var retArr=common.removeElementToArray($('#fileRepo').val().split(','),imgId);
		$('#fileRepo').val(retArr);
	};
	var removeBoardLi=function(imgId){
		$('#boardImgLi_'+imgId).remove();
		//배열삭제 
		var retArr=common.removeElementToArray($('#photoRepo').val().split(','),imgId);
		$('#photoRepo').val(retArr);
	};
	
	return {
		naviBar : naviBar,
		list : list,
		makePage : makePage,
		moveSetting : moveSetting,
		movePreview : movePreview,
		changeMode : changeMode,
		returnMode : returnMode,
		contentsView : contentsView,
		photoFactory : photoFactory,
		removeBoardLi : removeBoardLi,
		fileFactory : fileFactory,
		removeBoardFile : removeBoardFile
	}
}());
</script>
<script>
	//loaded reset
	$('#cmsPageTitle').html('페이지 관리');
	$('.menuLi').removeClass('active');
	$('#pageMenuLi').addClass('active');
	arange.naviBar('board', $("#categoryIdx").val(), $("#categoryName").val());
	arange.list('1','0');
	menuJs.makeJsTree('1');
	$("#setting").click(function(){
		arange.moveSetting($('#categoryIdx').val());
	});
	$("#preview").click(function(){
		arange.movePreview($('#categoryIdx').val());
	});
	$('#contents-search').keyup(function(key){
		var regExp =/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		var retString=$('#contents-search').val();
		if(regExp.test(retString)){
			$('#contents-search').val(retString.replace(regExp,""));	
		}
		if($('#contents-search').val().length!=0){
			arange.contentsView($('#categoryIdx').val());
		}
	});
	
</script>
