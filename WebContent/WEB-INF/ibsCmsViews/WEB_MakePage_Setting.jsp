<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script>
$('#settingAdd').click(function(){
	var totalArray=$('#totalArray').val().split(',');
	var maxValue=Math.max.apply(null, totalArray)+1;
	totalArray.push(maxValue);
	$('#totalArray').val(totalArray);
	layout.add('${category}',maxValue,'N','0');
});
$('#updateLayout').click(function(){
	var frmArray=layout.getArray();
	/*for(var i=0;i<frmArray.length;i++){
	alert("idx:"+$("#wl_idx_"+frmArray[i]).val()+"/wl_title:"+$("#wl_title_"+frmArray[i]).val()+"/wl_link_type:"+$("#wl_link_type_"+frmArray[i]).val()+"/wl_link_idx:"+$("#wl_link_idx_"+frmArray[i]).val()+"/wl_type: "+$("#wl_type_"+frmArray[i]).val()+"/wl_height:"+$("#wl_height_"+frmArray[i]).val()+"/wl_unit:"+$("#wl_unit_"+frmArray[i]).val()+"/wl_categorys:"+$("#wl_categorys_"+frmArray[i]).val()+"/wl_attribute:"+$("#wl_attribute_"+frmArray[i]).val()+"/wl_sort:"+$("#wl_sort_"+frmArray[i]).val()+"/wl_category:"+$('#categoryIdx').val());
	}*/
	if(frmArray.length!=0){
		for(var i=0;i<frmArray.length;i++){
			console.log(frmArray[i]+"/"+$('#categoryIdx').val());
			var option="insert";
			if(i==0) option="del"
			$.ajax({
				url : "${pageContext.request.contextPath}/user/layoutUpdate/"+option,
				cache : false,
				type : 'post',
				data : {"idx":$("#wl_idx_"+frmArray[i]).val(),"wl_title": $("#wl_title_"+frmArray[i]).val(),"wl_link_type": $("#wl_link_type_"+frmArray[i]).val(),"wl_link_idx": $("#wl_link_idx_"+frmArray[i]).val(),"wl_type": $("#wl_type_"+frmArray[i]).val(),"wl_height": $("#wl_height_"+frmArray[i]).val(),"wl_unit": $("#wl_unit_"+frmArray[i]).val(), "wl_categorys": $("#wl_categorys_"+frmArray[i]).val(),"wl_attribute": $("#wl_attribute_"+frmArray[i]).val(),"wl_sort": $("#wl_sort_"+frmArray[i]).val(),"wl_category": $('#categoryIdx').val()},
				async : false,
				success : function(data){
					console.log(data);
				},
				error : common.ajaxException
			});
		}
		arange.movePreview($('#categoryIdx').val());
	}
});
var layout={
	add:function(category,index,type,idx){
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/makepage/editForm/"+category+"/"+index+"/"+type+"/"+idx,
			async: false,
			success : function(data){
				$('.setUI').append(data);
			},
			error : exception.ajaxException
		});
	},
	del:function(idx){
		var totalArray=$('#totalArray').val().split(',');
		var retArr=common.removeElementToArray(totalArray,idx);
		$('#totalArray').val(retArr);
	},
	getArray:function(){
		var totalArray=$('#totalArray').val().split(',');
		return totalArray;
	},
	delCategorys : function(idx,index){
		$('#del_'+idx).remove();
		var totalArray=$('#wl_categorys_'+index).val().split(',');
		var retArr=common.removeElementToArray(totalArray,idx);
		$('#wl_categorys_'+index).val(retArr);
	}
};
var totalArray = new Array();
</script>
<div class="form_div setUI" style="max-height: 820px; overflow-y: auto; width:100%;">

</div>

<div class="tile col-md-12 p-5">
   <div class="col-md-6">
       <button class="btn btn-alt col-md-2 m-b-5" id="settingAdd">추가</button>
   </div>
   <div class="col-md-6">
       <button class="btn btn-alt col-md-2 m-b-5 pull-right" id="updateLayout">적용</button>
   </div>
</div>

<c:choose>
	<c:when test="${empty lists}">
		<script>
			layout.add('${category}',Number($('#totalCount').val())+1,'N','0');
			$('#totalCount').val(Number($('#totalCount').val())+1);
		</script>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="status">
  				<script>
  				
  				totalArray.push('${status.count}');
  				$('#totalArray').val(totalArray);
  				layout.add('${list.wl_category}','${status.count}','E','${list.idx}');
  				</script>
		</c:forEach>
	</c:otherwise>
</c:choose>
<input type="hidden" class="form-control" id="totalArray"> 
