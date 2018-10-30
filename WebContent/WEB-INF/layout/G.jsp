<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsUserJs/DevBoxSlide.js"></script>
<!-- 썸네일 혼합형 -->
				<div class="slider_form">
					<h2>${mainTitle}<span><a href="${pageContext.request.contextPath}/user/subList?searchWord=&idxArr=${wl_link_idx}"><img src="img/img_add.png" alt="더보기"/></a></span></h2>

					<div class="thumnail-mix">
						<c:choose>
						<c:when test="${empty lists }">
						데이타가 없습니다.
						</c:when>
						<c:otherwise>
						<c:forEach items="${lists}" var="list" varStatus="loop">
						<c:set var="remainInt" value="${status.index mod 11}" />
						<c:if test="${remainInt eq 0 ||remainInt eq 1||remainInt eq 4 }">
						<div class="contents_form mix-over h340 viewForm" id="form_${list.idx}" onClick="common.viewContents('${list.idx}')">
							<div class="gra"></div>
							<div class="text">${fn:substring(list.board_title,0,14)}</div>
							<div class="img"><img src="${list.vod_repo}" alt="컨텐츠이미지" /></div>
							<div class="text-over">
								<div class="header">
									<span class="hits">${list.view_count}</span>
									<span class="down ml-10"><c:forEach var="file" items="${tel}" varStatus="g">
		     								<c:if test="${g.count == 6}"><a href="/sedn/download/vod/mp4/${fn:substring(file,0,14)}" /></c:if>
										</c:forEach> 
										<img src="img/btn_file.png" alt="다운로드" /></a></span>
								</div>
								<div class="body text-center f16">
									<p><br /></p>
								</div>
								<div class="footer text-center">
									<hr />
									<p>${fn:substring(list.board_title,0,14)}</p>
								</div>
							</div>
						</div>
						</c:if>
						
						
				<c:if test="${remainInt ne 0 && remainInt ne 1 && remainInt ne 4 }">
				<div class="sm">
				<div class="contents_form" onClick="common.viewContents('${list.idx}')">
				<div class="h50 viewform" id="form_${list.idx}">
					<div class="gra"></div>
					<div class="text">${fn:substring(list.board_title,0,14)}</div>
					<div class="img"><img src="${list.vod_repo}" alt="컨텐츠이미지" /></div>
					<div class="text-over">
						<div class="header">
							<span class="hits">${list.view_count}</span>
							<span class="down ml-10">
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
				</div>
				</div>
				<div class="contents_form" onClick="common.viewContents('${list.idx}')">
				<div class="h50 viewform" id="form_${list.idx}">
					<div class="gra"></div>
					<div class="text">${fn:substring(list.board_title,0,14)}</div>
					<div class="img"><img src="${list.vod_repo}" alt="컨텐츠이미지" /></div>
					<div class="text-over">
						<div class="header">
							<span class="hits">${list.view_count}</span>
							<span class="down ml-10">
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
				</div>
				</div>
				</div>
				</c:if>
						
						
						
						</c:forEach>
						</c:otherwise>
						</c:choose>
					</div>
				</div><!-- //썸네일 혼합형 -->
