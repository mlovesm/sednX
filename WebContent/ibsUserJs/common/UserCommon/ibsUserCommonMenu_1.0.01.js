var UserMenuViewApp ={
		gFlug : "",
		gShowModel : null,
		
		MenuContents : function(vIdx){
			var vSplit = vIdx.split("_");
			var vMainContents = UserViewApp.MenuChildTitle(vSplit[0],vSplit[1]); // 레이아웃 제목 가져오기
			var vMainVodList = UserViewApp.MainVodAllList(vSplit[1],UserMenuViewApp.gFlug) ;
			var vList = [];
			var vCount = 0;
			vList[vCount++] =  ' <div class="slider_container"> ';
			vList[vCount++] =  '  <div class="form_div" style ="padding-left: 13px;">	'; 
			vList[vCount++] =  ' 	<h2>'+vMainContents[0].CATEGORY_NAME +'</h2> ';	
			vList[vCount++] =  '	<div class="option_menu right">';
			vList[vCount++] =  ' 		<ul>';
			vList[vCount++] =  ' 			<li><a href='+UserTopApp.request+'/svc/user/vodMenuChildNew?vIndex='+vIdx+'>최신</a></li>';
			vList[vCount++] =  ' 			<li><a href='+UserTopApp.request+'/svc/user/vodMenuChildFavorite?vIndex='+vIdx+'>인기</a></li>';
			vList[vCount++] =  ' 			<li><a href='+UserTopApp.request+'/svc/user/vodMenuChildTitle?vIndex='+vIdx+'>제목</a></li>';
			vList[vCount++] =  ' 	 	</ul>';
			vList[vCount++] =  ' 	</div>';
			vList[vCount++] =  ' 	<div class="search_page"> ';
			for(var j = 0 ; j < vMainVodList.length; j++){
				vList[vCount++] =  '  <div class="img_layout">';
				vList[vCount++] =  '  	<div class="hover">';
				vList[vCount++] =  '  <span class="triangle"></span>';
				vList[vCount++] =  '  		<img src="'+vMainVodList[j].MAIN_THUMBNAIL+'" alt="샘플 이미지1" title="'+vMainVodList[j].VOD_TITLE+'" />';
				vList[vCount++] =  '  		<div class="bx-caption"><span>'+vMainVodList[j].VOD_TITLE+'</span></div>';
				vList[vCount++] =  '  		<div class="text_form">';
				vList[vCount++] =  '  		<img src="'+vMainVodList[j].MAIN_THUMBNAIL+'" alt="샘플 이미지1" title="'+vMainVodList[j].VOD_TITLE+'" />';
				vList[vCount++] =  '  			<button class="modalBtn" id="modalBtn_0'+(j+1)+'"><img src="'+UserTopApp.request+'/ibsUserImg/btn_play.png"  alt="재생" /></button>';
				vList[vCount++] =  '  			<div class="text">';
				vList[vCount++] =  ' 						<h3>'+vMainVodList[j].VOD_TITLE+'</h3>';  
				vList[vCount++] =  ' 						<p>'+vMainVodList[j].EDIT_DT+'</p>'; 
				vList[vCount++] =  ' 						<p>'+vMainVodList[j].VOD_CONTENT+'</p>'; 
				vList[vCount++] =  '  			</div>';
				vList[vCount++] =  ' 			<span class="arr" id="down_0'+(j+1)+'_'+vMainVodList[j].KEY_IDX+'_'+vMainVodList[j].VOD_REPO+'_'+vMainVodList[j].IDX+'" ><img src="'+UserTopApp.request+'/ibsUserImg/arr_down.png" alt="down" /></span>'; 
				vList[vCount++] =  '  		</div>';
				vList[vCount++] =  '  	</div>';
				vList[vCount++] =  '  </div>';
				vList[vCount++] =  ' <div class="form_show" id="show_0'+ (j+1) +'"></div>';	
			}	
			
			vList[vCount++] =  '  	</div>';
			vList[vCount++] =  '  </div>';
			
			vList[vCount++] =  ' <div class="show_modal"></div>';
			
			$('.slider_container').append(vList.join('')); 
			
			{
				UserMenuViewApp.windowResize();
			  	$("span.arr").click(function () {
			  		
			  		$(".search_page").removeClass("border");
			  		$(this).parent().parent().parent().parent("div").addClass("border");
			  		$(".search_page.border .hover").removeClass("on");
			  		$(this).parent().parent().find("img").parent("div").addClass("on");
			  		$(".form_show").css("display","none");
			  		$(".search_page.border span.triangle").css("display","none");
			  		$(this).parent().parent().find("span.triangle").css('display','block');
			  		var playerId = this.id;
			        var show = playerId.replace("down_","");
			        $("#show_"+show).css('display','block');
				}).css({"cursor":"pointer"});

			  	
			  	
		  		$(".text_form").click(function () {
		  			var playerId = $(this).children('span').attr('id');
					var vIndexList = playerId.split("_"); 
		  			if ($(".search_page").hasClass("border") == true) {
		  				UserViewApp.showView(vIndexList);
		  				$(".search_page.border .hover").removeClass("on");
		  				$(this).parent("div").addClass("on");
		  				$(".search_page.border span.triangle").css("display","none");
		  				$(this).parent().parent().find("span.triangle").css('display','block');
		  				$(".form_show").css("display","none");
		  				var formId = this.id;
				        var show = formId.replace("form_","");
				        $("#show_"+vIndexList[1]).css('display','block');
					}else{
				        var offset = $("#show_" + vIndexList[1]).offset(); 
						$('html, body').animate({scrollTop : offset.top-250}, "slow");
		  				
		  			}
		  		}).css({"cursor":"pointer"});
		  		
		  		
			  	
		  		$(".modalBtn").click(function () {
		  			var playerId = $(this).parent().find('span').attr("id");
					var vod_path = playerId.split("_");

					location.href = UserTopApp.request+"/svc/user/vodPlay?vIndex="+vod_path[2]+"_"+vod_path[4];

				}).css({"cursor":"pointer"});
		  		
		  		
			}
		},
		
		windowResize : function(){
			
			if($(window).width() > 1024 ) {
			  	$(".hover").mouseover(function(){
					if ($(this).parent().parent("div").hasClass("border") == true){
						$(".hover").parent().parent("div").removeClass("on");
						$(".text_form .text").css("display","none");
						$(".text_form .arr").css("display","none");
						$(this).removeClass("active");
					}else{
						$(this).parent().parent("div").addClass("on");
						$(this).addClass("active");
						$(".bx-caption").css("display","block");
						$(".text_form .text").css("display","block");
						$(".text_form .arr").css("display","block");
					}
					return true;
				});
			  }else{
			  	$(".hover").mouseover(function(){
					$(".hover").parent().parent("div").removeClass("on");
					$(this).removeClass("active");
					$(".text_form .text").css("display","none");
					$(".text_form .arr").css("display","none");
				});
				$(".hover").mouseout(function(){
					$(this).parent().parent("div").removeClass("on");
					$(this).removeClass("active");
				});
			  }
		},
		
		start : function(vFlug,vIdx){
			UserMenuViewApp.gFlug = vFlug;
			UserMenuViewApp.MenuContents(vIdx);		
			
		}
};



$(window).resize(function (){
	UserMenuViewApp.windowResize();
});

$(window).on("load",function(){
    $(".scrollbar").mCustomScrollbar({
    	theme:"inset"
    });
    
});

