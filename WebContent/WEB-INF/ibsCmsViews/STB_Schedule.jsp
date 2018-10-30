<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<style>
.jstree-rename-input {
	color: #26120C;
}
</style>
<!--********** permittsion include **************-->
<c:import url="/inc/incPermission">
	<c:param name="permission" value="3000" />
</c:import>
<!--********* permittsion include **************-->
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
		<li><a href="${pageContext.request.contextPath}/sednmanager">Home</a></li>
		<li>STB</li>
		<li class="active">OTT SCHEDULT</li>
	</ol>
	<!-- 대메뉴-->
	<h4 class="page-title">
	<a href="${pageContext.request.contextPath}/sedn/stb/controle" style="padding-left:40px;padding-right:40px;">OTT CONTROLE</a>
	<a href="${pageContext.request.contextPath}/sedn/stb/schedule" style="padding-left:40px;padding-right:40px;font-weight:bold;color:#F8C529;" class="active">OTT SCHEDULE</a>
	<a href="${pageContext.request.contextPath}/sedn/stb/log" style="padding-left:40px;padding-right:40px;">OTT LOG</a>
	<a href="${pageContext.request.contextPath}/sedn/stb/ui" style="padding-left:40px;padding-right:40px;">OTT SETTING</a>
	</h4>
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
	   		<div class="tile-dark col-md-2">
	   		<!-- MENU TITLE START -->
	        <h3 class="block-title">OTT CATEGORY</h3>
	        <!-- MENU TITLE END -->
	        <!-- TREE START-->
			<div id="menuTree"></div>
			<!-- TREE END-->
		</div>
        <div class="col-md-10">
        	<!--TITLE START-->
			<h3 class="block-title" id="navibar"></h3>
			<div style="float: right;">
				<input type="hidden" id="categoryIdx" value="1" /><input
					id="sort" type="hidden"><input id="treeIdx" type="hidden"><input
					type="text" class="main-search" id="mainSearch"
					style="border-bottom: 1px solid #FFFFFF;" placeholder="제목,내용,지역">
			</div>
   			<!-- CONTENTS START -->
			<div id="listView" class="tile"></div>
			<!-- CONTENTS END -->	
	    </div>
	  </div>
   </div>
