<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header id="header" class="media">
    <a href="" id="menu-toggle"></a> 
    <a class="logo pull-left" href="${pageContext.request.contextPath}/sednmanager">SEDN</a>
    
    <div class="media-body">
        <div class="media" id="top-menu">
            <div class="pull-left tm-icon" style="margin-top: 5px;">
                <h4 id="cmsPageTitle">대시보드</h4>
            </div>                    

            <div id="time" class="pull-right">
                <span id="hours"></span>
                :
                <span id="min"></span>
                :
                <span id="sec"></span>
            </div>
        </div>
    </div>
</header>
