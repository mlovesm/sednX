<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<style>
    .b {top:10px; left:10px; position: absolute;}
    .form_show {
        text-align: left;
        position: relative;
        width: calc(100% + 10px);
        margin-left: -5px;
        margin-top: 5px;
        float: left;
        padding: 14px;
        background: rgba(0, 0, 0, 0.25);
        display: none;
    }
    .photo_form {background: rgba(0,0,0,0.35); box-shadow: 0 0 5px rgba(0, 0, 0, 0.15); text-align: center; padding: 5px;}
    .photo {display: inline;}
    .form_div {display: inline-block; position: relative; margin: 5px;cursor:pointer;}
    .form_div .img_box img {width: 160px; height: 160px;}
</style>
<style>
.jstree-rename-input{color:#26120C;}
</style>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>
<script>
$(function(){
	var data=eval('[${treeMenu}]');
	$('#jstreeModal').jstree({
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
	$('#jstreeModal').jstree("open_all");
	$('#jstreeModal').on("select_node.jstree", function (e, data) {
		$('#changeCateProperty').val(data.node.original.property);
		$("#changeCateIdx").val(data.node.id);
	});
});


</script>

<div id="jstreeModal"></div> 


 