$(function () {
		var sWidth = $(".slider>div").outerWidth()*2;
		$(window).on('load resize',function(){ 
			
			var vWidth = $(window).width();
			var vheight = $(window).height()
			$('.vod_play').css('height', vheight);
			$('.vod_play').css('width', vWidth);
			
			if($(window).width() > 1024 ) {
				$(".slider>div").mouseover(function(){
					if ($(this).parent("div").hasClass("border") == true){
						$(".slider>div").removeClass("last");
						$(".slider").removeClass("on");
						$(this).removeClass("active");
					}else{
						$(".slider>div").eq(5).addClass("last");
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

				$(".slider>div.last").mouseover(function(){
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
					var liWith = $(this).outerWidth()
					var depth2With = $(this).find(".depth2").outerWidth() - liWith;
					$(this).addClass("on");
					$(".depth2").css("display","block");
					$(this).find(".depth2").css("opacity","1");
					$(this).find(".depth2").css({"margin-left":-depth2With/2 +"px"});
				});
				$(".menu > ul > li").mouseout(function(e){
					$(".menu > ul > li").removeClass("on");
					$(".depth2").css('opacity','0');
					$(".depth2").css("display","none");					
				});
				return true;

			}else{
				$(".slider>div").mouseover(function(){
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
				$(".slider>div").mouseout(function(){
					$(".slider").removeClass("on");
					$(this).removeClass("active");
				});
				$(".slider>div.last").mouseover(function(){
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
					$(".bx-caption").css("left","0px");
					$(".player").css("left","0px");
					$(".text").css("left","0px");
				});
				$(".slider>div.last").mouseout(function(){
					$(this).css("left","0px");
					$(this).parent().find("div").css("left","0px");
				});

				$(".player").click(function () {
					var playerId = this.id;
					var show = playerId.split("_"); 
					$(".slider").removeClass("border");
					$(this).parent().parent().parent("div").addClass("border");
					$(".slider.border > div").removeClass("on");
					$(this).parent().parent().find("img").parent("div").addClass("on");
					$("#show_"+show[1]).css("display","none");
					$(".slider.border > div > span.triangle").css("display","none");
					$(this).parent().parent().find("span.triangle").css('display','block');
					$("#show_"+show[1]).css('display','block');
				});
				return true;
			}


		});
		
		
		/* 20180329 */
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
		});
		$(".tab a:first-child").click();

});