</section>
<script>
	var menuJs = (function() {
		var makeJsTree = function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/jstree/"
						+ $("#sort").val(),
				async : true,
				success : function(data) {
					$("#menuTree").empty();
					$("#menuTree").html(data);
				},
				error : exception.ajaxException
			});
		};
		var makeSelJstree = function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/checkJstree/"
						+ $("#sort").val(),
				async : true,
				success : function(data) {
					$("#scheduleInsertModel").empty();
					$("#scheduleInsertModel").html(data);
				},
				error : exception.ajaxException
			});
		};
		var editSelJstree = function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/checkJstreeEdit/"
						+ $("#sort").val()+"?groupArr="+$("#groupArr").val(),
				async : true,
				success : function(data) {
					$("#scheduleInsertModel").empty();
					$("#scheduleInsertModel").html(data);
				},
				error : exception.ajaxException
			});
		};
		var vodScheduleJstree = function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/vodSchedule/vod",
				async : true,
				success : function(data) {
					$("#video").empty();
					$("#video").html(data);
				},
				error : exception.ajaxException
			});
		};
		return {
			makeJsTree : makeJsTree,
			makeSelJstree : makeSelJstree,
			editSelJstree :editSelJstree,
			vodScheduleJstree :vodScheduleJstree
		};
	}());
	var contents = (function() {
		var list = function(childIdx) {
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/list/"
						+ $("#sort").val() + "?childIdx=" + childIdx,
				success : function(data) {
					$("#selectedIdx").val('');
					$("#listView").empty();
					$("#listView").html(data);
				},
				error : exception.ajaxException
			});
		};
		var naviBar = function() {
			$("#sort").val(arguments[0]);
			$("#treeIdx").val(arguments[1]);
			$("#categoryTitle").text($("#sort").val() + " CATEGORY");
			$("#navibar").html(arguments[2]);
		};
		var arangePage = function(sort, categoryIdx, naviString) {
			contents.naviBar(sort, categoryIdx, naviString);
			menuJs.makeJsTree();
			contents.list(categoryIdx);
		};
		var selectArrange = function(idx) {
			$('#jstree').jstree("deselect_all");
			$('#jstree').jstree('select_node', idx);
			menuJs.makeJsTree();
		};
		var search = function(searchWord) {
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/list/"
						+ $("#sort").val() + "?searchWord=" + searchWord
						+ "&childIdx=" + $("#treeIdx").val(),
				success : function(data) {
					$("#selectedIdx").val('');
					$("#listView").empty();
					$("#listView").html(data);
				},
				error : exception.ajaxException
			});
		};
		var contentForm = function(sort, order, idx) {
			if (order == "update") {
				$("#addTitle").html(sort + " contents edit");
			} else {
				$("#addTitle").html(sort + " contents add");
			}

			$.ajax({
				url : "${pageContext.request.contextPath}/cms/form/" + sort
						+ "/" + order + "/" + idx,
				success : function(data) {
					$("#insertForm").empty();
					$("#insertForm").html(data);
				},
				error : exception.ajaxException
			});
			$("#contentsAddModel").modal();
		};
		var deleteByIdxArr = function() {
			if ($("#selectedIdx").val().length == 0)
				return false;
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/delete/"
						+ $("#sort").val() + "?checkValArr="
						+ $("#selectedIdx").val(),
				async : false,
				success : function(responseData) {
					var data = JSON.parse(responseData);
					if (data.result == "success") {
						$("#successText").text("컨텐츠 삭제에 성공했습니다.");
						$("#sucessModal").modal();
						var array = $("#selectedIdx").val().split(',');
						for (i = 0; i < array.length; i++) {
							$('#list_' + array[i]).fadeOut('slow');
						}
						menuJs.makeJsTree();
						$("#selectedIdx").val('');
						$(".checkElem").prop("checked", false);
					}
				},
				error : exception.ajaxException
			});
		};
		var number_to_human_size = function(x) {
			var s = [ 'bytes', 'kB', 'MB', 'GB', 'TB', 'PB' ];
			var e = Math.floor(Math.log(x) / Math.log(1024));
			var se = (x / Math.pow(1024, e)).toFixed(2) + " " + s[e];
			return se.replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
		};
		return {
			list : list,
			naviBar : naviBar,
			arangePage : arangePage,
			selectArrange : selectArrange,
			search : search,
			contentForm : contentForm,
			deleteByIdxArr : deleteByIdxArr,
			number_to_human_size : number_to_human_size
		}
	})();
	
