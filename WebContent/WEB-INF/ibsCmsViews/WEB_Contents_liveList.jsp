<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<style>
.table-bordered > tbody > tr > td, .table-bordered > thead > tr > th {border-bottom:1px solid #ddd;}
</style>
<table class="table table-bordered  borderB  table-hover" >
<colgroup>
	<col width="auto"/>
	<col width="auto"/>
	<col width="auto"/>
	<col width="auto"/>
	<col width="auto"/>
	<col width="auto"/>
	<col width="auto"/>
	<col width="auto"/>
</colgroup>

<thead>
   <tr>
       <th><input type="checkbox" id="allCheck"></th>
       <th>No</th>
       <th>그룹명</th>
       <th>채널명</th>
       <th>채널주소</th>
       <th>최종수정일</th>
       <th>등록아이디</th>
       <th>등록아이피</th>
       <th>모니터링</th>
       <th>수정</th>
       <th>삭제</th>
   </tr>
</thead>
<tbody>
<c:choose>
	<c:when test="${empty lists }">
		<tr>
			<td colspan="10">데이타가 없습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list"  varStatus="loop">
		<tr id="list_${list.idx}">
	    <td><input type="checkbox" class="checkElem" id="${list.idx}" value="${list.idx}"></td>
	    <td>${list.idx}</td>
	    <td>${list.category_idx}</td>
	    <td>${list.live_title}</td>
	    <td>${list.live_path}</td>
	    <td>${list.edit_dt}</td>
	    <td>${list.reg_id}</td>
	    <td>${list.reg_ip }</td>
	    <td>
				<button type="button" class="btn btn-sm btn-alt icon  monitering" ><span>&#61698;</span> <span class="text">모니터링</span></button>
			</td>
			<td>
				<button type="button" class="btn btn-sm icon  editElement"><span>&#61952;</span> <span class="text">수정</span></button>
			</td>
	 		<td>
				<button type="button" class="btn btn-sm icon deleteElement"><span>&#61754;</span> <span class="text">삭제</span></button>
			</td>
		</tr>
		</c:forEach>
	</c:otherwise>	
</c:choose>              
</tbody>
</table>
<div class="col-md-12 text-center">
	 ${pagingStr}
</div>
<script>
$(function(){
	$(".monitering").click(function(){
		modalLayer.livePlayer(
				$(this).parent().siblings(':first').find("input").attr("id"),
				$(this).parent().siblings(':first').next().next().text(),
				$(this).parent().siblings(':first').next().next().next().text(),
				$(this).parent().siblings(':first').next().next().next().next().text());
	});
	var arr=[];
	$(".checkElem").click(function(){
		if($(this).is(":checked")==true){
			arr.push($(this).attr("id"));
		}else{
			arr.splice($.inArray($(this).attr("id"),arr),1);
		}
		$("#selectedIdx").val(arr);
	});
	$("#allCheck").click(function(){
		if($(this).prop("checked")){
			var chkbox = $(".checkElem");
			$(".checkElem").prop("checked",true);
			arr=[];
			for(i=0;i<chkbox.length;i++){
				arr.push(chkbox[i].value);
			}
			$("#selectedIdx").val(arr);
		}else{
			$(".checkElem").prop("checked",false);
			arr=[];
			$("#selectedIdx").val('');
		}
	});
	$("#pagingDiv li a").click(function(){
		var rel=$(this).attr('rel');
		$.ajax({url:rel,
				success:function(data){
					$("#selectedIdx").val('');
					$("#listView").empty();
					$("#listView").html(data);	
				},
		error:exception.ajaxException
		});
	});
	$(".editElement").click(function(){
		var idx=$(this).parent().siblings(':first').find('input').attr('id');
		contents.contentForm($("#sort").val(),"update",idx);
	});
	$(".deleteElement").click(function(ev){	
		$("#selectedIdx").val($(this).parent().siblings(':first').find('input').attr('id'));
		$("#confirmText").text("선택한 항목을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		ev.preventDefault();
		exception.delConfirm(function(confirm){
			if(confirm){
				contents.deleteByIdxArr();
			}
		});
	});
	$("#selectDeleteBtn").click(function(ev){
		var checkValArr=$("#selectedIdx").val();
		if(checkValArr.length==0){
			exception.checkboxException();
		}else{
			$("#confirmText").text("선택 회원을 삭제하시겠습니까?.");
			$("#confirmModal").modal();
			ev.preventDefault();
			exception.delConfirm(function(confirm){
				if(confirm){
					contents.deleteByIdxArr();
				}
			});
		}
	});
});
</script>