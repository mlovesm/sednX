var UserViewApp ={
		gFlug : "",
		gShowModel : null,
		gHistoryBack : "",
		gNextCount : 0,
		
		Contents : function(vIdx){
			var vList = [];
			var vCount = 0;
			var vMainContents = null;
			var vMainVodList2 = null;
			var vMainVodList = null;
			var vMainVodKeyword = null;
			
			
			vMainContents = [ {"idx" : "0" , "CATEGORY_NAME" : "이 영상 다음으로 많이 본 콘텐츠"},
					  		  {"idx" : "1" , "CATEGORY_NAME" : "지금 본 영상과 유사한 콘텐츠"}]; 
			vMainVodList = UserViewApp.MainVodAllList("","vodNext") ;
			vMainVodList2 = UserViewApp.MainVodAllList(vIdx,"vodFamily") ;
			
			if(vMainContents != null){
				for(var i = 0 ; i < vMainContents.length ; i ++){
					vList[vCount++] =  '  <div class="form_div">	'; 
					vList[vCount++] =  ' 	<h2>'+vMainContents[i].CATEGORY_NAME +'</h2> ';	
					vList[vCount++] =  ' 	<div class="slider"> ';
					var count = 0;
					if(vMainContents[i].idx  == "0"){
						for(var j = 0 ; j < vMainVodList.length ; j ++){

							vList[vCount++] =  ' 		<div class="slider_form "> ';
							vList[vCount++] =  ' 				<span class="triangle"></span> <img src="'+vMainVodList[j].MAIN_THUMBNAIL+'" alt="" title="'+vMainVodList[j].VOD_TITLE+'" />'; 
							vList[vCount++] =  ' 				<div class="player" id="player_0'+(i+1)+'">'; 
							vList[vCount++] =  ' 					<button class="modalBtn" id="modalBtn_0'+(i+1)+'"><img src="'+UserTopApp.request+'/ibsUserImg/btn_play.png" alt="재생" /> </button>'; 
							vList[vCount++] =  ' 					<div class="text" >'; 
							vList[vCount++] =  ' 						<h3>'+vMainVodList[j].VOD_TITLE+'</h3>';  
							vList[vCount++] =  ' 						<p>'+vMainVodList[j].EDIT_DT+'</p>'; 
							vList[vCount++] =  ' 						<p>'+vMainVodList[j].VOD_CONTENT+'</p>'; 
							vList[vCount++] =  ' 					</div>'; //text End 
							vList[vCount++] =  ' 					<span class="down" id="down_0'+(i+1)+'_'+vMainVodList[j].KEY_IDX+'_'+vMainVodList[j].VOD_REPO+'_'+vMainVodList[j].IDX+'" ></span>'; 
							vList[vCount++] =  ' 				</div>'; //player End 
							vList[vCount++] =  ' 			</div>'; //slider_form End
						}
						vList[vCount++] =  '    </div> '; //slider end
						vList[vCount++] =  ' </div> '; //form_div end


					}else if(vMainContents[i].idx == "1"){
						for(var j = 0 ; j < vMainVodList2.length ; j ++){
							vList[vCount++] =  ' 		<div class="slider_form "> ';
							vList[vCount++] =  ' 				<span class="triangle"></span> <img src="'+vMainVodList2[j].MAIN_THUMBNAIL+'" alt="" title="'+vMainVodList2[j].VOD_TITLE+'" />'; 
							vList[vCount++] =  ' 				<div class="player" id="player_0'+(i+1)+'">'; 
							vList[vCount++] =  ' 					<button class="modalBtn" id="modalBtn_ 0'+(i+1)+'"><img src="'+UserTopApp.request+'/ibsUserImg/btn_play.png" alt="재생" /> </button>'; 
							vList[vCount++] =  ' 					<div class="text" >'; 
							vList[vCount++] =  ' 						<h3>'+vMainVodList2[j].VOD_TITLE+'</h3>';  
							vList[vCount++] =  ' 						<p>'+vMainVodList2[j].EDIT_DT+'</p>'; 
							vList[vCount++] =  ' 						<p>'+vMainVodList2[j].VOD_CONTENT+'</p>'; 
							vList[vCount++] =  ' 					</div>'; //text End 
							vList[vCount++] =  ' 					<span class="down" id="down_0'+(i+1)+'_'+vMainVodList2[j].KEY_IDX+'_'+vMainVodList2[j].VOD_REPO+'_'+vMainVodList2[j].IDX+'" ></span>'; 
							vList[vCount++] =  ' 				</div>'; //player End 
							vList[vCount++] =  ' 			</div>'; //slider_form End
						}
						vList[vCount++] =  '    </div> '; //slider end
						vList[vCount++] =  ' </div> '; //form_div end
					}
				}
			}
			
		$('.slider_container').append(vList.join('')); 
		
		{
			//UserViewApp.FormLastClass();
			UserViewApp.windowResize();
			UserViewApp.ContentsEvent();
		}
		
		},
		
		
		// VOD 메인화면과 1STPE그려주기
		VodContensView : function(vIdx){
			$(".theMore").empty();
			var vMainContents = null;
			var vMainVodList = null;
			var vList = [];
			var vCount = 0;
			
			if(UserViewApp.gFlug == "vodMenuParents"){
				var vSplit = vIdx.split("_");
				vMainContents = UserViewApp.ShowViewMenuBar(vSplit[1]); // 레이아웃 제목 가져오기
				vMainVodList = UserViewApp.MainVodAllList(vSplit[1],UserViewApp.gFlug) ;
			}else{
				var vMainContents = UserViewApp.LayoutMenuList(); // 레이아웃 제목 가져오기	
			}

			if(vMainContents != null){
				for(var i = 0 ; i < vMainContents.length; i++ ){
					UserViewApp.gNextCount = vMainContents[i].ROWNUM;
					vList[vCount++] =  '  <div class="form_div" style ="padding-left: 13px;">	'; 
					vList[vCount++] =  ' 	<h2>'+vMainContents[i].CATEGORY_NAME +'<span class="right" name = "rightAll" id ="'+vMainContents[i].PID+"_"+vMainContents[i].IDX+'">전체보기 ></h2> ';	
					vList[vCount++] =  ' 	<div class="slider""> ';
					if(UserViewApp.gFlug != "vodMenuParents"){
						vMainVodList = UserViewApp.MainLaoutVodList(vMainContents[i].IDX);	
					}
					for(var j = 0 ; j < vMainVodList.length; j++){
						vList[vCount++] =  ' 		<div class="slider_form"> ';
						vList[vCount++] =  ' 				<span class="triangle"></span> <img src="'+vMainVodList[j].MAIN_THUMBNAIL+'" alt="" title="'+vMainVodList[j].VOD_TITLE+'" />'; 
						vList[vCount++] =  ' 				<div class="player" id="player_0'+(i+1)+'">'; 
						vList[vCount++] =  ' 					<button class="modalBtn" id="modalBtn_0'+(i+1)+'"><img src="'+UserTopApp.request+'/ibsUserImg/btn_play.png" alt="재생" /> </button>'; 
						vList[vCount++] =  ' 					<div class="text" >'; 
						vList[vCount++] =  ' 						<h3>'+vMainVodList[j].VOD_TITLE+'</h3>';  
						vList[vCount++] =  ' 						<p>'+vMainVodList[j].EDIT_DT+'</p>'; 
						vList[vCount++] =  ' 						<p>'+vMainVodList[j].VOD_CONTENT+'</p>'; 
						vList[vCount++] =  ' 					</div>'; //text End 
						if(UserViewApp.gFlug != "vodMenuParents"){
							vList[vCount++] =  ' 					<span class="down" id="down_0'+UserViewApp.gNextCount+'_'+vMainVodList[j].KEY_IDX+'_'+vMainVodList[j].VOD_REPO+'_'+vMainVodList[j].IDX+'"  name = "downName_'+(i+1)+(j+1)+'"><img src="'+UserTopApp.request+'/ibsUserImg/arr_down.png" alt="down" /></span>';
						}else{
							vList[vCount++] =  ' 					<span class="down" id="down_0'+(i+1)+'_'+vMainVodList[j].KEY_IDX+'_'+vMainVodList[j].VOD_REPO+'_'+vMainVodList[j].IDX+'"  name = "downName_'+(i+1)+(j+1)+'"><img src="'+UserTopApp.request+'/ibsUserImg/arr_down.png" alt="down" /></span>';
						}
						 
						vList[vCount++] =  ' 				</div>'; //player End 
						vList[vCount++] =  ' 			</div>'; //slider_form End
					}
					vList[vCount++] =  '    </div> '; //slider end
					vList[vCount++] =  ' </div> '; //form_div end

					if(UserViewApp.gFlug != "vodMenuParents"){
						vList[vCount++] =  ' <div class="form_show" id="show_0'+ UserViewApp.gNextCount +'"></div>';
						
					}else{
						vList[vCount++] =  ' <div class="form_show" id="show_0'+ (i+1) +'"></div>';
					}
		
				}
				
				if(UserViewApp.gFlug != "vodMenuParents" && vMainContents[0].CNT != UserViewApp.gNextCount){
					vList[vCount++] =  '<div class = "theMore"><div class="more"> ';
					vList[vCount++] =  '<hr />';
					vList[vCount++] =  '<p><span>더보기</span></p>';
					vList[vCount++] =  '</div></div>';
				}
			}
		

			$('.slider_container').append(vList.join('')); 
			
			{
				//UserViewApp.FormLastClass();
				UserViewApp.windowResize();
				UserViewApp.ContentsEvent();
				$(".more").click(function () {
					UserViewApp.VodContensView()
				});
				
			}
			
		},
		
		
		// 케러셀 slider_form 클래스에 last 넣어주기 
		FormLastClass : function(){
			var vViewPort = ($(".bx-viewport" ).width() / 347);
			var vFormCnt = $('.form_div').length;
			$('.form_div').find(".slider_form").removeClass("last");
			
				for(var i = 0 ; i < vFormCnt; i++){
					var vSliderFromCnt = $('.form_div').eq(i).find(".slider_form").length;
					$('.form_div').eq(i).find(".slider_form").eq(Math.round(vViewPort)-1).addClass("last");
					$('.form_div').eq(i).find(".slider_form").eq(vSliderFromCnt-1).addClass("last");
				}
		},
		
		
		// 상세보기 그려주기
		showView : function(vIndexList){ 
			$(".form_show").empty();
			$('.cycle-slideshow').cycle();
			var vList = [];
			var vCount = 0;
			var vImageList = null;
			var vDataFile = null
			var vViewCount = vIndexList[1];
			var vKEY_IDX = vIndexList[2];
			var vVodREPO = vIndexList[3];
			var vIdx 	 = vIndexList[4];
			 
			var vData = UserViewApp.MainVodAllList(vKEY_IDX,"SHOW_VIEW") ; // 다른쿼리
			//파일 가져오기
			if(vData[0].FILE_REPO != null){
				vImage =vData[0].FILE_REPO.split(",");
				var vImageSplit = "'X'";
				for(var i = 0 ; i < vImage.length; i++){
					vImageSplit += ",'"+vImage[i]+"'"
				}
				vFile= UserViewApp.ModelFileViewList(vImageSplit);
			}
			
			
			// 이미지 가져오기
			if(vData[0].PHOTO_REPO != ""){
				vImage =vData[0].PHOTO_REPO.split(",");
				var vImageSplit = "'X'";
				for(var i = 0 ; i < vImage.length; i++){
					vImageSplit += ",'"+vImage[i]+"'"
				}
				vImageList = UserViewApp.ModelImageList(vImageSplit);
			}
			
			
		vList[vCount++] =  ' <div class="img_right">';
		vList[vCount++] =  ' 	<div class="gra"></div>';
		vList[vCount++] =  ' 	<div class="gra bottom"></div>';
		vList[vCount++] =  ' 	<div class="cycle-slideshow">';    
		var fileHead = vData[0].PATH.split("."); 
		for(var j = 0 ; j < 10 ; j++) {
			vList[vCount++] =  ' <img src="'+vData[0].MAIN_THUMBNAIL+ fileHead[0] + "_"+ j + ".jpg"+'" /> ';  	
		}
		vList[vCount++] =  ' 	</div>';
		vList[vCount++] =  ' 	<div class="nav">';
		vList[vCount++] =  ' 		<button class="prev"><img src="'+UserTopApp.request+'/ibsUserImg/prev.png" alt="이전" /></button>';
		vList[vCount++] =  ' 		<button class="next"><img src="'+UserTopApp.request+'/ibsUserImg/next.png" alt="다음" /></button>';
		vList[vCount++] =  ' 	</div>';
		vList[vCount++] =  ' </div>';
     	vList[vCount++] =  ' <div class="tab text-center">';
		vList[vCount++] =  ' 	<a id="tab_01" class="on">VIDEO</a>';
		if(vImageList != null){
			vList[vCount++] =  ' 	<a id="tab_02">PHOTO</a>';
		}
		if(vData[0].BOARD_CONTENT != "" && vData[0].BOARD_CONTENT != "<p><br></p>"){
			vList[vCount++] =  ' 	<a id="tab_03">CONTENTS</a>';
		}
		vList[vCount++] =  ' </div>';
        vList[vCount++] =  ' ';
		vList[vCount++] =  ' <div class="info_form">';
		vList[vCount++] =  ' 	<button class="close"><img src="'+UserTopApp.request+'/ibsUserImg/close.png" alt="닫기" /></button>';
		vList[vCount++] =  ' 	<div class="total">';
		vList[vCount++] =  ' 		<ul>';
		vList[vCount++] =  ' 			<li class="like" id ="favoriteCount">'+vData[0].FAVORITE_COUNT+'</li>';
		vList[vCount++] =  ' 			<li class="view" id ="viewCount">'+vData[0].VIEW_COUNT+'</li>';
		vList[vCount++] =  ' 		</ul>';
		vList[vCount++] =  ' 	</div>';
		vList[vCount++] =  ' 	<h4>그것만이 내 세상</h4>';
		vList[vCount++] =  ' 	<div class="tab_form" id="tabForm_01">';
		vList[vCount++] =  ' 		<img class="play" src="'+UserTopApp.request+'/ibsUserImg/btn_play.png" alt="재생" />';
		vList[vCount++] =  ' 		<div class="info">';
		vList[vCount++] =  ' 			<ul>';
		vList[vCount++] =  ' 				<li><span>등록일 :</span> '+vData[0].REG_DT+'</li>';
		if(vFile.length > 0){
			vList[vCount++] =  ' 				<li><button>파일다운로드</button></li><br/>';
			vList[vCount++] =  ' <div class="download">';
			vList[vCount++] =  ' 	<div class="triangle"></div>';
			vList[vCount++] =  ' 	<button><img src="'+UserTopApp.request+'/ibsUserImg/close_s.png" alt="닫기"></button>';
			vList[vCount++] =  ' 	<div class="scrollbar" style="max-height: 155px;">'; 
			vList[vCount++] =  ' 		<ul>';
			for(var i = 0; i < vFile.length; i++){
				vList[vCount++] =  ' 			<li>· <a href= "'+UserTopApp.request+'/svc/FileDownlod?path='+vFile[i].FILE_PATH+'"><span></span>'+vFile[i].FILE_TITLE+'</a> <span>'+vFile[i].FILE_SIZE+'kb</span></li>';
			}
			vList[vCount++] =  ' 		</ul>';
			vList[vCount++] =  ' 	</div>';
			vList[vCount++] =  ' </div>';

		}
		vList[vCount++] =  ' 				<li><span>해상도 :</span>'+vData[0].RESOLUTION+'</li><br>';
		vList[vCount++] =  ' 				<li><span>재생시간 :</span>'+vData[0].VOD_PLAY_TIME+'</li>';
		vList[vCount++] =  ' 				<li><span>용량 :</span>'+vData[0].FILE_SIZE+'</li>';
		vList[vCount++] =  ' 			</ul>';
		vList[vCount++] =  ' 		</div>';
		vList[vCount++] =  ' 		<div class="scrollbar mt15" style="width: 33%; max-height: 305px;">';
		vList[vCount++] =  ' 			<p class="text">'+vData[0].VOD_CONTENT+'</p>';
		vList[vCount++] =  ' 		</div>';								
		vList[vCount++] =  ' 	</div>';
		
		if(vImageList != null){

			vList[vCount++] =  ' 	<div class="tab_form" id="tabForm_02">';
			vList[vCount++] =  ' 		<div class="bg"></div>';
			if(vImageList.length <= 4){
				vList[vCount++] =  ' 		<div class="photo_form none">';	
			}else{
				vList[vCount++] =  ' 		<div class="photo_form">';
			}
			
			for(var i = 0 ; i < vImageList.length; i++){
				vList[vCount++] =  ' 			<div class="img" >';
				vList[vCount++] =  ' 			<img src="'+vImageList[i].PHOTO_PATH+'"/>';
				vList[vCount++] =  ' 				<p class="title">'+vImageList[i].PHOTO_TITLE+'</p>';
				vList[vCount++] =  ' 				<div class="scrollbar">';
				vList[vCount++] =  ' 					<p>'+vImageList[i].PHOTO_CONTENT+'</p>';
				vList[vCount++] =  '				</div>';
				vList[vCount++] =  ' 			</div>';
			}
			vList[vCount++] =  ' 		</div>';	

			vList[vCount++] =  ' 	</div>';

		}
		
		
		if(vData[0].BOARD_CONTENT != "" && vData[0].BOARD_CONTENT != "<p><br></p>"){ 
			vList[vCount++] =  ' 	<div class="tab_form" id="tabForm_03">';
			vList[vCount++] =  ' 		<div class="bg"></div>';
			vList[vCount++] =  ' 		<div class="scrollbar" style="max-height: 425px;">'+vData[0].BOARD_CONTENT+'</div>';
			vList[vCount++] =  ' 	</div>';
	
		}
		vList[vCount++] =  ' </div>';

			jQuery("#show_"+vViewCount).append(vList.join(''));  

			
			{
				
				$('.cycle-slideshow').cycle({   
					fx:     'fade', 
					speed:  'fast', 
					timeout: 3000,  
					next:   '.next', 
					prev:   '.prev' 
				});
				
				if(vImageList != null && vImageList.length >= 4){
					$('.photo_form').bxSlider({
						mode: 'horizontal',
						slideWidth: 392,
						pager: false,
						captions: true,
						minSlides: 2, 
						maxSlides: 4,     
						slideMargin: 20,
						controls: true,
						moveSlides: 4,
						infiniteLoop: false
						
					});
				}
				
				$(".scrollbar").mCustomScrollbar({
					theme:"inset"
				});
				
				
				$(".info > ul > li > button").click(function () {
					$(".download").show(300);
				});
				$(".download button").click(function () {
					$(".download").hide(300);
				});
				
				$(".tab a").click(function () {
					$(".tab a").removeClass("on");
					$(this).addClass("on");
					$(".tab_form").hide();
					var tabId = this.id;
			        var tabForm = tabId.replace("tab_","");
			        $("#tabForm_"+tabForm).css('display','block');
			        $(".prev").css('display','none');
			        $(".next").css('display','none');
			        if ($(".tab a:first-child").hasClass("on") == true) {
			        	$(".prev").css('display','block');
			        	$(".next").css('display','block');
			        }
				}).css({"cursor":"pointer"});
				$(".tab a:first-child").click();
				
				
				$(".like").click(function (e) { 
					UserViewApp.VodCountInsert(vVodREPO,"FAVORITE");
					UserViewApp.ShowViewChange(vKEY_IDX);
					
					e.preventDefault();
				}).css({"cursor":"pointer"});

				$(".close").click(function (e) { 
				
					$(this).parent().parent().parent().find(".form_show").css("display","none");
					$(".slider").removeClass("border");
					$(".slider.border > div > img").removeClass("on");
					$('.cycle-slideshow').cycle('destroy');
					
		 			$(this).parent().parent().parent().find(".form_show").css("display","none");
		  			$(".search_page").removeClass("border");
		  			$(".search_page.border .hover").removeClass("on");
		  			$(".bx-caption").css("display","block");
					e.preventDefault();

				}).css({"cursor":"pointer"});

				$(".play").click(function (e) {
					
					UserViewApp.VodCountInsert(vVodREPO,"VIEW");
					UserViewApp.ShowViewChange(vKEY_IDX);
					location.href = UserTopApp.request+"/svc/user/vodPlay?vIndex="+vIndexList[2]+"_"+vIndexList[4];
					e.preventDefault();
				}).css({"cursor":"pointer"});
			}
		},
	
		
		
		// windowResize 시 호출
		windowResize : function(){
			
			var sWidth = $(".slider>div").outerWidth()*2;

			var vWidth = $(window).width();
			var vheight = $(window).height()
			$('.vod_play').css('height', vheight);
			$('.vod_play').css('width', vWidth);

			if($(window).width() > 1024 ) {
				
				$(".slider>div").mouseover(function(e){
					e.preventDefault();
					var offset = $(this).offset();
					console.log("left: " + offset.left + ", top: " + offset.top );
				/*	왼쪽 : 78 보다 작은거
					오늘쪽 : 윈도우 - offset.left 가 550 작으면 
				*/	
					if ($(this).parent("div").hasClass("border") == true){
						$(".slider>div").removeClass("last");
						$(".slider").removeClass("on");
						$(this).removeClass("active");
						
					}else{
						//$(".slider>div").eq(5).addClass("last");
						$(this).parent("div").addClass("on");
						$(this).addClass("active");
						jQuery('.text').show(); 
					}
					return true;
				});
				
				$(".slider>div").mouseout(function(){
					$(".slider").removeClass("on");
					$(this).removeClass("active");
				});

				$(".slider>div.last").mouseover(function(e){
					e.preventDefault();
					if ($(".slider>div").hasClass("last") == true){
		
						$(this).css("left","-210px");
						$(this).parent().find("div").css("left","-210px");
					}else{
						
						$(this).css("left","0px");
						$(this).parent().find("div").css("left","0px");
					}

					$(".bx-caption").css("left","0px");
					$(".player").css("left","0px");
					$(".text").css("left","0px");
				});
				$(".slider>div.last").mouseout(function(){
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
				});

				$(".menu > ul > li").mouseover(function(e){
					e.preventDefault();
					var liWith = $(this).outerWidth()
					var depth2With = $(this).find(".depth2").outerWidth() - liWith;
					$(this).addClass("on");
					$(".depth2").css("display","block");
					$(this).find(".depth2").css("opacity","1");
					$(this).find(".depth2").css({"margin-left":-depth2With/2 +"px"});
				});
				$(".menu > ul > li").mouseout(function(e){
					e.preventDefault();
					$(".menu > ul > li").removeClass("on");
					$(".depth2").css('opacity','0');
					$(".depth2").css("display","none");					
				});
				return true;

			}else{
				$(".slider>div").mouseover(function(e){
					e.preventDefault();
					if ($(this).parent("div").hasClass("border") == true){
						$(".slider>div").removeClass("last");
						$(".slider").removeClass("on");
						$(this).removeClass("active");
					}else{
						$(".slider>div").eq(5).removeClass("last");
						$(this).parent("div").removeClass("on");
						$(this).removeClass("active");
						jQuery('.text').hide(); 
					}
					return true;

				});
				$(".slider>div").mouseout(function(e){
					e.preventDefault();
					$(".slider").removeClass("on");
					$(this).removeClass("active");
				});
				$(".slider>div.last").mouseover(function(e){
					e.preventDefault();
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
					$(".bx-caption").css("left","0px");
					$(".player").css("left","0px");
					$(".text").css("left","0px");
				});
				$(".slider>div.last").mouseout(function(e){
					e.preventDefault();
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
				});
			}
		},
		
		
		//이벤트
		ContentsEvent : function(vSearch){
			
			$("[name=rightAll]").click(function () {
				var vId = this.id; 
				window.location.href = UserTopApp.request+'/svc/user/vodMenuChild?vIndex='+vId;
			}).css({"cursor":"pointer"});
			
			if(UserViewApp.gFlug == "VODVIEW"){
				$('.form_div').css('padding-top', 121);	
			}
		
			var slider  = $('.slider').bxSlider({
				mode: 'horizontal',
				slideWidth: 347,
				pager: false,
				captions: true,
				minSlides: 2,
				maxSlides: 8,     
				slideMargin: 3,
				controls: true,
				moveSlides: 5,
				captions: true,
				preloadImages: 'all',
				infiniteLoop: true
			});
				
			$("span.down").click(function () {
				var playerId = this.id;
				var playerName = $(this).attr("name");
				var vIndexList = playerId.split("_");
				var vNameList = playerName.split("_");
				UserViewApp.showView(vIndexList);
				

				$(".slider").removeClass("border");
				$(this).parent().parent().parent("div").addClass("border");
				$(".slider.border > div").removeClass("on");
				$(this).parent().parent().find("img").parent("div").addClass("on");
				$(".form_show").css("display","none");
				$(".slider.border > div > span.triangle").css("display","none");
				$(this).parent().parent().find("span.triangle").css('display','block');
				$("#show_"+vIndexList[1]).css('display','block');
				
				UserViewApp.gHistoryBack = vIndexList[1]+"_"+vNameList[1];

				var offset = $("#show_" + vIndexList[1]).offset(); 
				$('html, body').animate({scrollTop : offset.top-250}, "slow");
			}).css({"cursor":"pointer"});


			$(".player").click(function () {
				if(UserViewApp.gFlug == "VODVIEW"){
					var playerId = $(this).find('span').attr("id");
					var playerName = $(this).children('span').attr('name');
					var vod_path = playerId.split("_");
					var playerName = playerId.split("_");
					location.href = UserTopApp.request+"/svc/user/vodPlay?vIndex="+vod_path[2]+"_"+vod_path[4];
				}else{
					var playerId = $(this).children('span').attr('id');
					var vIndexList = playerId.split("_"); 
					UserViewApp.showView(vIndexList);
					$(".slider").removeClass("border");
					$(this).parent().parent("div").addClass("border");
					$(".slider.border > div").removeClass("on");
					$(this).parent().find("img").parent("div").addClass("on");
					$(".form_show").css("display","none");
					$(".slider.border > div > span.triangle").css("display","none");
					$(this).parent().find("span.triangle").css('display','block');

					$("#show_"+vIndexList[1]).css('display','block');
					var offset = $("#show_" + vIndexList[1]).offset(); 
					$('html, body').animate({scrollTop : offset.top-250}, "slow");
				}
			}).css({"cursor":"pointer"});


			$(".modalBtn").click(function () {
				var playerId = $(this).parent().find('span').attr("id");
				var vod_path = playerId.split("_");

				location.href = UserTopApp.request+"/svc/user/vodPlay?vIndex="+vod_path[2]+"_"+vod_path[4];

			});

		},


		
		//좋아요, 플레이어 클릭 시 숫자 변경
		ShowViewChange : function(vKEY_IDX){
			
			var oData =UserViewApp.MainVodAllList(vKEY_IDX,"VIEW_CHANGE");
			
			var vViewCount = oData[0].VIEW_COUNT;
			var vFavoriteCount = oData[0].FAVORITE_COUNT;
			
			$("#viewCount").text(" "+vViewCount+" ");
			$("#favoriteCount").text(" "+vFavoriteCount+" ");
			
			 
		},

		//-----------------------------------------DB연결-----------------------------------------------------
		LayoutMenuList : function(){	
			var vData = [];
			var vURL = UserViewDB.LayoutMenuList(); 
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},

		MainLaoutVodList : function(vIdx){

			var vData = [];
			var vURL = UserViewDB.MainLaoutVodList(vIdx);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		MainVodAllList : function(vIDX,vFlug){
			
			var vData = [];
			var vURL = UserViewDB.MainVodAllList(vIDX,vFlug);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				if(vFlug == "SHOW_VIEW"){
					UserViewApp.gShowModel = oData.lists;
				}
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		ModelImageList : function(image){ 

			var vData = [];
			var vURL = UserViewDB.ModelImageList(image);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		ModelFileViewList : function(vFileIdx){ 
			var vData = [];
			var vURL = UserViewDB.ModelFileViewList(vFileIdx);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
		
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});
			return vData;
		},
		
		VodCountInsert : function(vVodREPO,vFlug,vKEY_IDX){ 
			var vURL = UserViewDB.VodCountInsert(vVodREPO,vFlug,vKEY_IDX);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
		
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});
		},

		MenuChildTitle : function(vPID,vIDX){ 

			var vData = [];
			var vURL = UserViewDB.MenuChildTitle(vPID,vIDX);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		ShowViewMenuBar : function(vIDX){ 

			var vData = [];
			var vURL = UserViewDB.ShowViewMenuBar(vIDX);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		
		MainVodKeyWord : function(vSearch){ 

			var vData = [];
			var vURL = UserViewDB.MainVodKeyWord(vSearch);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		

		
		start : function(vFlug,vIdx){
			UserViewApp.gFlug = vFlug;
			
			if(UserViewApp.gFlug == "VOD" || UserViewApp.gFlug == "vodMenuParents"){
				UserViewApp.VodContensView(vIdx)
			//VOD 끝나고 난뒤 화면 그려주기	
			}else if(UserViewApp.gFlug == "VODVIEW"){
				UserViewApp.Contents(vIdx)
			}
			
			
		}
}; 
var UserViewDB = {

		LayoutMenuList : function(){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/LayoutMenuList" ;
			vParam = {"ROWNUM" : UserViewApp.gNextCount}

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		MainLaoutVodList : function(vIdx){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/MainLaoutVodList";
			vParam = {"IDX" : IBSUtil.getString(vIdx,"")}
			
			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;
			
			return vReturnURL;
		},
		
		MainVodAllList : function(vIDX,vFlug){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/MainVodAllList" ;
			vParam = {"IDX" : IBSUtil.getString(vIDX,""),
					  "FLUG" : IBSUtil.getString(vFlug,"")
				     };
			
			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;
			
			return vReturnURL;
		},
		
		ModelImageList : function(image){ 

			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/ModelImageList" ;

			vParam = {"IDX" : image};

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		ModelFileViewList : function(vFileIdx){ 

			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/ModelFileViewList" ;
			vParam = {"IDX" : IBSUtil.getString(vFileIdx,"")}

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		VodCountInsert : function(vVodREPO,vFlug,vKEY_IDX){ 
			
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/VodCountInsert" ;
			
			vParam = {"IDX" : IBSUtil.getString(vVodREPO,""),
					  "FLUG" : IBSUtil.getString(vFlug,""),
					  "KEY_IDX" : IBSUtil.getString(vKEY_IDX,"")
					}
			
			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		MenuChildTitle : function(vPID,vIDX){ 

			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/MenuChildTitle" ;

			vParam = {"vPID" : IBSUtil.getString(vPID,""),
					"vIDX" : IBSUtil.getString(vIDX,"")
			}

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		ShowViewMenuBar : function(vIDX){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/ShowViewMenuBar" ;

			vParam = {"IDX" : IBSUtil.getString(vIDX,"")}

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		MainVodKeyWord : function(vSearch){ 

			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/MainVodKeyWord" ;

			vParam = {"VOD_KEYWORD" : IBSUtil.getString(vSearch,"")};

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		
		
		list : function(){
			
		}

	

};



$(window).resize(function (){
	UserViewApp.FormLastClass(); 
	UserViewApp.windowResize();
});


$(window).on("load",function(){
	$(".scrollbar").mCustomScrollbar({
		theme:"inset"
	});
});
