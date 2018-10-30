<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="contents">
	<div class="sub_header">
		<ol class="location">
			<li class="li01"><img src="${pageContext.request.contextPath}/ibsImg/statisticsImg/icon_home.png" alt="홈 아이콘"/></li>
			<li class="li02">Statistics</li>
			<li class="li03">VOD 통계<span></span></li>
		</ol>
		<h1>VOD 통계</h1>
	</div>

	<div class="contents_container">					
		<div class="search_form mb30 text-right" style="height: 30px; line-height: 30px;">
			<div class="div_form">
				<div class="div_group" style="float: right;">
					<button class="btn-blue">오늘</button>
					<label for="">기간검색시작</label>
					<input type="text" class="datepicker" id="" style="width: 75px;" value="2018.10.15" />
				</div>
				<!-- <div class="div_group">
					<a class="list-a border" href="#">전일</a><a class="list-a" href="#">7일</a><a class="list-a" href="#">15일</a><a class="list-a" href="#">1개월</a><a class="list-a" href="#">3개월</a>
				</div> -->
			</div>
		</div>

		<!-- <div class="video_container">
			<div class="video">
				<h2>가장 인기있는 동영상</h2>
				<div class="border">(동영상 데이터)</div>
			</div>
		</div> -->
		<div style="position: relative;">
			<div class="date_container"> 
				<span class="tabSpan">주간편성</span>
		        <span class="tabButton">◀</span> 
		        <ul>
		        	<li>2018.10.05 (금)</li>
		        	<li>2018.10.06 (토)</li>
		        	<li>2018.10.07 (일)</li>
		        	<li class="on">
		        		2018.10.08 (월)
		        		<div class="channel_container">
		        			<div class="text-center">
		        				<ul>
		        					<li>공용채널 #1</li>
		        					<li>공용채널 #2</li>
		        				</ul>
		        			</div>
		        		</div>
		        	</li>
		        	<li>2018.10.09 (화)</li>
		        	<li>2018.10.10 (수)</li>
		        	<li>2018.10.11 (목)</li>
		        </ul>
		        <span class="tabButton right">▶</span> 
		    </div>
		    <div class="text-right">
		    	<button class="btn btn-excel">엑셀로 저장</button>
		    </div>
			<div class="table_container text-center">
				<table summary="통계 분석/이 표는 으로 구성">
					<colgroup>
						<col width="150px;" />
						<col width="auto;" />
						<col width="150px;" />
						<col width="150px;" />
						<col width="150px;" />
						<col width="150px;" />
						<col width="150px;" />
					</colgroup>
					<thead>
						<tr>
							<th>시간</th>
							<th>프로그램</th>
							<th>재생시간</th>
							<th>LIVE 시청 수</th>
							<th>OTT</th>
							<th>APP</th>
							<th>Web(PC)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/1.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/2.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/3.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/4.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/1.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/2.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/3.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/4.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr class="live">					
							<td>00:20</td>
							<td class="text-left"><img src="../img/1.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123(방송중)</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>	
						<tr>
							<td>00:20</td>
							<td class="text-left"><img src="../img/2.png" alt="썸네일 이미지"/> 프로그램 제목...</td>
							<td>00:00:00</td>
							<td>3,123</td>
							<td>2,500</td>
							<td>500</td>
							<td>198</td>
						</tr>							
					</tbody>
				</table>
				<!-- pagination -->
                <div class="pagination_container text-center">
                    <ul class="pagination">
                        <li><a href="#"><img src="../img/arr_left02.png" alt="맨처음" /></a></li>
                        <li><a href="#"><img src="../img/arr_left.png" alt="이전" /></a></a></li>
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
                        <li><a href="#"><img src="../img/arr_right.png" alt="다음" /></a></a></li>
                        <li><a href="#"><img src="../img/arr_right02.png" alt="마지막" /></a></a></li>
                    </ul>
                </div><!-- //pagination -->
			</div>
		</div>
	</div> <!-- //contents_container -->

</div> <!-- //contents -->
	

<script>
  $(function () {

  });
</script>
