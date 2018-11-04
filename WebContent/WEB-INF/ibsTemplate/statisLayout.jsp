<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles"  uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<head>
<title>SEDN ORGIN v1.0 Management System</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
	<meta name="format-detection" content="telephone=no">
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta http-equiv="Expires" content="-1">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico">
	<!-- end: Favicon -->
	
	<!-- CSS -->
	<link href="${pageContext.request.contextPath}/ibsCmsCss/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/font-awesome.min.css" rel="stylesheet">
	
	<link href="${pageContext.request.contextPath}/statistics/css/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/statistics/css/custom.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/statistics/css/jquery-ui.css" rel="stylesheet">
	
	<link href="${pageContext.request.contextPath}/ibsCmsCss/animate.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/lightbox.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/media-player.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/themes/default/style.css" rel="stylesheet">  
	<link href="${pageContext.request.contextPath}/ibsCmsCss/video-js.css" rel="stylesheet">

	
	<!-- jQuery -->
    <script src="${pageContext.request.contextPath}/statistics/js/jquery-2.2.1.min.js"></script> <!-- jQuery Library -->
	<script src="${pageContext.request.contextPath}/statistics/js/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/statistics/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/statistics/js/Chart.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/statistics/js/Chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/statistics/js/utils.js"></script>
	
	<script src="${pageContext.request.contextPath}/ibsCmsJs/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>

    <!-- video.js -->
    <script src="${pageContext.request.contextPath}/ibsCmsJs/video.js"></script>
	<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-flash.js"></script>
	<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-contrib-hls.js"></script>
	<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-playlists.js"></script>   
	
	<!-- Grid -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/tui-grid/css/tui-grid.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/tui-grid/css/checkbox.css" />
	<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
      
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.3.3/backbone.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mockjax/1.6.2/jquery.mockjax.min.js"></script>
	<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.4.0/tui-code-snippet.js"></script>
	<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.2.0/tui-pagination.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/tui-grid/js/tui-grid.js"></script>

		
</head>
<body>
<div id="wrap">
	<div class="top_container">
		<div class="inner">
			<h1><a href="/">SEDN</a></h1>
			<div class="right">
				<div class="login">
					<p>관리자님 환영합니다.</p>
					<button>Log out</button>
					<button>My page</button>
				</div>
			</div>
		</div>
	</div>
	<div class="page">
		<div class="inner">
			<!-- left start -->
			<tiles:insertAttribute name="left"/>
			<!-- left end -->
			<tiles:insertAttribute name="body"/>
		</div> <!-- //inner -->
	</div> <!-- //page -->
</div>

        
     
</body>
</html>

