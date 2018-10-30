$(function () {
	var sw = $(".slider>div").outerWidth()-373;
	var sww = $(".slider>div").outerWidth()-153;
	var swN = sw/3;
	var swwB = sww/5;
	$(".slider>div").mouseover(function(){
		$(this).css({"width":swN+"px"});
	});
	$(".slider>div").mouseout(function(){
		$(this).css({"width":swwB+"px"});
	});
	$(".slider>div.last").mouseover(function(){
		$(this).css({"left":-swN/2+60+"px"});
		$(".slider>div").css({"left":-swN/2+60+"px"});
	});
	$(".slider>div.last").mouseout(function(){
		$(this).css("left","0px");
		$(".slider>div").css("left","0px");
	});
	$(".menu > ul > li").click(function(){
		var liWith = $(this).outerWidth()
		var depth2With = $(this).find(".depth2").outerWidth() - liWith;
		$(".menu > ul > li").removeClass("on");
		$(this).addClass("on");
		$(".depth2").hide();
		$(this).find(".depth2").css("display","block");
		$(this).find(".depth2").css({"margin-left":-depth2With/2 +"px"});
	});
});
