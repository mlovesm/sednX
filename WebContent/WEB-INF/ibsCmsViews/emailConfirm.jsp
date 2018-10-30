<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<html>
    <head>
    <!-- start: Favicon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico">
    		<link href="${pageContext.request.contextPath}/ibsCmsCss/bootstrap.min.css" rel="stylesheet">
   		<link href="${pageContext.request.contextPath}/ibsCmsCss/style.css" rel="stylesheet">
    		<link href="${pageContext.request.contextPath}/ibsCmsCss/generics.css" rel="stylesheet"> 
    </head>
    <body id="skin-blur-ocean">
        <section id="error-page" class="tile">
            <h1 class="m-b-10">인증이 완료 되었습니다.</h1>
            <p>가입하신 이메일과 비밀번호로 로그인 해 주세요.</p>
            <a class="underline" href="${pageContext.request.contextPath}/cms/login">로그인 페이지로 가기</a> 
        </section>
        
    </body>
</html>