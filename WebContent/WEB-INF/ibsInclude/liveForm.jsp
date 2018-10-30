<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<c:set var="resultMap" value="${resultMap}" />
<!-- All JS functions -->
<form role="form" class="form-validation-1" id="contentsForm">

	<input type="text" id="live_title"
		class="form-control m-b-10 validate[required,maxSize[20],custom[onlyLetterSp]]"
		value="${resultMap.live_title}" placeholder="채널명">
	<input type="text" id="live_path"
		class="form-control m-b-10 validate[required,maxSize[100],custom[url]]"
		value="${resultMap.live_path}" placeholder="주소">
		<input type="hidden" id="order" value="${order}" />
		<input type="hidden" id="idx" value="${idx}" />
</form>
<script>
$("#contentsForm").submit(function(ev){
	$.ajax({
		url : '/cms/excute/'+$("#sort").val()+'/'+$("#order").val(),
		cache : false,
		type : 'post',
		data :{"live_title" :$("#live_title").val(),"live_path" : $("#live_path").val(),"idx": $("#idx").val(),"category_idx":$("#categoryIdx").val()},
		async : false,
		success : function(result) {
			if($("#order").val()=="insert"){
				menuJs.makeJsTree();
			}
			contents.list($("#treeIdx").val());
			$("#contentsAddModel").modal('hide');
		},
		error : exception.ajaxException
	});
	ev.preventDefault();
});
</script>