var IBSUtil ={
		
		getDataPath : function(vod_path,flag){
			return "/REPOSITORY/" + flag + "/"+vod_path.substring(0,4)+"/"+vod_path.substring(4,6)+"/"+vod_path.substring(6,8)+"/";
		},
		
		getString : function(text,value){
			var vReturn = "";
			if(text == "" || text == null || text == undefined  || text == 'NaN' ){
				text = value;
			}
			return text;
		},
		
		getDate : function(text){
			return (((text + "").length < 2) ? "0" + text : text);
		}

}; 
var UserSearchDB = {};
