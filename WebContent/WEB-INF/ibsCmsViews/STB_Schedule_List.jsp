<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<style>
    .label-pink {background-color: #ffa2cd;}
    .label-puple {background-color: #6e00ff;}
    .label-black {background-color: #000;}
    .label-gray {background-color: #8c8c8c;padding:1px;}
    .label-brown {background-color: #4a1824;}
    .label-green {background-color: #217724;padding:2px;}
    .label-new {background-color: #dc0000;}
     li.round {border-radius: 17px !important; background: rgba(0, 112, 255, 0.13); border: 1px solid rgba(0, 0, 0, 0.31); color: #fff; list-style: none; display: inline-block; padding: 6px 12px; font-size: 14px; line-height: 1.42857143;}
</style>
<script>
console.log("-------------------------------------------------");
</script>
<!-- carleder start -->
<div class="col-md-12 clearfix">
	<div class="text-center m-t-10 m-b-10">
		<ul>
	    <c:choose>
	    	<c:when test="${empty targetLists}">
	    			<li class="round m-r-5">방송 그룹이 없습니다.</li>
	    	</c:when>
	    	<c:when test="${internet=='true' and stbAll=='true'}">
	    			<li class="round m-r-5">인터넷 방송</li>
	    			<li class="round m-r-5">OTT 전체</li>
	    	</c:when>
	    	<c:when test="${internet=='false' and stbAll=='true'}">
	    			<li class="round m-r-5">OTT 전체</li>
	    	</c:when>
	    	<c:otherwise>
	    	<c:forEach items="${targetLists}" var="targetList" varStatus="loop">
	    		<li class="round m-r-5">${targetList.target_name }</li>
		    </c:forEach>
		   </c:otherwise>
		 </c:choose>
		 </ul>
	</div>
	<div id="calendar" class="p-relative p-5 m-b-10">
        <!-- Calendar Views -->
        <ul class="calendar-actions list-inline clearfix">
            <li class="p-r-0">
                <a data-view="month" href="#" class="tooltips" title="Month">
                    <i class="sa-list-month"></i>
                </a>
            </li>
            <li class="p-r-0">
                <a data-view="agendaWeek" href="#" class="tooltips" title="Week">
                    <i class="sa-list-week"></i>
                </a>
            </li>
            <li class="p-r-0">
                <a data-view="agendaDay" href="#" class="tooltips" title="Day">
                    <i class="sa-list-day"></i>
                </a>
            </li>
        </ul>
    </div>
</div>
 <div class="clearfix"></div>            	
<!-- carleder end -->
		<script type="text/javascript">
            $(document).ready(function() {
            	var events=eval("[${events}]");
                $('#calendar').fullCalendar({
                    header: {
                         center: 'title',
                         left: 'prev, next',
                         right: ''
                    },

                    selectable: true,
                    selectHelper: true,
                    editable: true,
                    events: events,
                     
                    //On Day Select
                    select: function(start, end, allDay) {
                    	$('#addNew-event').modal('show'); 
                    	$('#addNew-event form')[0].reset();
                    	 $('#order').val('insert');
                    	/*menuJs.makeSelJstree();
                    	$('#addNew-event').modal('show');   
                        $('#order').val('insert');
                        if($('#order').val()=="update"){
                         	$("#deleteEvent").css('display','block');
              	 			$("#addEvent").val("수 정");
                        }else{
                         	$("#deleteEvent").css('display','none');
              	 			$("#addEvent").val("생방송 추가");
                        }
                        */  
                    	var selStart = new Date(start);
                        var selEnd=new Date(end);
                        var hs = common.formatZeroDate(selStart.getHours(),2);
                        var ms = common.formatZeroDate(selStart.getMinutes(),2);
                        var he = common.formatZeroDate(selEnd.getHours(),2);
                        var me = common.formatZeroDate(selEnd.getMinutes(),2);
                        
                        $('#getStart').val($.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,start));
                        $('#getEnd').val($.datepicker.formatDate('yy-mm-dd '+he+':'+me,end)); 
                    },
                     
                    eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
                       if(dayDelta!=0||minuteDelta!=0){
                   		var updateStart=event.start;
							var hs = common.formatZeroDate(updateStart.getHours(),2);
                           var ms = common.formatZeroDate(updateStart.getMinutes(),2);
                           updateStart=$.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,updateStart);
							var updateEnd=event.end;
							var he = common.formatZeroDate(updateEnd.getHours(),2);
                           var me = common.formatZeroDate(updateEnd.getMinutes(),2);
                           updateEnd=$.datepicker.formatDate('yy-mm-dd '+he+':'+me,updateEnd);
                   		}
                       var result=calClick.updateScheduleDate(event.idx,updateStart,updateEnd);
                       if(result!="success"){
                    	   revertFunc();
                       }
                        $('#eventInfo').html(info);
                		$('#editEvent #editCancel').click(function(){
                             revertFunc();
                        }) 
                    },
                    eventDrop:function(event,dayDelta,minuteDelta,revertFunc){
                    	//날짜계산
                    	if(dayDelta!=0||minuteDelta!=0){
                    		var updateStart=event.start;
							var hs = common.formatZeroDate(updateStart.getHours(),2);
                            var ms = common.formatZeroDate(updateStart.getMinutes(),2);
                            updateStart=$.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,updateStart);
							var updateEnd=event.end;
							var he = common.formatZeroDate(updateEnd.getHours(),2);
                            var me = common.formatZeroDate(updateEnd.getMinutes(),2);
                            updateEnd=$.datepicker.formatDate('yy-mm-dd '+he+':'+me,updateEnd);
                    	}
                    	var result=calClick.updateScheduleDate(event.idx,updateStart,updateEnd);
                    	if(result!="success"){
                     	   revertFunc();
                        }
                    	 //$('#eventInfo').html(info);
                    	//해당 id에 없데이트 
                    	//$('#calendar').fullCalendar('removeEvents',event._id);
                    	//$('#calendar').fullCalendar('removeEventSources');
                    	//$('#calendar').fullCalendar('refetchEvents');
                    }
                });
                
                $('body').on('click', '#addEvent', function(ev){
                	$.blockUI({ message: '<h1> Loading...</h1>' });
                	/*if($('#source_type').val()=='VOD'){
                		var optionCount=$('#vodSource > option').length;
                		if(optionCount==0){
                    		jQuery('#vodSource').validationEngine('showPrompt', 'VOD 영상소스를 선택하세요.', 'pass');
                    		return;
                    	}else{
                    		jQuery('#vodSource').validationEngine('hideAll');
                    	}
                    	var vodArray=[];
                    	for(var i=0;i<optionCount;i++){
                    		vodArray.push($('#vodSource > option:eq('+i+')').val());
                    	}
                    	$("#vodArr").val('');
                    	$("#vodArr").val(vodArray);
                	}*/
                	
                	if($("#captionYn").val()=="Y"){
                		if($('#caption').val().length==0||$('#caption_text_color').val().length==0){
                			jQuery('#caption').validationEngine('showPrompt', '자막 내용과 자막 색상을 입력해주세요.', 'pass');
                			return;
                		}else{
                			jQuery('#caption').validationEngine('hideAll');
                		}
                	}
                	if($('#source_type').val()=='LIVE'){
                		if($('#live_stream_url').val().length==0){
                			jQuery('#live_stream_url').validationEngine('showPrompt', '라이브 채널을 선택 해 주세요.', 'pass');
                			return;
                		}else{
                			jQuery('#live_stream_url').validationEngine('hideAll');
                		}
                	}
                	
                     var eventForm =  $(this).closest('.modal').find('.form-validation');
                     eventForm.validationEngine('validate');
                     if (!(eventForm).find('.formErrorContent')[0]) {
                    	
                    	 var dataObject={};
                    	
                    	 if($("#captionYn").val()=="Y"){
                    		dataObject['caption']=$('#caption').val();
                   		 	dataObject['caption_size']=$("#caption_size").val();
                   		 	dataObject['caption_speed']=$("#caption_speed").val();
                   		 	dataObject['caption_text_color']=$("#caption_text_color").val();
                   		 	dataObject['caption_bg_color']=$("#caption_bg_color").val();
                    	 }else{
                    		 dataObject['caption']='';
                    		 dataObject['caption_size']='';
                    		 dataObject['caption_speed']='';
                    		 dataObject['caption_text_color']='';
                    		 dataObject['caption_bg_color']='';
                    	 }
                    	
                    	if($('#source_type').val()=='LIVE'){
                    		dataObject['live_ch_idx']=$('#live_ch_idx').val();
                        	dataObject['live_stream_url']=$("#live_stream_url").val();
                    		
                    	 }
                    	
                    	if($('#source_type').val()=='VOD'){
                    		dataObject['vodArr']=$('#vodArr').val();
                    	}
                    	 dataObject['name']=$('#eventName').val();
                    	 dataObject['start']=$("#getStart").val();
                    	 dataObject['end']=$("#getEnd").val();
                    	 dataObject['target_type']='GROUP';
                    	 dataObject['source_type']=$("#source_type").val();
                    	 dataObject['image_path']=$("#image_path").val();
                    	 dataObject['color']=$("#color").val();
                    	 dataObject['desc_text']=$("#desc_text").val();
                    	 dataObject['groupArr']=$("#groupArr").val();
                    	 dataObject['captionYn']=$('#captionYn').val();
                    	 dataObject['category_idx']=$('#categoryIdx').val();
                    	 dataObject['order']=$('#order').val();
                    	 if($('#order').val()=="update"){
                    		 dataObject['idx']=$('#idx').val();
                    	 }
                    	 console.log(dataObject);
							$.ajax({
	                    	 		url:'/cms/excute/stb-schedule/'+$("#order").val(),
	                    	 		type:'post',
	                    	 		data:dataObject,
	                    	 		async:false,
	                    	 		success : function(result){
	                            		//$('#addNew-event form')[0].reset();
	                                    $('#addNew-event').modal('hide');
	                    	 			//contents.naviBar('stb-schedule','', 'STB-SCHEDULE');
	                    	 			//menuJs.makeJsTree();
	                    	 			//menuJs.vodScheduleJstree();
	                    	 			//arange.list($("#categoryIdx").val());
	                                    var insertedEvent={
	                   	 					 	title: $('#eventName').val(),
	                                         	url:'javascript:calClick.viewEvent(result);',
	                                            start: $('#getStart').val(),
	                                            end:  $('#getEnd').val(),
	                                            allDay: false	
	                       	 			};
	                       	 			$('#calendar').fullCalendar('renderEvent',insertedEvent);
									},
	                    	 		error:exception.ajaxException
	                    	 	});
                    	 }
                    
                });
                $.unblockUI(); 
            });    
           
            //Calendar views
            $('body').on('click', '.calendar-actions > li > a', function(e){
                e.preventDefault();
                var dataView = $(this).attr('data-view');
                $('#calendar').fullCalendar('changeView', dataView);
                //Custom scrollbar
                var overflowRegular, overflowInvisible = false;
                overflowRegular = $('.overflow').niceScroll();     
            });                    
       </script>
       