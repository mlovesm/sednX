var UserVodApp ={
		
		MainImage : function(){
			var vList = [];
			var vCount = 0;

			jQuery.ajax({async : false, type:"POST" ,url: UserTopApp.request + "/svc/layoutImage", dataType : "json" , success : function(oData){
				for(var i = 0 ; i < oData.lists.length; i ++){
					vList[vCount++] = "<div><img src='"+oData.lists[i].IMG_NAME+"' /><span class='gra'></span></div>";
				}
				$('.bxslider').append(vList.join('')); 
			},error:function(e){ 
				alert("code:"+e.status+"\n"+"message:"+e.responseText+"\n"+"error:"+e);
			} 
			});


			{
				  $('.bxslider').bxSlider({
					    mode: 'fade',
					    auto: true,
					    speed: 1000,
					    controls: false
					  });

			}

		},
		
		start : function(){
			UserVodApp.MainImage();
			UserViewApp.start("VOD");			

		}
}; 
var UserVodDB = {
		
};
$(document).ready(function() {
	UserVodApp.start();
});

$(window).on("load",function(){
	$(".scrollbar").mCustomScrollbar({
		theme:"inset"
	});
}); 

