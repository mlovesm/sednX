var UserViewSearchApp ={
		gFlug : "",
		gShowModel : null,
		
		Contents : function(Search){
			
			$(".slider_containerSearch").empty();
			var vList = [];
			var vCount = 0;
			var vMainContents = null;
			var vMainVodList = null;
			var vMainVodKeyword = null;
			var Count = 0;

			vMainContents = [{"idx" : "0" , "CATEGORY_NAME" : "VOD"}]; //UCC및 등등 들어갈꺼임
			vMainVodKeyword = UserViewSearchApp.MainVodKeyWord(Search);
			vMainVodList = UserViewSearchApp.MainVodAllList(Search,"vodUserSearch");
			

			if(vMainVodList.length == 0){
				vList[vCount++] =  '  <div class="form_divSearch" style ="padding-left: 13px;">입력하신 검색어 '+Search+'(와)과 일치하는 결과가 없습니다.';
			}else{
				for(var i = 0 ; i < vMainContents.length ; i ++){
					var count = 0 ;
					vList[vCount++] =  '  <div class="form_divSearch">	'; 
					vList[vCount++] =  ' 	<div class="keyword"> ';
					vList[vCount++] =  ' 		<p>"'+Search+'"검색어와 관련된 키워드 : </p>';
					vList[vCount++] =  ' 	<ul>';
					for(var k = 0 ; k < vMainVodKeyword.length; k++ ){
						vList[vCount++] =  ' 		<li><a>'+vMainVodKeyword[k].SPLIT_TEXT+'</a></li>';	
					}
					vList[vCount++] =  ' 	</ul>';
					vList[vCount++] =  ' 	</div>';
					vList[vCount++] =  ' 	<h2 style ="margin-top: 58px; margin-left: 54px;">'+vMainContents[0].CATEGORY_NAME+'</h2> '; 
					vList[vCount++] =  ' 	<div class="sliderSearch" > ';
					for(var j = 0 ; j < vMainVodList.length; j++){
						count ++;
						if(((count)%5) == 0 ){
							vList[vCount++] =  ' 		<div class="slider_Searchform last"> ';
						}else{
							vList[vCount++] =  ' 		<div class="slider_Searchform "> ';
						}
						vList[vCount++] =  ' 				<span class="triangle"></span> <img src="'+vMainVodList[j].MAIN_THUMBNAIL+'" alt="" title="'+vMainVodList[j].VOD_TITLE+'" />'; 
						vList[vCount++] =  ' 				<div class="playerSearch" id="playerSearch_0'+(i+1)+'">'; 
						vList[vCount++] =  ' 					<button class="modalBtnSearch" id="modalBtnSearch_0'+(i+1)+'"><img src="'+UserTopApp.request+'/ibsUserImg/btn_play.png" alt="재생" /> </button>'; 
						vList[vCount++] =  ' 					<div class="textSearch" >'; 
						vList[vCount++] =  ' 						<h3>'+vMainVodList[j].VOD_TITLE+'</h3>';  
						vList[vCount++] =  ' 						<p>'+vMainVodList[j].EDIT_DT+'</p>'; 
						vList[vCount++] =  ' 						<p>'+vMainVodList[j].VOD_CONTENT+'</p>'; 
						vList[vCount++] =  ' 					</div>'; //text End 
						vList[vCount++] =  ' 					<span class="downSearch" id="downSearch_0'+(i+1)+'_'+vMainVodList[j].KEY_IDX+'_'+vMainVodList[j].VOD_REPO+'_'+vMainVodList[j].IDX+'" ><img src="'+UserTopApp.request+'/ibsUserImg/arr_down.png" alt="down" /></span>'; 
						vList[vCount++] =  ' 				</div>'; //player End 
						vList[vCount++] =  ' 			</div>'; //slider_Searchform End

					}
					vList[vCount++] =  '    </div> '; //slider end
					vList[vCount++] =  ' </div> '; //form_div end
					vList[vCount++] =  ' <div class="form_Searchshow" id="showSearch_0'+ (i+1) +'"></div>';
				}
			}
		
			
		$('.slider_containerSearch').append(vList.join('')); 
		
		{
			UserViewSearchApp.FormLastClass();
			UserViewSearchApp.windowResize();
			UserViewSearchApp.ContentsEvent();
			
		}
		
		},
 
		showView : function(vIndexList){ 
			$(".form_Searchshow").empty();
			$('.cycle-slideshowSearch').cycle()
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
		vList[vCount++] =  ' 	<div class="cycle-slideshowSearch">';    
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
     	vList[vCount++] =  ' <div class="tabSearch text-center">';
		vList[vCount++] =  ' 	<a id="tab_01" class="on">VIDEO</a>';
		if(vImageList != null){
			vList[vCount++] =  ' 	<a id="tab_02">PHOTO</a>';
		}
		if(vData[0].BOARD_CONTENT != "" && vData[0].BOARD_CONTENT != "<p><br></p>"){
			vList[vCount++] =  ' 	<a id="tab_03">CONTENTS</a>';
		}
		vList[vCount++] =  ' </div>';
        vList[vCount++] =  ' ';
		vList[vCount++] =  ' <div class="info_formSearch">';
		vList[vCount++] =  ' 	<button class="closeSearch"><img src="'+UserTopApp.request+'/ibsUserImg/close.png" alt="닫기" /></button>';
		vList[vCount++] =  ' 	<div class="total">';
		vList[vCount++] =  ' 		<ul>';
		vList[vCount++] =  ' 			<li class="likeSearch" id ="favoriteSearchCount">'+vData[0].FAVORITE_COUNT+'</li>';
		vList[vCount++] =  ' 			<li class="viewSearch" id ="viewSearchCount">'+vData[0].VIEW_COUNT+'</li>';
		vList[vCount++] =  ' 		</ul>';
		vList[vCount++] =  ' 	</div>';
		vList[vCount++] =  ' 	<h4>그것만이 내 세상</h4>';
		vList[vCount++] =  ' 	<div class="tab_formSearch" id="tabFormSearch_01">';
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

			vList[vCount++] =  ' 	<div class="tab_formSearch" id="tabFormSearch_02">';
			vList[vCount++] =  ' 		<div class="bg"></div>';
			if(vImageList.length <= 4){
				vList[vCount++] =  ' 		<div class="photo_formSearch none">';	
			}else{
				vList[vCount++] =  ' 		<div class="photo_formSearch">';
			}
			
			for(var i = 0 ; i < vImageList.length; i++){
				vList[vCount++] =  ' 			<div class="img">';
				vList[vCount++] =  ' 			<img src="'+vImageList[i].PHOTO_PATH+'" style ="height: 294px;"/>';
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
			vList[vCount++] =  ' 	<div class="tab_formSearch" id="tabFormSearch_03">';
			vList[vCount++] =  ' 		<div class="bg"></div>';
			vList[vCount++] =  ' 		<div class="scrollbar" style="max-height: 425px;">'+vData[0].BOARD_CONTENT+'</div>';
			vList[vCount++] =  ' 	</div>';
	
		}
		vList[vCount++] =  ' </div>';

		jQuery("#showSearch_"+vViewCount).append(vList.join(''));  

			
			{
	
				
				
				$(".info > ul > li > button").click(function () {
					$(".download").show(300);
				});
				$(".download button").click(function () {
					$(".download").hide(300);
				});
				
				$('.cycle-slideshowSearch').cycle({   
					fx:     'fade', 
					speed:  'fast', 
					timeout: 3000,  
					next:   '.next', 
					prev:   '.prev' 
				});
				
				if(vImageList != null && vImageList.length >= 4){
					$('.photo_formSearch').bxSlider({
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
				
		
				
				$(".tabSearch a").click(function () {
					$(".tabSearch a").removeClass("on");
					$(this).addClass("on");
					$(".tab_formSearch").hide();
					var tabId = this.id;
			        var tabForm = tabId.replace("tab_","");
			        $("#tabFormSearch_"+tabForm).css('display','block');
			        $(".prev").css('display','none');
			        $(".next").css('display','none');
			        if ($(".tabSearch a:first-child").hasClass("on") == true) {
			        	$(".prev").css('display','block');
			        	$(".next").css('display','block');
			        }
				}).css({"cursor":"pointer"});
				$(".tabSearch a:first-child").click();
				
				
				$(".likeSearch").click(function (e) { 
					UserViewSearchApp.VodCountInsert(vVodREPO,"FAVORITE");
					UserViewSearchApp.ShowViewChange(vKEY_IDX);
					
					e.preventDefault();
				}).css({"cursor":"pointer"});

				$(".closeSearch").click(function (e) { 
				
					$(this).parent().parent().parent().find(".form_Searchshow").css("display","none");
					$(".sliderSearch").removeClass("border");
					$(".sliderSearch.border > div > img").removeClass("on");
					$('.cycle-slideshowSearch').cycle('destroy');
					
		 			$(this).parent().parent().parent().find(".form_Searchshow").css("display","none");
		  			$(".search_page").removeClass("border");
		  			$(".search_page.border .hover").removeClass("on");
		  			$(".bx-caption").css("display","block");
					e.preventDefault();

				}).css({"cursor":"pointer"});

				$(".play").click(function (e) {
					
					UserViewSearchApp.VodCountInsert(vVodREPO,"VIEW");
					UserViewSearchApp.ShowViewChange(vKEY_IDX);
					location.href = UserTopApp.request+"/svc/user/vodPlay?vIndex="+vIndexList[2]+"_"+vIndexList[4];
					e.preventDefault();
				}).css({"cursor":"pointer"});
	
			}
		},

		windowResize : function(){
			var sWidth = $(".sliderSearch>div").outerWidth()*2;

			var vWidth = $(window).width();
			var vheight = $(window).height()
			$('.vod_play').css('height', vheight);
			$('.vod_play').css('width', vWidth);

			if($(window).width() > 1024 ) {
				$(".sliderSearch>div").mouseover(function(e){
					e.preventDefault();
					if ($(this).parent("div").hasClass("border") == true){
						$(".sliderSearch>div").removeClass("last");
						$(".sliderSearch").removeClass("on");
						$(this).removeClass("active");
					}else{
						$(".sliderSearch>div").eq(5).addClass("last");
						$(this).parent("div").addClass("on");
						$(this).addClass("active");
						jQuery('.textSearch').show(); 
					}
					return true;
				});
				$(".sliderSearch>div").mouseout(function(){
					$(".sliderSearch").removeClass("on");
					$(this).removeClass("active");
				});

				$(".sliderSearch>div.last").mouseover(function(e){
					e.preventDefault();
					if ($(".sliderSearch>div").hasClass("last") == true){
						$(this).css("left","-210px");
						$(this).parent().find("div").css("left","-210px");
					}else{
						$(this).css("left","0px");
						$(this).parent().find("div").css("left","0px");
					}
					$(".bx-caption").css("left","0px");
					$(".playerSearch").css("left","0px");
					$(".textSearch").css("left","0px");
				});
				$(".sliderSearch>div.last").mouseout(function(){
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
				});

				$(".menu > ul > li").mouseover(function(e){
					e.preventDefault();
					var liWith = $(this).outerWidth()
					var depth2With = $(this).find(".depth2").outerWidth() - liWith;
					$(this).addClass("on");
					$(this).find(".depth2").css("opacity","1");
					$(this).find(".depth2").css({"margin-left":-depth2With/2 +"px"});
				});
				$(".menu > ul > li").mouseout(function(e){
					e.preventDefault();
					$(".menu > ul > li").removeClass("on");
					$(".depth2").css('opacity','0');
				});
				return true;

			}else{
				$(".sliderSearch>div").mouseover(function(e){
					e.preventDefault();
					if ($(this).parent("div").hasClass("border") == true){
						$(".sliderSearch>div").removeClass("last");
						$(".sliderSearch").removeClass("on");
						$(this).removeClass("active");
					}else{
						$(".sliderSearch>div").eq(5).removeClass("last");
						$(this).parent("div").removeClass("on");
						$(this).removeClass("active");
						jQuery('.textSearch').hide(); 
					}
					return true;

				});
				$(".sliderSearch>div").mouseout(function(e){
					e.preventDefault();
					$(".sliderSearch").removeClass("on");
					$(this).removeClass("active");
				});
				$(".sliderSearch>div.last").mouseover(function(e){
					e.preventDefault();
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
					$(".bx-caption").css("left","0px");
					$("playerSearch").css("left","0px");
					$(".textSearch").css("left","0px");
				});
				$(".sliderSearch>div.last").mouseout(function(e){
					e.preventDefault();
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
				});
			}
		},
		
		
		FormLastClass : function(){
			
			
			var vViewPort = ($(".bx-viewport" ).width() / 347);
			var vFormCnt = $('.form_divSearch').length;
			$('.form_divSearch').find(".slider_Searchform").removeClass("last");
			
				for(var i = 0 ; i < vFormCnt; i++){
					var vSliderFromCnt = $('.form_divSearch').eq(i).find(".slider_Searchform").length;
					console.log(Math.round(vViewPort)-1);
					$('.form_divSearch').eq(i).find(".slider_Searchform").eq(Math.round(vViewPort)-1).addClass("last");
					$('.form_divSearch').eq(i).find(".slider_Searchform").eq(vSliderFromCnt-1).addClass("last");
				}
		},
		
		ContentsEvent : function(){
			$('.sliderSearch').bxSlider({
				mode: 'horizontal',
				slideWidth: 340,
				pager: false,
				captions: true,
				minSlides: 2,
				maxSlides: 8,     
				slideMargin: 15,
				controls: true,
				moveSlides: 5,
				captions: true,
				preloadImages: 'all',
				infiniteLoop: false
			});

			$("span.downSearch").click(function () {
				var playerId = this.id;
				var vIndexList = playerId.split("_");
				UserViewSearchApp.showView(vIndexList);

				$(".sliderSearch").removeClass("border");
				$(this).parent().parent().parent("div").addClass("border");
				$(".sliderSearch.border > div").removeClass("on");
				$(this).parent().parent().find("img").parent("div").addClass("on");
				$(".form_Searchshow").css("display","none");
				$(".sliderSearch.border > div > span.triangle").css("display","none");
				$(this).parent().parent().find("span.triangle").css('display','block');
				$("#showSearch_"+vIndexList[1]).css('display','block');

				var offset = $("#showSearch_" + vIndexList[1]).offset(); 
				$('html, body').animate({scrollTop : offset.top-250}, "slow");
			}).css({"cursor":"pointer"});


			$(".playerSearch").click(function() {
				var playerId = $(this).children('span').attr('id');
				var vIndexList = playerId.split("_"); 
				UserViewSearchApp.showView(vIndexList);
				$(".sliderSearch").removeClass("border");
				$(this).parent().parent("div").addClass("border");
				$(".sliderSearch.border > div").removeClass("on");
				$(this).parent().find("img").parent("div").addClass("on");
				$(".form_Searchshow").css("display","none");
				$(".sliderSearch.border > div > span.triangle").css("display","none");
				$(this).parent().find("span.triangle").css('display','block');

				$("#showSearch_"+vIndexList[1]).css('display','block');
				var offset = $("#showSearch_" + vIndexList[1]).offset(); 
				$('html, body').animate({scrollTop : offset.top-250}, "slow");
			}).css({"cursor":"pointer"});


			$(".modalBtnSearch").click(function () {
				var playerId = $(this).parent().find('span').attr("id");
				var vod_path = playerId.split("_");

				location.href = UserTopApp.request+"/svc/user/vodPlay?vIndex="+vod_path[2]+"_"+vod_path[4];

			});

		},


		ShowViewChange : function(vKEY_IDX){
			
			var oData =UserViewSearchApp.MainVodAllList(vKEY_IDX,"VIEW_CHANGE");
			
			var vViewCount = oData[0].VIEW_COUNT;
			var vFavoriteCount = oData[0].FAVORITE_COUNT;
			
			$("#viewSearchCount").text(" "+vViewCount+" ");
			$("#favoriteSearchCount").text(" "+vFavoriteCount+" ");
			
			 
		},

		//-----------------------------------------DB연결-----------------------------------------------------
		LayoutMenuList : function(){	
			var vData = [];
			var vURL = UserViewSearchDB.LayoutMenuList(); 
			jQuery.ajax({async : false, type:"POST" , url: vURL[0] , dataType : "json" , success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},

		MainLaoutVodList : function(){

			var vData = [];
			var vURL = UserViewSearchDB.MainLaoutVodList();
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
			var vURL = UserViewSearchDB.MainVodAllList(vIDX,vFlug);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				if(vFlug == "SHOW_VIEW"){
					UserViewSearchApp.gShowModel = oData.lists;
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
			var vURL = UserViewSearchDB.ModelImageList(image);
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
			var vURL = UserViewSearchDB.ModelFileViewList(vFileIdx);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
		
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});
			return vData;
		},
		
		VodCountInsert : function(vVodREPO,vFlug,vKEY_IDX){ 
			var vURL = UserViewSearchDB.VodCountInsert(vVodREPO,vFlug,vKEY_IDX);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
		
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});
		},

		MenuChildTitle : function(vPID,vIDX){ 

			var vData = [];
			var vURL = UserViewSearchDB.MenuChildTitle(vPID,vIDX);
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
			var vURL = UserViewSearchDB.ShowViewMenuBar(vIDX);
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
			var vURL = UserViewSearchDB.MainVodKeyWord(vSearch);
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1], success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});

			return vData;
		},
		

		
		start : function(Search){
			UserViewSearchApp.Contents(Search);		
			
		}
}; 
var UserViewSearchDB = {

		LayoutMenuList : function(){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];

			vURL += "/svc/LayoutMenuList" ;

			vReturnURL[0] = vURL;
			vReturnURL[1] = vParam;

			return vReturnURL;

		},
		MainLaoutVodList : function(){ 
			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = [];
			
			vURL += "/svc/MainLaoutVodList" ;
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
	UserViewSearchApp.windowResize();
});

