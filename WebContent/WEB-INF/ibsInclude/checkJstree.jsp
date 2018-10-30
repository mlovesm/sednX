<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>
<script>
$(function(){
	var data=eval('[${treeMenu}]');
	$('#jstreeGroup').jstree({
		"core" : {
			"data" :data,
			"check_callback" : true,
			"themes" : { "dots" : true },
			"animation" : 150
		},
	"checkbox":{
		"three_state":true,
		"cascade":"down"
	},
	"plugins" : [ "checkbox" ]
	});
	$('#jstreeGroup').jstree("open_all");
	$('#jstreeGroup').on("select_node.jstree", function (e, data) {
		var groupArr=[];
		groupArr=$("#groupArr").val().split(',');
		if(data.node.id!='1'){
			groupArr.push(data.node.id);
		}
		if(data.node.children_d.legnth!=0){
			var childArr=data.node.children_d;
			for(var i=0;i<childArr.length;i++){
				groupArr.push(childArr[i]);
			}
		}
		groupArr=common.removeOverlap(groupArr);
		groupArr=groupArr.filter(common.isNotEmpty);
		$("#groupArr").val(groupArr);
		console.log('add'+$("#groupArr").val());
		arange.targetPreview($("#groupArr").val());
	});
	$('#jstreeGroup').on("deselect_node.jstree", function (e, data) {
		/*var removeGroup=[];
		var groupForm=$("#groupArr").val().split(',');
		removeGroup.push(data.node.id);
		if(data.node.children_d.legnth!=0){
			var addList=data.node.children_d;
			for(var i=0;i<addList.length;i++){
				removeGroup.push(addList[i]);
			}
		}
		removeGroup=common.removeOverlap(removeGroup);
		removeGroup=removeGroup.filter(common.isNotEmpty);
		for(var i=0;i<removeGroup.length;i++){
			console.log(removeGroup[i]);
			groupForm.splice(groupForm.indexOf(removeGroup[i]),1);
			console.log("remainItem :"+groupForm);
		}*/
		var selectedElmsIds = [];
		var selectedElms = $('#jstreeGroup').jstree("get_selected", true);
		$.each(selectedElms, function() {
		    selectedElmsIds.push(this.id);
		});
		$("#groupArr").val(selectedElmsIds);
		console.log('del'+$("#groupArr").val());
		arange.targetPreview($("#groupArr").val());
	});
	
});
var checkJs=(function(){
	var targetCheck=function(id){
		$('#jstreeGroup').jstree(true).deselect_node(id);
	};
	return{
		targetCheck : targetCheck
	}
}());
</script>

<div id="jstreeGroup"></div> 
