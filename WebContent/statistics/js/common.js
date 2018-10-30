$(function () {
	$(".menu ul li").click(function(){
		if ( $(this).hasClass("menu01")) {
			$(this).addClass("on");
			$(".menu .menu01 .depth2").css("display","block");
		} else {
			$(this).removeClass("on");
			$(".menu .menu01 .depth2").css("display","none");
		}
	});
	$(".left_container ul li").click(function(){
		$(".left_container ul li").removeClass("on");
		$(this).addClass("on");
	});
	$(".btn-help").click(function(){
		$(".help_container").toggle();
	});

	$(".more").click(function(){
		$(".more").css("display","none");
		$(".close").css("display","block");
		$(".list>div.open").addClass("close");

	});
	$(".close").click(function(){
		$(".list>div.open").removeClass("close");
		$(".more").css("display","block");
		$(".close").css("display","none");
	});
	// $("#person").click(function () {
	// 	$("#person2").css("display","block");
	// 	$("#person2").css("opacity","1");
	// 	$("#person").css("opacity","0");
	// 	$("#person").css("display","none");
	// });
	// $("#person2").click(function () {
	// 	$("#person").css("opacity","1");
	// 	$("#person2").css("opacity","0");
	// 	$("#person2").css("display","none");
	// 	$("#person").css("display","block");
	// });

	// $(".tab_contents").hide();
 //    $(".tab ul li:first").addClass("on").show();
 //    $(".tab_contents:first").show();
    
 //    $(".tab ul li").click(function() {
 //        $(".tab ul li").removeClass("on");
 //        $(this).addClass("on");
 //        $(".tab_contents").hide();
 //        var activeTab = $(this).find("a").attr("href");
 //        $(activeTab).show();
 //        $("#time_02").css("height","300px");
	// });

	// function MoveTab(val){
	//     //호출시 파라미터에 따라 보여지는 탭을 조정할 수 있다. 0혹은 null은 처음부터 순서대로 
	//     var tabArray = ["tab_1","tab_2","tab_3","tab_4","tab_5","tab_6","tab_7","tab_8"]; //탭ID 
	//     var viewTab = 4;//보여지는 탭의 총 갯수 
	//     var state=[]; 
	//     if(val == null || val < 0) val = 0; 
	//     for (i=0; i<tabArray.length; i++) { 
	//         var tab = document.getElementById(tabArray[i]); 
	//         if(!isNaN(val)) { 
	//             //val에 따라 보여지는 탭을 정한다. 
	//             if(tabArray.length-viewTab < val){ 
	//                  break; 
	//             } 
	//             //val 시작위치부터 보여지는 탭 갯수까지 표시 
	//             if(i >= val && i < val+viewTab){ 
	//                 tab.style.display = ""; 
	//             }else{ 
	//                 tab.style.display = "none"; 
	//             } 
	//         }       
	//     } 
	//     for (i=0; i<tabArray.length; i++) { 
	//         if(document.getElementById(tabArray[i]).style.display == ""){ 
	//             state.push(i); 
	//         }   
	//     } 
	//     //재귀호출 
	//     if(val=="next"){ 
	//         MoveTab(state[0]+1); 
	//     }else if(val=="prev"){ 
	//         MoveTab(state[0]-1); 
	//     } 
	  
	   
	// } 
	// MoveTab();

	$(".tabButton.prev").click(function() {
		$(".date_container ul").css("margin-left","1000px");
	})
	$(".tabButton.next").click(function() {
		$(".date_container ul").css("margin-left","-1000px");
	});

	$(".disapp.graph01").click(function () {
		$(".graph").hide();
		$(".graph.graph01").show();
		$(".graph.graph01").css("height","300px");
	});
	$(".disapp.graph02").click(function () {
		$(".graph").hide();
		$(".graph.graph02").show();
		$(".graph.graph02").css("height","300px");
	});
	$(".disapp.graph03").click(function () {
		$(".graph").hide();
		$(".graph.graph03").show();
		$(".graph.graph03").css("height","300px");
	});
});