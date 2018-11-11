<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>

<c:choose>
	<c:when test="${empty lists }">
		<div style="height: 100px;"><h2>데이터가 없습니다.</h2></div>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="loop">
		
		<div class="img_box" id="layer_${list.idx}" style="position: relative; background: url('http://${sednIp}:${tomcatPort}${pageContext.request.contextPath}${list.main_thumbnail}') no-repeat center;
				 background-size: cover; display: inline-block;">
		<%-- <label for="check_${list.idx}" style="display: unset; cursor: pointer;"> --%>
			<div class="imgPopup" id="${list.idx}" data-title="${list.vod_path}" style="height: 100%;"></div>
		<!-- </label> -->
			<div>
				<input class="pull-left m-l-5 vodCheck" type="checkbox" value="${list.idx}"/>
				<%-- <input class="pull-left m-l-5 vodRadio" type="radio" name="redioVal" value="${list.idx}" title="${list.vod_path}" /> --%>	
			</div>
			<div class="vod_text_box">
				<h6>${list.vod_title}</h6>
			</div>
			
		</div>
		
		</c:forEach>
	</c:otherwise>
</c:choose>
<input type="hidden" class="form-control" id="allcheck" />
<input type="hidden" class="form-control" id="selectedIdxs" />
<input type="hidden" class="form-control" id="changeCateIdx" />
<input type="hidden" class="form-control" id="changeCateProperty" />
<script>
if($('#requestRepo').val()=='media'){	//CONTENT
	$('.vodCheck').css('display','none');
	//$('.vodRadio').css('display','none');
	
	$('.imgPopup').click(function(){
		console.log('imgPopup');
		$('#vodMediaView').css('display','block');
		$('#vodMediaEdit').css('display','none');
		common.delCashPlayer('vodPlayer');
		$('#vodOrder').val('update');
		common.vodDefault();
		$('#vodViewModal').modal();
		$.ajax({
			url : "${pageContext.request.contextPath}/api/media/"+ $("#sort").val() + "/"+$(this).attr('id'),
			cache : false,
			async : false,
			success : function(responseData){
				common.vodDefault();
				var data=JSON.parse(responseData);
				$('#vodViewTitle').html(data.info.vod_title);
				$('#vodViewDate').html(data.info.reg_dt);
				$('#vodViewDownload').attr('href','http://${sednIp}:${tomcatPort}${pageContext.request.contextPath}/sedn/download/vod/'+data.info.vodFile.split('.')[1]+'/'+data.info.vodFile.split('.')[0]);
				//$('#vodViewDownload').val(data.info.);
				$('#vodViewCount').html(data.info.view_count);
				$('#vodViewText').html(data.info.vod_content);
				$('#vodViewResolution').html(data.info.resolution);
				$('#vodViewRuntime').html(data.info.vod_play_time);
				$('#vodViewFilesize').html(common.number_to_human_size(data.info.file_size));
				$('#vodViewMainThumb').attr('src','http://${sednIp}:${tomcatPort}${pageContext.request.contextPath}'+data.info.thumnail_path);
				
				$('#vodDefaultImg').attr('src','http://${sednIp}${pageContext.request.contextPath}'+data.info.thumnail_path);
				$("#vod_title").val(data.info.vod_title);
				$("#vod_content").val(data.info.vod_content);
				$("#vod_path").val(data.info.vodFile);
				$("#keyword").val(data.info.vod_keyword);
				$("#vod_play_time").val(data.info.vod_play_time);
				$("#main_thumbnail").val(data.info.main_thumbnail);
				$("#file_size").val(data.info.file_size);
				$("#vodIdx").val(data.info.idx);
				$("#thumnailList").val(data.thumb);
				$("#categoryIdx").val(data.info.category_idx);
				$.each(data.thumbPath,function(index,value){
					var retHtml='<li class="thum" style="float:left;background: url(http://${sednIp}:${tomcatPort}'+value
					+') no-repeat center; background-size: cover;" id="thumbLi_'+data.thumb[index].split('.')[0]+'" onClick="arange.makeMainThumb(\''+data.thumb[index].split('.')[0]+'\',\''+data.thumb[index].split('.')[1]+'\')">'
          			+'<a class="close" onClick="arange.removeThumbLi(\''+data.thumb[index].split('.')[0]+'\',\''+data.thumb[index].split('.')[1]+'\');"><img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"/></a>'
          			+'</li>';
          			$("#vodSlideShow").append(retHtml);
          			if($('#main_thumbnail').val()==data.thumb[index]){
          				$('#thumbLi_'+data.thumb[index].split('.')[0]).addClass('boxLine');
          			}
				});
				
				$('#vodSlideShow').append('<li id="addLi"><a class="add" onclick="arange.selectSource();"><img src="/ibsImg/img_add.png" alt="추가" style="cursor:pointer;"></a></li>');
				slide.init();
				$("#play_url").val(data.info.vod_path);
				$("#play_thum").val('http://${sednIp}:${tomcatPort}${pageContext.request.contextPath}'+data.info.thumnail_path);
				
				$('#vodViewArea').empty();
				$('#vodPreview').empty();
				$('#vodViewArea').html('<img src="'+$('#play_thum').val()+'" alt="샘플" id="vodViewMainThumb">');
				$('#vodPreview').html('<img src="'+$('#play_thum').val()+'" alt="샘플" id="vodDefaultImg">');
				$('#letsPlay').css('display','block');
				$('#letsEditPlay').css('display','block');

				$('#vodDefaultImg').attr('src', $('#play_thum').val());
			},
			error : exception.ajaxException
		});
	});
	
	$('#letsPlay').click(function(){
		//common.vodDefault();
		console.log('letsPlay');
		$('#vodViewArea').empty();
		$('#vodPreview').empty();
		$('#vodViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="vodViewMainThumb">');
		$('#vodPreview').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="vodDefaultImg">');
		$('#letsPlay').css('display','block');
		$('#letsEditPlay').css('display','block');
		$('#letsPlay').css('display','none');
		$('#vodDefaultImg').attr('src', $('#play_thum').val());
		modalLayer.vodPlayer($('#play_url').val(), $('#play_thum').val(),"vodViewArea");
	});
	$('#letsEditPlay').click(function(){
		//common.vodDefault();
		common.delCashPlayer('vodPlayer');
		$('#vodViewArea').empty();
		$('#vodPreview').empty();
		$('#vodViewArea').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="vodViewMainThumb">');
		$('#vodPreview').html('<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" id="vodDefaultImg">');
		$('#letsPlay').css('display','block');
		$('#letsEditPlay').css('display','block');
		$('#letsEditPlay').css('display','none');
		$('#vodViewMainThumb').attr('src', $('#play_thum').val());
		modalLayer.vodPlayer($('#play_url').val(), $('#play_thum').val(),"vodPreview");
	});
	
	var arr=[];
	$(".vodCheck").click(function(e){
		console.log('media');
		//e.stopPropagation();
		if($(this).is(":checked")==true){
			arr.push($(this).val());
		}else{
			arr.splice($.inArray($(this).val(),arr),1);
		}
		$("#selectedIdxs").val(arr);
	});
	
}else if($('#requestRepo').val()=='vod'){	//PAGE 영상추가
	$('.vodCheck').css('display','none');
	//$('.vodRadio').css('display','block');
	
	$('.imgPopup').click(function(){
		$(this).parent().siblings().css("border", "none");
		$(this).parent().css("border", "2px solid red");
		console.log($(this).data("title"));
		$('#tempVodList').val($(this).attr('id'));
		common.delCashPlayer('vodPlayer');
		$('#boardPreview').empty();
		modalLayer.vodPlayer($(this).data("title"),"${pageContext.request.contextPath}/img/live.jpg","boardPreview");
	});
}else{
	$('.vodCheck').css('display','block');
	//$('.vodRadio').css('display','none');
	var arr=[];
	$('.vodCheck').click(function(){	//LIVE > vod
		console.log('기타');
		if ($(this).is(":checked") == true) {
			arr.push($(this).val());
		} else {
			arr.splice($.inArray($(this).val(), arr), 1);
		}
		$('#tempVodList').val(arr);
	});
}
</script>
<input type="hidden" id="tempVodList" />
                                  