<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>

<script>
$(function(){
	var data=eval('[${treeMenu}]');
	$('#jstreeForm').jstree({
		"core" : {
			"data" :data,
			"check_callback" : true,
			"themes" : { "dots" : true },
			"animation" : 150
		},
	"plugins" : [ "dnd" ]
	});
	$('#jstreeForm').on("select_node.jstree", function (e, data) {
		$("#category_idx").val(data.node.id);
	});
	$("#jstreeForm").on("loaded.jstree", function(){
		if($("#order").val()=='update'){
			$('#jstreeForm').jstree(true).select_node($("#category_idx").val());
		}else{
			$('#jstreeForm').jstree(true).select_node($("#categoryIdx").val());
		}
	});
});
</script>
<div id="jstreeForm"></div> 
<c:set var="resultMap" value="${resultMap}" />
<form role="form" class="form-validation-1" id="contentsForm">
	<input id="name" type="text"  class="form-control m-b-10 validate[required,maxSize[10]]" value="${resultMap.name}" placeholder="장비명">
	<input id="ip_addr" class="form-control m-b-10 mask-ip_address validate[required,custom[ipv4]]" autocomplete="off" value="${resultMap.ip_addr}"  type="text" placeholder="아이피">
	<input id="mac" class="form-control m-b-10 mask-mac_address validate[required,custom[mac]]" autocomplete="off" value="${resultMap.mac}"  type="text" placeholder="맥 주소">
	<textarea id="note" class="form-control m-b-10" placeholder="메모">${resultMap.note}</textarea>
	<input type="hidden" id="category_idx" value="${resultMap.category_idx}" />
	<input type="hidden" id="order" value="${order}" />
	<input type="hidden" id="idx" value="${idx}" />
</form>

<script>

$("#contentsForm").submit(function(ev){
	$.ajax({
		url : '/cms/excute/'+$("#sort").val()+'/'+$("#order").val(),
		cache : false,
		type : 'post',
		data :{
			"name" :$("#name").val(),
			"ip_addr":$("#ip_addr").val(),
			"mac" : $("#mac").val(),
			"note" : $("#note").val(),
			"category_idx" : $("#category_idx").val(),
			"idx": $("#idx").val()
			},
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
$(function(){
	(function(){
		$('.mask-ip_address').mask('0ZZ.0ZZ.0ZZ.0ZZ', {translation: {'Z': {pattern: /[0-9]/, optional: true}}});
        $('.mask-ip_address').mask('099.099.099.099');
        $('.mask-mac_address').mask('AA:AA:AA:AA:AA:AA');
	})();
});
</script>