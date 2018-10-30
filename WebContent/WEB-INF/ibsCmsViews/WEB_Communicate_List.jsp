<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<div class="tile">
    <h2 class="tile-title">전체선택 &nbsp;&nbsp;<input type="checkbox" id="allCheck"></h2>
    <div class="listview narrow">
    <c:choose>
		<c:when test="${empty lists }">
			<div style="height: 100px;">데이타가 없습니다.</div>
		</c:when>
		<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="loop">
        <div class="media" id="list_${list.idx}">
            <div class="pull-right">
            	<c:set var="vod" value="${list.vod_repo}" />
            	<c:if test="${vod ne ''}">
    			<img src="${pageContext.request.contextPath}/img/vodRepo.png" alt="">
				</c:if>
				<c:set var="photo" value="${list.photo_repo}" />
            	<c:if test="${photo ne ''}">
    			<img src="${pageContext.request.contextPath}/img/photoRepo.png" alt="">
				</c:if>
				<c:set var="file" value="${list.file_repo}" />
            	<c:if test="${file ne ''}">
    			<img src="${pageContext.request.contextPath}/img/fileRepo.png" alt="">
				</c:if>
				<c:set var="live" value="${list.live_repo}" />
            	<c:if test="${live ne ''}">
    			<img src="${pageContext.request.contextPath}/img/liveRepo.png" alt="">
				</c:if>
            </div>
            <div class="media-body">
            	<label class="checkbox-inline"><input type="checkbox" class="checkElem" id="${list.idx}" value="${list.idx}"></label>
                <span class="editElement" id="lineIdx_${list.idx}"><a style="cursor:pointer;">${list.board_title}</a></span>
                <div class="clearfix"></div>
                <small class="muted">${list.category_idx}</small> | <small class="muted">${list.edit_dt}</small>
            </div>
        </div>
       	</c:forEach>
		</c:otherwise>
	</c:choose>
        <div class="media p-5 text-center l-100">
        ${pagingStr}
        </div>
    </div>
</div>
<script>
$(function(){
	var arr = [];
	$("#allCheck").click(function() {
		if ($(this).prop("checked")) {
			var chkbox = $(".checkElem");
			$(".checkElem").prop("checked", true);
			arr = [];
			for (i = 0; i < chkbox.length; i++) {
				arr.push(chkbox[i].value);
			}
			$("#selectedIdx").val(arr);
		} else {
			$(".checkElem").prop("checked", false);
			arr = [];
			$("#selectedIdx").val('');
		}
	});
	$(".checkElem").click(function() {
		if ($(this).is(":checked") == true) {
			arr.push($(this).attr("id"));
		} else {
			arr.splice($.inArray($(this).attr("id"), arr), 1);
		}
		$("#selectedIdx").val(arr);
	});
	$("#pagingDiv li a").click(function() {
		var rel = $(this).attr('rel');
		$.ajax({
			url : rel,
			success : function(data) {
				$("#selectedIdx").val('');
				$("#listView").empty();
				$("#listView").html(data);
			},
			error : exception.ajaxException
		});
	});
	$(".editElement").click(function() {
		var idArr =$(this).attr('id').split('_');
		var idx = idArr[1];
		contents.contentForm($("#sort").val(), "update", idx);
	});
	$("#selectDeleteBtn").click(function(ev) {
		var checkValArr = $("#selectedIdx").val();
		if (checkValArr.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택 파일을 삭제하시겠습니까?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					contents.deleteByIdxArr();
				}
			});
		}
	});
});
</script>
