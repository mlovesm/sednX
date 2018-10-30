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
	$('#jstree').jstree({
		"core" : {
			"data" :data,
			'strings' : {
				'Loading ...' : 'Please wait ...'
			},
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
		//"plugins" : ["dnd"]
	});
	$('#jstree').jstree("open_all");
	$('#jstree').on("ready.jstree",function(e,data){
		var ref = $('#jstree').jstree(true);
		var naviString="";
		sel = ref.get_selected("full");
		if(!sel.length) { return false; }
		sel = sel[0];
		if($('#sort').val()!="live"||sel.id!='1'){
			$("#treeIdx").val(sel.id+","+sel.children_d);
			
		}
	});
	$('#jstree').on("select_node.jstree", function (e, data) {
		var ref = $('#jstree').jstree(true);
		var naviString="";
		sel = ref.get_selected("full");
		if(!sel.length) { return false; }
		sel = sel[0];
		
		all_children = sel.children_d;
		all_children.push(sel.id);
		all_children=all_children.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);//중복제거
		$("#treeIdx").val(all_children);
		$('#treeProperty').val(sel.original.property);
		console.log(sel.original.property, all_children);
/* 		all_parents=sel.parents;
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
		
		naviString=all_parents.join('<i class="fa fa-angle-right m-r-10 m-l-10"></i><i class="fa fa-list-alt m-r-10"></i>');
		
		
		if($('#sort').val()!="live"||sel.id!='1'){
			arange.list($('#treeIdx').val(),sel.original.property);
			arange.naviBar($('#sort').val(),$('#treeIdx').val(),naviString);
		} */
		$("#categoryIdx").val(sel.id);
		menuTree.getVODListData($("#treeIdx").val());
	});

});
var menuTree=(function(){
	var renameGroup=function(){
  		var ref = $('#jstree').jstree(true);
		sel = ref.get_selected('full');
		if(!sel.length) { return false; }
			sel = sel[0];
			console.log(sel.original.name);
		if(sel.id == '1') {
			exception.rootException();
		return false;
		}
		ref.edit(sel, sel.original.name);
	};

 var getVODListData=function(childIdx){
	$.ajax({
		url:"${pageContext.request.contextPath}/statistics/vod/VODListData",
		type:'post',
		data: {
			"childIdx": childIdx
		},
		async:false,
		success:function(data){
			//console.log(data.response.data);
			var net = grid.getAddOn('Net');
			//net.download('excel');
			//net.reloadData();
			grid.setData(data.response.data.contents);
			//net.readData(1, {"childIdx": childIdx}, false);
		},
		error:exception.ajaxException
	});
 };

 return{
	renameGroup:renameGroup,
	getVODListData:getVODListData
 };
}());

</script>
<div id="jstree" ></div> 
<div class="clearfix"></div>



 