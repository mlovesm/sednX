<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>

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
	.label-pink {background-color: #ffa2cd;}
    .label-puple {background-color: #6e00ff;}
    .label-black {background-color: #000;}
    .label-gray {background-color: #8c8c8c;padding:1px;}
    .label-brown {background-color: #4a1824;}
    .label-green {background-color: #217724;padding:2px;}
    .label-new {background-color: #dc0000;}
     li.round {border-radius: 17px !important; background: rgba(0, 112, 255, 0.13); border: 1px solid rgba(0, 0, 0, 0.31); color: #fff; list-style: none; display: inline-block; padding: 6px 12px; font-size: 14px; line-height: 1.42857143;}
</style>
<style>
.jstree-rename-input {
	color: #26120C;
}
</style>
<section id="content" class="container">
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
   			<div class="tile-dark col-md-3">
   				<div class="text-right" style="position:absolute;right:10px;top:10px;">
                    <img src="${pageContext.request.contextPath}/ibsImg/list_add.png" id="createMenu" alt="메뉴" style="cursor:pointer;">
                </div>
	   			<!-- TREE START-->
				<div id="menuTree" style="margin:10px;">
					<div id="jstree" ></div> 
					  <div class="p-10 text-center">
					  <button class="btn btn-block btn-alt" id="renameGroup">이름변경</button>
					  <button class="btn btn-block btn-alt" id="deleteGroup" >카테고리 삭제</button>
					 </div>
					<div class="clearfix"></div>
				</div>
				<!-- TREE END-->
			</div>
			<div class="col-md-9">
			<!--TITLE START-->
				<div class="tile">
					<div class="tile-title tile-dark">
	                   <h5 class="pull-left">
	                       <i class="fa fa-bars m-r-10"></i><span id="navibar"></span>
	                   </h5>
	                   <div class="pull-right">
	                   		<a id="addLiveTarget" style="cursor:pointer;"><span class="icon" >&#61886;</span> 설정</a>
	                   </div>	
	                 </div>
	                 <div id="pageView">
	                 	<div class="text-center m-t-10 m-b-10">
							<ul id="targetView">
						    <c:choose>
						    	<c:when test="${empty targetLists}">
						    			<li class="round m-r-5">해당 채널에 방송 타겟이 없습니다.</li>
						    	</c:when>
						    	<c:when test="${internet=='true' and stbAll=='true'}">
						    			<li class="round m-r-5">인터넷 방송</li>
						    			<li class="round m-r-5">OTT 전체</li>
						    	</c:when>
						    	<c:when test="${internet=='false' and stbAll=='true'}">
						    			<li class="round m-r-5">OTT 전체</li>
						    	</c:when>
						    	<c:otherwise>
						    	<c:forEach items="${targetLists}" var="targetList" varStatus="loop">
						    		<li class="round m-r-5">${targetList.target_name }</li>
							    </c:forEach>
							   </c:otherwise>
							 </c:choose>
							 </ul>
						</div>
	                 	<div id="calendar" class="p-relative p-5 m-b-10">
					        <!-- Calendar Views -->
					        <ul class="calendar-actions list-inline clearfix">
					            <li class="p-r-0">
					                <a data-view="month" href="#" class="tooltips" title="Month">
					                    <i class="sa-list-month"></i>
					                </a>
					            </li>
					            <li class="p-r-0">
					                <a data-view="agendaWeek" href="#" class="tooltips" title="Week">
					                    <i class="sa-list-week"></i>
					                </a>
					            </li>
					            <li class="p-r-0">
					                <a data-view="agendaDay" href="#" class="tooltips" title="Day">
					                    <i class="sa-list-day"></i>
					                </a>
					            </li>
					        </ul>
    					</div>
	                 </div>
	                 
                 </div>
			</div>
	    </div>
   	</div>
   	<!-- Hidden Value Start-->
<!-- 최초 카테고리 인덱스  --><input type="hidden" class="form-control" id="categoryIdx" > 
<!--  최초 카테고리 명  --><input type="hidden" class="form-control" id="categoryName" />
<!-- 트리  카테고리  --><input id="sort" class="form-control" type="hidden" value="live">
<!-- 트리의 자식노드 --><input id="treeIdx" class="form-control" type="hidden">
<!-- 모달 저장소 초기값 --><input id="repoOrder" type="hidden" class="form-control" value="vod"/>
<input id="requestRepo" type="hidden" class="form-control" value="schedule">
<!-- Hiddne value End -->

</section>

<script>
/**
 *Tree 관련 스크립트 시작 
 */
 var menuJs={
	//트리오픈
	 makeJsTree : function(){
		 $.ajax({
				url : "${pageContext.request.contextPath}/api/advenceTree/json/"
						+ $("#sort").val(),
				async : false,
				success : function(responseData) {
					var data=JSON.parse(responseData);
					console.log(data);
					menuJs.setTree(data.ret);
					
				},
				error : exception.ajaxException
			});
	 },
	 setTree : function(treeData){
		 var data=eval('['+treeData+']');
		 $('#jstree').jstree({
				"core" : {
					"data" :data,
					"check_callback" : function(operation, node, parent,position,more ) {
										if('move_node' === operation) {
											if(more.pos=="i"||parent.parent==null){
												return false;
											}
											return true;
										}},
					"themes" : { "dots" : true},
					"animation" : 150
				},
				"plugins" : ["dnd"]
		});
		 
	 },
	 editSelJstree:function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/checkJstreeEdit/stb-schedule"
						+"?groupArr="+$("#groupArr").val(),
				async : false,
				success : function(data) {
					var retString=data;
					$("#stbGroupCheck").empty();
					$("#stbGroupCheck").html(retString);
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
 
 $('#jstree').jstree("open_all");
/* $('#jstree').on("ready.jstree",function(e,data){
		var ref = $('#jstree').jstree(true);
		var naviString="";
		sel = ref.get_selected("full");
		if(!sel.length) { return false; }
		sel = sel[0];
		$("#treeIdx").val(sel.id);
});*/
 $('#jstree').on("select_node.jstree", function (e, data) {
		var ref = $('#jstree').jstree(true);
		var naviString="";
		sel = ref.get_selected("full");
		if(!sel.length) { return false; }
		sel = sel[0];
		
		all_children = sel.children_d;
		all_children.push(sel.id);
		all_children=all_children.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);//중복제거
		$("#treeIdx").val(all_children);
		all_parents=sel.parents;
		all_parents=all_parents.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);//중복제거
		//#삭제 
		var removeItem='#';
		all_parents=jQuery.grep(all_parents,function(value){return value!=removeItem}); 
		//역순
		all_parents=all_parents.reverse();
		//추가
		all_parents.push(sel.id);
		//중복제거
		all_parents=all_parents.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
		//한글화 
		for(var i=0;i<all_parents.length;i++){
			var sliceVal=$('#'+all_parents[i]+"_anchor").text();
			var splitVal=sliceVal.split('[');
			all_parents[i]=splitVal[0];
		}
		if(all_parents.length>1){
			all_parents.splice(0,1);
		}
		
		naviString=all_parents.join('<i class="fa fa-angle-right m-r-10 m-l-10"></i><i class="fa fa-list-alt m-r-10"></i>');
		$("#categoryIdx").val(sel.id);
		arange.getEvents($("#categoryIdx").val());
		arange.targetView($("#categoryIdx").val());
		arange.naviBar($('#sort').val(),$("#categoryIdx").val(),naviString);
});
	
$('#jstree').on("move_node.jstree", function (e, data) {
   	$.ajax({
         url:'/api/jstree/moveCategory',
         type:'post',
         data:{"idx": data.node.id, "old_parent": data.old_parent, "old_position": data.old_position, "parent": data.parent, "position": data.position,"sort":"${sort}"},
         success:function(result){
         	console.log("move success");
         },
         error:function() {
         	exception.renameException
         }
	});
});
$('#jstree').on("rename_node.jstree", function (e, data) {
	if(data.old != data.text || data.old == "새 그룹") {
			$.ajax({
        		url:'/api/jstree/renameGroup',
        		type:'post',
        		data:{"idx": data.node.id, "name": data.text,"sort":$('#sort').val()},
        		async:false,
        		success:function(result){
					data.node.original.name = data.text;
					new_name = data.text;
        		},
        		error:function() {
        			exception.renameException
        		}
			});
			data.node.text = data.node.original.name ;
			//console.log(data.node);
			$('#jstree').jstree(true).redraw(true);
			var removeItem='#';
			all_parents=data.node.parents;
			all_parents=jQuery.grep(all_parents,function(value){return value!=removeItem}); 
			//역순
			all_parents=all_parents.reverse();
			//추가
			all_parents.push(data.node.id);
			//중복제거
			all_parents=all_parents.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
			//한글화 
			for(var i=0;i<all_parents.length;i++){
				var sliceVal=$('#'+all_parents[i]+"_anchor").text();
				console.log(sliceVal);
				var splitVal=sliceVal.split('[');
				all_parents[i]=splitVal[0];
			}
			if(all_parents.length>1){
				all_parents.splice(0,1);
			}
			naviString=all_parents.join('<i class="fa fa-angle-right m-r-10 m-l-10"></i><i class="fa fa-list-alt m-r-10"></i>');
			arange.naviBar($('#sort').val(),$('#treeIdx').val(),naviString);
		}
});
/***트리 관련 이밴트 **/
$('#createMenu').click(function(){
	//그룹 생성 
	menuTree.createGroup('1');
});
$('#renameGroup').click(function(){
	//이름 변경
	menuTree.renameGroup();
});
$('#deleteGroup').click(function(){
	//그룹 삭제
	menuTree.deleteGroup();
});
var menuTree={
		createGroup : function(attrebute){
			var ref = $('#jstree').jstree(true);
			sel = ref.get_selected('full');
	        if(sel[0].original.property=="1"){
	        	exception.menuMakeException();
	        	return false;
	        }else{
	        	if(!sel.length) { return false; }
	    		sel = sel[0].id;
	    		var new_id =menuTree.getNewGroupID(sel, "새 그룹",$('#sort').val(),attrebute);
	    		var  icon="menu.png";
	    		if(attrebute=="1"){
	    			icon="list.png";
	    		}
	    		var new_node = {"id":new_id, "text":"새 채널", "num": 0,"property":attrebute,"icon":"${pageContext.request.contextPath}/ibsImg/"+icon};
	    		console.log("new id : " + new_id);
	    		ref.create_node(sel, new_node);
	    		ref.edit(new_id);	
	        }   
		},
		renameGroup : function(){
			var ref = $('#jstree').jstree(true);
			sel = ref.get_selected('full');
			if(!sel.length) { return false; }
				sel = sel[0];
				console.log(sel.original.name);
			if(sel.id == '1') {
				exception.rootException();
			return false;
			}
			ref.edit(sel, sel.original.name);
		},
		deleteGroup : function(){
			var ref = $('#jstree').jstree(true);
			sel = ref.get_selected('full');
			if(!sel.length) { return false; }
			sel = sel[0];

			if(sel.id == '1') {
				exception.rootException();
				return false;
			}
			console.log(sel);
			var msg = sel.original.name + " 그룹 및 모든 하위 그룹이 삭제되며\n삭제된 그룹 요소들은 ROOT로 옮겨집니다.\n\n정말 삭제하시겠습니까?";
			$("#confirmText").text(msg);
			$("#confirmModal").modal('show');
			exception.delConfirm(function(confirm){
				if(confirm){
					var all_children = sel.children_d,
					parent_node = ref.get_node(sel.parent),
					position = $.inArray(sel.id, parent_node.children);
					all_children.push(sel.id);
					all_children=all_children.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);//중복제거
					console.log(all_children.toString());
					$.ajax({
		            url:'/api/jstree/deleteGroup',
		            type:'post',
		            data:{"parent": sel.parent, "position": position, "groupIdArr": all_children.toString(),"sort":$('#sort').val()},
		            success:function(result){
		            	console.log(result);
		            	ref.delete_node(sel);
		            	ref.select_node("1");
		            },
		            error:exception.delGroupException
					});
				}
			});
		},
		getNewGroupID : function(parent,name,sort,property){
			var newID="";
			$.ajax({
					url:"${pageContext.request.contextPath}/api/jstree/addGroup",
					type:'post',
					data:{"parent":parent,"name":name,"sort":sort,"property":property},
					async:false,
					success:function(responseData){
						var data=JSON.parse(responseData);
						newID=data.newNodeId;
					},
					error:exception.addGroupException
				});
			 return newID;
		}
};	
 /**
  *Tree 관련 스크립트 끝 
  */
  
  
  /**
  *카렌더 관련 스크립트 시작 
  */
  var arange={
		 getEvents:function(){
			 $.ajax({
					url : "${pageContext.request.contextPath}/api/web/scheduleJson"
						+ "?childIdx="+ $('#categoryIdx').val(),
					async: false,
					success : function(responseData){
						var data=JSON.parse(responseData);
						var events=eval('['+data.eventLists+']');
						$('#calendar').fullCalendar('removeEventSource', events);
					   /*$('#calendar').fullCalendar('addEventSource', events);*/
					    $('#calendar').fullCalendar('refetchEvents');
					},
					error : exception.ajaxException
			});
		 },
		 naviBar:function(){
			$("#sort").val(arguments[0]);
			$("#treeIdx").val(arguments[1]);
			$("#navibar").html(arguments[2]);
		 },
		 targetView:function(idx){
			 $.ajax({
					url : "${pageContext.request.contextPath}/api/targetView",
					cache : false,
					type : 'post',
					data : {"idxArr":idx},
					async : false,
					success : function(responseData){
						var data=JSON.parse(responseData);
						var retHtml='';
						if(data.list.length==0){
							retHtml+='<li class="round m-r-5">해당 채널에 방송 타겟이 없습니다.</li>';
						}else if(data.internet=="1"&&data.stbAll=="1"){
							retHtml+='<li class="round m-r-5">인터넷 방송</li>';
							retHtml+='<li class="round m-r-5">OTT 전체</li>';
						}else if(data.internet=="0"&&data.stbAll=="1"){
							retHtml+='<li class="round m-r-5">OTT 전체</li>';
						}else{
							for(var i=0;i<data.list.length;i++){
								retHtml+='<li class="round m-r-5">'+data.list[i].target_name+'</li>';
							}
						}
						$('#categoryName').val(data.mainCategory);
						$('#targetView').empty();
						$('#targetView').html(retHtml);
					},
					error : exception.ajaxException
				});
		 },
		 targetEditBtn:function(idx){
				$.ajax({
					url : "${pageContext.request.contextPath}/cms/liveTarget/"+idx,
					success : function(responseData){
						var data=JSON.parse(responseData);
						$('#channelName').text(data.categoryName);
						var retHtml='';
						var idxList=[];
						for(var i=0;i<data.ret.targetList.length;i++){
							retHtml+='<button class="btn btn-sm targetBtn" id="target_'+data.ret.targetList[i].group_idx+'">'+data.ret.targetList[i].target_name+' <span class="del" style="margin-left: 5px; font-size: 18px;line-height: 0;top: 4px;position: relative;font-weight: 500;" onClick="checkJs.targetCheck('+data.ret.targetList[i].group_idx+')">×</span></button>';
							idxList.push(data.ret.targetList[i].group_idx);
						}
						$('#groupArr').val(idxList.join(','));
						menuJs.editSelJstree();
						$('#modelTargetList').html(retHtml);
					},
					error : exception.ajaxException
				});
		},
		targetPreview : function(idxArr){
			if(idxArr.length==0){
				$('#modelTargetList').html('방송 타겟이 없습니다.');
			}else{
				$.ajax({
					url : "${pageContext.request.contextPath}/api/categoryNames/stb-schedule"
						+ "?idxArr="+idxArr,
					cache : false,
					type : 'post',
					data : {"idxArr":idxArr},
					async : false,
					success : function(responseData){
						var data=JSON.parse(responseData);
						var retHtml='';
						for(var i=0;i<data.categoryList.length;i++){
							retHtml+='<button class="btn btn-sm targetBtn" id="target_'+data.categoryList[i].idx+'">'+data.categoryList[i].category_name+' <span class="del" style="margin-left: 5px; font-size: 18px;line-height: 0;top: 4px;position: relative;font-weight: 500;" onClick="checkJs.targetCheck('+data.categoryList[i].idx+')">×</span></button>';
						}
						$('#modelTargetList').empty();
						$('#modelTargetList').html(retHtml);
					},
					error : exception.ajaxException
				});
			}
		},
		vodImgFactory : function(imgArr){
			if(imgArr.length!=0){
				$.ajax({
					url : "${pageContext.request.contextPath}/api/imageNames",
					cache : false,
					type : 'post',
					data : {"imgArr":imgArr},
					async : false,
					success : function(responseData){
						var data=JSON.parse(responseData);
						var retHtml='';
						for(var i=0;i<data.imgList.length;i++){
			                retHtml+='<li style="float:left; background: url(${pageContext.request.contextPath}'+data.imgList[i].img_url
									+') no-repeat center; background-size: cover;" id="vodImgLi_'+data.imgList[i].img_idx+'">'
		                  			+'<a class="close" onClick="arange.removeVodLi('+data.imgList[i].img_idx+')"><img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"/></a>'
		                  			+'</li>'
						}
						$('#slideShow').append(retHtml);
						
					},
					error : exception.ajaxException
				});
			}
		},
		removeVodLi:function(imgId){
			$('#vodImgLi_'+imgId).remove();
			//배열삭제 
			var retArr=common.removeElementToArray($('#vodArr').val().split(','),imgId);
			$('#vodArr').val(retArr);
		},
		liveSlideDefault:function(){
			$('#liveDefaultImg').attr('src','${pageContext.request.contextPath}/img/live.jpg');
			$('#slideShow').empty();
			$('#slideShow').html('<li>'
          			+'<a class="add" onclick="common.selectRepoSource(\'schedule\');"><img src="${pageContext.request.contextPath}/ibsImg/img_add.png" alt="추가"   style="cursor:pointer;"/></a>'
              		+'</li>');
		},
		selectSource:function(){
			$("#shceduleSource").css('display','block');
		},
		videoJsPlay:function(attr,urlArr){
			var html="";
			arange.delJsPlayer();
			if(attr=='LIVE'){
				html += '<video id="livePlayer" class="video-js"  controls preload="auto"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
				html += '<source  src="'+urlArr[0]+'"  type="application/x-mpegURL"></source>';
				html += '</video>';
				$("#liveJsPlayer").html(html);
				$('#defaultPlayer').css('display','none');
				$('#liveJsPlayer').css('display','block');
				var options = {};
				var player = videojs('livePlayer', options,
					function onPlayerReady() {
						this.play();
						this.on('ended', function() {
							videojs.log('vod end');
						});
					});
			}else if(attr=='VOD'){
				html+='<video id="livePlayer" class="video-js" controls preload="auto"  data-setup="{}"  data-setup="{}" style="width: 100% !important; height: 100% !important;"></video>'; 
				$("#liveJsPlayer").html(html);
				$('#defaultPlayer').css('display','none');
				$('#liveJsPlayer').css('display','block');
				var player = videojs('livePlayer');
				//배열 텍스트 만들기 
				var jArray="";
				var comma=",";
				for(var i=0;i<urlArr.length;i++){
					if(i==urlArr.length-1){
						comma="";
					}
					jArray+="{"
					+"src : ["+"'"+urlArr[i]+"'],"
					+"poster : '${pageContext.request.contextPath}/img/live.jpg',"
					+"title : 'video"+i+"'"
					+"}"+comma;
					
				}
				var videos = eval('['+jArray+']');
			    videojs.registerPlugin('playlist',playList);
			    player.playlist(videos, {
			        getVideoSource: function(vid, cb) {
			            cb(vid.src, vid.poster);
			          }
			     });
			     player.play();
			}
		},
		delJsPlayer:function(){     
			if (videojs.getPlayers()['livePlayer']) {
				var oldPlayer = document.getElementById('livePlayer');
				videojs(oldPlayer).dispose();
			}
		}
 };
  /**
   *카렌더 관련 스크립트 시작 
   */
 /**페이지 기본 셋팅 */
$('#cmsPageTitle').html('라이브 관리');
$('.menuLi').removeClass('active');
$('#liveMenuLi').addClass('active');
 $('#categoryIdx').val('${hn:getDefaultLiveIdx()}');
 $('#categoryName').val('${hn:getDefaultLiveName()}');
 $("#getStart").datetimepicker({format:'Y-m-d H:i',step:10,theme:'dark'});
 $("#getEnd").datetimepicker({format:'Y-m-d H:i',step:10,theme:'dark'});
 menuJs.makeJsTree();
 arange.naviBar($('#sort').val(), $("#categoryIdx").val(), $("#categoryName").val());
 $('body').on('click', '#addEvent', function(ev){
 	/*if($('#source_type').val()=='VOD'){
 		var optionCount=$('#vodSource > option').length;
 		if(optionCount==0){
     		jQuery('#vodSource').validationEngine('showPrompt', 'VOD 영상소스를 선택하세요.', 'pass');
     		return;
     	}else{
     		jQuery('#vodSource').validationEngine('hideAll');
     	}
     	var vodArray=[];
     	for(var i=0;i<optionCount;i++){
     		vodArray.push($('#vodSource > option:eq('+i+')').val());
     	}
     	$("#vodArr").val('');
     	$("#vodArr").val(vodArray);
 	}*/
 	
 	if($("#captionYn").val()=="Y"){
 		if($('#caption').val().length==0||$('#caption_text_color').val().length==0){
 			jQuery('#caption').validationEngine('showPrompt', '자막 내용과 자막 색상을 입력해주세요.', 'pass');
 			return;
 		}else{
 			jQuery('#caption').validationEngine('hideAll');
 		}
 	}
 	if($('#source_type').val()=='LIVE'){
 		if($('#live_stream_url').val().length==0){
 			jQuery('#live_stream_url').validationEngine('showPrompt', '라이브 채널을 선택 해 주세요.', 'pass');
 			return;
 		}else{
 			jQuery('#live_stream_url').validationEngine('hideAll');
 		}
 	}
 	
      var eventForm =  $(this).closest('.modal').find('.form-validation');
      eventForm.validationEngine('validate');
      if (!(eventForm).find('.formErrorContent')[0]) {
     	
     	 var dataObject={};
     	
     	 if($("#captionYn").val()=="Y"){
     		dataObject['caption']=$('#caption').val();
    		 	dataObject['caption_size']=$("#caption_size").val();
    		 	dataObject['caption_speed']=$("#caption_speed").val();
    		 	dataObject['caption_text_color']=$("#caption_text_color").val();
    		 	dataObject['caption_bg_color']=$("#caption_bg_color").val();
     	 }else{
     		 dataObject['caption']='';
     		 dataObject['caption_size']='';
     		 dataObject['caption_speed']='';
     		 dataObject['caption_text_color']='';
     		 dataObject['caption_bg_color']='';
     	 }
     	
     	if($('#source_type').val()=='LIVE'){
     		dataObject['live_ch_idx']=$('#live_ch_idx').val();
         	dataObject['live_stream_url']=$("#live_stream_url").val();
     		
     	 }
     	
     	if($('#source_type').val()=='VOD'){
     		dataObject['vodArr']=$('#vodArr').val();
     	}
     	 dataObject['name']=$('#eventName').val();
     	 dataObject['start']=$("#getStart").val();
     	 dataObject['end']=$("#getEnd").val();
     	 dataObject['target_type']='GROUP';
     	 dataObject['source_type']=$("#source_type").val();
     	 dataObject['image_path']=$("#image_path").val();
     	 dataObject['color']=$("#color").val();
     	 dataObject['desc_text']=$("#desc_text").val();
     	 dataObject['groupArr']=$("#groupArr").val();
     	 dataObject['captionYn']=$('#captionYn').val();
     	 dataObject['category_idx']=$('#categoryIdx').val();
     	 if($('#forceLive').is(":checked")){
     		dataObject['forceLive']=1;
     	 }else{
     		dataObject['forceLive']=0;
     	 }
     	 dataObject['order']=$('#order').val();
     	 if($('#order').val()=="update"){
     		 dataObject['idx']=$('#idx').val();
     	 }
				$.ajax({
         	 		url:'/cms/excute/stb-schedule/'+$("#order").val(),
         	 		type:'post',
         	 		data:dataObject,
         	 		async:false,
         	 		success : function(result){
                         $('#addNew-event').modal('hide');
                         common.settopCmd();
						var insertedEvent={
        	 					title: $('#eventName').val(),
                              	url:'javascript:calClick.viewEvent('+result+');',
                                start: $('#getStart').val(),
                                end:  $('#getEnd').val(),
                                allDay: false	
            	 			};
							if($('#order').val()=="insert"){
								$('#calendar').fullCalendar('renderEvent',insertedEvent);
								arange.getEvents();
							}else if($('#order').val()=="update"){
								arange.getEvents();
							}
            	 			
						},
         	 		error:exception.ajaxException
         	 	});
     	 }
     
 }); 
$('#calendar').fullCalendar({
     header: {
          center: 'title',
          left: 'prev, next',
          right: ''
     },

     selectable: true,
     selectHelper: true,
     editable: true,
     events:function(start, end,callback){
    	 $.ajax({
				url : "${pageContext.request.contextPath}/api/web/scheduleJson"
					+ "?childIdx="+ $('#categoryIdx').val(),
				async: false,
				success : function(responseData){
					var data=JSON.parse(responseData);
					var events=eval('['+data.eventLists+']');
					callback(events);
				},
				error : exception.ajaxException
		});
     },
      
     //On Day Select
     select: function(start, end, allDay) {
    	$('#scheduleEdit').css('display','block');
    	$('#scheduleView').css('display','none');
    	$('#vodArr').val('');
     	$('#addNew-event').modal('show'); 
     	$('#addNew-event form')[0].reset();
     	//슬라이드 초기화 
     	arange.liveSlideDefault();
     	 $('#order').val('insert');
     	 var selStart = new Date(start);
         var selEnd=new Date(end);
         var hs = common.formatZeroDate(selStart.getHours(),2);
         var ms = common.formatZeroDate(selStart.getMinutes(),2);
         var he = common.formatZeroDate(selEnd.getHours(),2);
         var me = common.formatZeroDate(selEnd.getMinutes(),2);
         
         $('#getStart').val($.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,start));
         $('#getEnd').val($.datepicker.formatDate('yy-mm-dd '+he+':'+me,end)); 
     },
      
     eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
        if(dayDelta!=0||minuteDelta!=0){
    		var updateStart=event.start;
			var hs = common.formatZeroDate(updateStart.getHours(),2);
            var ms = common.formatZeroDate(updateStart.getMinutes(),2);
            updateStart=$.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,updateStart);
			var updateEnd=event.end;
			var he = common.formatZeroDate(updateEnd.getHours(),2);
            var me = common.formatZeroDate(updateEnd.getMinutes(),2);
            updateEnd=$.datepicker.formatDate('yy-mm-dd '+he+':'+me,updateEnd);
    		}
        var result=calClick.updateScheduleDate(event.idx,updateStart,updateEnd);
        if(result!="success"){
     	   revertFunc();
        }
 		$('#editEvent #editCancel').click(function(){
              revertFunc();
         }) 
     },
     eventDrop:function(event,dayDelta,minuteDelta,revertFunc){
     	//날짜계산
     	if(dayDelta!=0||minuteDelta!=0){
     		var updateStart=event.start;
			var hs = common.formatZeroDate(updateStart.getHours(),2);
            var ms = common.formatZeroDate(updateStart.getMinutes(),2);
            updateStart=$.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,updateStart);
			var updateEnd=event.end;
			var he = common.formatZeroDate(updateEnd.getHours(),2);
            var me = common.formatZeroDate(updateEnd.getMinutes(),2);
            updateEnd=$.datepicker.formatDate('yy-mm-dd '+he+':'+me,updateEnd);
     	}
     	var result=calClick.updateScheduleDate(event.idx,updateStart,updateEnd);
     	if(result!="success"){
      	   revertFunc();
         }
     }
 });

//Calendar views
$('body').on('click', '.calendar-actions > li > a', function(e){
 e.preventDefault();
 var dataView = $(this).attr('data-view');
 $('#calendar').fullCalendar('changeView', dataView);
 //Custom scrollbar
 var overflowRegular, overflowInvisible = false;
 overflowRegular = $('.overflow').niceScroll();     
});                    
 /***/
 $('#addLiveTarget').click(function(){
		arange.targetView($('#treeIdx').val());
		$('#liveTargetAdd').modal();
});
var calClick={
		viewEvent:function(idx){
			arange.delJsPlayer();
			$('#defaultPlayer').css('display','block');
			$('#liveJsPlayer').css('display','none');
			$('#addNew-event').modal('show'); 
 	     	$('#addNew-event form')[0].reset();
 	     	//슬라이드 초기화 
 	     	arange.liveSlideDefault();
 	     	$("#order").val('update');
    		$.ajax({
    	 		url:'/api/web/stb-schedule/'+$("#order").val()+"/"+idx,
    	 		success : function(responseData){
    	 			var data=JSON.parse(responseData);
					console.log(data);
    	 			var nowDate=new Date();
    	 			//idx 값셋팅 
    	 			$("#idx").val(data.idx);
    	 			//제목셋팅
    	 			$('#eventName').val(data.name);
    	 			$('#scheduleTitle').html(data.name);
                    //시작날짜 
    	 			var setStart=common.setDate(data.start);
    	 			$("#getStart").val(setStart);
    	 			//종료 날짜 
    	 			var setEnd=common.setDate(data.end);
    	 			$("#getEnd").val(setEnd);
    	 			//view 날짜 셋팅 
    	 			$('#scheduleTime').html(common.setScheduleDate(data.start,data.end));
    	 			//소스 타입
    	 			$("#source_type").val(data.source_type);
    	 			
    	 			if(data.source_type=="LIVE"){
    	 				$('#live_stream_url').val(data.live_stream_url);
    	 				$('#live_ch_idx').val(data.live_ch_idx);
    	 				var retHtml='<li style="float:left; background: url(${pageContext.request.contextPath}/img/live.jpg) no-repeat center; background-size: cover;padding-top:70px;"></li>';
    	 				$("#slideShow").html(retHtml);
    	 				$('#slideShow').append('<li onclick="common.selectRepoSource(\'schedule\');"><a class="add"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
    	 				$("#shceduleSource").css('display','block');
					}
    	 			if(data.source_type=="VOD"){
    	 				var imgArr=data.vodArr;
    	 				$('#vodArr').val(imgArr);
    	 				console.log(imgArr);
    	 				$("#scheduleVodList").css('display','none');
    	 				//var imgToArray=imgArr.split(',');
    	 				$('#slideShow').empty();
    	 				$.each(imgArr,function(index,value){
    	 					arange.vodImgFactory(value);
    	 				});
    	 				$('#slideShow').append('<li onclick="common.selectRepoSource(\'schedule\');"><a class="add"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
    	 			}
    	 			if(data.forceLive){
    	 				$('#forceLive').prop("checked",true);
    	 			}
    	 			$("#liveDefaultImg").attr('src','${pageContext.request.contextPath}/REPOSITORY/SCHIMG/'+data.image_path);
    	 			$('#liveViewImg').attr('src','${pageContext.request.contextPath}/REPOSITORY/SCHIMG/'+data.image_path);
    	 			$("#image_path").val(data.image_path);
    	 			$("#desc_text").val(data.desc_text);
    	 			$('#liveDesc').html(data.desc_text);
    	 			$('#scheduleEdit').css('display','none');
    	 	    	$('#scheduleView').css('display','block');
				},
    	 		error:exception.ajaxException
    	 	});
		},
		updateScheduleDate:function(idx,start,end){
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
     				common.settopCmd();
     			},
     			error : exception.ajaxException 
     		});	
     		return result;
		},
		deleteEvent:function(){
			$("#confirmText").text("선택 파일을 삭제하시겠습니까?.");
			 $("#confirmModal").modal();
			 exception.scheduleDelConfirm(function(confirm){
   				if(confirm){
   					$.ajax({
   						url : '/cms/delete/stb-schedule?checkValArr='+$("#idx").val()+"&childIdx=",
   						success : function(responseData){
   							var data=JSON.parse(responseData);
   							if(data.result=="success"){
   								arange.getEvents();
   								common.settopCmd();
   							}
   						},
   						error : exception.ajaxException
   					});
   				}
				});
		}
};

$('#addLiveTarget').click(function(){
	arange.targetEditBtn($('#categoryIdx').val());
	$('#channelName').val($('#categoryName').val());
	$('#liveTargetAdd').modal();
});
$('#targetInsert').click(function(){
	$.ajax({
		url : "${pageContext.request.contextPath}/cms/target/insert",
		cache : false,
		type : 'post',
		data : {"groupArr":$('#groupArr').val(),"categoryIdx":$('#categoryIdx').val()},
		async : false,
		success : function(data){
			arange.targetView($('#categoryIdx').val());
			common.settopCmd();
			$('#liveTargetAdd').modal('hide');
		},
		error : exception.ajaxException
	});
});
$('#liveViewImg,#playArrow').click(function(){
	var attr=$('#source_type').val();
	var urlArr=[];
	if(attr=='LIVE'){
		urlArr.push($('#live_stream_url').val());
		arange.videoJsPlay(attr,urlArr);
	}else if(attr=='VOD'){
		$.ajax({
				url:"${pageContext.request.contextPath}/api/smList/vodIdxArr?idxArr="+$('#vodArr').val(),
				success:function(responseData){
					var data=JSON.parse(responseData);
					console.log(data.lists.length);
					for(var i=0;i<data.lists.length;i++){
						urlArr.push(data.lists[i].vod_path);
					}
					arange.videoJsPlay(attr,urlArr);
				},
				error:exception.ajaxException
			});
	}
	
});
$('#scheduleEditCancel').click(function(){
	arange.delJsPlayer();
	$('#scheduleEdit').css('display','block');
 	$('#scheduleView').css('display','none');
});
$('#scheduleDel').click(function(){
	calClick.deleteEvent();
});

</script>
