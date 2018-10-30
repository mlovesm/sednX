<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>
<style>
.optionImg
{
background-size: contain; 
padding: 10px 0 10px 75px;
background-repeat: no-repeat;
}

</style>
<script>
$(function(){
	var data=eval('[${treeMenu}]');
	$('#jstreeModal').jstree({
		"core" : {
			"data" :data,
			"check_callback" : true,
			"themes" : { "dots" : true },
			"animation" : 150
		},
	"plugins" : [ "dnd" ]
	});
	$('#jstreeModal').on("select_node.jstree", function (e, data) {
		var childIdx=data.node.id+","+data.node.children_d;
		var optionHtml="";
		$.ajax({
			url:"${pageContext.request.contextPath}/api/smList/vod?childIdx="+childIdx,
			success:function(responseData){
				var optionData=JSON.parse(responseData);
				$.each(optionData.lists,function(key,value){
					var img=value.main_thumbnail;
					optionHtml+="<option  class='optionImg' value='"+value.idx+"' style=background-image:url('${pageContext.request.contextPath}"+img+"'); title="+value.vod_play_time+">"+value.vod_title+"</option>";		
				});
				$('#chooseList').html(optionHtml);
			},
			error:exception.ajaxException
		});
		
	});
	
});
$(function(){
	$("#chooseList").dblclick(function(){
		var second=common.runtimeToSecond($("#chooseList >option:selected").attr('title'));
		$('#totalRuntimeForm').val(Number($('#totalRuntimeForm').val())+second);
		$('#totalRuntime').text($('#totalRuntimeForm').val().toHHMMSS());
		$("#vodSource").append($(this).prop(this.selectedIndex));
		$("#vodSource").val('');
	});
	$("#vodSource").dblclick(function(){
		var second=common.runtimeToSecond($("#vodSource >option:selected").attr('title'));
		$('#totalRuntimeForm').val(Number($('#totalRuntimeForm').val())-second);
		$('#totalRuntime').text($('#totalRuntimeForm').val().toHHMMSS());
		$(this).prop(this.selectedIndex).remove();
		$("#vodSource").val('');
	});
	$("#deleteSource").click(function(){
		$("#vodSource option:selected").remove();
	});
	$("#upOrder").click(function(){
		sourceIndex.move('up','vodSource');
	});
	$("#downOrder").click(function(){
		sourceIndex.move('down','vodSource');
	});
	$("#topOrder").click(function(){
		sourceIndex.move('top','vodSource');
	});
	$("#bottomOrder").click(function(){
		sourceIndex.move('bottom','vodSource');
	});
});
var sourceIndex=(function(){
	var move=function(order,elementId){
		var element = document.getElementById(elementId);  // Multiple Select Element
        var selIndex = element.selectedIndex;              // Selected Index
        if(selIndex < 0) {
        	jQuery('#vodSource').validationEngine('showPrompt', '이동하고자 하는 컨텐츠를 선택 해 주세요.', 'pass')
            return;
        }else{
        	jQuery('#vodSource').validationEngine('hideAll');
        }
        var elementLength = element.options.length;        // Select Element Item Length
        var selText = element.options[selIndex].text;      // Selected Item Text
        var selValue = element.options[selIndex].value;
        var selImg=element.options[selIndex].style.backgroundImage;
        switch(order){
        case "up":
        	if(selIndex-1 < 0) return;
			var oldText = element.options[selIndex-1].text;
            var oldValue = element.options[selIndex-1].value;
            var oldImg = element.options[selIndex-1].style.backgroundImage;
            element.options[selIndex-1].text = selText;
            element.options[selIndex-1].value = selValue;
            element.options[selIndex-1].style.backgroundImage = selImg;
            element.options[selIndex].text = oldText;
            element.options[selIndex].value = oldValue;
            element.options[selIndex].style.backgroundImage=oldImg;
			element.selectedIndex = selIndex-1;
       		break;
        case "down":
        	if(selIndex+2 > elementLength) return;
			var oldText = element.options[selIndex+1].text;
            var oldValue = element.options[selIndex+1].value;
            var oldImg = element.options[selIndex-1].style.backgroundImage;
            element.options[selIndex+1].text = selText;
            element.options[selIndex+1].value = selValue;
            element.options[selIndex+1].style.backgroundImage = selImg;
            element.options[selIndex].text = oldText;
            element.options[selIndex].value = oldValue;
            element.options[selIndex].style.backgroundImage=oldImg;
            element.selectedIndex = selIndex+1;
           	break;
        case "top":
        	var index = selIndex;
            while(index > 0) {
                element.options[index].text = element.options[index-1].text;
                element.options[index].value = element.options[index-1].value;
                element.options[index].style.backgroundImage=element.options[index-1].style.backgroundImage;
                index--;
            }
			element.options[0].text = selText;
            element.options[0].value = selValue;
            element.options[0].style.backgroundImage = selImg;
            element.selectedIndex = 0;
           	break;
        case "bottom":
        	var index = selIndex;
            while(index < elementLength-1) {
                element.options[index].text = element.options[index+1].text;
                element.options[index].value = element.options[index+1].value;
                element.options[index].style.backgroundImage=element.options[index+1].style.backgroundImage;
                index++;
			}
			element.options[element.options.length-1].text = selText;
            element.options[element.options.length-1].value = selValue;
            element.options[element.options.length-1].style.backgroundImage = selImg;
            element.selectedIndex = element.options.length-1;
           	break;
        }
	};
	return{
		move:move
	};
}());

</script>
<div id="jstreeModal"></div>
<table class="table" style="margin:0px;">
<colgroup>
	<col>
	<col>
	<col width="50px">
</colgroup>
<thead>
	<tr>
		<th style="background:none;">영상리스트 <small> * VIDEO 카테고리를 선택하세요.</small></th>
		<th style="background:none;">선택된 영상 <small>* 영상리스트를 더블 클릭하세요.</small></th>
		<th style="background:none;"></th>
	</tr>
</thead>
<tbody>
<tr>
	<td style="padding:0px;">
		<select multiple class="form-control " id="chooseList">
		</select>
	</td>
	<td style="padding:0px;">
		<select multiple class="form-control" id="vodSource">
		</select>
		<input type="text" id="vodArr" class="input-sm form-control  validate[required]"  style="opacity: 0;width:1px;height:1px;"/>
	</td>
	<td style="padding:0px;" style="width:30px;">
	<button type="button" class="btn btn-lg icon" id="topOrder"><span>&#61870;</span></button>
	<button type="button" class="btn btn-lg icon" id="upOrder"><span>&#61736;</span></button>
	<button type="button" class="btn btn-lg icon" id="downOrder"><span>&#61701;</span></button>
	<button type="button" class="btn btn-lg icon" id="bottomOrder"><span>&#61699;</span></button>
	<button type="button" class="btn btn-lg icon" id="deleteSource"><span>&#61754;</span></button>
	</td>
</tr>
<tr>
	<td></td><td colspan="2">총 재생시간: <span id="totalRuntime">0</span><input type="hidden" id="totalRuntimeForm" value="0"></td>
</tr>
</tbody>
</table> 
