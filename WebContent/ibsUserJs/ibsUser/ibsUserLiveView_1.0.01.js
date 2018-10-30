var UserLiveApp ={
		
		slidePositionIndex : 0, // 테이블 시간 화살표 움직임 
		CalendarIndex : 0,   //  날짜 화살표 움직임
		Now : new Date(), 
		gEND 	: "",  // 동영상 끝나는 시간 담아주는곳
		gStartSecond	: "", // 동영상 시작나는 시간 담아주는곳
		gVodChannel : null, //현재 채널 데이터 리스트
		gVodCnt : 0, // VOD인경우 몇번의 동영상 총 개수
		gChannelIdx : 0, // 동영상 시간 끝나고 리플래쉬 될때, 현재 채널방송 유지시키기위한 idx;
		gLiveChIdx : 0,
		gSeconds : 0,
		gStart   : 0 ,
		
		
		
		// 메인 화면 그리기
		contents : function(vFlug,vIdx){
			
			$(".quick_contents").empty();
			var vChannel = UserLiveApp.Channel(vFlug,vIdx);
			var vNow = UserLiveApp.Now.getFullYear()+"."+IBSUtil.getDate(UserLiveApp.Now.getMonth()+1)+"."+IBSUtil.getDate(UserLiveApp.Now.getDate())+"  ";
			var vList = [];
			var vCount = 0;
			if(vChannel.length == 0){
				vList[vCount++] =  ' 	<div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left" style="width:100%;height:100%; background-size: cover;"> ';
				vList[vCount++] = '	      <div class="video">';
				vList[vCount++] =  ' 			<video id="my-player_01" class="video-js" controls autoplay  preload="auto"  poster="'+UserTopApp.request+'/ibsUserImg/img_nosianal.png" data-setup="{}" style="width: 100% !important; height: 100% !important;">';
				vList[vCount++] =  ' 					<source src="" type="application/x-mpegURL">';
				vList[vCount++] =  ' 			</video>';
				vList[vCount++] =  ' 		</div>';
				vList[vCount++] = '		</div>';

				vList[vCount++] = '	<div class="right">';
				vList[vCount++] = '		<p class="chanel">';
				vList[vCount++] = 				'방송 시간이 없습니다.';
				vList[vCount++] = '				<img src="'+UserTopApp.request+'/ibsUserImg/img_web.png" alt="WEB" /> ';
				vList[vCount++] = '				<img src="'+UserTopApp.request+'/ibsUserImg/img_app.png" alt="APP" />';
				vList[vCount++] = '				<img src="'+UserTopApp.request+'/ibsUserImg/img_tv.png" alt="TV"/> ';
				vList[vCount++] = '		</p>';
				vList[vCount++] = '		<div class="weather">';
				vList[vCount++] = '		<span>'+vNow+'  </span><span id ="weather"></span>';
				vList[vCount++] = '		</div>';
				vList[vCount++] = '	</div>';
				
				$('.quick_contents').append(vList.join('')); 
				
			}else{
				
				UserLiveApp.gChannelIdx = vChannel[0].IDX;
				UserLiveApp.gLiveChIdx = vChannel[0].LIVE_CH_IDX;
				UserLiveApp.gVodChannel = vChannel;
				UserLiveApp.gEND = vChannel[0].END_HI;
				UserLiveApp.gStartSecond = vChannel[0].START_SC;
				UserLiveApp.gStart = vChannel[0].START_HI;
				
				if(vChannel[0].SOURCE_TYPE == "LIVE"){
					vList[vCount++] =  ' 	<div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left" style="width:100%;height:100%; background-size: cover;"> ';
					vList[vCount++] = '	      <div class="video">';
					vList[vCount++] =  ' 			<video id="my-player_01" class="video-js" controls autoplay  preload="auto" poster="'+UserTopApp.request+'/ibsUserImg/img_nosianal.png" data-setup="{}" style="width: 100% !important; height: 100% !important;">';
					vList[vCount++] =  ' 					<source src="'+vChannel[0].LIVE_STREAM_URL+'" type="application/x-mpegURL">';
					vList[vCount++] =  ' 			</video>';
					vList[vCount++] =  ' 		</div>';
					vList[vCount++] = '		</div>';

				}else if(vChannel[0].SOURCE_TYPE == "VOD"){
					vList[vCount++] =  ' 	<div class="vodPlay"></div> ';
				}
				vList[vCount++] = '	<div class="right">';
				vList[vCount++] = '		<p class="chanel">';
				vList[vCount++] = 				vChannel[0].CH_NAME	 
				vList[vCount++] = '				<img src="'+UserTopApp.request+'/ibsUserImg/img_web.png" alt="WEB" /> ';
				vList[vCount++] = '				<img src="'+UserTopApp.request+'/ibsUserImg/img_app.png" alt="APP" />';
				vList[vCount++] = '				<img src="'+UserTopApp.request+'/ibsUserImg/img_tv.png" alt="TV"/> ';
				vList[vCount++] = '		</p>';
				vList[vCount++] = '		<div class="weather">';
				vList[vCount++] = '		<span>'+vNow+'   </span><span id ="weather"></span>';
				vList[vCount++] = '		</div>';
				vList[vCount++] = '		<h3>'+vChannel[0].NAME+'</h3>';
				vList[vCount++] = '		<p class="time" style ="font-size: 14px;">방송 시간 : '+vChannel[0].START+' ~ '+vChannel[0].END+'</p>';
				vList[vCount++] = '		<br />';
				vList[vCount++] = '		<p>';
				vList[vCount++] = '			방송 안내 :<br /> '+vChannel[0].NAME+'';
				vList[vCount++] = '		</p>';
				vList[vCount++] = '	</div>';
	
				
				
				$('.quick_contents').append(vList.join('')); 
				
				
				if(vChannel[0].SOURCE_TYPE == "VOD"){
					UserLiveApp.videoPlayer("START",vFlug);
				}else{
					UserLiveApp.liveEndPlayer();
				}
			}
		
			{
				UserLiveApp.printClock();
				if(vFlug == "TITLE"){ 
					UserLiveApp.RePlayClock();
				}
				
			}
		},
	
		// VOD인경우에는 반복재생해야되서 삭제 후 다시 그려줘야함.
		videoPlayer : function(vFlug,newFlug){

			$(".vodPlay").empty();
			var oData = UserLiveApp.VodChannel(UserLiveApp.gChannelIdx);
			
			if(vFlug != "END" && oData != null && newFlug != "liveView"){
				console.log(vFlug != "END" && oData != null && newFlug != "liveView");
				UserLiveApp.videoStartPlayer(oData);
			}
			if(oData != null){
				var vList = [];
				var vCount = 0
				vList[vCount++] =  ' 		<div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left" style="width:100%;height:100%; background-size: cover;"> ';
				vList[vCount++] = '	     	 	<div class="video">';
				vList[vCount++] =  ' 				<video id="my-player_02" class="video-js listPlayer" controls autoplay preload="auto"  poster="'+UserTopApp.request+'/ibsUserImg/img_nosianal.png"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
				vList[vCount++] =  ' 						<source  src="'+oData[UserLiveApp.gVodCnt].VOD_PATH+'"  type="application/x-mpegURL"></source>';
				vList[vCount++] =  ' 				</video>';
				vList[vCount++] =  ' 			</div>';
				vList[vCount++] = '			</div>';

/*				vList[vCount++] =  ' <div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left" ';
				vList[vCount++] =  ' 	style="width:100%;height:100%; background-size: cover; background: url('+oData[UserLiveApp.gVodCnt].MAIN_THUMBNAIL+') no-repeat center;">';
				vList[vCount++] =  ' 		<video id="my-player_01" class="video-js listPlayer" controls autoplay preload="auto"  poster="'+oData[UserLiveApp.gVodCnt].VOD_PATH+'" data-setup="{}" style="width: 100% !important; height: 100% !important;">';
				vList[vCount++] =  ' 			<source  src="'+oData[UserLiveApp.gVodCnt].VOD_PATH+'"  type="application/x-mpegURL"></source>';
				vList[vCount++] =  ' 		</video>';
				vList[vCount++] =  ' </div>';*/
				
				$('.vodPlay').append(vList.join('')); 

			}
				
			
	
			{
				UserLiveApp.videoEndPlayer(oData,vFlug,newFlug);
			}

		},
		
		
		videoStartPlayer : function(oData){
			
			UserLiveApp.gSeconds = 0;
			UserLiveApp.gVodCnt = 0;
			var vTime = 0 ;
			//현재 시간 - 시작시간
			var vTodayTimeSecond = (oData[0].TODAY - UserLiveApp.gStartSecond ) ;
			var vTodayTimeSecondCnt = Math.round(vTodayTimeSecond);
			// (현재시간 - 시작시간 ) / 영상 개수의 총 시간 : 초로 변환 > 값 : 나머지를 구한다.
			var vSeconds = (vTodayTimeSecond%oData[0].SUM); 
			
			//남은시간이 첫번째 영상보다 작으면 첫번째영상을 보여주고 초는 나머지초로 세팅
			if(vSeconds < oData[0].SECOND){
				UserLiveApp.gSeconds = vSeconds;  
				UserLiveApp.gVodCnt = 0;
			}else{
				// 첫번째 영상보다 크면 for문 돌려 초를 계산한다.
				for(var i = 0 ; i < oData.length ; i++){
					if(i == 0){
						if(vSeconds > oData[i].SECOND){
							vTime = vSeconds - oData[i].SECOND;
							UserLiveApp.gVodCnt++;
						}
					}else{
						if( vTime > oData[i].SECOND){
							vTime = vTime - oData[i].SECOND;
							UserLiveApp.gVodCnt++;
						}else{
							break;
						}
					}
				}
				UserLiveApp.gSeconds = vTime;
				
				
			}
		},
		
		liveEndPlayer : function(){ 
			
			var video = videojs('#my-player_01').ready(function(){
				
				var player = this;
				
					// 비디오 에러난경우 다시 호출
				player.on('error', function(e) {  
					$(".vjs-error-display").css("display","none");
					$(".vjs-modal-dialog-content").css("display","none");
				});
			}); 

		},
		
		
		// 비디오 이벤트
		videoEndPlayer : function(oData,vFlug,newFlug){ 
			
			var video = videojs('#my-player_02').ready(function(){
				$(".vjs-progress-holder").css("display","none");
				$(".vjs-progress-holder").unbind(); 
				
				var player = this;
				
				if(vFlug != "END" && oData != null && newFlug != "liveView"){
					
					player.currentTime(UserLiveApp.gSeconds);	
				}
				// 비디오 끝난경우 이벤트
				player.on('ended', function() {
					if (videojs.getPlayers()['my-player_02']) {
						delete videojs.getPlayers()['my-player_02'];
					} 
					if (videojs.getPlayers()['my-player_01']) {
						delete videojs.getPlayers()['my-player_01'];
					} 
					if(oData[0].MAX == UserLiveApp.gVodCnt){
						UserLiveApp.gVodCnt = 0;
					}else{
						UserLiveApp.gVodCnt++;
					}
					
					UserLiveApp.videoPlayer("END");

				});
				// 비디오 에러난경우 다시 호출
				player.on('error', function(e) {  
					$(".vjs-error-display").css("display","none");
					$(".vjs-modal-dialog-content").css("display","none");
					UserLiveApp.contents("liveView",UserLiveApp.gLiveChIdx);
				});
			}); 

		},
		
		
		//스캐쥴 표 그리기
		scheduleSetting : function(vFlug,vDay){
			
			$(".stt_all_w").empty();
			
			var vList = [];
			var vCount = 0;
			var vChannelData = UserLiveApp.ChannelData();
			var vCalendarDate = UserLiveApp.CalendarDate();
				
			vList[vCount++] = ' <div class="stt_day_top">';
			vList[vCount++] = ' 	<p class="stt_tday">';
			vList[vCount++] = ' 		<span class="stt_todaynum_w"><strong class="stt_tnum">'+vCalendarDate[0].DATE+'</strong>';
			vList[vCount++] = ' 			<span class="stt_txt">('+vCalendarDate[0].WEEK+')</span></span>';
			vList[vCount++] = ' 		<button type="button" class="b_sttday_prev" id="'+vCalendarDate[0].PREV+'" title="이전">';
			vList[vCount++] = ' 			<em class="mdm_prevday"><i class="ir">이전날</i></em>';
			vList[vCount++] = ' 		</button>';
			vList[vCount++] = ' 		<button type="button" class="b_sttday_next" id ='+vCalendarDate[0].NEXT+' title="다음">';
			vList[vCount++] = ' 			<em class="mdm_nextday"><i class="ir">다음날</i></em>';
			vList[vCount++] = ' 		</button>';
			vList[vCount++] = ' 	</p>';
			vList[vCount++] = ' 	<button type="button" class="b_sttday_today" title="오늘">';
			vList[vCount++] = ' 		<em class="sttd_today"><i class="ir">오늘</i></em>';
			vList[vCount++] = ' 	</button>';
			vList[vCount++] = ' 	<button type="button" id="btnCalendar" class="b_sttcal" title="달력보기">';
			vList[vCount++] = ' 		<em class="sttd_cal"><i class="ir">달력보기</i></em>';
			vList[vCount++] = ' 	</button>';
			vList[vCount++] = ' 	<!-- 달력 -->';
			vList[vCount++] = ' 	<div class="sbsmd_cal_w" id="schedule"></div>';
			vList[vCount++] = ' </div>';
			vList[vCount++] = ' <div class="stt_table_w">';
			vList[vCount++] = ' 	<div class="stt_tquick">';
			vList[vCount++] = ' 		<span class="sttq_tit">방송시간</span>';
			vList[vCount++] = ' 		<div class="btn_stttime_w">';
			vList[vCount++] = ' 			<button type="button" class="btn_stt_am" id = "btn_stt_am" title="AM"">';
			vList[vCount++] = ' 				<i class="ir">AM</i>';
			vList[vCount++] = ' 			</button>';
			vList[vCount++] = ' 			<button type="button" class="btn_stt_pm" id = "btn_stt_pm" title="PM">';
			vList[vCount++] = ' 				<i class="ir">PM</i>';
			vList[vCount++] = ' 			</button>';
			vList[vCount++] = ' 		</div>';
			vList[vCount++] = ' 		<ul class="stt_tquick_channel">';
			for(var j = 0 ; j < vChannelData.length; j++){
				vList[vCount++] = ' 			<li><a>'+vChannelData[j].LIVE_TITLE+'</a></li>';
			}
			vList[vCount++] = ' 		</ul>';
			vList[vCount++] = ' 	</div>';
			vList[vCount++] = ' 	<h5 class="hide">SBS 전체 2018.03.09 편성표</h5>';
			vList[vCount++] = ' 	<div class="stt_table_cont">';
			vList[vCount++] = ' 		<table class="stt_table" style="left: 0px; overflow: hidden">';
			vList[vCount++] = ' 			<!--3시간씩 움직일경우 -792px-->';
			vList[vCount++] = ' 			<caption class="hide">SBS, SBS Plus, SBS Sports</caption>';
			vList[vCount++] = ' 			<colgroup>';
			vList[vCount++] = ' 					<col width="264px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
			vList[vCount++] = ' 					<col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/><col width="22px"/>';
	        vList[vCount++] = ' 			</colgroup>';
			vList[vCount++] = ' 			<thead>';
			vList[vCount++] = ' 				<tr>';
			vList[vCount++] = ' 						<th scope="row">방송시간</th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">12:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">01:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">02:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">03:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">04:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">05:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">06:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">07:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">08:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">09:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">10:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">11:00</strong>AM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">12:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">01:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">02:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">03:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">04:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">05:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">06:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">07:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">08:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">09:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">10:00</strong>PM</div></th>';
			vList[vCount++] = ' 						<th scope="col" colspan="12"><div class="stt_time_w"><strong class="stt_timenum">11:00</strong>PM</div></th>';
	        vList[vCount++] = ' 				</tr>';
			vList[vCount++] = ' 			</thead>';
			vList[vCount++] = ' 			<tbody>';
			var vChannel = null;
			for(var j = 0 ; j < vChannelData.length; j++){ //채널
				if(UserLiveApp.gLiveChIdx == ""){
					UserLiveApp.gLiveChIdx = vChannelData[0].IDX;
				}
				if(vFlug== "NEXT" || vFlug == 'PREV'){
					vChannel = UserLiveApp.Channel(vFlug,vDay);
				}else{
					vChannel = UserLiveApp.Channel(vFlug,vChannelData[j].IDX);	
				}
				
				var vColSpan = 0;
				vList[vCount++] = ' 			<tr><th scope="row">SBS</th>';
				if(vChannel.length){
					for(var i = 0 ; i < vChannel.length ; i++){
						if(vChannel[i].LIVE_CH_IDX == vChannelData[j].IDX ){
					
							if(i == 0 && (vChannel[0].START_HI != "00:00")){
								var vStartSplit = vChannel[0].START_HI.split(":");
								var vStart = (Number(vStartSplit[0])*60) + Number(vStartSplit[1]);
								var vRow = vStart/5;
								
								vColSpan = vColSpan+vRow;
								
								if(vRow < 3){ 
									vList[vCount++] = ' <td colspan="'+vRow+'" class="stt_ellipsis">';
									vList[vCount++] = ' 	<div class="stt_cont_w">';
									vList[vCount++] = ' 		<span class="stt_pro_link" id ="9999999"> ';
									vList[vCount++] = ' 			<strong class="sttpl_pname">방송시간이 없습니다.</strong>';
									vList[vCount++] = ' 		</span>';
									vList[vCount++] = ' 		<div id="detail_'+i+'" class="stt_pro_detail" style="display: none;">';									
									vList[vCount++] = ' 			<span class="stt_pro_link" id = "9999999" > <span class="sttpl_time"></span>';
									vList[vCount++] = ' 				<strong class="sttpl_pname">방송시간이 없습니다.</strong> ';
									vList[vCount++] = ' 				<span class="stt_icn_hd">LIVE</span>';
									vList[vCount++] = ' 			</span>';
									vList[vCount++] = ' 		</div>';
									vList[vCount++] = ' 		<i class="stt_page"></i>';
									vList[vCount++] = ' 	</div>';
									vList[vCount++] = ' </td>';
								}else{
									vList[vCount++] = ' <td colspan="'+vRow+'">';
									vList[vCount++] = ' 	<div class="stt_cont_w">';
									vList[vCount++] = ' 		<span class="stt_pro_link" id ="9999999"> <span class="sttpl_time"></span>';
									vList[vCount++] = ' 			<strong class="sttpl_pname">방송시간이 없습니다.</strong> ';
									vList[vCount++] = ' 		</span>';
									vList[vCount++] = ' 	</div>';
									vList[vCount++] = ' </td>';
										
								}
									
							
							}else if((i != 0 && vChannel.length != i )&& (i != 0 && (vChannel[i-1].END_HI != vChannel[i].START_HI))){
								var vEndSplit = vChannel[i-1].END_HI.split(":");
								var vEnd = (Number(vEndSplit[0])*60) + Number(vEndSplit[1]);
								
								var vStartSplit = vChannel[i].START_HI.split(":");
								var vStart = (Number(vStartSplit[0])*60) + Number(vStartSplit[1]);
								var vRow = vStart - vEnd;
								vRow = vRow/5;
								
								vColSpan = vColSpan+vRow;
								
								if(vRow < 3){
									vList[vCount++] = ' <td colspan="'+vRow+'" class="stt_ellipsis">';
									vList[vCount++] = ' 	<div class="stt_cont_w">';
									vList[vCount++] = ' 		<span class="stt_pro_link" id ="9999999"> ';
									vList[vCount++] = ' 			<strong class="sttpl_pname">방송시간이 없습니다.</strong>';
									vList[vCount++] = ' 		</span>';
									vList[vCount++] = ' 		<div id="detail_'+i+'" class="stt_pro_detail" style="display: none;">';									
									vList[vCount++] = ' 			<span class="stt_pro_link" id = "9999999" > <span class="sttpl_time"></span>';
									vList[vCount++] = ' 				<strong class="sttpl_pname">방송시간이 없습니다.</strong> ';
									vList[vCount++] = ' 				<span class="stt_icn_hd">LIVE</span>';
									vList[vCount++] = ' 			</span>';
									vList[vCount++] = ' 		</div>';
									vList[vCount++] = ' 		<i class="stt_page"></i>';
									vList[vCount++] = ' 	</div>';
									vList[vCount++] = ' </td>';
								}else{
									vList[vCount++] = ' <td colspan="'+vRow+'">';
									vList[vCount++] = ' 	<div class="stt_cont_w">';
									vList[vCount++] = ' 		<span class="stt_pro_link" id ="9999999"> <span class="sttpl_time"></span>';
									vList[vCount++] = ' 			<strong class="sttpl_pname">방송시간이 없습니다.</strong> ';
									vList[vCount++] = ' 		</span>';
									vList[vCount++] = ' 	</div>';
									vList[vCount++] = ' </td>';	
								}
								
								
							}
							
							if(vChannel[i].ROW < 3){
								vColSpan = vColSpan+vChannel[i].ROW;
								
								vList[vCount++] = ' <td colspan="'+vChannel[i].ROW+'" class="stt_ellipsis">';
								vList[vCount++] = ' 	<div class="stt_cont_w">';
								vList[vCount++] = ' 		<span class="stt_pro_link" id ='+vChannel[i].IDX+'> ';
								vList[vCount++] = ' 			<span class="sttpl_time">'+vChannel[i].START_HI+'</span>'; 
								vList[vCount++] = ' 			<strong class="sttpl_pname">'+vChannel[i].NAME+'</strong>';
								vList[vCount++] = ' 		</span>';
								vList[vCount++] = ' 		<div id="detail_'+i+'" class="stt_pro_detail" style="display: none;">';									
								vList[vCount++] = ' 			<span class="stt_pro_link" id ='+vChannel[i].IDX+' > <span class="sttpl_time">'+vChannel[i].START_HI+'</span>';
								vList[vCount++] = ' 				<strong class="sttpl_pname">'+vChannel[i].NAME+'</strong> ';
								vList[vCount++] = ' 				<span class="stt_icn_hd">LIVE</span>';
								vList[vCount++] = ' 			</span>';
								vList[vCount++] = ' 		</div>';
								vList[vCount++] = ' 		<i class="stt_page"></i>';
								vList[vCount++] = ' 	</div>';
								vList[vCount++] = ' </td>';
							}else{
								vColSpan = vColSpan+vChannel[i].ROW;
								vList[vCount++] = ' <td colspan="'+vChannel[i].ROW+'">';
								vList[vCount++] = ' 	<div class="stt_cont_w">';
								vList[vCount++] = ' 		<span class="stt_pro_link" id ='+vChannel[i].IDX+'> <span class="sttpl_time">'+vChannel[i].START_HI+'</span>';
								vList[vCount++] = ' 			<strong class="sttpl_pname">'+vChannel[i].NAME+'</strong> ';
								vList[vCount++] = ' 			<span class="stt_icn_hd">LIVE</span>';
								vList[vCount++] = ' 		</span>';
								vList[vCount++] = ' 	</div>';
								vList[vCount++] = ' </td>';
									
							}
						}
					}
					     var span   = 288 - vColSpan ; 
							vList[vCount++] = ' <td colspan="'+span+'">';
							vList[vCount++] = ' 	<div class="stt_cont_w">';
							vList[vCount++] = ' 		<span class="stt_pro_link" id ="9999999"> <span class="sttpl_time"></span>';
							vList[vCount++] = ' 			<strong class="sttpl_pname">방송시간이 없습니다.</strong> ';
							vList[vCount++] = ' 		</span>';
							vList[vCount++] = ' 	</div>';
							vList[vCount++] = ' </td>';	
					
				}else{
					vList[vCount++] = ' <td colspan="288" class="stt_ellipsis">방송 시간이 없습니다.</td>';
				}
				vList[vCount++] = ' 		</tr>';
			}
		
			vList[vCount++] = ' 			</tbody>';
			vList[vCount++] = ' 		</table>';
			vList[vCount++] = ' 		<button type="button" class="btn_stt_tprev" title="이전시간" id ="btn_stt_tprev">';
			vList[vCount++] = ' 			<span class="sbtn b_stt_tprev"><i class="ir">이전시간</i></span>';
			vList[vCount++] = ' 		</button>';
			vList[vCount++] = ' 		<button type="button" class="btn_stt_tnext" title="다음시간" id = "btn_stt_tnext">';
			vList[vCount++] = ' 			<span class="sbtn b_stt_tnext"><i class="ir">다음시간</i></span>';
			vList[vCount++] = ' 		</button>';
			vList[vCount++] = ' 		<i class="stt_line"></i>';
			vList[vCount++] = ' 	</div>';
			vList[vCount++] = ' </div>';
			
			
			$('.stt_all_w').append(vList.join('')); 
			
			
			
			{
				
				//한시간마다 스케쥴표 다시 그려주기
				UserLiveApp.scheduleClock();
				
				//스케쥴 현재시간 색상 넣기
				UserLiveApp.ToDaySetting();


				//스케쥴 td 선택 시  방송보기 유무 
				$(".stt_pro_link").click(function (e) {
					var vId = this.id;
					var vData = UserLiveApp.BroadcastingTime(vId);
					if(vData.length == 0){
						alert("방송시간이 아닙니다.");
					}else{
				    	if (videojs.getPlayers()['my-player_01']) {
							delete videojs.getPlayers()['my-player_01'];
						}
				    	if (videojs.getPlayers()['my-player_02']) {
							delete videojs.getPlayers()['my-player_02'];
						}
				    	UserLiveApp.contents("CHANNEL",vId);
						$('head').append('<script src="'+UserTopApp.request+'/ibsCmsJs/video.js"></script>');
						$('head').append('<script src="'+UserTopApp.request+'/ibsCmsJs/videojs-flash.js"></script>');
						$('head').append('<script src="'+UserTopApp.request+'/ibsCmsJs/videojs-contrib-hls.js"></script>');
					}
				}).css({"cursor":"pointer"});


				//오늘 버튼 클릭
				$(".b_sttday_today").click(function (e) {
					var currentDate = new Date();// 현재시간
					var toTime = currentDate.getFullYear()+""+IBSUtil.getDate(currentDate.getMonth()+1)+""+IBSUtil.getDate(currentDate.getDate());
					UserLiveApp.ToDaySetting();
					UserLiveApp.CalenderSetting(toTime,"TODAY");
				}).css({"cursor":"pointer"});


				//AM, PM 버튼 클릭
				$("#btn_stt_am, #btn_stt_pm").click(function (e) {
					var vId = this.id;
					var index = 0 ;
					if(vId == 'btn_stt_pm'){index = 12;	}
					UserLiveApp.slideSheet(index);

				}).css({"cursor":"pointer"});

				//AM,PM 색상 주기
				if(IBSUtil.getDate(UserLiveApp.Now.getHours()) > 12){
					$(".btn_stt_am").removeClass("current");
					$(".btn_stt_pm").addClass("current");
				}else{
					$(".btn_stt_pm").removeClass("current");
					$(".btn_stt_am").addClass("current");

				}
				//스케쥴 표 좌우 버튼클릭
				$("#btn_stt_tprev, #btn_stt_tnext").click(function (e) {
					var vId = this.id;
					if (vId == 'btn_stt_tnext' && UserLiveApp.slidePositionIndex < 18){
						UserLiveApp.slidePositionIndex++;
					}else if (vId == 'btn_stt_tprev' && UserLiveApp.slidePositionIndex > 0){
						UserLiveApp.slidePositionIndex--;
					}else{
						UserLiveApp.slidePositionIndex = 0;
					}
					UserLiveApp.slideSheet(UserLiveApp.slidePositionIndex);
				}).css({"cursor":"pointer"});


				//스케쥴 td가 colspan이  2개이하일때 접혀있음. 마우스 오버시 활짝 펴지는 이벤트 
				$(".stt_ellipsis").mouseover(function (e) {
					var elId = $(this).children().children('.stt_pro_detail').attr('id');
					var obj  = $(this).children('.stt_cont_w');
					$('td').each(function() {
						$(this).removeAttr('style');
					});
					if (obj != undefined) {
						$(obj).parent().attr('style', 'position:relative;z-index:10;');
					}
					var $detailList = $('.stt_pro_detail');
					var $detailItem;
					$detailList.each(function(idx) {
						$detailItem = $detailList.get(idx);
						if ($detailItem.id != elId)
							$($detailItem).hide();
					});
					$(obj).children(".stt_pro_detail").css('display', 'block');

				}).css({"cursor":"pointer"});


				//마우스 이웃시 다시 접히는 이벤트 
				$(".stt_ellipsis").mouseout(function (e) {
					$(this).children().children('.stt_pro_detail').css('display', 'none');
					$(this).children().children('.stt_pro_detail').parent().parent().removeAttr('style');
				});

				//text 왼쪽 버튼클릭
				$(".b_sttday_next").click(function (e) {
					var vId = this.id;
					UserLiveApp.CalenderSetting(vId,"NEXT");
				});


				//text 오른쪽 버튼클릭
				$(".b_sttday_prev").click(function (e) {
					var vId = this.id;
					UserLiveApp.CalenderSetting(vId,"PREV");
				});
				
				//오늘 버튼 클릭
				$(".b_sttday_today").click(function (e) {
					var currentDate = new Date();// 현재시간
					var toTime = currentDate.getFullYear()+""+IBSUtil.getDate(currentDate.getMonth()+1)+""+IBSUtil.getDate(currentDate.getDate());
					UserLiveApp.ToDaySetting("TODAY");
					UserLiveApp.CalenderSetting(toTime,"TODAY");
				}).css({"cursor":"pointer"});
				
				calendar.onClickButton("btnCalendar");
				
		
			}
		},
		
		//스케쥴 이벤트
		CalenderSetting : function(ymd,vFlug){

			calendar.makeCalendarHTML();
			calendar.elementId = "schedule";
			calendar.onClickButton("btnCalendar");
			if (ymd.length >= 8) {
				calendar.rYear = ymd.substring(0, 4);
				calendar.rMonth = ymd.substring(4, 6);
				calendar.rDay = ymd.substring(6, 8);
			}
			calendar.selCalendarDatePrev = function() {
				var strDate1 = calendar.rYear + "-" + calendar.rMonth +"-"+ calendar.rDay;
				var strDate2 = UserLiveApp.Now.getFullYear()+"-"+(UserLiveApp.Now.getMonth()+1)+"-"+UserLiveApp.Now.getDate();
				var arr1 = strDate1.split('-');
				var arr2 = strDate2.split('-');
				var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
				var dat2 = new Date(arr2[0], arr2[1], arr2[2]);
				var diff = dat1 - dat2;
				var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
				var currMonth = currDay * 30;// 월 만듬
				var currYear = currMonth * 12; // 년 만듬

				UserLiveApp.CalendarIndex = parseInt(diff/currDay);
				if(strDate2 != strDate1 ){
					UserLiveApp.scheduleSetting("NEXT",calendar.rYear+""+ calendar.rMonth+""+calendar.rDay);	
				}else{
					UserLiveApp.scheduleSetting("TODAY");	
				}

				this.display(); 
			};
			var today = new Date();
			var currHour = "16";
			var idx = 0;
			

			if(vFlug == "NEXT"){
				UserLiveApp.CalendarIndex++;
				UserLiveApp.scheduleSetting("NEXT",ymd);

			}else if(vFlug == "PREV"){
				UserLiveApp.CalendarIndex--;
				UserLiveApp.scheduleSetting("PREV",ymd);
			}else if(vFlug == "TODAY"){
				UserLiveApp.CalendarIndex = 0;
				UserLiveApp.scheduleSetting("TODAY");	
			}

			if (Number(today.getFullYear()) == Number(calendar.rYear)
					&& (Number(UserLiveApp.addZeros(today.getMonth()),2) + 1) == Number(calendar.rMonth)
					&& Number(UserLiveApp.addZeros(today.getDate()),2) == Number(calendar.rDay)) {

				UserLiveApp.scheduleSetting("TODAY");

			}else{
				UserLiveApp.slideSheet(idx);
				UserLiveApp.slidePositionIndex = 0 ;
			}
		},
		
		//스케쥴 현재시간 색상 넣기
		ToDaySetting : function(){
			var currentDate = new Date(); // 현재시간
			$('.stt_table tr:eq(0) th:eq('+(currentDate.getHours()+1)+')').children().css("background-color","#191818");
			UserLiveApp.slideSheet(currentDate.getHours()-2);
		},
		
		//스케쥴 표 좌우 클릭 시 td가 한칸씩 좌우로 이동
		slideSheet : function(index){
			var COL_WIDTH = 264;
			var slideWidth = 0;
			if (index != null && index >= 0 && index <= 18){
				UserLiveApp.slidePositionIndex = index;
			}
			slideWidth = -(UserLiveApp.slidePositionIndex * COL_WIDTH);
			$(".stt_table").animate({"left" : slideWidth + "px"});
			if (UserLiveApp.slidePositionIndex < 12) {
				$(".btn_stt_pm").removeClass("current");
				$(".btn_stt_am").addClass("current");
			} else {
				$(".btn_stt_am").removeClass("current");
				$(".btn_stt_pm").addClass("current");
			}
		},
		
		//메인화면 시계그려주기
		printClock : function(){

			$("#weather").empty();
			var currentDate = new Date();                                     // 현재시간
			var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
			var amPm = 'AM'; // 초기값 AM
			var currentHours = UserLiveApp.addZeros(currentDate.getHours(),2); 
			var currentMinute = UserLiveApp.addZeros(currentDate.getMinutes() ,2);
			var currentSeconds =  UserLiveApp.addZeros(currentDate.getSeconds(),2);
			if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
				amPm = 'PM';
				currentHours = UserLiveApp.addZeros(currentHours - 12,2);
			}
			if(currentSeconds >= 50){// 50초 이상일 때 색을 변환해 준다.
				currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
			}
			var vList = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:20px;'>"+ amPm+"</span>"; //날짜를 출력해 줌
			$('#weather').append(vList); 

			setTimeout("UserLiveApp.printClock()",1000);         // 1초마다 printClock() 함수 호출
		},
		
		// 방송시간이 끝나면 리플래쉬
		RePlayClock : function(){ 
			var currentDate = new Date();// 현재시간
		    var currentHours = UserLiveApp.addZeros(currentDate.getHours(),2); 
		    var currentMinute = UserLiveApp.addZeros(currentDate.getMinutes() ,2);
		    var currentSeconds =  UserLiveApp.addZeros(currentDate.getSeconds(),2);
		    var toTime = currentHours +":"+currentMinute;
		    var minus = 60000 - (Number(currentSeconds) * 1000) ; 
		    var vRePlayClok = UserLiveApp.RePlayClok(toTime);
		    if(vRePlayClok.length > 0){
		    	if (videojs.getPlayers()['my-player_01']) {
					delete videojs.getPlayers()['my-player_01'];
				}
		    	if (videojs.getPlayers()['my-player_02']) {
					delete videojs.getPlayers()['my-player_02'];
				}
		    	UserLiveApp.contents("liveView",UserLiveApp.gLiveChIdx);
		    }
		    
		    setTimeout("UserLiveApp.RePlayClock()",minus);
		},
		
		// 한시간 마다 재호출 schedule
		scheduleClock : function(){ 

			var currentDate = new Date();
		    var currentMinute = UserLiveApp.addZeros(currentDate.getMinutes() ,2) * 60;
		    var currentSeconds = UserLiveApp.addZeros(currentDate.getSeconds(),2);
		    var date = currentMinute + currentSeconds;
		    if(date == 003){
		    	UserLiveApp.scheduleSetting("TODAY");
		    }
		    setTimeout("UserLiveApp.scheduleClock()",1000);
		},
		
		
		// 시간, 분을 한자리인경우 0으로 들어가
		addZeros : function(num, digit){
			var zero = '';
			  num = num.toString();
			  if (num.length < digit) {
			    for (i = 0; i < digit - num.length; i++) {
			      zero += '0';
			    }
			  }
			  return zero + num;
		},
		
		//-----------------------------------------DB연결-----------------------------------------------------
		
		
		
		
		ChannelData : function(){

			var vData = []; 
			var vURL = UserLiveDB.ChannelData();
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		RePlayClok : function(toTime){

			var vData = []; 
			var vURL = UserLiveDB.RePlayClok(toTime);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		BroadcastingTime : function(idx){

			var vData = []; 
			var vURL = UserLiveDB.BroadcastingTime(idx);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		VodChannel : function(idx){

			var vData = []; 
			var vURL = UserLiveDB.VodChannel(idx);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		
		CalendarDate : function(){

			var vData = [];
			var vURL = UserLiveDB.CalendarDate();
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		Channel : function(vFlug,vDay){

			var vData = [];
			var vURL = UserLiveDB.Channel(vFlug,vDay);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		start : function(vFlug){
			UserLiveApp.contents("TITLE");
			UserLiveApp.CalenderSetting("","TODAY");
			
			
		}
}; 
var UserLiveDB = {
		
		ChannelData : function(){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/ChannelData" ;

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		BroadcastingTime : function(vidx){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/BroadcastingTime" ;

			vParam = {
					"IDX" : vidx				
			};
			
			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		
		
		Channel : function(vFlug,vDay){ 
			
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/Channel" ;

			vParam = {
					"FLUG" : vFlug ,
					"DAY" : vDay
					
			};
			
			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		VodChannel : function(idx){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/VodChannel" ;

			vParam = {
					"IDX" : idx 
			};
			
			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		
		
		CalendarDate : function(){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/CalendarDate" ;
			var date = UserLiveApp.CalendarIndex;
			var vNext = UserLiveApp.CalendarIndex + 1;
			var vPrev = UserLiveApp.CalendarIndex - 1;
			date = date.toString();
			vNext = vNext.toString();
			vPrev = vPrev.toString();
			
			if(vPrev.indexOf('-') == -1){vPrev = "+" + vPrev;}
			if(vNext.indexOf('-') == -1){vNext = "+" + vNext;}
			if(date.indexOf('-') == -1){date = "+" + date;}
			
	
			vParam = {
					"DATE" : date ,
					"NEXT" : vNext,
					"PREV" : vPrev,
			}

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;
			return vReturnURL;

		},
		
		RePlayClok : function(toTime){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/RePlayClok" ;

			vParam = {
					"TIME" : toTime ,
					"CH" : UserLiveApp.gLiveChIdx
			};
			
			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		}
		
		
};
$(window).resize(function (){
	
});

$(document).ready(function() {
	UserLiveApp.start();
	
});
