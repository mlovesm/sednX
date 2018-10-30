<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--********** permittsion include **************-->
<c:import url = "/inc/incPermission">
			<c:param name = "permission" value = "1000" />
		</c:import>
<!--********* permittsion include **************-->
<script>
  $(function () {
      if ($('#line-chart')) {
          var d1 = [[1,150], [2,80], [3,90], [4,16], [5,20], [6,35], [7,82], [8,30], [9,73], [10,10], [11,13],[12,80]];
          var d2 = [[1,45], [2,78], [3,59], [4,60], [5,14], [6,24], [7,45], [8,54], [9,29], [10,49], [11,16],[12,90]];
          $.plot('#line-chart', [ {
              data: d1,
              //label: "web",
          },
          {
              data: d2,
              //label: "mobile",
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

  });
  </script>
  <script>
  		
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
	    <li class="active">DASH BOARD</li>
	</ol>
	<!-- 대메뉴-->
	<h4 class="page-title">DASH BOARD</h4>
	<!-- Main Widgets -->
   	<!-- Shortcuts -->
                <div class="block-area shortcut-area">
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/web/contents">
                        <span class="icon" style="font-size:40px;">&#61696;</span>
                        <small class="t-overflow">CONTENTS ACHIVE</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/web/communicate">
                        <span class="icon" style="font-size:40px;">&#61875;</span>
                        <small class="t-overflow">CATEGORY</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/web/layout">
                        <span class="icon" style="font-size:40px;">&#61717;</span>
                        <small class="t-overflow">MAIN PAGE EDITOR</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/stb/controle">
                        <span class="icon" style="font-size:40px;">&#61808;</span>
                        <small class="t-overflow">OTT CONTROLE</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/stb/schedule">
                        <span class="icon" style="font-size:40px;">&#61940;</span>
                        <small class="t-overflow">OTT SCHEDULE</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/stb/log">
                        <span class="icon" style="font-size:40px;">&#61803;</span>
                        <small class="t-overflow">OTT LOG</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/stb/ui">
                        <span class="icon" style="font-size:40px;">&#61931;</span>
                        <small class="t-overflow">OTT SETTING</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/web/managerAccount">
                        <span class="icon" style="font-size:40px;">&#61887;</span>
                        <small class="t-overflow">ACCOUT MANAGER</small>
                    </a>
                    <a class="shortcut tile" href="${pageContext.request.contextPath}/sedn/web/statistics">
                        <span class="icon" style="font-size:40px;">&#61721;</span>
                        <small class="t-overflow">ANALIZER</small>
                    </a>
                </div>
                
                <hr class="whiter" />
                
                <!-- Quick Stats -->
                <div class="block-area">
                    <div class="row">
                        <div class="col-md-3 col-xs-6">
                            <div class="tile quick-stats">
                                <div id="stats-line-2" class="pull-left"></div>
                                <div class="data">
                                    <h2 data-value="98">0</h2>
                                    <small>Today Web Visitor</small>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="tile quick-stats media">
                                <div id="stats-line-3" class="pull-left"></div>
                                <div class="media-body">
                                    <h2 data-value="1452">0</h2>
                                    <small>Total Web Visitor</small>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="tile quick-stats media">
								<div id="stats-line-4" class="pull-left"></div>
								<div class="media-body">
                                    <h2 data-value="4896">0</h2>
                                    <small>Today OTT</small>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="tile quick-stats media">
                                <div id="stats-line" class="pull-left"></div>
                                <div class="media-body">
                                    <h2 data-value="29356">0</h2>
                                    <small>Total OTT</small>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

                <hr class="whiter" />
                
                <!-- Main Widgets -->
               
                <div class="block-area">
                    <div class="row">
                        <div class="col-md-8">
                            <!-- Main Chart -->
                            <div class="tile">
                                <h2 class="tile-title">Statistics</h2>
                                <div class="p-10">
                                    <div id="line-chart" class="main-chart" style="height: 250px"></div>
									<div class="chart-info">
                                        <ul class="list-unstyled">
                                            <li class="m-b-10">
                                                <b>TOTAL COUNT</b> 12180
                                            </li>
                                            <li>
                                                <small>
                                                    WEB 647
                                                </small>
                                                <div class="progress progress-small">
                                                    <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%"></div>
                                                </div>
                                            </li>
                                            <li>
                                                <small>
                                                    OTT 566
                                                </small>
                                                <div class="progress progress-small">
                                                    <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 60%"></div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>  
                            </div>
    
                            <!-- Pies -->
                            <div class="tile text-center">
                                <div class="tile-dark p-10">
                                    <div class="pie-chart-tiny" data-percent="86">
                                        <span class="percent"></span>
                                        <span class="pie-title">Sedn Disk <i class="m-l-5 fa fa-retweet"></i></span>
                                    </div>
                                    <div class="pie-chart-tiny" data-percent="23">
                                        <span class="percent"></span>
                                        <span class="pie-title">Sedn Mem <i class="m-l-5 fa fa-retweet"></i></span>
                                    </div>
                                    <div class="pie-chart-tiny" data-percent="57">
                                        <span class="percent"></span>
                                        <span class="pie-title">Media Disk<i class="m-l-5 fa fa-retweet"></i></span>
                                    </div>
                                    <div class="pie-chart-tiny" data-percent="34">
                                        <span class="percent"></span>
                                        <span class="pie-title">Media Mem<i class="m-l-5 fa fa-retweet"></i></span>
                                    </div>
                                    <div class="pie-chart-tiny" data-percent="81">
                                        <span class="percent"></span>
                                        <span class="pie-title">OTT Connect<i class="m-l-5 fa fa-retweet"></i></span>
                                    </div>
                                </div>
                            </div>

                            <!--  Recent Postings -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="tile">
                                        <h2 class="tile-title">최근 동영상</h2>
                                        
                                        <div class="listview narrow">
                                            <div class="media p-l-5">
                                                <div class="pull-left">
                                                    <img width="40" src="${pageContext.request.contextPath}/img/photo-gallery/movie_image1.jpg" alt="">
                                                </div>
                                                <div class="media-body">
                                                    <small class="text-muted">2 Hours ago by reload@gmail.com</small><br/>
                                                    <a class="t-overflow" href="">신과 함께</a>
                                                   
                                                </div>
                                            </div>
                                            <div class="media p-l-5">
                                                <div class="pull-left">
                                                    <img width="40" src="${pageContext.request.contextPath}/img/photo-gallery/movie_image2.jpg" alt="">
                                                </div>
                                                <div class="media-body">
                                                    <small class="text-muted">5 Hours ago by reload@gmail.com</small><br/>
                                                    <a class="t-overflow" href="">쥬만지</a>
                                                    
                                                </div>
                                            </div>
                                            <div class="media p-l-5">
                                                <div class="pull-left">
                                                    <img width="40" src="${pageContext.request.contextPath}/img/photo-gallery/movie_image3.jpg" alt="">
                                                </div>
                                                <div class="media-body">
                                                    <small class="text-muted">On 5/3/2018 by hanibal0717@gmail.com</small><br/>
                                                    <a class="t-overflow" href="">1987</a>
                                                    
                                                </div>
                                            </div>
                                            <div class="media p-l-5">
                                                <div class="pull-left">
                                                    <img width="40" src="${pageContext.request.contextPath}/img/photo-gallery/movie_image4.jpg" alt="">
                                                </div>
                                                <div class="media-body">
                                                    <small class="text-muted">On 28/2/2013 by hanibal0717@gmail.com</small><br/>
                                                    <a class="t-overflow" href="">강철비 </a>
                                                    
                                                </div>
                                            </div>
                                            <div class="media p-l-5">
                                                <div class="pull-left">
                                                    <img width="40" src="${pageContext.request.contextPath}/img/photo-gallery/movie_image5.jpg" alt="">
                                                </div>
                                                <div class="media-body">
                                                    <small class="text-muted">On 13/2/2018 by hanibal0717@gmail.com</small><br/>
                                                    <a class="t-overflow" href="">꾼</a>
                                                    
                                                </div>
                                            </div>
                                            <div class="media p-l-5">
                                                <div class="pull-left">
                                                    <img width="40" src="${pageContext.request.contextPath}/img/photo-gallery/movie_image13.jpg" alt="">
                                                </div>
                                                <div class="media-body">
                                                    <small class="text-muted">On 17/1/2018 by hanibal0717@gmail.com</small><br/>
                                                    <a class="t-overflow" href="">해피버스 데이 </a>
                                                    
                                                </div>
                                            </div>
                                            <div class="media p-l-5">
                                                <div class="pull-left">
                                                    <img width="40" src="${pageContext.request.contextPath}/img/photo-gallery/movie_image10.jpg" alt="">
                                                </div>
                                                <div class="media-body">
                                                    <small class="text-muted">On 15/12/2017 by hanibal0717@gmail.com</small><br/>
                                                    <a class="t-overflow" href="">스타워즈</a>
                                                    
                                                </div>
                                            </div>
                                            
                                            
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Tasks to do -->
                                <div class="col-md-6">
                                    <div class="tile">
                                        <h2 class="tile-title">셋탑박스 로그</h2>
                                        
                                        <div class="listview todo-list sortable">
                                            <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                        엔지니어 미팅실 셋탑이 재부팅을 했습니다.
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                        재2본부에서 스케쥴을 다운로드 받았습니다.
                                                    </label>
                                                </div>
                                                
                                            </div>
                                            <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                        광주 PCC에서 펌웨어 업데이트를 했습니다.
                                                    </label>
                                                </div>
                                                
                                            </div>
                                            <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                        거제사무소에 네트워크에 문제가 생겼습니다.
                                                    </label>
                                                </div>
                                             </div>
                                             <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                        2그룹이 스케쥴이 업데이트되었습니다.
                                                    </label>
                                                </div>
                                             </div>
                                             <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                       4그룹셋탑이 재부팅을 했습니다.
                                                    </label>
                                                </div>
                                             </div>
                                             <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                        2그룹이 재부팅을 했습니다. 
                                                    </label>
                                                </div>
                                             </div>
                                             <div class="media">
                                                <div class="checkbox m-0">
                                                    <label class="t-overflow">
                                                        3본부에 네트워크에 문제가 있습니다.
                                                    </label>
                                                </div>
                                             </div>
                                             
                                        </div>
                                     </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        
                        <div class="col-md-4">
                            <!-- USA Map -->
                            <div class="tile">
                                <h2 class="tile-title">인기 영상 순위</h2>
                                <div class="p-5">
                                	<div class="m-b-10">
                    	 		한국영화 > 멜로 > 도깨비 3화
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		한국영화 > 블랙고메디 > 해버스 데이 
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		스포츠 > 야구 >LG - 75%
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100" style="width: 72%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 정치 > 이명박 구속 
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뉴스 > 경제 > 비트코인 하락 
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 > JTBC > 품위있는 그녀
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="47" aria-valuemin="0" aria-valuemax="100" style="width: 47%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		스포츠 > 익스트림 > UFC 
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="38" aria-valuemin="0" aria-valuemax="100" style="width: 38%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		드라마 > KBS > 황금빛 내인생 
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="22" aria-valuemin="0" aria-valuemax="100" style="width: 22%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		뮤직비디오 > 직캠 > BTOB 
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" style="width: 15%"></div>
                    			</div>
                      		</div>
                      		<div class="m-b-10">
                    	 		해외드라마 > 미드 > 프렌즈
                    			<div class="progress progress-striped progress-alt">
                        			<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="5" aria-valuemin="0" aria-valuemax="100" style="width: 5%"></div>
                    			</div>
                      		</div>
                                </div>
                            </div>
                                
                            <!-- Activity -->
                            <div class="tile">
                                <h2 class="tile-title">장비 접속 순위</h2>
                                <div class="p-5">
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
									<td>메인 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 80%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>플레너 본부</td>
									<td>서브 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 77%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>4본부</td>
									<td>본부장 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 65%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>일산 PCC</td>
									<td>메인 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 40%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>기획자 미팅실</td>
									<td>메인 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 32%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>구미 사무소</td>
									<td>메인 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 28%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>광주 PCC</td>
									<td>메인 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 21%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>거제 사무소</td>
									<td>메인 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 18%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	<tr>
	                          		<td>광주 PCC</td>
									<td>메인 셋탑</td>
	                          		<td style="width:60%;">
	                          		<div class="progress progress-striped progress-alt">
                        				<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 8%"></div>
                    				</div>
	                          		</td>
	                          	</tr>
	                          	
	                          	</tbody>
	                          	</table>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
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
