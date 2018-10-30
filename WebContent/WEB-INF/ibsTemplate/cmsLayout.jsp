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
	<meta http-equiv=”Pragma” content=”no-cache”>
	<meta http-equiv=”Cache-Control” content=”no-cache”>
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico">
	<!-- end: Favicon -->
	<!-- CSS -->
	
	<link href="${pageContext.request.contextPath}/ibsCmsCss/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/animate.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/font-awesome.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/form.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/calendar.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/photo-gallery.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/style.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/hanibalDev.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/icons.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/lightbox.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/media-player.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/generics.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/ibsCmsCss/themes/default/style.css" rel="stylesheet">  
	<link href="${pageContext.request.contextPath}/ibsCmsCss/video-js.css" rel="stylesheet">

	
	<!-- jQuery -->
    <script src="${pageContext.request.contextPath}/ibsCmsJs/jquery.min.js"></script> <!-- jQuery Library -->
    <!-- tmpl JS -->
    <script src="${pageContext.request.contextPath}/ibsCmsJs/js.cookie.js"></script>
		<script src="${pageContext.request.contextPath}/ibsCmsJs/jquery-ui.min.js"></script> <!-- jQuery UI -->
		<script src="${pageContext.request.contextPath}/ibsCmsJs/jquery.form.min.js"></script>
	<!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/ibsCmsJs/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/ibsCmsJs/jquery.easing.1.3.js"></script> <!-- jQuery Easing - Requirred for Lightbox + Pie Charts-->
    
	<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>
		
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ibsCmsJs/datetimepicker/jquery.datetimepicker.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/ibsCmsJs/datetimepicker/jquery.datetimepicker.full.min.js"></script>
	<!-- Charts -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/charts/jquery.flot.js"></script> <!-- Flot Main -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/charts/jquery.flot.time.js"></script> <!-- Flot sub -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/charts/jquery.flot.animator.min.js"></script> <!-- Flot sub -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/charts/jquery.flot.resize.min.js"></script> <!-- Flot sub - for repaint when resizing the screen -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/charts/jquery.flot.orderBar.js"></script> <!-- Flot Bar chart -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/charts/jquery.flot.pie.min.js"></script> <!-- Flot Pie chart -->
		<script src="${pageContext.request.contextPath}/ibsCmsJs/sparkline.min.js"></script> <!-- Sparkline - Tiny charts 메인상단 미니차트 JS -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/easypiechart.js"></script> <!-- EasyPieChart - Animated Pie Charts -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/charts.js"></script> <!-- All the above chart related functions -->
		<!-- Map -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/maps/jvectormap.min.js"></script> <!-- jVectorMap main library -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/maps/usa.js"></script> <!-- USA Map for jVectorMap -->
		<script src="${pageContext.request.contextPath}/ibsCmsJs/select.min.js"></script> <!-- Custom Select -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/chosen.min.js"></script> <!-- Custom Multi Select -->
         <!-- <script src="${pageContext.request.contextPath}/ibsCmsJs/datetimepicker.min.js"></script>Date & Time Picker -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/colorpicker.min.js"></script> <!-- Color Picker -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/autosize.min.js"></script> <!-- Textare autosize -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/toggler.min.js"></script> <!-- Toggler -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/input-mask.min.js"></script> <!-- Input Mask -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/spinner.min.js"></script> <!-- Spinner -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/slider.min.js"></script> <!-- Input Slider -->
        <!--  Form Related -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/icheck.js"></script> <!-- Custom Checkbox + Radio -->
		<!-- Text Editor -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/editor.min.js"></script> <!-- WYSIWYG Editor -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/markdown.min.js"></script> <!-- Markdown Editor -->
        <!-- UX -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/scroll.min.js"></script> <!-- Custom Scrollbar -->
        <!--  Form Related -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/validation/validate.min.js"></script> <!-- jQuery Form Validation Library -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/validation/validationEngine.min.js"></script> <!-- jQuery Form Validation Library - requirred with above js -->
         <!-- Other -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/fileupload.min.js"></script> <!-- File Upload -->
        <!-- All JS functions -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/functions.js"></script>
         <!-- Calendar -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/calendar.js"></script>
        <!-- vodeo Js -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/video.js"></script>
		<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-flash.js"></script>
		<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-contrib-hls.js"></script>
		<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-playlists.js"></script>
		
		
		<!-- new user page -->
		<script src="${pageContext.request.contextPath}/ibsCmsJs/jquery.blockUI.js"></script>
		<script src="${pageContext.request.contextPath}/ibsCmsJs/TweenMax.min.js"></script>
		<script>
// Detect objectFit support
if('objectFit' in document.documentElement.style === false) {
  
  // assign HTMLCollection with parents of images with objectFit to variable
  var container = document.getElementsByClassName('imgSize'); // img를 감싸고 있는 div의 class name 을 써주세요.
  
  // Loop through HTMLCollection
  for(var i = 0; i < container.length; i++) {
    
    // Asign image source to variable
    var imageSource = container[i].querySelector('img').src;
    
    // Hide image
    container[i].querySelector('img').style.display = 'none';
    
    // Add background-size: cover
    container[i].style.backgroundSize = 'cover';
    
    // Add background-image: and put image source here
    container[i].style.backgroundImage = 'url(' + imageSource + ')';
    
    // Add background-position: center center
    container[i].style.backgroundPosition = 'center center';
  }
}
else {
  // You don't have to worry
  console.log('No worries, your browser supports objectFit')
}
</script>
		
</head>
<body id="skin-blur-ocean">
		<!-- top start-->
      	<tiles:insertAttribute name="top"/>
        <!-- top end -->
        <div class="clearfix"></div>
        	<section id="main" class="p-relative" role="main">
        		<!-- left start -->
        		<tiles:insertAttribute name="left"/>
        		<!-- left end -->
        		<tiles:insertAttribute name="body"/>
        </section>
        
</body>
 <!-- Javascript Libraries -->
        
	
		


        
</html>

