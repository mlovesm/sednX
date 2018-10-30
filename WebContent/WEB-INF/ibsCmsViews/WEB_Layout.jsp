<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<!--********** permittsion include **************-->
<c:import url="/inc/incPermission">
	<c:param name="permission" value="2000" />
</c:import>
<!--********* permittsion include **************-->
<!-- Content -->
<section id="content" class="container">
    <!-- Messages Drawer 메세지 클릭햇을시 (최신영상이 )%%%대메뉴 공통 부 분-->
	<div id="messages" class="tile drawer animated">
		<c:import url = "/inc/incMsg">
			<c:param name = "q" value = "보라매공원" />
		</c:import>
	</div>

	<!-- Notification Drawer -->
	<div id="notifications" class="tile drawer animated">
		<c:import url = "/inc/incNoti">
			<c:param name = "q" value = "보라매공원" />
		</c:import>
	</div>
	<!--메뉴경로... -->
	<ol class="breadcrumb hidden-xs">
	    <li><a href="#">Home</a></li>
	    <li class="active">MAIN PAGE EDITOR</li>
	</ol>
	<!-- 대메뉴-->
	<h4 class="page-title">MAIN PAGE EDITOR</h4>
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
	   		<div id="carousel-example-generic" class="carousel slide">
                <!-- Indicators -->
                <ol class="carousel-indicators" id="indicators">
                  
                </ol>
              
                <!-- Wrapper for slides -->
                <div class="carousel-inner" id="carouselInner">
                </div>
                
                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                    <i class="icon">&#61903;</i>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                    <i class="icon">&#61815;</i>
                </a>
            </div>
            <div class="clearfix">&nbsp;</div>
            <div class="tile-dark col-md-12 p-5">
            <form  class="form-validation-1" id="contentsForm">
            	<div class="col-md-4">
	            	<div class="col-lg-4 p-5">
	                    <input type="text" id="img_title" class="form-control validate[required,maxSize[15]]" placeholder="이미지 제목" >
	                </div>
	                <div class="col-lg-8 p-5">
	                    <input type="text" id="img_url" class="form-control validate[required,maxSize[100],custom[url]]" placeholder="관련 URL">
	                    <input type="text" id="img_name" class="form-control validate[required,funcCall[uploadFile.checkMainImgExist]]" placeholder="파일명" style="width:0px;height:1px;opacity: 0">
	                </div>
	                <div class="fileupload fileupload-new p-5" data-provides="fileupload">
	       				<div class="fileupload-preview thumbnail form-control" id="imgName_view">메인 이미지를 업로드하세요</div>
	        			<div class="pull-right">
	            			<span class="btn btn-file btn-alt btn-sm">
	                			<span class="fileupload-new">이미지 선택</span>
	                			<span class="fileupload-exists">이미지 바꾸기</span>
	                			<input type="file" id="mainImg" onchange="uploadFile.mainImage(this,'mainImg');" />
	                		</span>
	                		<button type="button" class="btn btn-alt btn-sm icon" id="mainImgAdd"><span>&#61943;</span> <span class="text">등록</span></button>
	            		</div>
	    			</div>
            	</div>
            	</form>
	            <div class="col-md-8">
	            	<!-- 케로셀 이미지 리스트  -->
	            	<div id="carouselList">
	            	
	            	</div>
	            	<!-- 케로셀 이미지 리스트  -->
	            	
	            	<div class="col-md-12 p-5">
	            		<input type="hidden" id="selectedImgIdx" />
	            		<button type="button" class="btn btn-alt btn-sm icon pull-right" id="deleteImg"><span>&#61754;</span> <span class="text">선택 삭제</span></button>
	            	</div>
	            	<div class="clearfix"></div>
	            </div>
            </div>
            <div class="clearfix">&nbsp;</div>
            <div class="tile-dark col-md-12 p-10">
  				 <div class="col-md-4">
  				 	<form class="form-inline selectArea" role="form">
                        ${hn:getCategorySelect('tb_board_category','1')}
                    </form>
                 </div>
                 <input type="hidden" id="mainContentsIdx">
                 <button type="button" class="btn btn-alt btn-sm icon" id="listAdd"><span>&#61943;</span> <span class="text">메인노출 컨텐츠</span></button>
                 <button type="button" class="btn btn-alt btn-sm" id="selectDefault">추 가</button>
            </div>
            <div class="clearfix">&nbsp;</div>
            <!-- main contents list -->
            <div id="mainContentsList">
            </div>
	        <!-- main contents list --> 
	    </div>
   	</div>
