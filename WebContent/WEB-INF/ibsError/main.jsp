<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<html>
    <head>
    	<link href="${pageContext.request.contextPath}/ibsCmsCss/bootstrap.min.css" rel="stylesheet">
   		<link href="${pageContext.request.contextPath}/ibsCmsCss/style.css" rel="stylesheet">
    	<link href="${pageContext.request.contextPath}/ibsCmsCss/generics.css" rel="stylesheet"> 
    </head>
    <body id="skin-blur-ocean">
        <section id="error-page" class="tile">
            <h1 class="m-b-10">${errorTitle}</h1>
            <p>${description }</p>
            <a class="underline" href="javascript:history.back();">이전 페이지 돌아가기</a> or <a class="underline" href="${pageContext.request.contextPath}/">사용자 페이지 이동하기</a> 
        </section>
        
    </body>
</html>