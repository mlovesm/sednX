<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
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
	    		<div class="tile" id="listView">
                      <div class="tile-title">
                          <h5 class="pull-left"><i class="fa fa-bars m-r-10"></i><span id="navibar">메인 페이지</span></h5>
                          <div class="col-md-6 pull-right">
                              <div class="col-md-4 p-r-20 m-t-5">
                                   <select id="selectSort" class="form-control input-sm">
                                       <option value="vod">VOD</option>
                                       <option value="photo">PHOTO</option>
                                       <option value="file">FILE</option>
                                       <option value="stream">STREAM</option>
                                   </select>
                               </div>
                               <div class="col-md-8 p-0">                                        
                                   <input type="text" class="main-search" id="contents-search" style="border-bottom: 1px solid #fff; width: 100%;" placeholder="검색어를 입력하세요." />                               
                               </div>
                           </div>
                      </div>
                      <div class="photo-gallery clearfix">
                          <div class="photo">
                              <div class="form_div col-md-12" id="contentView">
                                  
                              </div>
                          </div>
                      </div>

                      <div class="tile col-md-12 p-5" id="addBtns">
                          <div class="col-md-6">
                              <button class="btn btn-alt col-md-2 m-r-10 m-b-5" id="goEdit">편집</button>                            
                          </div>
                          <div class="col-md-6">
                              <button class="btn btn-alt col-md-2 m-b-5 pull-right" id="media-add">추가</button>
                          </div>
                      </div>
                      <div class="tile col-md-12 p-5" id="editBtns" style="display:none;">
                          <div class="col-md-6" >
                               <button class="btn btn-alt col-md-2 m-r-10 m-b-5" id="selectAllChk">전체선택</button>
                               <button class="btn btn-alt col-md-2 m-r-10 m-b-5" id="checkDel">삭제</button>
                               <button class="btn btn-alt col-md-2 m-b-5" id="checkMove">이동</button>                                        
                           </div>
                          <div class="col-md-6">
                              <button class="btn btn-alt col-md-2 m-b-5 pull-right" id="backAddBtns">완 료</button>
                          </div>
                      </div>
					
                  </div>
	    		
	    	</div>
	    </div>
	</div>
</section>
<input type="hidden" class="form-control" id="vodOrder" value="insert">
<input type="hidden" class="form-control" id="photoOrder" value="insert">
<input type="hidden" class="form-control" id="fileOrder" value="insert">
<input type="hidden" class="form-control" id="streamOrder" value="insert">
<input type="hidden" class="form-control" id="sort" value="vod">
<input type="hidden" class="form-control" id="categoryIdx" />
<input type="hidden" class="form-control" id="categoryName"/>
<input type="hidden" class="form-control" id="treeIdx" >
<input type="hidden" class="form-control" id="treeProperty" value="1">
<input id="repoOrder" type="text" class="form-control"/>
<input id="requestRepo" type="text" class="form-control" value="media">

