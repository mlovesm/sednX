<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<h2 class="tile-title">
	전체선택 <input type="checkbox" id="allCheck">
</h2>
<div class="photo-gallery clearfix">
	<div class="photo_form">
		<c:choose>
			<c:when test="${empty lists }">
				<div style="height: 100px;">데이타가 없습니다.</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${lists}" var="list" varStatus="loop">
					<div class="photo" id="list_${list.idx}">
						<div class="form_div">
							<div class="b" style="z-index: 1;">
								<input type="checkbox" class="checkElem" id="${list.idx}"
									value="${list.idx}">
							</div>
							<div class="img_box" style="width: 215px;">
								<div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left"
									style="width:220px;height:120px; background: url('${pageContext.request.contextPath}${list.main_thumbnail}') no-repeat center; background-size: cover;"></div>
							</div>
						</div>
						<div class="form_show" id="view_${list.idx}">
							<div class="superbox-current-img col-md-6 p-0 m-r-15 pull-left"
								style="width:480px;height:270px; background: url('${pageContext.request.contextPath}${list.main_thumbnail}') no-repeat center; background-size: cover;">
									<video id="my-player_${list.idx }" class="video-js listPlayer" controls preload="auto"  poster="${pageContext.request.contextPath}${list.main_thumbnail}"  style="width: 100% !important; height: 100% !important;">
										<source  src="${list.vod_path}"  type="application/x-mpegURL"></source>
									</video>
								</div>
							<div class="superbox-close">X</div>
							<div class="img-info madia-body" style="position: absolute; width: calc(100% - 500px);right: 0;">
								<!-- <h4>
									<span class="label label-default">${list.category_idx}</span><span>&nbsp;&nbsp;</span>
									${list.vod_title}
								</h4>
								<h5>
									<span class="label label-warning"><b>${list.vod_play_time}</b></span>
									<span class="label label-success fileSize"><b>${list.file_size}</b></span>
									<span class="label label-primary"><b>${list.resolution}</b></span>
									<span class="label label-info" ><b>${list.reg_ip}</b></span>
									<span class="label label-warning"><b>${list.reg_id}</b></span>
									<span class="label label-primary"><b>${list.audio_codec}</b></span>
									<span class="label label-info"><b>${list.video_codec}</b></span>
									<span class="label label-success"><b>${list.bitrate}</b></span>
								</h5>
								<h6>
									[${list.edit_dt}]<span>&nbsp;&nbsp;</span>" <small>${list.vod_keyword}</small>"
								</h6>
								<p class="m-b-20">${list.vod_content}</p>
								<p></p> -->
								<table class="table tile text-center" style="float:left;">
								<thead>
									<tr>
										<th>카테고리명</th>
										<th>제목</th>
										<th>등록일시</th>
										<th>태그</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${list.category_idx}</td>
										<td>${list.vod_title}</td>
										<td>${list.edit_dt}</td>
										<td>${list.vod_keyword}</td>
									</tr>
								</tbody>
								</table>		
								<table class="table tile" style="float:left;">
								<thead>
									<tr>
										<th class="text-center">내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><p style="height:70px; overflow-y:auto;">${list.vod_content}</p></td>
									</tr>
								</tbody>
								</table>
								
								
						
								<button type="button"
									class="btn btn-alt btn-sm icon editElement">
									<span>&#61952;</span> <span class="text">수정</span>
								</button>
								<button type="button"
									class="btn btn-alt btn-sm icon deleteElement">
									<span>&#61754;</span> <span class="text">삭제</span>
								</button>
							</div>
							<div class="img-info">
								<table class="table tile text-center" style="float:left;">
									<thead>
										<tr>
											<th>재생시간</th>
											<th>용량</th>
											<th>해상도</th>
											<th>등록 IP</th>
											<th>등록자</th>
											<th>오디오 코덱</th>
											<th>비디오 코덱</th>
											<th>비트레이트</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="orange">${list.vod_play_time}</td>
											<td class="ygreen fileSize">${list.file_size}</td>
											<td class="blue">${list.resolution}</td>
											<td class="sky">${list.reg_ip}</td>
											<td class="green">${list.reg_id}</td>
											<td class="pink">${list.audio_codec}</td>
											<td class="yellow">${list.video_codec}</td>
											<td class="puple">${list.bitrate}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="superbox-float"></div>
	<div class="col-md-12 text-center p-t-10">${pagingStr}</div>
	<button id="test"></button>
