<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsUserJs/DevBoxSlide.js"></script>
<!-- 기본 가로형 썸네일 -->
<div class="slider_form">
	<h2>${mainTitle}<span><a href="${pageContext.request.contextPath}/user/subList?searchWord=&idxArr=${wl_link_idx}"><img src="img/img_add.png" alt="더보기"/></a></span></h2>
	
	<div class="default-x">
	<c:choose>
	<c:when test="${empty lists }">
		데이타가 없습니다.
	</c:when>
	<c:otherwise>
	<c:forEach items="${lists}" var="list" varStatus="loop">
		<div class="contents_form" id="form_${list.idx}" onClick="common.viewContents('${list.idx}')">
			<div class="text">${fn:substring(list.board_title,0,14)}</div>
			<div class="text-over">
				<div class="header">
					<span class="hits">${list.view_count}</span>
					<span class="down ml-10"><c:set var="tel" value="${fn:split(list.vod_repo,'/')}" />
									<c:forEach var="file" items="${tel}" varStatus="g">
     								<c:if test="${g.count == 6}"><a href="/sedn/download/vod/mp4/${fn:substring(file,0,14)}" /></c:if>
								</c:forEach> 
								<img src="img/btn_file.png" alt="다운로드" /></a></span>
				</div>
				<div class="body text-center f15">
					<p><br /></p>
				</div>
				<div class="footer text-center">
					<hr />
					<p>${fn:substring(list.board_title,0,14)}</p>
				</div>
			</div>
			<div class="gra"></div>
			<div class="img"><img src="${list.vod_repo}" alt="컨텐츠이미지" /></div>
		</div>
	</c:forEach>
	</c:otherwise>
	</c:choose>
	</div>
</div><!-- //기본 가로형 썸네일 -->