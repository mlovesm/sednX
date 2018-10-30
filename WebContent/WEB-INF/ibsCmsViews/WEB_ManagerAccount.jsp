<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<!--********** permittsion include **************-->
<c:import url = "/inc/incPermission">
	<c:param name = "permission" value = "10000" />
</c:import>
<!--********* permittsion include **************-->
<!-- Content -->
<section id="content" class="container">
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
	   		<div class="col-md-12">
			<h3 class="block-title"> ACCOUNT MANAGEMENT | <small>가입한 회원의 권한 부여 및 삭제합니다.</small></h3>
             <div style="float:right;"><input type="text" class="main-search" id="mainSearch" style="border-bottom:1px solid #FFFFFF;" placeholder="email or ID or name"></div>
					<div class="table-responsive overflow">
                  		<div class="pull-left">
                  			<div class="btn-group" data-toggle="buttons">
                  					<label class="btn btn-gr-gray btn-sm active" id="defaultTab"  onClick="memberList.sortByAuthrity('');">
		                            <input type="radio" name="options"/> <i class="icon">&#61873;</i> <span class="text">전체 회원</span>
		                        </label>
                  					<label class="btn btn-gr-gray btn-sm"  onClick="memberList.sortByAuthrity('0');">
		                            <input type="radio" name="options"/> <i class="icon">&#61887;</i> <span class="text">웹회원</span>
		                        </label>
		                        <label class="btn btn-gr-gray btn-sm" onClick="memberList.sortByAuthrity('5000');">
		                            <input type="radio" name="options" /> <i class="icon">&#61822;</i> <span class="text">데모 회원</span>
		                        </label>
		                        <label class="btn btn-gr-gray btn-sm" onClick="memberList.sortByAuthrity('1000');" >
		                            <input type="radio" name="options" /> <i class="icon">&#61696;</i> <span class="text">컨텐츠 관리자</span>
		                        </label>
		                        <label class="btn btn-gr-gray btn-sm"  onClick="memberList.sortByAuthrity('2000');">
		                            <input type="radio" name="options"/> <i class="icon">&#61782;</i> <span class="text">웹 관리자</span>
		                        </label>
		                        <label class="btn btn-gr-gray btn-sm"  onClick="memberList.sortByAuthrity('3000');">
		                            <input type="radio" name="options"/> <i class="icon">&#61931;</i> <span class="text">셋탑 관리자</span>
		                        </label>
		                        <label class="btn btn-gr-gray btn-sm"  onClick="memberList.sortByAuthrity('10000');">
		                            <input type="radio" name="options"/> <i class="icon">&#61838;</i> <span class="text">최종 관리자</span>
		                        </label>
                   			 </div>
	                    </div>
	                     <div class="pull-right p-b-10">
	                     	 <div class="form-inline">
													${hn:getAuthorityInfo('authority','')}
													<input type="hidden" id="selectedIdx" /><button type="button" class="btn btn-sm icon" id="authChangeBtn"><span>&#61844;</span> <span class="text">선택 권한 변경</span></button>
	                       	<button type="button" class="btn btn-sm icon" id="authDeleteBtn"><span>&#61754;</span> <span class="text">선택 계정 삭제</span></button>
	                       	</div>
	                   	</div>
	                  <div class="col-md-12 p-b-10" id="explainText">가입회원 전체의 회원정보를 조회합니다.</div>
                      <div id="TBList">
                      </div>
              	</div>
	    	</div>
	    </div>
   	</div>
</section>
<script>
/*EVENT JS*/	
$(function(){
	$('#cmsPageTitle').html('계정 관리');
	$('.menuLi').removeClass('active');
	$('#memberMenuLi').addClass('active');
		$("#mainSearch").keydown(function(key){
			if(key.keyCode==13){
				if($("#mainSearch").val().length==0){
					exception.searchException();
				}else{
					memberList.search($("#mainSearch").val());
				}
			}
		});
 });
</script>
<script>
/*FUNCTION JS*/	
	var memberList=(function(){
		var sortByAuthrity=function(authority){
			$.ajax({
				url:"${pageContext.request.contextPath}/cms/list/member?authority="+authority,
							success:function(data){
							$("#TBList").empty();
							$("#TBList").html(data);
							if(authority==''){
								$("#explainText").html('가입회원 전체의 회원정보를 조회합니다.');
							}else if(authority=='0'){
								$("#explainText").html('SEDN WEB 가입 회원이며 관리 권한은 없습니다.');
							}else if(authority=='5000'){
								$("#explainText").html('SEDN CMS를 조회만 가능합니다.');
							}else if(authority=='1000'){
								$("#explainText").html('SEDN 콘텐츠 등록, 수정, 삭제 관리가 가능합니다.');
							}else if(authority=='2000'){
								$("#explainText").html('콘텐츠 관리자 권한과 카테고리, 사용자 메인화면 관리가 가능합니다.');
							}else if(authority=='3000'){
								$("#explainText").html('웹관리자 권한과 셋탑 화면 관리가 가능합니다.');
							}else if(authority=='10000'){
								$("#explainText").html('SEDN CMS의 전체 메뉴 관리가 가능합니다.');
							}
						},
					error:exception.ajaxException
			});
		}; 
		var search=function(searchWord){
			$.ajax({
				url:"${pageContext.request.contextPath}/cms/list/member?searchWord="+searchWord,
							success:function(data){
							$(".btn-gr-gray").removeClass('active');
							$("#defaultTab").addClass('active');
							$("#TBList").empty();
							$("#TBList").html(data);
						},
					error:exception.ajaxException
			});
		};
		var updateByIdxArr=function(changeVal,checkValArr){
				$.ajax({
						url:"${pageContext.request.contextPath}/cms/update/member?changeVal="+changeVal+"&checkValArr="+checkValArr,
								success:function(responseData){
								var data=JSON.parse(responseData);
								if(data.result=="success"){
									$("#successText").text("회원 권한 업데이트에 성공했습니다.");
									$("#sucessModal").modal();
									var array=checkValArr.split(',');
									for(i=0;i<array.length;i++){
										$("#memberSelect_"+array[i]).find('select').val(changeVal);
									}
								}else{
									$("#warnText").text("회원권한 업데이트에 실패했습니다.");
									$("#msgModal").modal();
								}
							},
						error:exception.ajaxException
				});
		};
		var deleteByIdxArr=function(checkValArr){
			console.log(checkValArr);
			$.ajax({
					url:"${pageContext.request.contextPath}/cms/delete/member?checkValArr="+checkValArr,
							success:function(responseData){
							var data=JSON.parse(responseData);
							if(data.result=="success"){
								$("#successText").text("회원 삭제에 성공했습니다.");
								$("#sucessModal").modal();
								var array=checkValArr.split(',');
								for(i=0;i<array.length;i++){
									$('#'+array[i]).parent().parent().fadeOut('slow');
								}
							}else{
								$("#warnText").text("회원 삭제에 실패했습니다.");
								$("#msgModal").modal();
							}
						},
					error:exception.ajaxException
			});
	};
	return{
			sortByAuthrity:sortByAuthrity,
			search:search,
			updateByIdxArr:updateByIdxArr,
			deleteByIdxArr:deleteByIdxArr
		}
	}());
	memberList.sortByAuthrity('');
</script>

