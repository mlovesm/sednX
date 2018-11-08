<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>

<div class="contents">
	<div class="sub_header">
		<ol class="location">
			<li class="li01"><img src="../img/icon_home.png" alt="홈 아이콘"/></li>
			<li class="li02">Statistics</li>
			<li class="li03">VOD 통계<span></span></li>
		</ol>
		<h1>VOD 통계</h1>
	</div>

	<div class="contents_container">
		<div class="leftRight_contents">
			<h2>${map.vod_title}</h2><br/>
			<div class="left">
				<div class="vedio" id="vodViewArea">
					<div class="img_box" id="${map.idx}" style="height: 100%; position: relative; background: url('${pageContext.request.contextPath}${map.main_thumbnail}') no-repeat center;
						background-size: cover; border: 1px solid #888888;">
                  		<a class="play" style="cursor:pointer;" id="letsPlay"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
					</div>
				</div>
			</div>		
			<div class="right">							
				<div class="table_container text-center mb30">
					<table summary="통계 분석/이 표는 날짜, 재생시간, 재생 수, 평균 재생 시간으로 구성">
						<colgroup>
							<col width="auto;" />
							<col width="12%;" />
							<col width="12%;" />
							<col width="12%;" />
							<col width="12%;" />
							<col width="12%;" />
							<col width="12%;" />
							<col width="12%;" />
						</colgroup>
						<thead>
							<tr>
								<th>카테고리</th>
								<th>영상 시간</th>
								<th>총 조회 수</th>
								<th>OTT</th>
								<th>APP</th>
								<th>Web(PC)</th>
								<th>SNS 공유수</th>
								<th>평균 재생 시간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${map.category_name}</td>
								<td>${map.vod_play_time}</td>
								<td>3050</td>
								<td>155</td>
								<td>2012</td>
								<td>393</td>
								<td>1069</td>
								<td>90%</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>	
		<div class="graph mb50">
			<canvas id="time" style="height: 300px;"></canvas>
		</div>
		<div class="search_form mb30 text-center" style="height: 30px;">
			<div class="div_form">
				<div class="div_group">
					기간 검색 :
					<label for="">기간검색시작</label>
					<input type="text" class="datepicker" id="startDate" value="" /> ~
				</div>
				<div class="div_group mr50">
					<label for="">기간검색종류</label>
					<input type="text" class="datepicker" id="endDate" value="" />
				</div>
				<div class="div_group date_select">
					<a class="list-a border" href="#">전일</a><a class="list-a" href="#">7일</a><a class="list-a on" href="#">14일</a><a class="list-a" href="#">1개월</a><a class="list-a" href="#">3개월</a>
				</div>
				<button class="btn-search">검색</button>
			</div>
		</div>
		<div class="text-right">
			<button class="btn btn-excel">엑셀로 저장</button>
		</div>
		<div class="site_container">
			<div id="grid"></div>	
			<div class="table_container text-center">
				<table summary="통계 분석/이 표는 날짜, 재생시간, 재생 수, 평균 재생 시간으로 구성">
					<colgroup>
						<col width="auto;" />
					</colgroup>
					<thead>
						<tr>
							<th>날짜</th>
							<th>총 조회 수</th>
							<th>OTT</th>
							<th>APP</th>
							<th>Web(PC)</th>
							<th>재생시간</th>
							<th>평균 재생 시간</th>
							<th>평균 재생 구간</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>2018.09.06</td>
							<td>1,069</td>
							<td>469</td>
							<td>300</td>
							<td>300</td>
							<td>03:37:04</td>
							<td>00:00:29</td>
							<td>90%</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- pagination -->
               <div class="pagination_container text-center">
                   <ul class="pagination">
                       <li><a href="#"><img src="../img/arr_left02.png" alt="맨처음" /></a></li>
                       <li><a href="#"><img src="../img/arr_left.png" alt="이전" /></a></li>
                       <li><a href="#">1</a></li>
                       <li><a href="#">2</a></li>
                       <li><a href="#">3</a></li>
                       <li><a href="#">4</a></li>
                       <li><a href="#">5</a></li>
                       <li><a href="#">6</a></li>
                       <li><a href="#">7</a></li>
                       <li><a href="#">8</a></li>
                       <li><a href="#">9</a></li>
                       <li><a href="#">10</a></li>
                       <li><a href="#"><img src="../img/arr_right.png" alt="다음" /></a></li>
                       <li><a href="#"><img src="../img/arr_right02.png" alt="마지막" /></a></li>
                   </ul>
               </div><!-- //pagination -->
		</div>		
			
<input type="text" name="categoryIdx" id="categoryIdx" value="${map.categoryIdx}"/>

		<script>
			
			var config = {
				type: 'line',
				data: {
					labels: ['','', '', '', '', '', '', '', '', '', '', '', '', ''],
					datasets: [{
						label: 'OTT',
						fill: false,
						backgroundColor: window.chartColors.red,
						borderColor: window.chartColors.red,
						data: [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
					}, {									
						label: 'APP',
						backgroundColor: window.chartColors.blue,
						borderColor: window.chartColors.blue,
						data: [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
						fill: false,
					}, {									
						label: 'Web(PC)',
						backgroundColor: window.chartColors.orange,
						borderColor: window.chartColors.orange,
						data: [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
						fill: false,
					}]
				},
				options: {
					maintainAspectRatio: false, //높이조절
					responsive: true,
					tooltips: {
						mode: 'index',
						intersect: false,
					},
					hover: {
						mode: 'nearest',
						intersect: true
					},
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true
							}
						}]
					}
				}
			};
			

		</script>

	</div> <!-- //contents_container -->