</section>
<script>

var layout=(function(){
	var getCarouselList=function(){
		var result="";
		var indicators="";
		var carouselInner="";
		var list=0;
		$.ajax({
			url : "${pageContext.request.contextPath}/api/public/carousel",
			success : function(responseData) {
				var data = JSON.parse(responseData);
				$.each(data.lists, function( index, value ) {
					 result+='<div class="col-xs-4 p-2" id="list_'+value.idx+'">';
					 result+='<div style="float:left;position:absolute;padding:5px;">';
					 result+='<label class="checkbox-inline"><input type="checkbox" onClick="layout.deleteImg(this)"; id="'+value.idx+'" value="'+value.idx+'"></label>';
					 result+='</div>';
					 result+='<img src="${pageContext.request.contextPath}/REPOSITORY/CAROUSEL/'+value.img_name+'" class="checkImag">';
					 result+='</div>'; 
					 list++;
				});
				$("#carouselList").empty();
				$("#carouselList").html(result);
				for(var i=0;i<list;i++){
					if(i==0){
						indicators+='<li data-target="#carousel-example-generic" data-slide-to="'+i+'" class="active"></li>';
					}else{
						indicators+='<li data-target="#carousel-example-generic" data-slide-to="'+i+'"></li>';
					}
				}
				$("#indicators").empty();
				$("#indicators").html(indicators);
				for(var i=1;i<list+1;i++){
					if(i==1){
						carouselInner+='<div class="item active"><img src="${pageContext.request.contextPath}/REPOSITORY/CAROUSEL/'+data.lists[i-1].img_name+'" alt="Slide-'+i+'"></div>';
                    }else{
                    	carouselInner+='<div class="item"><img src="${pageContext.request.contextPath}/REPOSITORY/CAROUSEL/'+data.lists[i-1].img_name+'" alt="Slide-'+i+'"></div>';
					}
				}
				$("#carouselInner").empty();
				$("#carouselInner").html(carouselInner);
			},
			error : exception.ajaxException
		});
	};
	var getMainContentsList=function(){
		var result="";
		$.ajax({
			url : "${pageContext.request.contextPath}/api/public/mainContents",
			success : function(responseData) {
				var data = JSON.parse(responseData);
				$.each(data.lists,function(index,value){
					result+='<div class="alert alert-info alert-dismissable fade in" id="'+value.idx+'">';
					result+='<button type="button"  class="close" data-dismiss="alert" aria-hidden="true" onClick="layout.deleteContents(this)">&times;</button>';
					result+=value.category_idx; 
					result+='</div>';
				});
				$("#mainContentsList").html(result);
			},
			error : exception.ajaxException
		});
	};
	var arr = [];
	var deleteImg=function(obj){
		if ($(obj).is(":checked") == true) {
			arr.push($(obj).attr("id"));
		} else {
			arr.splice($.inArray($(obj).attr("id"), arr), 1);
		}
		$("#selectedImgIdx").val(arr);
	};
	var deleteByIdxArr=function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/layout/mainImage/delete?checkValArr="+$("#selectedImgIdx").val(),
			async : false,
			success : function(responseData) {
				var data = JSON.parse(responseData);
				if (data.result == "success") {
					$("#successText").text("컨텐츠 삭제에 성공했습니다.");
					$("#sucessModal").modal();
					var array = $("#selectedImgIdx").val().split(',');
					for (i = 0; i < array.length; i++) {
						$('#list_' + array[i]).fadeOut('slow');
					}
					getCarouselList();
					$("#selectedImgIdx").val('');
				}
			},
			error : exception.ajaxException
		});
	};
	var selectList=function(obj){
		if($(obj).val()!=""){
			$("#mainContentsIdx").val($(obj).val());
			$(obj).prop('disabled', 'disabled');
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/category/select/"
						+ $("#mainContentsIdx").val(),
				success : function(data) {
					$(".selectArea").append(data);
				},
				error : exception.ajaxException
			});
		}else{
			$(".selectArea").empty();
			$("#mainContentsIdx").val('');
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/category/select/1",
				success : function(data) {
					$(".selectArea").append(data);
				},
				error : exception.ajaxException
			});
		}
	};
	var insertMainList=function(idx){
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/layout/mainContents/insert?idx="+idx,
			success : function(data) {
				getMainContentsList();
			},
			error : exception.ajaxException
		});
	};
	var deleteContents=function(obj){
		var idx=$(obj).parent().attr('id');
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/layout/mainContents/delete?idx="+idx,
			success : function(data) {
				getMainContentsList();
			},
			error : exception.ajaxException
		});
	};
	return{
		getCarouselList:getCarouselList,
		getMainContentsList:getMainContentsList,
		deleteImg:deleteImg,
		deleteByIdxArr:deleteByIdxArr,
		selectList:selectList,
		insertMainList:insertMainList,
		deleteContents:deleteContents
	};
}());

