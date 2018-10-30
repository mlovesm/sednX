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
	$('#jstreeContents').jstree({
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
	$('#jstreeContents').jstree("open_all");

	$('#jstreeContents').on("select_node.jstree", function (e, data) {
		
		var ref = $('#jstreeContents').jstree(true);
		sel = ref.get_selected("full");
		if(!sel.length) { return false; }
		sel = sel[0];
		
		all_children = sel.children_d;
		all_children.push(sel.id);
		all_children=all_children.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);//중복제거
		//$("#treeIdx").val(all_children);
		all_parents=sel.parents;
		all_parents=all_parents.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);//중복제거
		//#삭제 
		var removeItem='#';
		all_parents=jQuery.grep(all_parents,function(value){return value!=removeItem}); 
		//역순
		all_parents=all_parents.reverse();
		//추가
		all_parents.push(sel.id);
		//중복제거
		all_parents=all_parents.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
		//한글화 
		for(var i=0;i<all_parents.length;i++){
			var sliceVal=$('#'+all_parents[i]+"_anchor").text();
			var splitVal=sliceVal.split('[');
			all_parents[i]=splitVal[0];
		}
		if(all_parents.length>1){
			all_parents.splice(0,1);
		}
		$('#searchIdx').val(sel.children_d);
			common.repolist(sel.children_d);
		});
});


</script>
<div id="jstreeContents" ></div> 
<div class="clearfix"></div>



 