</script>
<script>
	$(function() {
		//페이지 초기화
		contents.naviBar('stb-schedule', '', 'OTT SCHEDULE');
		menuJs.makeJsTree();
		menuJs.vodScheduleJstree();
		contents.list('');
		
		$("#getStart").datetimepicker({format:'Y-m-d H:i',step:30,theme:'dark'});
		$("#getEnd").datetimepicker({format:'Y-m-d H:i',step:30,theme:'dark'});
		
		$("#mainSearch").keydown(function(key) {
			if (key.keyCode == 13) {
				if ($("#mainSearch").val().length == 0) {
					exception.searchException();
				} else {
					contents.search($("#mainSearch").val());
				}
			}
		});
		
	});
	 var calClick=function(){
     	var viewEvent=function(idx){
     		$("#order").val('update');
     		 if($('#order').val()=="update"){
              	$("#deleteEvent").css('display','block');
   	 			$("#addEvent").val("수 정");
              }else{
              	$("#deleteEvent").css('display','none');
   	 			$("#addEvent").val("생방송 추가");
              }
     		$.ajax({
     	 		url:'/api/web/stb-schedule/'+$("#order").val()+"/"+idx,
     	 		success : function(responseData){
     	 			var data=JSON.parse(responseData);
     	 			$('#addNew-event form')[0].reset();
     	 			var nowDate=new Date();
     	 			if(Date.parse(nowDate)>data.start&&Date.parse(nowDate)<data.end){
     	 				exception.liveException();
     	 				return;
     	 			}
     	 			$("#idx").val(data.idx);
     	 			$('#eventName').val(data.name);
                     var setStart=common.setDate(data.start);
     	 			$("#getStart").val(setStart);
     	 			var setEnd=common.setDate(data.end);
     	 			$("#getEnd").val(setEnd);
     	 			$("#groupArr").val(data.groupArr);
     	 			menuJs.editSelJstree(data.groupArr);
     	 			$("#source_type").val(data.source_type);
     	 			if(data.source_type=="LIVE"){
     	 				$(".sourceTab").removeClass('active');
     	 				$("#liveTab").addClass('active');
     	 				$(".tab-pane").removeClass('active');
     	 				$("#live").addClass('active');
     	 				$("#selectLive").val(data.live_stream_url);
     	 				$('#live_stream_url').val(data.live_stream_url);
     	 				$('#live_ch_idx').val(data.live_ch_idx);
     	 			}
     	 			if(data.source_type=="VOD"){
     	 				$(".sourceTab").removeClass('active');
     	 				$("#vodTab").addClass('active');
     	 				$(".tab-pane").removeClass('active');
     	 				$("#video").addClass('active');
     	 				var optionHtml="";
     	 				$.ajax({
     	 					url:"${pageContext.request.contextPath}/api/smList/vodIdxArr?idxArr="+data.vodArr,
     	 					success:function(responseData){
     	 						var optionData=JSON.parse(responseData);
     	 						$.each(optionData.lists,function(key,value){
     	 							var second=common.runtimeToSecond(value.vod_play_time);
     	 							$('#totalRuntimeForm').val(Number($('#totalRuntimeForm').val())+second);
     	 							var img=value.main_thumbnail;
     	 							optionHtml+="<option  class='optionImg' value='"+value.idx+"' style=background-image:url('${pageContext.request.contextPath}"+img+"'); title="+value.vod_play_time+">"+value.vod_title+"</option>";		
     	 						});
     	 						$('#totalRuntime').text($('#totalRuntimeForm').val().toHHMMSS());
     	 						$('#vodSource').html(optionHtml);
     	 					},
     	 					error:exception.ajaxException
     	 				});
     	 			}
						if(typeof(data.caption)!="undefined"){
     	 				$('#captionYn').val('Y');
     	 				$('#captionForm').css('display','block');
     	 				$("#caption").val(data.caption);
     	 				$("#caption_size").val(data.caption_size);
     	 				$("#caption_speed").val(data.caption_speed);
     	 				$("#caption_text_color").val(data.caption_text_color);
     	 				$("#caption_text_color").next().css('backgroundColor',data.caption_text_color);
     	 				if(data.caption_bg_color.lenght!=0){
     	 					$("#caption_bg_color").val(data.caption_bg_color);
     	 					$("#caption_bg_color").next().css('backgroundColor',data.caption_bg_color);
     	 				}
     	 				$('#captionView').html('자 막 설 정 닫 기');
     	 				}else{
     	 				$('#captionView').html('자 막 설 정 열 기');
     	 				$('#captionYn').val('N');
     	 				$('#captionForm').css('display','none');
     	 			}
     	 			$("#imgName_view").html("<img src='${pageContext.request.contextPath}/REPOSITORY/SCHIMG/"+data.image_path+"'/>");
     	 			$("#image_path").val(data.image_path);
     	 			$("#color").val(data.color);
     	 			$("#color").next().css('backgroundColor',data.color);
     	 			$("#desc_text").val(data.desc_text);
     	 			$('#addNew-event').modal('show');
     	 		},
     	 		error:exception.ajaxException
     	 	});
     	};
     	var updateScheduleDate=function(idx,start,end){
     		var result="success";
     		$.ajax({
     			url:'/cms/update/ScheduleDate',
     			cache:false,
     			type : 'post',
     			data : {"idx":idx,"start":start,"end":end},
     			async : false,
     			success : function(data){
     				if(data!='success'){
     					$("#warnText").text("현재시간이 포함된 스케쥴은 이동할 수 없습니다.");
     					$("#msgModal").modal();
     					result="fail";
     				}
     			},
     			error : exception.ajaxException 
     		});	
     		return result;
     	};
     	var deleteEvent = function(){
     		$("#confirmText").text("선택 파일을 삭제하시겠습니까?.");
 			 $("#confirmModal").modal();
 			 exception.scheduleDelConfirm(function(confirm){
    				if(confirm){
    					$.ajax({
    						url : '/cms/delete/stb-schedule?checkValArr='+$("#idx").val()+"&childIdx=",
    						success : function(responseData){
    							var data=JSON.parse(responseData);
    							if(data.result=="success"){
    								//$('#calendar').fullCalendar('removeEvents');
        			            	//$('#calendar').fullCalendar('addEventSource','${pageContext.request.contextPath}/api/web/scheduleJson?childIdx=');
        			             	//$('#calendar').fullCalendar('rerenderEvents' );
    								location.reload();
    								//menuJs.makeJsTree();
    								//$('#calendar').remove();
        				 			//contents.list('');
        				 			/*$.ajax({
        				 				url : '${pageContext.request.contextPath}/api/web/scheduleJson?childIdx=',
        				 				success : function(data){
        				 					var events=new Array();
        				 					events=data;
        				 					$('#calendar').fullCalendar('removeEvents');
        				 					$('#calendar').fullCalendar('addEventSource',events);
        				 					$('#calendar').fullCalendar('rerenderEvents' );
        				 				},
        				 				error : exception.ajaxException
        				 			});*/
    							}
    							
    							//$('#calendar').fullCalendar('removeEvents');
    			            	//$('#calendar').fullCalendar('addEventSource','${pageContext.request.contextPath}/api/web/scheduleJson?childIdx=');
    			            	//$('#calendar').fullCalendar('fetchEvents');
    			             	//$('#calendar').fullCalendar('rerenderEvents' );
    			             	//$('#calendar').fullCalendar('refresh');
    						},
    						error : exception.ajaxException
    					});
    				}
				});
 			
     	};
     	return{
     		viewEvent:viewEvent,
     		updateScheduleDate:updateScheduleDate,
     		deleteEvent : deleteEvent
     	};
     }();
