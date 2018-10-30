<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<style>
.table-bordered > tbody > tr > td, .table-bordered > thead > tr > th {border-bottom:1px solid #ddd;}
</style>
<table class="table table-bordered  borderB  table-hover" >
 <thead>
     <tr>
        <th><input type="checkbox" id="allCheck"></th>
        <th>그룹명</th>
        <th>장비명</th>
        <th>아이피주소</th>
        <th>MAC</th>
        <th>활동상태</th>
        <th>장비제어</th>
        <th>편집</th>
     </tr>
 </thead>
 <tbody>
  <c:choose>
		<c:when test="${empty lists }">
			<tr><td colspan="8">데이타가 없습니다.</td></tr>
		</c:when>
		<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="loop">
	    <tr id="list_${list.idx}">
	        <td><input type="checkbox" class="checkElem" id="${list.idx}" value="${list.idx}" title="${list.mac}" name="${list.mac}"></td>
	        <td>${list.category_idx}</td>
	        <td>${list.name}</td>
	        <td>${list.ip_addr}</td>
	        <td>${list.mac}</td>
	        <td>
	        <c:if test="${list.status eq 1}">
    			<span class="label label-danger">OFF</span>
			</c:if>
			 <c:if test="${list.status eq 2}">
    			<span class="label label-success">ON</span>
			</c:if>
			<c:if test="${list.status eq 3}">
    			<span class="label label-info">VOD</span>
			</c:if>
			<c:if test="${list.status eq 4}">
    			<span class="label label-primary">LIVE 방송중</span>
			</c:if>
	        <td>
	        	<div class="btn-group" style="margin:0px;">
	    			<button type="button" class="btn btn-sm btn-alt icon STB_reboot"><span>&#61725;</span> <span class="text">REBOOT</span></button>
	    			<button type="button" class="btn btn-sm btn-alt icon STB_apk_update" ><span>&#61910;</span> <span class="text">OTT APP UPDATE</span></button>
					<button type="button" class="btn btn-sm btn-alt icon STB_schedule_download"><span>&#61751;</span> <span class="text">SCHEDULE SETTING DOWNLOAD</span></button>
	    			<button type="button" class="btn btn-sm btn-alt icon STB_tv_on"><span>&#61931;</span> <span class="text">TV ON</span></button>
	    			<button type="button" class="btn btn-sm btn-alt icon STB_tv_off"><span>&#61834;</span> <span class="text">TV OFF</span></button>
				</div>
	      </td>
	      <td>
	      	<div class="btn-group" style="margin:0px;">
	         	<button type="button" class="btn btn-sm icon editElement"><span>&#61952;</span> <span class="text">수정</span></button>
	         	<button type="button" class="btn btn-sm icon deleteElement"><span>&#61754;</span> <span class="text">삭제</span></button>
	     	</div>
	      </td>
      </tr>
    </c:forEach>
	</c:otherwise>
</c:choose>
    </tbody>
  </table>
 
<div class="media p-5 text-center l-100">
  ${pagingStr}
</div>
<script>
$(function(){
	var arr = [];
	var macArr = [];
	$("#allCheck").click(function() {
		if ($(this).prop("checked")) {
			var chkbox = $(".checkElem");
			$(".checkElem").prop("checked", true);
			arr = [];
			for (i = 0; i < chkbox.length; i++) {
				arr.push(chkbox[i].value);
				macArr.push(chkbox[i].name);
			}
			$("#selectedIdx").val(arr);
			$("#selectedMac").val(macArr);
		} else {
			$(".checkElem").prop("checked", false);
			arr = [];
			macArr=[];
			$("#selectedIdx").val('');
			$("#selectedMac").val('');
		}
	});
	$(".checkElem").click(function() {
		if ($(this).is(":checked") == true) {
			arr.push($(this).attr("id"));
			macArr.push($(this).attr("title"));
		} else {
			arr.splice($.inArray($(this).attr("id"), arr), 1);
			macArr.splice($.inArray($(this).attr("title"), macArr), 1);
		}
		$("#selectedIdx").val(arr);
		$("#selectedMac").val(macArr);
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
		var idx=$(this).parent().parent().siblings(':first').find('input').attr('id');
		contents.contentForm($("#sort").val(),"update",idx);
	});
	$(".deleteElement").click(function(ev){	
		$("#selectedIdx").val($(this).parent().parent().siblings(':first').find('input').attr('id'));
		$("#confirmText").text("선택한 파일을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		ev.preventDefault();
		exception.delConfirm(function(confirm){
			if(confirm){
				contents.deleteByIdxArr();
			}
		});
	});
	$("#selectDeleteBtn").click(function(ev) {
		var checkValArr = $("#selectedIdx").val();
		if (checkValArr.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택 파일들을 삭제하시겠습니까?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					contents.deleteByIdxArr();
				}
			});
		}
	});
	
	$("#STB_schedule_download_check").click(function(ev) {
		var stbList = $("#selectedMac").val();
		if (stbList.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택한 셋탑박스들에 스케쥴 다운로드 명령을 보내시겠습니?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					cmd.settopCmd("schedule_download",stbList);
				}
			});
		}
	});
	
	$("#STB_reboot_check").click(function(ev) {
		var stbList = $("#selectedMac").val();
		if (stbList.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택한 셋탑박스들에게 재 부팅 명령을 보내시겠습니?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					cmd.settopCmd("reboot",stbList);
				}
			});
		}
	});
	
	$("#STB_apk_update_check").click(function(ev) {
		var stbList = $("#selectedMac").val();
		if (stbList.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택한 셋탑박스들에 펌웨어 업데이트 명령을 보내시겠습니?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					cmd.settopCmd("firmware_update",stbList);
				}
			});
		}
	});
	
	$("#STB_tv_on_check").click(function(ev) {
		var stbList = $("#selectedMac").val();
		if (stbList.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택한 셋탑박스들의 TV를 켜는 명령을 보내시겠습니?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					cmd.settopCmd("tv_power_on",stbList);
				}
			});
		}
	});
	
	$("#STB_tv_off_check").click(function(ev) {
		var stbList = $("#selectedMac").val();
		if (stbList.length == 0) {
			exception.checkboxException();
		} else {
			$("#confirmText").text("선택한 셋탑박스들의 TV를 끄는 명령을 보내시겠습니?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					cmd.settopCmd("tv_power_off",stbList);
				}
			});
		}
	});
	
	$(".STB_reboot").click(function(){
		cmd.settopCmd("reboot",$(this).parent().parent().siblings(':first').find('input').attr('title'));
	});
	$(".STB_apk_update").click(function(){
		cmd.settopCmd("firmware_update",$(this).parent().parent().siblings(':first').find('input').attr('title'));
	});        
	$(".STB_schedule_download").click(function(){
		cmd.settopCmd("schedule_download",$(this).parent().parent().siblings(':first').find('input').attr('title'));
	});   
	$(".STB_tv_on").click(function(){
		cmd.settopCmd("tv_power_on",$(this).parent().parent().siblings(':first').find('input').attr('title'));
	});             
	$(".STB_tv_off").click(function(){
		cmd.settopCmd("tv_power_off",$(this).parent().parent().siblings(':first').find('input').attr('title'));
	});            
});
var cmd=(function(){
	var settopCmd=function(command,stbList){
		jQuery.ajaxSettings.traditional = true;
		$.ajax({
			url : '/api/web/sendCommandToSTB',
			type : 'post',
			data:{'command':command, "stbList":stbList},
			success : function(result) {
				$("#successText").text("셋탑박스에 명령을 보냈습니다.");
				$("#sucessModal").modal();
			},
			error : exception.ajaxException
		});
	};
	return{
		settopCmd:settopCmd
	} 
}());
</script>