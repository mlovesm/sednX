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
			<div class="img_box" id="layer_${list.idx}"  style="position: relative; background: url('${pageContext.request.contextPath}/img/live.jpg') no-repeat center; background-size: cover;">
				<%-- <input class="pull-left m-l-5 streamCheck" type="radio"  name="redioVal" value="${list.idx}" title="${list.live_path}" /> --%>
				<label for="check_${list.idx}" style="display: unset; cursor: pointer;">
					<input class="pull-left m-l-5 streamCheck" type="checkBox" id="check_${list.idx}" name="redioVal" value="${list.idx}" title="${list.live_path}" style="display:none;"/>
				</label>
				<p class="text-center" style="font-size:12px;" id="streamText" title="${list.live_title}">${list.live_title}<br/>
				<div class="imgPopup" id="${list.idx}" data-title="${list.live_path}" style="height: 100%;"></div>
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
	//$('.streamCheck').css('display','none');
	$('.imgPopup').click(function(){
		common.delCashPlayer('vodPlayer');
		common.fileDefault();
		$('#streamMediaView').css('display','block');
		$('#streamMediaEdit').css('display','none');
		$('#streamOrder').val('update');
		$('#streamViewModal').modal();
		$.ajax({
			url : "${pageContext.request.contextPath}/api/media/"+ $("#sort").val() + "/"+$(this).attr('id'),
			cache : false,
			async : false,
			success : function(responseData){
				var data=JSON.parse(responseData);
				$('#streamViewTitle').html(data.info.live_title);
				$('#streamViewAddress').html(data.info.live_path);
				$('#streamViewCount').html(data.info.view_count);
				$('#streamViewDate').html(data.info.reg_dt);
				modalLayer.vodPlayer(data.info.live_path,"${pageContext.request.contextPath}/img/live.jpg","streamViewArea");
				$('#streamTitle').val(data.info.live_title);
				$('#streamAddress').val(data.info.live_path);
				$("#streamIdx").val(data.info.idx);
			},
			error : exception.ajaxException
		});
	});
	$(".streamCheck").click(function(){
		if($(this).is(":checked")==true){
			arr.push($(this).val());
		}else{
			arr.splice($.inArray($(this).val(),arr),1);
		}
		$("#selectedIdxs").val(arr);
	});
}else{
	$('.imgPopup').click(function(){
		$(this).parent().siblings().css("border", "none");
		$(this).parent().css("border", "2px solid red");
		
		$('#live_ch_idx').val($(this).attr('id'));
		$('#live_stream_url').val($(this).data('title'));
		$('#tmpStreamName').val($('#streamText').attr('title'));
		$('#source_type').val('LIVE');
	});
}
</script>

                                  