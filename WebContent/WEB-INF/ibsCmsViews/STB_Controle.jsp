<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.jstree-rename-input {
	color: #26120C;
}
</style>
<!--********** permittsion include **************-->
<c:import url="/inc/incPermission">
	<c:param name="permission" value="3000" />
</c:import>
<!--********* permittsion include **************-->
<section id="content" class="container">
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
	   		<div class="tile-dark col-md-2">
	   		<!-- MENU TITLE START -->
	        <h3 class="block-title">OTT GROUP</h3>
	        <!-- MENU TITLE END -->
	        <!-- TREE START-->
			<div id="menuTree"></div>
			<!-- TREE END-->
		</div>
        <div class="col-md-10">
        	<!--TITLE START-->
			<div>
				<h3 class="block-title" id="navibar"></h3>
				<div style="float: right;">
					<input type="hidden" id="categoryIdx" value="1" /><input
						id="sort" type="hidden"><input id="treeIdx" type="hidden"><input
						type="text" class="main-search" id="mainSearch"
						style="border-bottom: 1px solid #FFFFFF;" placeholder="아이피,장비명,맥주소">
				</div>
			</div>
			<!--TITLE END-->
   			<div class="clearfix">
	   			<div class="pull-left">
	            	<button type="button" class="btn btn-sm icon" id="STB_reboot_check"><span>&#61725;</span> <span class="text">REBOOT</span></button>
	               	<button type="button" class="btn btn-sm icon" id="STB_apk_update_check"><span>&#61910;</span> <span class="text">OTT APP UPDATE</span></button>
	         		<button type="button" class="btn btn-sm icon" id="STB_schedule_download_check"><span>&#61751;</span> <span class="text">SCHEDULE SETTING DOWNLOAD</span></button>
	               	<button type="button" class="btn btn-sm icon" id="STB_tv_on_check"><span>&#61931;</span> <span class="text">TV ON</span></button>
	               	<button type="button" class="btn btn-sm icon" id="STB_tv_off_check"><span>&#61834;</span> <span class="text">TV OFF</span></button>
	            </div>
               <div class="pull-right p-5">
               		<input type="hidden" id="selectedIdx" />
               		<input type="hidden" id="selectedMac" />
                    <button type="button" class="btn btn-sm icon" id="cateChangeBtn"><span>&#61844;</span> <span class="text">카테고리 변경</span></button>
                    <button type="button" class="btn btn-sm icon" id="contentForm"><span>&#61943;</span> <span class="text">STB 추가</span></button>
                    <button type="button" class="btn btn-sm icon" id="selectDeleteBtn"><span>&#61918;</span> <span class="text">STB 삭제</span></button>
              </div>
          	</div>
            <!-- CONTENTS START -->
			<div id="listView" class="tile"></div>
			<!-- CONTENTS END -->	
	    	</div>
	    </div>
   	</div>
   	 <input type="hidden" class="form-control" id="changeCateIdx" />
