<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>
<script>
  $(function () {
    // 6 create an instance when the DOM is ready
    $('#jstree').jstree();
    $('#jstree').jstree("open_all");
    // 7 bind to events triggered on the tree
   /* $('#jstree').on("changed.jstree", function (e, data) {
      console.log(data.selected);
    });*/
    // 8 interact with the tree - either way is OK
    $('button').on('click', function () {
      $('#jstree').jstree(true).select_node('child_node_1');
      $('#jstree').jstree('select_node', 'child_node_1');
      $.jstree.reference('#jstree').select_node('child_node_1');
    });
  });
  </script>
  <script>
  //Line Chart
    /*$(function () {
        if ($('#line-chart')) {
            var d1 = [[1,150], [2,80], [3,90], [4,16], [5,20], [6,0], [7,0], [8,0], [9,0], [10,0], [11,0],[12,0]];
            var d2 = [[1,45], [2,78], [3,59], [4,60], [5,14], [6,0], [7,0], [8,0], [9,0], [10,0], [11,0],[12,0]];
            $.plot('#line-chart', [ {
                data: d1,
                label: "web",
            },
            {
                data: d2,
                label: "mobile",
            },
            
            ],

                {
                    series: {
                        lines: {
                            show: true,
                            lineWidth: 1,
                            fill: 0.25,
                        },

                        color: 'rgba(255,255,255,0.7)',
                        shadowSize: 0,
                        points: {
                            show: true,
                        }
                    },

                    yaxis: {
                        min: 0,
                        max: 200,
                        tickColor: 'rgba(255,255,255,0.15)',
                        tickDecimals: 0,
                        font :{
                            lineHeight: 13,
                            style: "normal",
                            color: "rgba(255,255,255,0.8)",
                        },
                        shadowSize: 0,
                    },
                    xaxis: {
                        tickColor: 'rgba(255,255,255,0)',
                        tickDecimals: 0,
                        font :{
                            lineHeight: 13,
                            style: "normal",
                            color: "rgba(255,255,255,0.8)",
                        }
                    },
                    grid: {
                        borderWidth: 1,
                        borderColor: 'rgba(255,255,255,0.25)',
                        labelMargin:10,
                        hoverable: true,
                        clickable: true,
                        mouseActiveRadius:6,
                    },
                    legend: {
                        show: true
                    }
                });

            $("#line-chart").bind("plothover", function (event, pos, item) {
                if (item) {
                    var x = item.datapoint[0].toFixed(2),
                        y = item.datapoint[1].toFixed(2);
                    $("#linechart-tooltip").html(item.series.label + " of " + x + " = " + y).css({top: item.pageY+5, left: item.pageX+5}).fadeIn(200);
                }
                else {
                    $("#linechart-tooltip").hide();
                }
            });

            $("<div id='linechart-tooltip' class='chart-tooltip'></div>").appendTo("body");
        }

    });*/
    $(function () {
        if ($('#line-chart2')) {
            var d1 = [[1,14], [2,15], [3,18], [4,16], [5,19], [6,17], [7,15], [8,16], [9,20], [10,16], [11,18],[12,14], [13,18], [14,18], [15,16], [16,19], [17,17], [18,15], [19,16], [20,30], [21,20], [22,15], [23,7], [24,20], [25,20], [26,9], [27,], [28,2], [29,0], [30,0], [31,0]];
            var d2 = [[1,15], [2,18], [3,12], [4,20], [5,14], [6,12], [7,10], [8,13], [9,15], [10,11], [11,10],[12,14], [13,4], [14,31], [15,47], [16,10], [17,31], [18,15], [19,16], [20,8], [21,7], [22,20], [23,9], [24,12], [25,31], [26,45], [27,35], [28,1], [29,0], [30,0], [31,0]];
            $.plot('#line-chart2', [ {
                data: d1,
                label: "web",
            },
            {
                data: d2,
                label: "mobile",
            },
            
            ],

                {
                    series: {
                        lines: {
                            show: true,
                            lineWidth: 1,
                            fill: 0.25,
                        },

                        color: 'rgba(255,255,255,0.7)',
                        shadowSize: 0,
                        points: {
                            show: true,
                        }
                    },

                    yaxis: {
                        min: 0,
                        max: 50,
                        tickColor: 'rgba(255,255,255,0.15)',
                        tickDecimals: 0,
                        font :{
                            lineHeight: 13,
                            style: "normal",
                            color: "rgba(255,255,255,0.8)",
                        },
                        shadowSize: 0,
                    },
                    xaxis: {
                        tickColor: 'rgba(255,255,255,0)',
                        tickDecimals: 0,
                        font :{
                            lineHeight: 13,
                            style: "normal",
                            color: "rgba(255,255,255,0.8)",
                        }
                    },
                    grid: {
                        borderWidth: 1,
                        borderColor: 'rgba(255,255,255,0.25)',
                        labelMargin:10,
                        hoverable: true,
                        clickable: true,
                        mouseActiveRadius:6,
                    },
                    legend: {
                        show: true
                    }
                });

            $("#line-chart2").bind("plothover", function (event, pos, item) {
                if (item) {
                    var x = item.datapoint[0].toFixed(2),
                        y = item.datapoint[1].toFixed(2);
                    $("#linechart-tooltip").html(item.series.label + " of " + x + " = " + y).css({top: item.pageY+5, left: item.pageX+5}).fadeIn(200);
                }
                else {
                    $("#linechart-tooltip").hide();
                }
            });

            $("<div id='linechart-tooltip' class='chart-tooltip'></div>").appendTo("body");
        }

    });
    $(function () {
        if ($('#line-chart3')) {
            var d1 = [[1,14], [2,15], [3,18], [4,16], [5,19], [6,17], [7,15], [8,16], [9,20], [10,16], [11,4],[12,0], [13,0], [14,0], [15,0], [16,0], [17,0], [18,0], [19,0], [20,0], [21,0], [22,0],[23,0],[24,0]];
            var d2 = [[1,1], [2,8], [3,2], [4,0], [5,4], [6,12], [7,10], [8,13], [9,5], [10,11], [11,0],[12,0], [13,0], [14,0], [15,0], [16,0], [17,0], [18,0], [19,0], [20,0], [21,0], [22,0],[23,0],[24,0]];
            $.plot('#line-chart3', [ {
                data: d1,
                label: "web",
            },
            {
                data: d2,
                label: "mobile",
            },
            
            ],

                {
                    series: {
                        lines: {
                            show: true,
                            lineWidth: 1,
                            fill: 0.25,
                        },

                        color: 'rgba(255,255,255,0.7)',
                        shadowSize: 0,
                        points: {
                            show: true,
                        }
                    },

                    yaxis: {
                        min: 0,
                        max: 40,
                        tickColor: 'rgba(255,255,255,0.15)',
                        tickDecimals: 0,
                        font :{
                            lineHeight: 13,
                            style: "normal",
                            color: "rgba(255,255,255,0.8)",
                        },
                        shadowSize: 0,
                    },
                    xaxis: {
                        tickColor: 'rgba(255,255,255,0)',
                        tickDecimals: 0,
                        font :{
                            lineHeight: 13,
                            style: "normal",
                            color: "rgba(255,255,255,0.8)",
                        }
                    },
                    grid: {
                        borderWidth: 1,
                        borderColor: 'rgba(255,255,255,0.25)',
                        labelMargin:10,
                        hoverable: true,
                        clickable: true,
                        mouseActiveRadius:6,
                    },
                    legend: {
                        show: true
                    }
                });

            $("#line-chart3").bind("plothover", function (event, pos, item) {
                if (item) {
                    var x = item.datapoint[0].toFixed(2),
                        y = item.datapoint[1].toFixed(2);
                    $("#linechart-tooltip").html(item.series.label + " of " + x + " = " + y).css({top: item.pageY+5, left: item.pageX+5}).fadeIn(200);
                }
                else {
                    $("#linechart-tooltip").hide();
                }
            });

            $("<div id='linechart-tooltip' class='chart-tooltip'></div>").appendTo("body");
        }

    });
    </script>