<script>
$('#categoryIdx').val('${hn:getDefaultContentsIdx()}');
$('#categoryName').val('${hn:getDefaultContentsParentName()}<i class="fa fa-angle-right m-r-10 m-l-10"></i><i class="fa fa-list-alt m-r-10"></i>${hn:getDefaultContentsName()}');
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
		}
};
var arange={
	naviBar:function(){
		$("#sort").val(arguments[0]);
		$("#navibar").html(arguments[2]);
	},
	contentsView :function(idx){
		$("#contentView").empty();
		$('#addBtns').css('display','block');
		$('#editBtns').css('display','none');
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/list/"+ $("#sort").val() + "?childIdx="+idx+"&searchWord="+$('#contents-search').val(),
			success : function(data){
				$('#contentView').html(data);
			},
			error : exception.ajaxException
		});
	},
	selectSource: function(){
		$('#thumnailSource').css('display','block');
	},
	removeThumbLi:function(imgId,exe){
		$('#thumbLi_'+imgId).remove();
		//배열삭제 
		var thumbArr=$('#thumnailList').val().split(',')
		var retArr=common.removeElementToArray(thumbArr,imgId+'.'+exe);
		$('#thumnailList').val(retArr);
	},
	makeMainThumb : function(mainThumb,exe){
		$("#main_thumbnail").val(mainThumb+"."+exe);
		$(".thum").removeClass('boxLine');
		$("#thumbLi_"+mainThumb).addClass('boxLine');
	},
	list : function(idx,property){
		arange.contentsView(idx);
	}
	
};
$('#cmsPageTitle').html('미디어 관리');
$('.menuLi').removeClass('active');
$('#contentsMenuLi').addClass('active');
menuJs.makeJsTree($('#categoryIdx').val());
arange.naviBar('vod', $("#categoryIdx").val(), $("#categoryName").val());
arange.contentsView($("#categoryIdx").val());
$('#selectSort').change(function(){
	$('#sort').val($(this).val());
	menuJs.makeJsTree($('#categoryIdx').val());
	$('#contents-search').val('');
	arange.contentsView($('#treeIdx').val());
	$('#addBtns').css('display','block');
	$('#editBtns').css('display','none');
	
});
$('#goEdit').click(function(){
	if($('#selectSort').val()=="vod"){
		$('.vodCheck').css('display','block');
	}else if($('#selectSort').val()=="stream"){
		$('.selectCheck').css('display','block');
	}else if($('#selectSort').val()=="photo"){
		$('.photoCheck').css('display','block');
	}else if($('#selectSort').val()=="file"){
		$('.fileCheck').css('display','block');
	}
	$('#addBtns').css('display','none');
	$('#editBtns').css('display','block');
});
$('#backAddBtns').click(function(){
	if($('#selectSort').val()=="vod"){
		$('.vodCheck').css('display','none');
	}else if($('#selectSort').val()=="stream"){
		$('.selectCheck').css('display','none');
	}else if($('#selectSort').val()=="photo"){
		$('.photoCheck').css('display','none');
	}else if($('#selectSort').val()=="file"){
		$('.fileCheck').css('display','none');
	}
	$('#addBtns').css('display','block');
	$('#editBtns').css('display','none');
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
$('#media-add').click(function(){
	if($('#sort').val()=='vod'&&$('#treeProperty').val()!=0){
		$('#mediaDel').css('display','none');
		$('#vodMediaView').css('display','none');
		$('#vodMediaEdit').css('display','block');
		$('#thumnailSource').css('display','none');
		common.vodDefault();
		$('#letsEditPlay').css('display','none');
		$('#vodPreview').html('<img src="/img/live.jpg" alt="샘플" id="mediaDefaultImg">');
		$('#vodOrder').val('insert');
		$('#vodSlideShow').empty();
		$('#vodSlideShow').css('margin-left','');
		$('#vodSlideShow').append('<li id="addLi"><a class="add" onclick="arange.selectSource();"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
		slide.init();
		$('#vodViewModal').closest('.modal').find('.form-validation-2').validationEngine('hideAll');
		$('#vodViewModal').modal();
	}else if($('#sort').val()=='photo'&&$('#treeProperty').val()!=0){
		$('#photoDel').css('display','none');
		$('#photoMediaView').css('display','none');
		$('#photoMediaEdit').css('display','block');
		$('#photoOrder').val('insert');
		common.photoDefault();
		$('#photoViewModal').closest('.modal').find('.form-validation-3').validationEngine('hideAll');
		$('#photoViewModal').modal();
	}else if($('#sort').val()=='file'&&$('#treeProperty').val()!=0){
		$('#fileDel').css('display','none');
		$('#fileMediaView').css('display','none');
		$('#fileMediaEdit').css('display','block');
		$('#fileOrder').val('insert');
		common.fileDefault();
		$('#fileViewModal').closest('.modal').find('.form-validation-4').validationEngine('hideAll');
		$('#fileViewModal').modal();
	}else if($('#sort').val()=='stream'&&$('#treeProperty').val()!=0){
		$('#streamDel').css('display','none');
		$('#streamMediaView').css('display','none');
		$('#streamMediaEdit').css('display','block');
		$('#streamOrder').val('insert');
		common.streamDefault();
		$('#streamViewModal').closest('.modal').find('.form-validation-5').validationEngine('hideAll');
		$('#streamViewModal').modal();
	}else{
		exception.contentsAddException();
	}
	
});
$('#thumRepositoryAdd').click(function(){
	menuJs.vodScheduleJstree();
	//arange.repolist('');
	$('#repositoryList').modal();
});
$('#vodViewEdit').click(function(){
	common.delCashPlayer('vodPlayer');
	$('#mediaDel').css('display','block');
	$('#vodMediaView').css('display','none');
	$('#vodMediaEdit').css('display','block');
});
$('#photoViewEdit').click(function(){
	$('#photoDel').css('display','block');
	$('#photoMediaView').css('display','none');
	$('#photoMediaEdit').css('display','block');
});
$('#fileViewEdit').click(function(){
	$('#fileDel').css('display','block');
	$('#fileMediaView').css('display','none');
	$('#fileMediaEdit').css('display','block');
});
$('#streamViewEdit').click(function(){
	common.delCashPlayer('vodPlayer');
	$('#streamMediaView').css('display','none');
	$('#streamMediaEdit').css('display','block');
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
				if($('#selectSort').val()=="vod"){
					$('.vodCheck').css('display','none');
				}else if($('#selectSort').val()=="stream"){
					$('.selectCheck').css('display','none');
				}else if($('#selectSort').val()=="photo"){
					$('.photoCheck').css('display','none');
				}else if($('#selectSort').val()=="file"){
					$('.fileCheck').css('display','none');
				}
				$('#addBtns').css('display','block');
				$('#editBtns').css('display','none');
			}
		});
	}
});
var arr=[];
$('#selectAllChk').click(function(){
	var chkbox=$("."+$('#sort').val()+"Check");
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

</script>