</section>
<script>
	var menuJs = (function() {
		var makeJsTree = function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/jstree/"
						+ $("#sort").val(),
				async : true,
				success : function(data) {
					$("#menuTree").empty();
					$("#menuTree").html(data);
				},
				error : exception.ajaxException
			});
		};
		var makeSelJstree = function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/selJstree/"
						+ $("#sort").val(),
				async : true,
				success : function(data) {
					$("#modalTree").empty();
					$("#modalTree").html(data);
					$("#changeCateModel").modal();
				},
				error : exception.ajaxException
			});
		};
		return {
			makeJsTree : makeJsTree,
			makeSelJstree : makeSelJstree
		};
	}());
	var contents = (function() {
		var list = function(childIdx) {
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/list/"
						+ $("#sort").val() + "?childIdx=" + childIdx,
				success : function(data) {
					$("#selectedIdx").val('');
					$("#listView").empty();
					$("#listView").html(data);
				},
				error : exception.ajaxException
			});
		};
		var naviBar = function() {
			$("#sort").val(arguments[0]);
			$("#treeIdx").val(arguments[1]);
			$("#categoryTitle").text($("#sort").val() + " CATEGORY");
			$("#navibar").html(arguments[2]);
		};
		var arangePage = function(sort, categoryIdx, naviString) {
			contents.naviBar(sort, categoryIdx, naviString);
			menuJs.makeJsTree();
			contents.list(categoryIdx);
		};
		var selectArrange = function(idx) {
			$('#jstree').jstree("deselect_all");
			$('#jstree').jstree('select_node', idx);
			menuJs.makeJsTree();
		};
		var search = function(searchWord) {
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/list/"
						+ $("#sort").val() + "?searchWord=" + searchWord
						+ "&childIdx=" + $("#treeIdx").val(),
				success : function(data) {
					$("#selectedIdx").val('');
					$("#listView").empty();
					$("#listView").html(data);
				},
				error : exception.ajaxException
			});
		};
		var contentForm = function(sort, order, idx) {
			if (order == "update") {
				$("#addTitle").html(sort + " contents edit");
			} else {
				$("#addTitle").html(sort + " contents add");
			}

			$.ajax({
				url : "${pageContext.request.contextPath}/cms/form/" + sort
						+ "/" + order + "/" + idx,
				success : function(data) {
					$("#insertForm").empty();
					$("#insertForm").html(data);
				},
				error : exception.ajaxException
			});
			$("#contentsAddModel").modal();
		};
		var deleteByIdxArr = function() {
			if ($("#selectedIdx").val().length == 0)
				return false;
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/delete/"
						+ $("#sort").val() + "?checkValArr="
						+ $("#selectedIdx").val(),
				async : false,
				success : function(responseData) {
					var data = JSON.parse(responseData);
					if (data.result == "success") {
						$("#successText").text("컨텐츠 삭제에 성공했습니다.");
						$("#sucessModal").modal();
						var array = $("#selectedIdx").val().split(',');
						for (i = 0; i < array.length; i++) {
							$('#list_' + array[i]).fadeOut('slow');
						}
						menuJs.makeJsTree();
						$("#selectedIdx").val('');
						$(".checkElem").prop("checked", false);
					}
				},
				error : exception.ajaxException
			});
		};
		var number_to_human_size = function(x) {
			var s = [ 'bytes', 'kB', 'MB', 'GB', 'TB', 'PB' ];
			var e = Math.floor(Math.log(x) / Math.log(1024));
			var se = (x / Math.pow(1024, e)).toFixed(2) + " " + s[e];
			return se.replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
		};
		return {
			list : list,
			naviBar : naviBar,
			arangePage : arangePage,
			selectArrange : selectArrange,
			search : search,
			contentForm : contentForm,
			deleteByIdxArr : deleteByIdxArr,
			number_to_human_size : number_to_human_size
		}
	})();
</script>
<script>
	$(function() {
		//페이지 초기화
		contents.naviBar('stb-controle', '', 'OTT CONTROLE');
		menuJs.makeJsTree();
		$('#cmsPageTitle').html('OTT 관리');
		$('.menuLi').removeClass('active');
		$('#ottMenuLi').addClass('active');
		contents.list('');
		$("#mainSearch").keydown(function(key) {
			if (key.keyCode == 13) {
				if ($("#mainSearch").val().length == 0) {
					exception.searchException();
				} else {
					contents.search($("#mainSearch").val());
				}
			}
		});
		$("#contentForm").click(function() {
			contents.contentForm($("#sort").val(), "insert", "0");
		});
		$("#contentsAddSubmit").click(function() {
			if ($("#contentsForm").validationEngine('validate')) {
				$("#contentsForm").submit();
			}
			;
		});
	});
</script>

<!-- Older IE Message -->
<!--[if lt IE 9]>
    <div class="ie-block">
        <h1 class="Ops">Ooops!</h1>
        <p>You are using an outdated version of Internet Explorer, upgrade to any of the following web browser in order to access the maximum functionality of this website. </p>
        <ul class="browsers">
            <li>
                <a href="https://www.google.com/intl/en/chrome/browser/">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/chrome.png" alt="">
                    <div>Google Chrome</div>
                </a>
            </li>
            <li>
                <a href="http://www.mozilla.org/en-US/firefox/new/">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/firefox.png" alt="">
                    <div>Mozilla Firefox</div>
                </a>
            </li>
            <li>
                <a href="http://www.opera.com/computer/windows">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/opera.png" alt="">
                    <div>Opera</div>
                </a>
            </li>
            <li>
                <a href="http://safari.en.softonic.com/">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/safari.png" alt="">
                    <div>Safari</div>
                </a>
            </li>
            <li>
                <a href="http://windows.microsoft.com/en-us/internet-explorer/downloads/ie-10/worldwide-languages">
                    <img src="${pageContext.request.contextPath}/${pageContext.request.contextPath}/img/browsers/ie.png" alt="">
                    <div>Internet Explorer(New)</div>
                </a>
            </li>
        </ul>
        <p>Upgrade your browser for a Safer and Faster web experience. <br/>Thank you for your patience...</p>
    </div>   
<![endif]-->