<!-- Content -->
<section id="content" class="container">
    <!-- Messages Drawer 메세지 클릭햇을시 (최신영상이 )%%%대메뉴 공통 부 분-->
	<div id="messages" class="tile drawer animated">
		<c:import url = "/inc/incMsg">
			<c:param name = "q" value = "보라매공원" />
		</c:import>
	</div>

	<!-- Notification Drawer -->
	<div id="notifications" class="tile drawer animated">
		<c:import url = "/inc/incNoti">
			<c:param name = "q" value = "보라매공원" />
		</c:import>
	</div>
	<!--메뉴경로... -->
	<ol class="breadcrumb hidden-xs">
	    <li><a href="#">Home</a></li>
	    <li class="active">CONTENTS ANALIZER</li>
	</ol>
	<!-- 대메뉴-->
	<h4 class="page-title">CONTENTS ANALIZER</h4>
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
	   		<div class="col-md-6">
	        	<h3 class="block-title">웹 접속 통계</h3>
	        	<div class="tab-container tile">
                   <ul class="nav tab nav-tabs">
                        <li class="active"><a href="#webByYear">연도별 통계</a></li>
                        <li><a href="#webByMonth">월별 통계</a></li>
                        <li><a href="#webByDay">일별통계</a></li>
                        <li><a href="#webByHour">시간별통계</a></li>
                    </ul>
                   <div class="tab-content">
                   		<div class="tab-pane active" id="webByYear">
                       		<div class="p-10">
                           		<div id="line-chart2" class="main-chart2" style="height: 250px"></div>
                       		</div>
                      	</div>
                   		<div class="tab-pane" id="webByMonth">
                       		
               			</div>
               			<div class="tab-pane" id="webByDay">
                   			<!-- <div class="p-10">
                            		<div id="line-chart2" class="main-chart2" style="height: 250px"></div>
                        	</div> -->
                      	</div>
                   		<div class="tab-pane" id="webByHour">
                   			<!-- <div class="p-10">
                            		<div id="line-chart3" class="main-chart3" style="height: 250px"></div>
                        		</div> -->
               			</div>
               			<div class="clearfix"></div>
                 	</div>
                </div>
	    	</div>
	    	
	    	<div class="col-md-6">
	    		<h3 class="block-title">OTT 접속 통계</h3>
	    		<div class="tab-container tile">
                   <ul class="nav tab nav-tabs">
                        <li class="active"><a href="#stbByYear">연도별 통계</a></li>
                        <li><a href="#stbByMonth">월별 통계</a></li>
                        <li><a href="#stbByDay">일별통계</a></li>
                        <li><a href="#stbByHour">시간별통계</a></li>
                    </ul>
                   <div class="tab-content">
                   		<div class="tab-pane active" id="stbByYear">
                   			<div class="p-10">
                           		<div id="line-chart3" class="main-chart3" style="height: 250px"></div>
                       		</div>
                      	</div>
                   		<div class="tab-pane" id="stbByMonth">
                   			B
               			</div>
               			<div class="tab-pane" id="stbByDay">
                   			C
                      	</div>
                   		<div class="tab-pane" id="stbByHour">
                   			D
               			</div>
               			<div class="clearfix"></div>
                 	</div>
                </div>
    		</div>
    		<div class="col-md-6">
	        	<h3 class="block-title">컨텐츠 통계</h3>
	        	 <div class="tab-container tile">
                   <ul class="nav tab nav-tabs">
                        <li class="active"><a href="#contentsByYear">총순위</a></li>
                        <li><a href="#contentsByMonth">월순위</a></li>
                        <li><a href="#contentsByDay">일순위</a></li>
                        <li><a href="#contentsByHour">시간순위</a></li>
                    </ul>
                   <div class="tab-content">
                   		<div class="tab-pane active" id="contentsByYear">
                   			<div class="m-b-10">
                    	 		한국영화 > 멜로 > 도깨비 - 250
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 블랙코메디 > 해피버스데이 - 221
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="71" aria-valuemin="0" aria-valuemax="100" style="width: 71%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		스포츠 > 야구 > LG - 198
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100" style="width: 65%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 정치 > 이명박 구속 - 182
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="61" aria-valuemin="0" aria-valuemax="100" style="width: 61%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 경제 > 비트코인 하락 - 175
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100" style="width: 58%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 > JTBC > 도깨비 3화 - 130
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 >SBS > 키스 먼저 할까요? 2회 - 121
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="51" aria-valuemin="0" aria-valuemax="100" style="width: 51%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		스포츠 > 익스트림 > UFC - 52
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="48" aria-valuemin="0" aria-valuemax="100" style="width: 48%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 > KBS > 황금빛 내 인생 56화 - 38
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뮤직비디오 > 직캠 > BTOB - 25
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="42" aria-valuemin="0" aria-valuemax="100" style="width: 42%"></div>
                    			</div>
                      		</div>
                      	</div>
                   		<div class="tab-pane" id="contentsByMonth">
                   			<div class="m-b-10">
                    	 		한국영화 > 멜로 > 도깨비 - 250
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 블랙코메디 > 해피버스데이 - 221
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="71" aria-valuemin="0" aria-valuemax="100" style="width: 71%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		스포츠 > 야구 > LG - 198
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100" style="width: 65%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 정치 > 이명박 구속 - 182
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="61" aria-valuemin="0" aria-valuemax="100" style="width: 61%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 경제 > 비트코인 하락 - 175
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100" style="width: 58%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 > JTBC > 도깨비 3화 - 130
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 >SBS > 키스 먼저 할까요? 2회 - 121
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="51" aria-valuemin="0" aria-valuemax="100" style="width: 51%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="48" aria-valuemin="0" aria-valuemax="100" style="width: 48%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="42" aria-valuemin="0" aria-valuemax="100" style="width: 42%"></div>
                    			</div>
                      		</div>
               			</div>
               			<div class="tab-pane" id="contentsByDay">
                   			<div class="m-b-10">
                    	 		한국영화 > 멜로 > 도깨비 - 250
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 블랙코메디 > 해피버스데이 - 221
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="71" aria-valuemin="0" aria-valuemax="100" style="width: 71%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		스포츠 > 야구 > LG - 198
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100" style="width: 65%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 정치 > 이명박 구속 - 182
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="61" aria-valuemin="0" aria-valuemax="100" style="width: 61%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 경제 > 비트코인 하락 - 175
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100" style="width: 58%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 > JTBC > 도깨비 3화 - 130
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 >SBS > 키스 먼저 할까요? 2회 - 121
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="51" aria-valuemin="0" aria-valuemax="100" style="width: 51%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="48" aria-valuemin="0" aria-valuemax="100" style="width: 48%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="42" aria-valuemin="0" aria-valuemax="100" style="width: 42%"></div>
                    			</div>
                      		</div>
                      	</div>
                   		<div class="tab-pane" id="contentsByHour">
                   			<div class="m-b-10">
                    	 		한국영화 > 멜로 > 도깨비 - 250
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 블랙코메디 > 해피버스데이 - 221
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="71" aria-valuemin="0" aria-valuemax="100" style="width: 71%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		스포츠 > 야구 > LG - 198
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100" style="width: 65%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 정치 > 이명박 구속 - 182
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="61" aria-valuemin="0" aria-valuemax="100" style="width: 61%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 경제 > 비트코인 하락 - 175
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100" style="width: 58%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 > JTBC > 도깨비 3화 - 130
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 >SBS > 키스 먼저 할까요? 2회 - 121
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="51" aria-valuemin="0" aria-valuemax="100" style="width: 51%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="48" aria-valuemin="0" aria-valuemax="100" style="width: 48%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 액션 > 주먹이 운다 - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="42" aria-valuemin="0" aria-valuemax="100" style="width: 42%"></div>
                    			</div>
                      		</div>
               			</div>
               			<div class="clearfix"></div>
                 	</div>
                </div>
	    	</div>
	    	<div class="col-md-6">
	    		<h3 class="block-title">장비별 통계</h3>
	    		<div class="tab-container tile">
                   <ul class="nav tab nav-tabs">
                        <li class="active"><a href="#equipmentByYear">총순위</a></li>
                        <li><a href="#equipmentByMonth">월순위</a></li>
                        <li><a href="#equipmentByDay">일순위</a></li>
                        <li><a href="#equipmentByHour">시간순위</a></li>
                    </ul>
                   <div class="tab-content">
                   		<div class="tab-pane active" id="equipmentByYear">
                   			<table class="table table-bordered table-hover tile" style="">
                          		<thead>
                              	<tr>
                                  <th>그룹명</th>
                                  <th>그래프</th>
                              	</tr>
                          		</thead>
                          		<tbody>
	                          	<tr>
	                          		<td>1본부 구미</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>일산 PCC</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>엔지니어 미팅실</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100" style="width: 72%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>의정부 PCC</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="68" aria-valuemin="0" aria-valuemax="100" style="width: 68%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>6본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="61" aria-valuemin="0" aria-valuemax="100" style="width: 61%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>창원사무소</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>거제 사무소</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="48" aria-valuemin="0" aria-valuemax="100" style="width: 48%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>일산 PCC</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>기획자 미팅실</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" style="width: 15%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>의정부 PCC</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="7" aria-valuemin="0" aria-valuemax="100" style="width: 7%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
                          		</tbody>
                          	</table>
                      	</div>
                   		<div class="tab-pane" id="equipmentByMonth">
                   			<table class="table table-bordered table-hover tile" style="">
                          		<thead>
                              	<tr>
                                  <th>그룹</th>
                                  <th>장비명</th>
                                  <th>그래프</th>
                              	</tr>
                          		</thead>
                          		<tbody>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
                          		</tbody>
                          	</table>
               			</div>
               			<div class="tab-pane" id="equipmentByDay">
                   			<table class="table table-bordered table-hover tile" style="">
                          		<thead>
                              	<tr>
                                  <th>그룹</th>
                                  <th>장비명</th>
                                  <th>그래프</th>
                              	</tr>
                          		</thead>
                          		<tbody>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
                          		</tbody>
                          	</table>
                      	</div>
                   		<div class="tab-pane" id="equipmentByHour">
                   			<table class="table table-bordered table-hover tile" style="">
                          		<thead>
                              	<tr>
                                  <th>그룹</th>
                                  <th>장비명</th>
                                  <th>그래프</th>
                              	</tr>
                          		</thead>
                          		<tbody>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									
	                          		<td style="width:80%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
                          		</tbody>
                          	</table>
               			</div>
               			<div class="clearfix"></div>
                 	</div>
                </div>
    		</div>		
	    </div>
   	</div>
