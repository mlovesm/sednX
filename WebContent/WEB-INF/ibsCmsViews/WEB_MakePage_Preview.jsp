<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<c:choose>
	<c:when test="${empty lists}">
		이 메뉴에 설정한 레이아웃이 없습니다.
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="status">
			<img src="/img/${list.wl_type}.jpg" style="margin-bottom:10px;">
		</c:forEach>
	</c:otherwise>
</c:choose>