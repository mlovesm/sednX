var calendarList=new Array();
Calendar = function(eleId,clsNm,calNm){
	this.elementId=eleId;
	this.className=clsNm;
	this.calendarName=calNm;
	this.rYear="";
	this.rMonth="";
	this.rDay="";
	this.weekdaysArray=["일","월","화","수","목","금","토"];
	this.showDuplCalendar="N";
	
	this.display=function(){
		if($("#"+this.elementId).attr("class").indexOf(this.className)==-1){
			if(this.showDuplCalendar!="Y"){
				var cal;
				for(var i=0;i<calendarList.length;i++){
					cal=calendarList[i];
					if(cal.elementId!=this.elementId){
						$("#"+cal.elementId).removeClass(cal.className);
						$("#"+cal.elementId).hide();
					}
				}
			}
			this.makeCalendarHTML();
			$("#"+this.elementId).addClass(this.className);
			$("#"+this.elementId).show();
			$("#"+this.elementId).css("z-index","9999");
		}else{
			$("#"+this.elementId).removeClass(this.className);
			$("#"+this.elementId).hide();
		}
	};
	
	this.makeCalendarHTML=function(direction){
		debugger;
		var today=new Date();
		var tDay=today.getDate();
		var tMonth=today.getMonth()+1;
		var tYear=today.getFullYear();
		if(this.rYear==null||this.rYear==""){
			this.rYear=tYear;
			this.rMonth=tMonth;
			this.rDay=tDay;
		}
		var rY=this.rYear;
		var rM=this.rMonth;
		var rD=this.rDay;
		var el=this.elementId;
		var cl=this.className;
		var calNm=this.calendarName;
		if((rM+"").length<2)rM='0'+rM;
		if(direction=="P"){
			rM=Number(rM)-1;if((rM+"").length<2)rM='0'+rM;if(rM=="00"){rM="12";rY--;this.rYear=rY;}
			this.rMonth=rM;
		}else if(direction=="N"){
			rM=Number(rM)+1;
			if((rM+"").length<2)rM='0'+rM;
			if(rM=="13"){
				rM="01";rY++;this.rYear=rY;
			}
			this.rMonth=rM;
		}
	var d1=new Date(rY,Number(rM)-1,"01");
	var firstDayOfWeek=d1.getDay();
	var calendarLineCount=0;
	var monthDay=30;
	switch(rM.toString()){
	case"01":
	case"03":
	case"05":
	case"07":
	case"08":
	case"10":
	case"12": monthDay=31;
	break;
	case"02":
		if(((rY%4==0)&&(rY%100!=0))||(rY%400==0))
			monthDay=29;
		else
			monthDay=28;
		break;
	case"04":
	case"06":
	case"09":
	case"11": monthDay=30;
	break;
	}
	if(firstDayOfWeek==5){
		if(monthDay==31)
			calendarLineCount=6;
		else
			calendarLineCount=5;
		
	}else if(firstDayOfWeek==6){
		if(monthDay>=30)
			calendarLineCount=6;
		else
			calendarLineCount=5;
	}else if(firstDayOfWeek==0){
		if(monthDay==28)
			calendarLineCount=4;else
				calendarLineCount=5;
	}else{
		calendarLineCount=5;
	}
var calendarHTML="";
calendarHTML="<div class=\"sbsmdcal_inner\">"+"		<p class=\"sbsmdcal_head\">"+"			<strong class=\"sbamdc_thism\">"+rY+"."+rM+"</strong>"+"			<button type=\"button\" class=\"sbtn b_calfnc_prev\" onclick=\""+calNm+".makeCalendarHTML('P');\"><i class=\"icn\"><span class=\"ir\">이전달</span></i></button>"+"			<button type=\"button\" class=\"sbtn b_calfnc_next\" onclick=\""+calNm+".makeCalendarHTML('N');\"><i class=\"icn\"><span class=\"ir\">다음달</span></i></button>"+"		</p>"+"		<table class=\"sbsmd_calendar\" summary=\"날짜 선택\">"+"			<thead>"+"				<tr>"+"					<th scope=\"col\"><i class=\"i_cal_sun\"><span class=\"date\">Sun</span></i></th>"+"					<th scope=\"col\"><i class=\"i_cal_mon\"><span class=\"date\">Mon</span></i></th>"+"					<th scope=\"col\"><i class=\"i_cal_tue\"><span class=\"date\">Tue</span></i></th>"+"					<th scope=\"col\"><i class=\"i_cal_wed\"><span class=\"date\">Wed</span></i></th>"+"					<th scope=\"col\"><i class=\"i_cal_thu\"><span class=\"date\">Thu</span></i></th>"+"					<th scope=\"col\"><i class=\"i_cal_fri\"><span class=\"date\">Fri</span></i></th>"+"					<th scope=\"col\"><i class=\"i_cal_sat\"><span class=\"date\">Sat</span></i></th>"+"				</tr>"+"			</thead>"+"		<tbody>";
for(var rowCnt=1;rowCnt<=calendarLineCount;rowCnt++){
	calendarHTML+="		<tr>";
	for(var columnCnt=0;columnCnt<7;columnCnt++){
		var kNum=(rowCnt-1)*7+columnCnt;
		if(kNum>=firstDayOfWeek&&kNum<firstDayOfWeek+monthDay){
			var nDigit=kNum-firstDayOfWeek+1;
			if(nDigit==rD)calendarHTML+="<td><button type='button' class='b_cal_date today' onclick='"+calNm+".selCalendarDate("+rY+","+rM+","+nDigit+")'>"+nDigit+"</button></td>";
			else calendarHTML+="<td><button type='button' class='b_cal_date' onclick='"+calNm+".selCalendarDate("+rY+","+rM+","+nDigit+")'>"+nDigit+"</button></td>";
		}else{calendarHTML+="<td></td>";
		}
	}
	calendarHTML+="            </tr>";
}
calendarHTML+=" </tbody>"+"           </table>"+"       <button type=\"button\" onClick=\""+calNm+".display(); return false;\" class=\"sbtn b_sbsmdc_close\"><i class=\"icn\"><span class=\"ir\">닫기</span></i></button>"+"    </div>"+"</div>";
$("#"+el).html(calendarHTML);};

this.selCalendarDatePrev=function(){
	debugger;
	var strDate1 = calendar.rYear + "-" + (((calendar.rMonth + "").length < 2) ? "" + calendar.rMonth : calendar.rMonth) +"-"+ (((calendar.rDay + "").length < 2) ? "" + calendar.rDay	: calendar.rDay);
	var strDate2 = UserLiveApp.Now.getFullYear()+"-"+(UserLiveApp.Now.getMonth()+1)+"-"+UserLiveApp.Now.getDate();
	var arr1 = strDate1.split('-');
	var arr2 = strDate2.split('-');
	var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
	var dat2 = new Date(arr2[0], arr2[1], arr2[2]);
	var diff = dat1 - dat2;
	var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
	var currMonth = currDay * 30;// 월 만듬
	var currYear = currMonth * 12; // 년 만듬

	UserLiveApp.CalendarIndex = parseInt(diff/currDay);
	UserLiveApp.schedule();
	cal.display();
	
};
this.selCalendarDate=function(sYear,sMonth,sDay){
	this.rYear=sYear;
	this.rMonth=sMonth;
	this.rDay=sDay;
	this.selCalendarDatePrev();
	this.display();
};
this.onClickButton=function(btnId,cal){
	if(cal==null)cal=calendar;
	var el=this.elementId;
	$("#"+btnId).click(function(){
		cal.display();
	});
};

calendarList.push(this);};
var calendar=new Calendar("schedule","on","calendar");