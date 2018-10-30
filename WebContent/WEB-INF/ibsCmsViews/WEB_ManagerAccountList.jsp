<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>

<script>
	$("#pagingDiv li a").click(function(){
		var rel=$(this).attr('rel');
		$.ajax({url:rel,
						success:function(data){
						$("#TBList").empty();
						$("#TBList").html(data);
					},
				error:exception.ajaxException
		});
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
	$("#authChangeBtn").click(function(){
		var changeVal=$(this).prev().prev().val();
		var checkValArr=$("#selectedIdx").val();
		if(checkValArr.length==0){
			exception.checkboxException();
		}else{
			memberList.updateByIdxArr(changeVal,checkValArr);
		}
	});
	$(".editElement").click(function(){
		var changeVal=$(this).siblings(':first').val();
		var checkValArr=$(this).parent().parent().siblings(':first').find('input').attr('id');
		memberList.updateByIdxArr(changeVal,checkValArr);
	});
	$(".deleteElement").click(function(ev){	
		var checkValArr=$(this).parent().siblings(':first').find('input').attr('id');
		$("#confirmText").text("선택한 항목을 삭제하시겠습니까?.");
		$("#confirmModal").modal('show');
		ev.preventDefault();
		exception.delConfirm(function(confirm){
			if(confirm){
				memberList.deleteByIdxArr(checkValArr);
			}
		});
	});
	$("#authDeleteBtn").click(function(){
		var checkValArr=$("#selectedIdx").val();
		if(checkValArr.length==0){
			exception.checkboxException();
		}else{
			$("#confirmText").text("선택 회원을 삭제하시겠습니까?.");
			$("#confirmModal").modal();
			exception.delConfirm(function(confirm){
				if(confirm){
					memberList.deleteByIdxArr(checkValArr);
				}
			});
		}
	});
</script>
<table class="table table-bordered table-hover tile">
<colgroup>
	<col width="auto"/>
	<col width="auto"/>
	<col width="50px;"/>
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
         <th>이미지</th>
         <th>이름(소속)</th>
         <th>아이디</th>
         <th>이메일</th>
         <th>최종 로그인</th>
         <th>권한</th>
         <th>삭제</th>
     </tr>
</thead>
<tbody id="memberTbody">
<c:choose>
	<c:when test="${empty lists }">
		<tr>
			<td colspan="10">데이타가 없습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list"  varStatus="loop">
		<tr>
		    <td><input type="checkbox" class="checkElem" id="${list.idx}" value="${list.idx}"></td>
		    <td>${list.idx}</td>
		    <td><img src="${pageContext.request.contextPath}/REPOSITORY/PROFILE/${list.member_profile}" width="35"/></td>
		    <td>${list.member_name}</td>
		    <td>${list.member_id}</td>
		    <td>${list.member_email}</td>
		    <td>${list.member_last_dt}</td>
		    <td>
		      <div class="form-inline authOption" id="memberSelect_${list.idx}">
		      <c:set var="authority" value="${list.member_authority}"/>
						${hn:getAuthorityInfo('authority',authority)}
			    <button type="button" class="btn btn-sm icon  editElement"><span>&#61952;</span> <span class="text">수정</span></button>
		    </div>
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
     