var UserVodPlayApp ={
		
		player : function(vIdx){
			$(".vod_play").empty(); 
			
			var vList = [];
			var vCount = 0;
			var vWidth = $(window).width();
			var vheight = $(window).height();
			var vSpilt = vIdx.split("_");
			
			var oData =UserViewApp.MainVodAllList(vSpilt[0],"play");
			
			$('.vod_play').css({'width':vWidth,'height':vheight});
			$('.button').css({'width':vWidth});

//			vList[vCount++] =  ' 	<div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left" style="width:100%;height:100%; background-size: cover;"> ';
//			vList[vCount++] =  ' 			<video id="my-player_01" class="video-js listPlayer" controls autoplay preload="auto"  poster="'+oData[0].VOD_PATH+'"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
//			vList[vCount++] =  ' 					<source  src="'+oData[0].VOD_PATH+'"  type="video/mp4"></source>';
//			vList[vCount++] =  ' 				</video>';
//			vList[vCount++] =  ' 		</div>';
			
			
			
			vList[vCount++] =  ' <div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left" ';
			vList[vCount++] =  ' 	style="width:100%;height:100%; background-size: cover; background: url('+oData[0].MAIN_THUMBNAIL+') no-repeat center;">';
			vList[vCount++] =  ' 		<video id="my-player_01" class="video-js listPlayer" controls autoplay preload="auto"  poster="'+oData[0].VOD_PATH+'" data-setup="{}" style="width: 100% !important; height: 100% !important;">';
			vList[vCount++] =  ' 			<source  src="'+oData[0].VOD_PATH+'"  type="application/x-mpegURL"></source>';
			vList[vCount++] =  ' 		</video>';
			vList[vCount++] =  ' </div>';

			jQuery(".vod_play").append(vList.join('')); 

			{ 
				
				$('html, body').css({'overflow': 'hidden', 'height': '100%'});
				$(".modal").css('display','block'); 
				
				var video = videojs('#my-player_01').ready(function(){
					var player = this;

					player.on('ended', function() {
						UserVodPlayApp.vedioDelete();
						UserViewApp.start("VODVIEW",vSpilt[1]);
					});
				});
	
				
				$(".modal_close").click(function () {
					window.history.back();
				});
			}

		},
		
		vedioDelete : function(){
			$(".vod_play").remove();
			if (videojs.getPlayers()['my-player_01']) {
				delete videojs.getPlayers()['my-player_01'];
			}
		},

		
		windowResize : function(){
			var vWidth = $(window).width();
			var vheight = $(window).height()
			$('.vod_play').css('height', vheight);
			$('.vod_play').css('width', vWidth);
		},

		
		start : function(vIdx){
			UserVodPlayApp.player(vIdx);			
		}
}; 
var UserVodPlayDB = {
		
};
$(window).resize(function (){
	UserVodPlayApp.windowResize();
});
