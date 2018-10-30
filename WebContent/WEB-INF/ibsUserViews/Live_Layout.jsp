<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserJs/schedule/bootstrap.min.css">
<link  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserJs/schedule/bootstrap-datetimepicker.css">
<link  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserJs/schedule/pitscheduler.min.css">
<link  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsUserJs/schedule/demo.css">
<div id="page" class="sub">
	<div class="quick_contents" id="liveView" style="display:none;">
		<div class="video" id="schImg">
			<!-- 비디오영역 -->
			<!-- <img src="${pageContext.request.contextPath}/REPOSITORY/SCHIMG/20180319125436.jpg" /> -->
		</div>
		<div class="right">
			<p class="chanel" id="channel"></p>
			<div class="weather">
				
			</div>
			<h3 id="title"></h3>
			<p class="time">방송 시간 : <span id="time"></span></p>
			<br />
			<p >
				방송 안내 :<br /> <span id="desc"></span>
			</p>
		</div>
	</div>
	
</div>
<div class="main-container container-fluid row" style="padding-top:50px;" >
    <div class="demo-container">
        <div id="pit-scheduler"></div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/ibsUserJs/schedule/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/ibsUserJs/schedule/moment-with-locales.min.js"></script>
<script src="${pageContext.request.contextPath}/ibsUserJs/schedule/bootstrap-datetimepicker.js"></script>
<script src="${pageContext.request.contextPath}/ibsUserJs/schedule/pitscheduler.js"></script>
<script>
	var common={
			formatZeroDate:function(n, digits){
				 var zero = '';
				    n = n.toString();
				    if (digits > n.length) {
				        for (var i = 0; digits - n.length > i; i++) {
				            zero += '0';
				        }
				    }
				    return zero + n;
			},
			delJsPlayer:function(){     
				console.log('delPlayer');
				if (videojs.getPlayers()['livePlayer']) {
					var oldPlayer = document.getElementById('livePlayer');
					videojs(oldPlayer).dispose();
				}
			}
	};
	var StringNowDate=new Date(jQuery.now());
	var hs = common.formatZeroDate(StringNowDate.getHours(),2);
    var ms = common.formatZeroDate(StringNowDate.getMinutes(),2);
    console.log($.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,StringNowDate));
    var dateNow=$.datepicker.formatDate('yy-mm-dd '+hs+':'+ms,StringNowDate);
    var users;
    var tasks;
    $.ajax({
		url : "${pageContext.request.contextPath}/user/channelTask",
		cache : false,
		type : 'post',
		async : false,
		success : function(responseData){
			var data = JSON.parse(responseData);
			users=data.tasks;
			tasks=data.detail;
		},
		error : common.ajaxException
	});
    $(document).ready(function () {
        $("#pit-scheduler").pitScheduler({
            locale: 'en',
            defaultDisplay: 'days',
            hideEmptyLines: true,
            disableLabelsMovement: false,
            defaultGroupName: 'Default group',
            defaultDate: dateNow,
            disableNotifications: true,
            notificationDuration: 4000,
            hideSpinner: true,
            onChange: '',
            onTaskCreation: '',
            onUserCreation: '',
            onTaskRemoval: '',
            onUserRemoval: '',
            onUserEdition: '',
            onTaskAssignation: '',
            onUserTaskDeletion: '',
            onTaskEdition: '',
            disableUndo: false,
            resizeTask: false,
            tasks:  tasks,
            users: users
                   
        });

    });

</script>