</div>
<script>
	$(function() {
		var arr = [];
		$(".checkElem").click(function() {
			if ($(this).is(":checked") == true) {
				arr.push($(this).attr("id"));
			} else {
				arr.splice($.inArray($(this).attr("id"), arr), 1);
			}
			$("#selectedIdx").val(arr);
		});
		$("#allCheck").click(function() {
			if ($(this).prop("checked")) {
				var chkbox = $(".checkElem");
				$(".checkElem").prop("checked", true);
				arr = [];
				for (i = 0; i < chkbox.length; i++) {
					arr.push(chkbox[i].value);
				}
				$("#selectedIdx").val(arr);
			} else {
				$(".checkElem").prop("checked", false);
				arr = [];
				$("#selectedIdx").val('');
			}
		});
		$("#pagingDiv li a").click(function() {
			var rel = $(this).attr('rel');
			$.ajax({
				url : rel,
				success : function(data) {
					$("#selectedIdx").val('');
					$("#listView").empty();
					$("#listView").html(data);
				},
				error : exception.ajaxException
			});
		});
		$(".editElement").click(function() {
			var idArr = $(this).parent().parent().attr('id').split('_');
			var idx = idArr[1];
			contents.contentForm($("#sort").val(), "update", idx);
		});
		$(".deleteElement").click(function(ev) {
			var idArr = $(this).parent().parent().attr('id').split('_');
			var idx = idArr[1];
			$("#selectedIdx").val(idx);
			$("#confirmText").text("선택한 파일을 삭제하시겠습니까?.");
			$("#confirmModal").modal('show');
			ev.preventDefault();
			exception.delConfirm(function(confirm) {
				if (confirm) {
					contents.deleteByIdxArr();
				}
			});
		});
		$("#selectDeleteBtn").click(function(ev) {
			var checkValArr = $("#selectedIdx").val();
			if (checkValArr.length == 0) {
				exception.checkboxException();
			} else {
				$("#confirmText").text("선택 파일을 삭제하시겠습니까?.");
				$("#confirmModal").modal();
				ev.preventDefault();
				exception.delConfirm(function(confirm) {
					if (confirm) {
						contents.deleteByIdxArr();
					}
				});
			}
		});
		$(".fileSize").each(function() {
			$(this).text(contents.number_to_human_size($(this).text()));
		});
		$(".form_div .img_box").click(
				function() {
					if ($(this).parent().parent().find(".form_show").css(
							"display") == "block") {
						$(".form_show").css("display", "none");
					} else {
						$(".form_show").css("display", "none");
						$(this).parent().parent().find(".form_show").css(
								"display", "block");
					}
				});
		$(".superbox-close").click(function() {
			$(".form_show").fadeOut("slow");
		})
	});
	$(".listPlayer").each(function(){
		var oldplayer=videojs($(this).attr("id"));
		if (videojs.getPlayers()[$(this).attr("id")]) {
			oldplayer.dispose();
		}
		var options = {"autoplay": false};
		var player = videojs($(this).attr("id"), options,
			function onPlayerReady() {
			var isPlaying = false;

			this.on(['waiting', 'pause'], function() {
			  isPlaying = false;
			  //alert("잠시멈춤");
			});

			this.on('playing', function() {
			  isPlaying = true;
			 videojs.log(videojs($(this).attr("id")).currentTime());
			});
			this.on('ended', function() {
				delete videojs.getPlayers()[$(this).attr("id")];
				videojs.log('the end');
			});
		});
	});
</script>