</script>

<!-- Older IE Message -->
<!--[if lt IE 9]>
    <div class="ie-block">
        <h1 class="Ops">Ooops!</h1>
        <p>You are using an outdated version of Internet Explorer, upgrade to any of the following web browser in order to access the maximum functionality of this website. </p>
        <ul class="browsers">
            <li>
                <a href="https://www.google.com/intl/en/chrome/browser/">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/chrome.png" alt="">
                    <div>Google Chrome</div>
                </a>
            </li>
            <li>
                <a href="http://www.mozilla.org/en-US/firefox/new/">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/firefox.png" alt="">
                    <div>Mozilla Firefox</div>
                </a>
            </li>
            <li>
                <a href="http://www.opera.com/computer/windows">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/opera.png" alt="">
                    <div>Opera</div>
                </a>
            </li>
            <li>
                <a href="http://safari.en.softonic.com/">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/safari.png" alt="">
                    <div>Safari</div>
                </a>
            </li>
            <li>
                <a href="http://windows.microsoft.com/en-us/internet-explorer/downloads/ie-10/worldwide-languages">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/ie.png" alt="">
                    <div>Internet Explorer(New)</div>
                </a>
            </li>
        </ul>
        <p>Upgrade your browser for a Safer and Faster web experience. <br/>Thank you for your patience...</p>
    </div>   
<![endif]-->
