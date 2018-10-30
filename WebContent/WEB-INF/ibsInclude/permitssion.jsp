<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:parseNumber var="PagePermission" value="${permission}"/>
<fmt:parseNumber  var="UserPermission" value="${sessionScope.member_authority}"/>
<c:choose>
	<c:when test="${PagePermission gt UserPermission }">
		<script>
			location.href="${pageContext.request.contextPath}/error/PERMISSION";
		</script>
	</c:when>
	<c:when test="${UserPermission eq '5000'  }">
		<script>
			$(function(){
				$("#successText").text("데모 관리자는 삭제,수정 버튼을 사용할 수 없습니다. 참고 하세요.");
				$("#sucessModal").modal();
				$(".btn:button").prop("disabled","true");
			});
		</script>
	</c:when>
</c:choose>