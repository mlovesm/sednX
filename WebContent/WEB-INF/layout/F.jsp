<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsUserJs/DevBoxSlide.js"></script>
<!-- 가로형 리스트 -->
				<div class="slider_form">
					<h2>${mainTitle}<span><a href="${pageContext.request.contextPath}/user/subList?searchWord=&idxArr=${wl_link_idx}"><img src="img/img_add.png" alt="더보기"/></a></span></h2>

					<div class="list-x">
						<c:choose>
						<c:when test="${empty lists }">
						데이타가 없습니다.
						</c:when>
						<c:otherwise>
						<c:forEach items="${lists}" var="list" varStatus="loop">
						<div class="contents_form" id="form_${list.idx}" onClick="common.viewContents('${list.idx}')">
							<div class="wp50 float-left">
								<div class="img"><img src="${list.vod_repo}" alt="컨텐츠이미지" /></div>
							</div>
							<div class="wp50 float-right">
								<div class="text-list">
									<p class="f18 lh20 fw600">${fn:substring(list.board_title,0,14)}<span class="filePoint"></span></p>
									<div class="f13 fw500 mt-10">
										${list.reg_dt}
										<span class="down ml-10"><c:set var="tel" value="${fn:split(list.vod_repo,'/')}" />
									<c:forEach var="file" items="${tel}" varStatus="g">
     								<c:if test="${g.count == 6}"><a href="/sedn/download/vod/mp4/${fn:substring(file,0,14)}" /></c:if>
								</c:forEach> 
								<img src="img/btn_file.png" alt="다운로드" /></a></span>
										<span class="hits ml-10">${list.view_count}</span>
									</div>
									<p class="last">
										<c:out value='${fn:substring(list.board_content.replaceAll("\\\<.*?\\\>",""),0,55)}' />
									</p>
								</div>
							</div>
							<div class="text-over none"></div>
						</div>
						</c:forEach>
						</c:otherwise>
						</c:choose>
					
					</div>
				</div><!-- //가로형 리스트 -->