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
		console.log(sel.original.property);
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
		
		naviString=all_parents.join('<i class="fa fa-angle-right m-r-10 m-l-10"></i><i class="fa fa-list-alt m-r-10"></i>');
		
		$("#categoryIdx").val(sel.id);
		if($('#sort').val()!="live"||sel.id!='1'){
			arange.list($('#treeIdx').val(),sel.original.property);
			arange.naviBar($('#sort').val(),$('#treeIdx').val(),naviString);
		}
	});
	
	$('#jstree').on("move_node.jstree", function (e, data) {
      	$.ajax({
            url:'/api/jstree/moveCategory',
            type:'post',
            data:{"idx": data.node.id, "old_parent": data.old_parent, "old_position": data.old_position, "parent": data.parent, "position": data.position,"sort":"${sort}"},
            success:function(result){
            	console.log("move success");
            },
            error:function() {
            	exception.renameException
            }
		});
	});
	$('#jstree').on("rename_node.jstree", function (e, data) {
		if(data.old != data.text || data.old == "새 그룹") {
			$.ajax({
           		url:'/api/jstree/renameGroup',
           		type:'post',
           		data:{"idx": data.node.id, "name": data.text,"sort":"${sort}"},
           		async:false,
           		success:function(result){
   					data.node.original.name = data.text;
   					new_name = data.text;
           		},
           		error:function() {
           			exception.renameException
           		}
			});
			data.node.text = data.node.original.name + ' [' + data.node.original.num + ']';
			//console.log(data.node);
			$('#jstree').jstree(true).redraw(true);
			var removeItem='#';
			all_parents=data.node.parents;
			all_parents=jQuery.grep(all_parents,function(value){return value!=removeItem}); 
			//역순
			all_parents=all_parents.reverse();
			//추가
			all_parents.push(data.node.id);
			//중복제거
			all_parents=all_parents.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
			//한글화 
			for(var i=0;i<all_parents.length;i++){
				var sliceVal=$('#'+all_parents[i]+"_anchor").text();
				console.log(sliceVal);
				var splitVal=sliceVal.split('[');
				all_parents[i]=splitVal[0];
			}
			if(all_parents.length>1){
				all_parents.splice(0,1);
			}
			naviString=all_parents.join('<i class="fa fa-angle-right m-r-10 m-l-10"></i><i class="fa fa-list-alt m-r-10"></i>');
			arange.naviBar($('#sort').val(),$('#treeIdx').val(),naviString);
		}
	});
	$('#createGroup').click(function(){
		//그룹 생성 
		menuTree.createGroup('0');
	});
	$('#createMenu').click(function(){
		//그룹 생성 
		menuTree.createGroup('0');
	});
	$('#createBoard').click(function(){
		//그룹 생성 
		menuTree.createGroup('1');
	});
	$('#renameGroup').click(function(){
		//이름 변경
		menuTree.renameGroup();
	});
	$('#deleteGroup').click(function(){
		//그룹 삭제
		menuTree.deleteGroup();
	});
});
var menuTree=(function(){
	var createGroup=function(attrebute){
		var ref = $('#jstree').jstree(true);
		sel = ref.get_selected('full');
        if(sel[0]==undefined){
        	exception.beforeSelectException();
        	return false;
        }else if(sel[0].original.property=="1"){
        	exception.menuMakeException();
        	return false;
        }else if(sel[0].id=="1"&&attrebute=="1"){
        	exception.subMainException();
        	return false;	
        }else{
        	if(!sel.length) { return false; }
    		sel = sel[0].id;
    		var new_id =menuTree.getNewGroupID(sel, "새 그룹","${sort}",attrebute);
    		var  icon="menu.png";
    		if(attrebute=="1"){
    			icon="list.png";
    		}
    		var new_node = {"id":new_id, "text":"새 그룹", "num": 0,"property":attrebute,"icon":"${pageContext.request.contextPath}/ibsImg/"+icon};
    		console.log(sel[0]);
    		console.log("new id : " + new_id);
    		ref.create_node(sel, new_node);
    		ref.edit(new_id);	
        }   
		
	 };
	
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
 
 var deleteGroup=function(){
	 var ref = $('#jstree').jstree(true);
		sel = ref.get_selected('full');
		if(!sel.length) { return false; }
		sel = sel[0];

		if(sel.id == '1') {
			exception.rootException();
			return false;
		}
		console.log(sel);
		var msg = sel.original.name + " 그룹 및 모든 하위 그룹이 삭제되며\n삭제된 그룹 요소들은 ROOT로 옮겨집니다.\n\n정말 삭제하시겠습니까?";
		$("#confirmText").text(msg);
		$("#confirmModal").modal('show');
		exception.delConfirm(function(confirm){
			if(confirm){
				var all_children = sel.children_d,
				parent_node = ref.get_node(sel.parent),
				position = $.inArray(sel.id, parent_node.children);
				all_children.push(sel.id);
				all_children=all_children.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);//중복제거
				console.log(all_children.toString());
				$.ajax({
	            url:'/api/jstree/deleteGroup',
	            type:'post',
	            data:{"parent": sel.parent, "position": position, "groupIdArr": all_children.toString(),"sort":"${sort}"},
	            success:function(result){
	            	console.log(result);
	            	ref.delete_node(sel);
	            },
	            error:exception.delGroupException
				});
			}
		});
 };
 var getNewGroupID=function(parent,name,sort,property){
	 var newID="";
		$.ajax({
				url:"${pageContext.request.contextPath}/api/jstree/addGroup",
				type:'post',
				data:{"parent":parent,"name":name,"sort":sort,"property":property},
				async:false,
				success:function(responseData){
					var data=JSON.parse(responseData);
					newID=data.newNodeId;
				},
				error:exception.addGroupException
			});
		 return newID;
 };

 return{
  renameGroup:renameGroup,
  createGroup:createGroup,
  deleteGroup:deleteGroup,
  getNewGroupID:getNewGroupID
 };
}());

</script>
<div id="jstree" ></div> 
  <div class="p-10 text-center">
  <button class="btn btn-block btn-alt" id="renameGroup">이름변경</button>
  <button class="btn btn-block btn-alt" id="deleteGroup" >카테고리 삭제</button>
 </div>
<div class="clearfix"></div>



 