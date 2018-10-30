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
</style>
<!-- carleder start -->
<div class="col-md-8 clearfix">
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
               	
<!-- carleder end -->
               	<div class="col-md-4">
                    <h4 class="m-l-5">최근 방송</h4>
                    <div class="listview narrow">
                   <c:choose>
					<c:when test="${empty lists }">
						<div class="media p-l-5">
							<div class="media-body"><a class="t-overflow">데이타가 없습니다.</a></div>
						</div>
					</c:when>
					<c:otherwise>
					<c:forEach items="${lists}" var="list" varStatus="loop">
                        <div class="media p-l-5">
                            <div class="pull-left">
                                <c:if test="${list.image_path ne ''}">
                                	<img width="40" src="${list.image_path}">
                                </c:if>
                            </div>
                            <div class="media-body">
                                <a href="javascript:calClick.viewEvent('${list.idx}');"><small class="text-muted">${hn:getLiveTimeExpress(list.start,list.end)}</small><br></a>
                                <a class="t-overflow" href="" style="margin-top:5px;">${list.name}</a>
                            </div>
                        </div>
                    	</c:forEach>
						</c:otherwise>
					</c:choose>
						
                    </div>
                   <!-- <div class="media p-5 text-center l-100">
       					${pagingStr}
        			</div>  --> 
                </div>
                 	<div class="pull-right">
	                   	<button type="button" class="btn btn-default icon" id="createEvent"><span>&#61940;</span> <span class="text">신규등록</span></button>
               		</div>

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
                    	$('#addNew-event form')[0].reset();
                    	menuJs.makeSelJstree();
                    	$('#addNew-event').modal('show');   
                        $('#order').val('insert');
                        if($('#order').val()=="update"){
                         	$("#deleteEvent").css('display','block');
              	 			$("#addEvent").val("수 정");
                        }else{
                         	$("#deleteEvent").css('display','none');
              	 			$("#addEvent").val("생방송 추가");
                        }
                        
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
                
                $('body').on('click', '#addEvent', function(){
                	
                	if($('#source_type').val()=='VOD'){
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
                	}
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
                    	 //공통 자막
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
                    	 //라이브 일 경우 필드 
                    	if($('#source_type').val()=='LIVE'){
                    		dataObject['live_ch_idx']=$('#live_ch_idx').val();
                        	dataObject['live_stream_url']=$("#live_stream_url").val();
                    		
                    	 }
                    	 //비디오 일 경우 필드
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
                    	 dataObject['order']=$('#order').val();
                    	 if($('#order').val()=="update"){
                    		 dataObject['idx']=$('#idx').val()
                    	 }
                    	 //console.log(dataObject);
                    	 $.ajax({
                    	 		url:'/cms/excute/stb-schedule/'+$("#order").val(),
                    	 		cache:false,
                    	 		type:'post',
                    	 		data:dataObject,
                    	 		async : false,
                    	 		success : function(result){
                            		$('#addNew-event form')[0].reset();
                                    $('#addNew-event').modal('hide');
                    	 			contents.naviBar('stb-schedule','', 'STB-SCHEDULE');
                    	 			menuJs.makeJsTree();
                    	 			menuJs.vodScheduleJstree();
                    	 			contents.list('');
                    	 		},
                    	 		error:exception.ajaxException
                    	 	});
                          //Event Name
                          /*var eventName = $('#eventName').val();
                          //Render Event
                          $('#calendar').fullCalendar('renderEvent',{
                               title: eventName,
                               url:'javascript:calClick.viewEvent(2);',
                               start: $('#getStart').val(),
                               end:  $('#getEnd').val(),
                               allDay: false,
                          },true ); //Stick the event*/
                          
                          
                     } 
                });
                
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
           
            $(function(){
            	 $("#createEvent").click(function(){
            		 $('#addNew-event form')[0].reset();
            		 $("#order").val('insert');
            		 if($('#order').val()=="update"){
                     	$("#deleteEvent").css('display','block');
          	 			$("#addEvent").val("수 정");
                     }else{
                     	$("#deleteEvent").css('display','none');
          	 			$("#addEvent").val("생방송 추가");
                     }
            		menuJs.makeSelJstree();
                 	$('#addNew-event').modal('show');   
                    $('#source_type').val('LIVE');
                     var start = new Date();
                     var end=new Date(Date.parse(start)+60*1000*10);
                     var hs = common.formatZeroDate(start.getHours(),2);
                     var ms = common.formatZeroDate(start.getMinutes(),2);
                     var he = common.formatZeroDate(end.getHours(),2);
                     var me = common.formatZeroDate(end.getMinutes(),2);
                     $('#getStart').val($.datepicker.formatDate('yy-mm-dd '+hs+':'+ms, new Date()));
                     $('#getEnd').val($.datepicker.formatDate('yy-mm-dd '+he+':'+me, new Date()));
                 });
            });
       </script>