</section>

<!-- Older IE Message -->
<!--[if lt IE 9]>
    <div class="ie-block">
        <h1 class="Ops">Ooops!</h1>
        <p>You are using an outdated version of Internet Explorer, upgrade to any of the following web browser in order to access the maximum functionality of this website. </p>
        <ul class="browsers">
            <li>
                <a href="https://www.google.com/intl/en/chrome/browser/">
                    <img src="${pageContext.request.contextPath}/img/browsers/chrome.png" alt="">
                    <div>Google Chrome</div>
                </a>
            </li>
            <li>
                <a href="http://www.mozilla.org/en-US/firefox/new/">
                    <img src="${pageContext.request.contextPath}/img/browsers/firefox.png" alt="">
                    <div>Mozilla Firefox</div>
                </a>
            </li>
            <li>
                <a href="http://www.opera.com/computer/windows">
                    <img src="${pageContext.request.contextPath}/img/browsers/opera.png" alt="">
                    <div>Opera</div>
                </a>
            </li>
            <li>
                <a href="http://safari.en.softonic.com/">
                    <img src="${pageContext.request.contextPath}/img/browsers/safari.png" alt="">
                    <div>Safari</div>
                </a>
            </li>
            <li>
                <a href="http://windows.microsoft.com/en-us/internet-explorer/downloads/ie-10/worldwide-languages">
                    <img src="${pageContext.request.contextPath}/img/browsers/ie.png" alt="">
                    <div>Internet Explorer(New)</div>
                </a>
            </li>
        </ul>
        <p>Upgrade your browser for a Safer and Faster web experience. <br/>Thank you for your patience...</p>
    </div>   
<![endif]-->
