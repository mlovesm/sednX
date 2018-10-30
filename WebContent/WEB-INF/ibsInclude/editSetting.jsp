<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script>
$('#modalClose_${index}').click(function(){
	//alert($('#model_${index}').attr('title'));
	layout.del($('#model_${index}').attr('title'));
	$('#model_${index}').remove();
});

</script>
<form id="frm_${index}">
 <div class="modal modal-dialog frm" id="model_${index}" title="${index}" style="display: block; overflow-y: visible; overflow: visible;">
	<div class="modal-content">
		<div class="modal-header" style="border-bottom: none;">
			<button type="button" class="close" id="modalClose_${index}" data-dismiss="modal" aria-hidden="true" style="color:#000; opacity: 1; position:absolute; top:-10px; right:-5px; background:#fff; border-radius: 10px !important; width: 20px;height: 20px; z-index:1000;">
	        ×
	    	</button>
		</div>
		<div class="modal-body col-md-12" style="padding: 30px; overflow: hidden;">
			<div class="col-md-12">
	    		<div class="m-b-15 col-md-2" style="top: 5px;">
	        		<label class="checkbox-inline">
	            		<span class="checkableBox">
	                		<input type="checkbox" id="setTitle_${index}" style="display:none;"> 
	            		</span>
	            	제목 :
	        		</label>
	    		</div>
	    		<div class="col-md-10">
	        		<input type="text" class="form-control input-sm" id="wl_title_${index}" placeholder="배너 내용입력"  value="${resultMap.wl_title}"/>
	    		</div>
			</div>
	
			<div class="col-md-12">
	    		<div class="m-b-15 col-md-2" style="top: 5px;">
	    			<label class="checkbox-inline">
	        			<span class="checkableBox">
	            			<input type="checkbox" id="setLink_${index}" style="display:none;"> 
	        			</span>
	        		링크 :
	    			</label>
				</div>
				<div class="col-md-5">
	    			<select class="form-control input-sm" id="wl_link_type_${index}">
	        			<option value="A"> + </option>
	        			<option value="B">더보기</option>
	        			<option value="C">more</option>
	    			</select>
				</div>
				<div class="col-md-5">
	   				<select class="form-control input-sm selectOption" id="wl_link_idx_${index}">
	    				
	        		</select>
	    		</div>
			</div>
	
			<div class="col-md-12">
	    		<div class="m-b-15 col-md-2" style="top: 5px; left: 25px;">
	    		타입 :
				</div>
				<div class="col-md-5">
	    			<select class="form-control input-sm" id="wl_type_${index}">
	        			<option value="A">배너타입</option>
	        			<option value="B">기본 세로형 썸네일</option>
	        			<option value="C">기본 가로형 썸네일</option>
	        			<option value="D">세로형 리스트</option>
	        			<option value="E">가로형 리스트</option>
	        			<option value="F">이미지 가로 세로 리스트</option>
	        			<option value="G">썸네일 혼합형</option>
	        			<option value="H">리스트 혼합형</option>
	    			</select>
				</div>
				<div class="col-md-5">
	    			<div class="col-md-3" style="top:5px;">
	    			<span style="display:none">높이 :</span>
					</div>
					<div class="col-md-5">
	    				<input type="hidden" class="form-control input-sm" id="wl_height_${index}" value="${resultMap.wl_height}">
					</div>
					<div class="col-md-4" style="padding: 0;">
	            		<select class="form-control input-sm " id="wl_unit_${index}"  style="display:none;">
	                		<option>%</option>
	                		<option>px</option>
	            		</select>
	        		</div>
	    		</div>
			</div>
	
			<div class="col-md-12 m-t-20 m-b-15 p-20" style="border: 1px solid rgba(255, 255, 255, 0.5); width: calc(100% - 29px); left: 15px;">
				<p style="position: absolute; top: -11px; background: #202932; padding: 0 10px;">게시판 선택</p>
				<div class="col-md-4 m-b-15">
					<select class="form-control input-sm selectOption" id="wl_categorys_select_${index}">
	    				            
	        		</select>
	        		<input type="hidden" class="form-control" id="wl_categorys_${index}" value="${resultMap.wl_categorys}">
	    		</div>
	    		
	    		<div class="col-md-3 m-b-15">
	        		<div class="btn btn-sm" id="category_add_${index}">게시판 추가</div>
	    		</div>
	    		<div id="boardGethering_${index}" class="col-md-12 m-t-10">
	        			<c:if test="${not empty resultMap}">
						${hn:getCategoryNames("board",resultMap.wl_categorys,index)}
						</c:if>
	        	</div>
	    		<div class="clearfix"></div>
			</div>
	
			<div class="col-md-12">
	    		<div class="m-b-15 col-md-2" style="top: 5px;">
	             	게시 형식 :
	         	</div>
	            <div class="col-md-5">
	            	<select class="form-control input-sm" id="wl_attribute_${index}">
	                	<option value="A">전체 게시물을</option>
	                	<option value="B">배너용 게시물을</option>
	                </select>
	            </div>
	            <div class="col-md-5">
	            	<select class="form-control input-sm" id="wl_sort_${index}">
	                   <option value="R">최신순으로 정렬 </option>
	                   <option value="F">인기순으로 정렬</option>
	                </select>
	         	</div>
			</div>
	
	     </div>
	     <div class="clearfix"></div>
	</div>
	
</div>
<input type="hidden" id="wl_idx_${index}" value="${idx}" />
</form>
<script>
$('#wl_link_idx_${index}').html($('#optionText').val());
$('#wl_categorys_select_${index}').html($('#optionText').val());
if($('#wl_idx_${index}').val()!=0){
	$('#wl_link_type_${index}').val('${resultMap.wl_link_type}');
	$('#wl_link_idx_${index}').val('${resultMap.wl_link_idx}');
	$('#wl_type_${index}').val('${resultMap.wl_type}');
	$('#wl_unit_${index}').val('${resultMap.wl_unit}');
	$('#wl_attribute_${index}').val('${resultMap.wl_attribute}');
	$('#wl_sort_${index}').val('${resultMap.wl_sort}');
}
$('#category_add_${index}').click(function(){
	if($('#wl_categorys_${index}').val().length==0){
			if($('#wl_categorys_select_${index}').val()!="") $('#wl_categorys_${index}').val($('#wl_categorys_select_${index}').val());
	}else{
			if($('#wl_categorys_select_${index}').val()!="") $('#wl_categorys_${index}').val($('#wl_categorys_${index}').val()+","+$('#wl_categorys_select_${index}').val());
	}
	var innerHtml="";
	innerHtml+="<div class=\"m-b-15 m-l-10 delCate_${index}\" id=\"del_"+$('#wl_categorys_select_${index}').val()+"\" style=\"float:left\">"	;
	innerHtml+="<div class=\"btn btn-sm\">";
	innerHtml+=$('#wl_categorys_select_${index} option:selected').text();
	innerHtml+="<span class=\"del\" onClick=\"layout.delCategorys("+$('#wl_categorys_select_${index}').val()+",${index})\"> ×</span>";
	innerHtml+="</div>";
	innerHtml+="</div>";
	$('#boardGethering_${index}').append(innerHtml);
});

</script>