$(function(){
	$("#selectDefault").click(function(){
		$(".selectArea").empty();
		$("#mainContentsIdx").val('');
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/category/select/1",
			success : function(data) {
				$(".selectArea").append(data);
			},
			error : exception.ajaxException
		});
	});
	layout.getCarouselList();
	layout.getMainContentsList();
	
	$("#listAdd").click(function(){
		if($("#mainContentsIdx").val()==""){
			$("#warnText").text("카테고리를 선택 해 주세요.");
			$("#msgModal").modal();
		}else{
			layout.insertMainList($("#mainContentsIdx").val());
		}
		
	});
	$("#deleteImg").click(function(ev){
		var checkValArr = $("#selectedImgIdx").val();
		if (checkValArr.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택 파일을 삭제하시겠습니까?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					layout.deleteByIdxArr();
				}
			});
		}
	});
	$("#mainImgAdd").click(function() {
		if ($("#contentsForm").validationEngine('validate')) {
			$("#contentsForm").submit();
		}
	});
	
	$("#contentsForm").submit(function(ev){
		$.ajax({
			url : '/cms/layout/mainImage/insert',
			cache : false,
			type : 'post',
			data :{
				"img_name":$("#img_name").val(),
				"img_title":$("#img_title").val(),
				"img_url":$("#img_url").val(),
				},
			async : false,
			success : function(result) {
				layout.getCarouselList();
			},
			error : exception.ajaxException
		});
		ev.preventDefault();
	});
	
});
</script>
<!-- Older IE Message -->
<!--[if lt IE 9]>
    <div class="ie-block">
        <h1 class="Ops">Ooops!</h1>
        <p>You are using an outdated version of Internet Explorer, upgrade to any of the following web browser in order to access the maximum functionality of this website. </p>
        <ul class="browsers">
            <li>
                <a href="https://www.google.com/intl/en/chrome/browser/">
                    <img src="img/browsers/chrome.png" alt="">
                    <div>Google Chrome</div>
                </a>
            </li>
            <li>
                <a href="http://www.mozilla.org/en-US/firefox/new/">
                    <img src="img/browsers/firefox.png" alt="">
                    <div>Mozilla Firefox</div>
                </a>
            </li>
            <li>
                <a href="http://www.opera.com/computer/windows">
                    <img src="img/browsers/opera.png" alt="">
                    <div>Opera</div>
                </a>
            </li>
            <li>
                <a href="http://safari.en.softonic.com/">
                    <img src="img/browsers/safari.png" alt="">
                    <div>Safari</div>
                </a>
            </li>
            <li>
                <a href="http://windows.microsoft.com/en-us/internet-explorer/downloads/ie-10/worldwide-languages">
                    <img src="img/browsers/ie.png" alt="">
                    <div>Internet Explorer(New)</div>
                </a>
            </li>
        </ul>
        <p>Upgrade your browser for a Safer and Faster web experience. <br/>Thank you for your patience...</p>
    </div>   
<![endif]-->