</div> <!-- //contents -->


<script>
(function() {

})();

var startDate= moment().add(-14, 'days').format('YYYY-MM-DD');
var endDate= moment().format('YYYY-MM-DD');
$("#startDate").val(startDate);
$("#endDate").val(endDate);

var ctx = document.getElementById('time').getContext('2d');
var vod_chart = new Chart(ctx, config);

var grid = new tui.Grid({
    el: $('#grid'),
    scrollX: false,
    scrollY: true,
    virtualScrolling: true,
    bodyHeight: 500,
    columns: [
        { title: '날짜', name: 'Date', width: 200, align: 'center', sortable: true,
        	formatter: function(value, rowData) {
        		//console.log(rowData);
	            return value;
        	}
        },
        { title: '총 조회수', name: '', align: 'right', sortable: true },
        { title: 'OTT', name: 'STB_Count', width: 200, align: 'right', sortable: true },
        { title: 'APP', name: 'APP_Count', width: 200, align: 'right', sortable: true },
        { title: 'Web(PC)', name: 'WEB_Count', width: 200, align: 'right', sortable: true }
    ],
});

$(document).ready(function() {
	$(".datepicker").datepicker({
	    dayNamesMin:["일","월","화","수","목","금","토"], // 요일에 표시되는 형식 설정
	    dateFormat:"yy-mm-dd", //날짜 형식 설정
	    monthNames:["1월","2월","3월","4월","5월","6월","7월",
	       "8월","9월","10월","11월","12월"], //월표시 형식 설정
	    showOn:"button", //버튼 보이기
	    buttonImage: "/statistics/img/icon_calendar.png", //버튼에 보이는 이미지설정
	    buttonImageOnly: true,
	    showMonthAfterYear: true, //년,달 순서바꾸기
	    showAnim:"fold", //애니메이션효과
	    onSelect: function(dateText) {
	    	vodData.getChartData("${map.idx}");
		}
	});
	vodData.getChartData("${map.idx}");

});

var vodData={
	getChartData:function(vod_idx){
		$.ajax({
			url : "${pageContext.request.contextPath}/statistics/vod/getChartData",
			data: {
				"vod_idx": vod_idx,
				"startDate": $("#startDate").val(),
				"endDate": $("#endDate").val()
			},
			success : function(result) {
				console.log(result.response.data.contents);
				var contents = result.response.data.contents;
				
				config.data.labels= [];
				contents.forEach(function(item, index) {
					config.data.labels[index]= item.Date.substr(5);
					config.data.datasets[0].data[index]= item.STB_Count
					config.data.datasets[1].data[index]= item.APP_Count
					config.data.datasets[2].data[index]= item.WEB_Count
				});
				vod_chart.update();
				/* 나이순으로 정렬 */
				var sortingField = "Date";
				result.response.data.contents.sort(function(b, a) { // 오름차순
				    return a[sortingField] - b[sortingField];
				});
				grid.setData(result.response.data.contents);
			},
			error : exception.ajaxException
		});
	},

};

$('.play').click(function(){
	console.log('imgPopup');
	common.delCashPlayer('vodPlayer');
	$.ajax({
		url : "${pageContext.request.contextPath}/api/media/"+ "vod" + "/"+$(this).parent().attr('id'),
		cache : false,
		async : false,
		success : function(responseData){
			common.vodDefault();
			var data=JSON.parse(responseData);
			$('#vodViewTitle').html(data.info.vod_title);
			$('#vodViewDate').html(data.info.reg_dt);
			$('#vodViewDownload').attr('href','${pageContext.request.contextPath}/sedn/download/vod/'+data.info.vodFile.split('.')[1]+'/'+data.info.vodFile.split('.')[0]);
			$('#vodViewCount').html(data.info.view_count);
			$('#vodViewText').html(data.info.vod_content);
			$('#vodViewResolution').html(data.info.resolution);
			$('#vodViewRuntime').html(data.info.vod_play_time);
			$('#vodViewFilesize').html(common.number_to_human_size(data.info.file_size));
			$('#vodViewMainThumb').attr('src','${pageContext.request.contextPath}'+data.info.thumnail_path);
 			$('#vodDefaultImg').attr('src','${pageContext.request.contextPath}'+data.info.thumnail_path);
			
			$("#play_url").val(data.info.vod_path);
			$("#play_thum").val('${pageContext.request.contextPath}'+data.info.thumnail_path);

			$('#letsPlay').css('display','none');
			modalLayer.vodPlayer($('#play_url').val(),$('#play_thum').val(),"vodViewArea");
		},
		error : exception.ajaxException
	});
});

$(".date_select a").bind("click", function(e){
	console.log($(this).text());
	var date_text = $(this).text();
	$(this).addClass('on').siblings().removeClass('on');
	var addData= 0;
	if(date_text === '전일') {
		addData= -1;
	}else if(date_text === '7일') {
		addData= -7;
	}else if(date_text === '14일') {
		addData= -14;
	}else if(date_text === '1개월') {
		addData= -30;
	}else if(date_text === '3개월') {
		addData= -90;
	}
	var startDate= moment().add(addData, 'days').format('YYYY-MM-DD');
	$("#startDate").val(startDate);
	var endDate= moment().format('YYYY-MM-DD');
	$("#endDate").val(endDate);
	
	vodData.getChartData("${map.idx}");
	e.preventDefault();
});

	

</script>
