$(function () {
	$(".gnb > ul > li").mouseover(function(){
		var liaWith = $(this).find("a").outerWidth();
		var liWith = $(this).outerWidth() - 20;
		var liWith2 = liWith + 40;
		var depth2With = liaWith - 40;
		$(this).addClass("on");
		$(this).find(".depth2").css('display','block');
		$(this).find(".depth2").css({"width": liWith + "px"});
	});
	$(".gnb > ul > li").mouseout(function(){
		$(".gnb > ul > li").removeClass("on");
		$(".depth2").hide();
	}); //메뉴 GNB

	$(".textForm").each(function () {
		var bxHeight = $(this).height();
		$(this).css({"margin-top": -bxHeight/2 + "px"});
	}); //메인 슬라이드 텍스트

	//popup
	$(".contents_form").click(function () {
        $("#popup").show();
    });
    $(".info").hover(function(){
            $(".infoForm").css({"opacity": 1});
        }, function(){
            $(".infoForm").css({"opacity": 0});
    });

    $(".down").click(function () {
        $(".downForm").css({"opacity": 1});
    });
    $(".downForm > a").click(function () {
        $(".downForm").css({"opacity": 0});
    });

    $("#popup .close").click(function () {
        $("#popup").hide();
    });
});
