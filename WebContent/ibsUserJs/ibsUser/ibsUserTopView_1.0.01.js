var UserTopApp ={
		request : "",
		tag : null,
		
		MenuBar : function(vFlug){
			var vList = [];
			var vCount = 0;

			var vData = UserTopApp.ShowViewMenuBar();

			vList[vCount++] =  ' <div class="mo_menu mo">                                               ';
			vList[vCount++] =  ' 	<a id="menu"><img src="'+UserTopApp.request+'/ibsUserImg/btn_menu.png" alt="메뉴" /></a>   ';
			vList[vCount++] =  ' </div>                                                                 ';
		
			vList[vCount++] =  ' <h1>                                                                   ';
			vList[vCount++] =  ' 	<a href="/"><img src="'+UserTopApp.request+'/ibsUserImg/logo.png" alt="SEDN" /></a>      ';
			vList[vCount++] =  ' </h1>                                                                  ';
			
			vList[vCount++] =  ' <div class="menu_bg"></div>                                            ';
			
			if(vFlug == "VOD"){
				vList[vCount++] =  ' <!-- 추가 -->                                                            ';
				vList[vCount++] =  ' <div class="menu" id="menu">                                           ';
				vList[vCount++] =  ' 	<div class="login mo">                                              ';
				vList[vCount++] =  ' 		<img src="'+UserTopApp.request+'/ibsUserImg/login.png" alt="회원사진" /> nickname               ';
				vList[vCount++] =  ' 	</div>                                                             ';
				vList[vCount++] =  ' 	<ul>                                                               ';
				vList[vCount++] =  ' 		<li class="on"><a class="on" >VOD</a></li>                 ';
		
				for(var i = 0; i < vData.length; i ++){
					if(vData[i].PID == '1'){
						vList[vCount++] =  ' 		<li><a href='+UserTopApp.request+'/svc/user/vodMenuParents?vIndex='+vData[i].PID+"_"+vData[i].IDX+'>'+vData[i].CATEGORY_NAME+'</a>                 ';
						
						vList[vCount++] =  ' 			<ul class="depth2">                                         ';
						for(var j = 0; j < vData.length; j ++){
							if(vData[j].PID != '1' && vData[i].IDX == vData[j].PID){
								vList[vCount++] =  '<li id = "'+vData[j].IDX+'_KEY"><a href='+UserTopApp.request+'/svc/user/vodMenuChild?vIndex='+vData[j].PID+"_"+vData[j].IDX+'>'+vData[j].CATEGORY_NAME+'</a></li> ';
							}
						}
						vList[vCount++] =  ' 			</ul>                                                       ';
						vList[vCount++] =  ' 		</li>                                                           ';

					}
				}

				vList[vCount++] =  ' 	</ul>                                                               ';
				vList[vCount++] =  ' </div>                                                                 ';
				vList[vCount++] =  ' <!-- //menu -->                                                        ';
			}else{
				
				vList[vCount++] =  '<p class="title">'+vFlug+'</p>';	
			}
			
			
			
			vList[vCount++] =  ' <div class="right">                                                    ';
			vList[vCount++] =  ' 	<div class="search">                                                ';
			vList[vCount++] =  ' 		<img src="'+UserTopApp.request+'/ibsUserImg/search.png" alt="검색" /> <input type="text" placeholder="제목,내용,키워드 검색" id="searchBox" />       ';
			vList[vCount++] =  ' 	</div>                                                              ';
			vList[vCount++] =  ' 	<div class="login">                                                 ';
			vList[vCount++] =  ' 		<img src="'+UserTopApp.request+'/ibsUserImg/login.png" alt="회원사진" /> nickname               ';
			vList[vCount++] =  ' 	</div>                                                              ';
			vList[vCount++] =  ' </div>';                                                             
			jQuery(".top").append(vList.join(''));
			
			//event 
			{
				$(".menu>ul").css('cursor','pointer');
				
				$(".search img").click(function () {
					$(".search input").toggle(800);
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



				$(".menu_bg").click(function () { 
					$(".menu").css('display','none');
					$(".menu_bg").css('display','none');

				});

				// 20180219 추가
				$(".quick").click(function (e) {
					$(".quick_menu.pc").toggle();
				});

			
				$("#searchBox").keyup(function(key) {
					var vSearch = $("#searchBox").val();
					if(vSearch.length > 0){
						if(key.which != "8"){
							function timer(){
								UserViewSearchApp.start(vSearch);
								$(".contents").css("display","none");
								$(".contentsSearch").css("display","block");	
							}
							setTimeout(timer,50);  
						}
					}else{
						$(".contents").css("display","block");
						$(".contentsSearch").css("display","none");
						$(".slider_containerSearch").empty();
					}
					key.preventDefault();
				});

				
				$("a#menu").click(function () {
					$("div#menu").css('display','block');
				});

			}

		},
		test : function(){

			var filter = "win16|win32|win64|mac|macintel"; 
			if ( navigator.platform ) {
				if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
					//mobile 
					//alert('mobile 접속'); 
				}else{ //pc 
					//alert('pc 접속');  
				}
			}
		},


		//-----------------------------------------DB연결-----------------------------------------------------
		
		ShowViewMenuBar : function(){ 

			var vData = [];
			var vURL = UserTopDB.ShowViewMenuBar();
			jQuery.ajax({async : false, type:"POST" , url: vURL[0], dataType : "json" , data : vURL[1] ,success : function(oData){
				vData = oData.lists;
			},error:function(e){ 
				console.log("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});


			return vData;
		},


		start : function(){
			UserTopApp.test();
			UserTopApp.request = $("#request").val();
			UserTopApp.MenuBar($("#title").val());
			
		}
}; 
var UserTopDB = {
		
		ShowViewMenuBar: function(){ 

			var vReturnURL =[];
			var vURL = UserTopApp.request;
			var vParam = {};

			vURL += "/svc/ShowViewMenuBar" ;  

			vReturnURL[0] = vURL; 
			vReturnURL[1] = vParam; 
			return vReturnURL;

		}

};

$(document).ready(function() {
	UserTopApp.start();
});

$(window).on("load",function(){
	$(".scrollbar").mCustomScrollbar({
		theme:"inset"
	});
}); 

var StringBuffer = function() {
    this.buffer = new Array();
};
StringBuffer.prototype.append = function(str) {
    this.buffer[this.buffer.length] = str;
};
StringBuffer.prototype.toString = function() {
    return this.buffer.join("");
};




