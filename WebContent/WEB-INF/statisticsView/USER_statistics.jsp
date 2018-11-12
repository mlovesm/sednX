<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<style>
.jstree-default .jstree-clicked {
  background: #4b96e6;
}
</style>
<div class="contents">
	<div class="sub_header">
		<ol class="location">
			<li class="li01"><img src="${pageContext.request.contextPath}/statistics/img/icon_home.png" alt="홈 아이콘"/></li>
			<li class="li02">Statistics</li>
			<li class="li03">사용자 이용 통계<span></span></li>
		</ol>
		<h1>사용자 이용 통계</h1>
	</div>

	<div class="contents_container">		
		<div class="search_form mb30 text-right" style="height: 30px; line-height: 30px;">
			<div class="div_form">
				<div class="div_group">
					<label for="">검색</label>
					<input type="text" id="" />
				</div>
				<button class="btn-search">검색</button>
			</div>
		</div>

		<!-- <div class="video_container">
			<div class="video">
				<h2>가장 인기있는 동영상</h2>
				<div class="border">(동영상 데이터)</div>
			</div>
		</div> -->
		<div style="position: relative;">
						<div class="table_container text-center">
							<a href="sub_03_1.html">
							<table summary="통계 분석/이 표는 으로 구성">
								<colgroup>
									<col width="80px;" />
									<col width="auto;" />
									<col width="180px;" />
									<col width="auto;" />
									<col width="150px;" />
									<col width="150px;" />
									<col width="100px;" />
									<col width="100px;" />
									<col width="100px;" />
								</colgroup>
								<thead>
									<tr>
										<th>No</th>
										<th>ID</th>
										<th>이름</th>
										<th>이메일</th>
										<th>최근 접속 IP</th>
										<th>최근 접속일</th>
										<th>접속 단말</th>
										<th>영상 조회수</th>
										<th>UCC 영상</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>10</td>
										<td>inuc</td>
										<td>홍길동</td>
										<td>inuc@naver.com</td>
										<td>123.456.77.89</td>
										<td>2018.10.15</td>
										<td>APP</td>
										<td>100</td>
										<td>50</td>
									</tr>		
								</tbody>
							</table>
							</a>
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
			<!-- <div id="grid"></div> -->			

		</div>
	</div> <!-- //contents_container -->

</div> <!-- //contents -->


<script>

var menuJs={
		getData: function(idx){
			$.ajax({
				url : "${pageContext.request.contextPath}/statistics/vod/VODListData/"+idx,
				async : false,
				success : function(data) {
					console.log(data);
				},
			});
		}

};
/* 
var grid = new tui.Grid({
    el: $('#grid'),
    scrollX: false,
    scrollY: 'auto',
    virtualScrolling: true,
    //pagination: true,
    bodyHeight: 650,
    columns: [
        { title: '제목', name: 'vod_title', align: 'center', ellipsis: true, 
        	formatter: function(value, rowData) {
        		//console.log(rowData);
	            var idx = rowData.idx;
	            var url = "./vodDetail?idx=" + idx;
	            return '<a href="' + url + '" >' + value + '</a>';
        	}
        },
        { title: '카테고리', name: 'category_name', width: 200, align: 'center' },
        { title: '영상시간', name: 'vod_play_time', width: 100, align: 'center' },
        { title: '등록일', name: 'reg_dt', width: 100, align: 'center', sortable: true },
        { title: '총 조회수', name: 'vod_title_link', width: 150, align: 'right', sortable: true }
    ],
});

tui.Grid.applyTheme('striped', {
    outline: {
        //border: '#d3d3d3',
        //showVerticalBorder: true
    },
    cell: {
    	background: '#fff',
    }
});

grid.use('Net', {
    readDataMethod: 'GET',
    initialRequest: true,
    //perPage: 2,
    api: {
        'readData': "${pageContext.request.contextPath}/statistics/vod/VODListData/"+$('#categoryIdx').val(),
        'createData': './api/create',
        'updateData': './api/update',
        'deleteData': './api/delete',
        'modifyData': './api/modify',
        'downloadExcel': './api/download/excel',
        'downloadExcelAll': './api/download/excelAll'
    }
}); */


/* var grid_net = grid.getAddOn('Net');

grid_net.readData({
	childIdx: $('#categoryIdx').val(),
    page: 1,
    perPage: 2
	//resetData: true
}); */


// Bind event handlers
grid.on('beforeRequest', function(data) {
	console.log('beforeRequest', data);
	
}).on('response', function(data) {
	console.log('response', data);
	
}).on('successResponse', function(data) {
	console.log('successResponse', data);
	
}).on('failResponse', function(data) {
	console.log('failResponse', data);
    
}).on('errorResponse', function(data) {
	console.log('errorResponse', data);
});
/* 
pagination.on('beforeMove', function(eventData) {
    return confirm('Go to page ' + eventData.page + '?');
});
pagination.on('afterMove', function(eventData) {
    alert('The current page is ' + eventData.page);
});
 */
grid.on('click', function(ev) {
	var target = ev.nativeEvent.target;
	var obj = grid.getRow(ev.rowKey);
	if(obj != null) {
		//location.href= "./vodDetail?idx="+obj.idx;
	}
    console.log(obj, target);
});

grid.on('selectRow', function(ev) {
	console.log('selectRow', obj, target);
    if (ev.rowKey === 3) {
      ev.stop();  
    }
});

grid.on('check', function(ev) {
    console.log('check', ev);
});

grid.on('uncheck', function(ev) {
    console.log('uncheck', ev, grid.getRowCount());
});

$(document).ready(function() {
	$(".btn-search").bind('click', function(){
		var net = grid.getAddOn('Net');
		//net.download('excel');
		//net.reloadData();
		//net.readData(2, {"test":"test"}, true);
		var options = {
			'childIdx': $('#categoryIdx').val()
		};
		//net.request('readData', options);
		//net.readData(1, {"childIdx":$('#categoryIdx').val()}, true);
	});
});




</script>
