<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/jstree.js"></script>
<script>
  $(function () {
    // 6 create an instance when the DOM is ready
    $('#jstree').jstree();
    $('#jstree').jstree("open_all");
    // 7 bind to events triggered on the tree
   /* $('#jstree').on("changed.jstree", function (e, data) {
      console.log(data.selected);
    });*/
    // 8 interact with the tree - either way is OK
    $('button').on('click', function () {
      $('#jstree').jstree(true).select_node('child_node_1');
      $('#jstree').jstree('select_node', 'child_node_1');
      $.jstree.reference('#jstree').select_node('child_node_1');
    });
  });
  </script>
<!-- Content -->
<section id="content" class="container">
    <!-- Messages Drawer 메세지 클릭햇을시 (최신영상이 )%%%대메뉴 공통 부 분-->
	<div id="messages" class="tile drawer animated">
		<c:import url = "/inc/incMsg">
			<c:param name = "q" value = "보라매공원" />
		</c:import>
	</div>

	<!-- Notification Drawer -->
	<div id="notifications" class="tile drawer animated">
		<c:import url = "/inc/incNoti">
			<c:param name = "q" value = "보라매공원" />
		</c:import>
	</div>
	<!--메뉴경로... -->
	<ol class="breadcrumb hidden-xs">
	    <li><a href="#">Home</a></li>
	    <li><a href="#">Library</a></li>
	    <li class="active">Data</li>
	</ol>
	<!-- 대메뉴-->
	<h4 class="page-title">DASHBOARD</h4>
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
	   		<div class="tile-dark col-md-2">
	        <h3 class="block-title">STB AREA</h3>
	        	<div id="jstree" >
				    <!-- in this example the tree is populated from inline HTML -->
				    <ul>
				      <li>ROOT
				      	<ul>
				      		<li>플레너 본부
				      			<ul>
				      				<li>1그룹
				      					<ul>
				      						<li>1본부
				      							<ul>
				      								<li>1본부 구미</li>
				      								<li>1본부 광주</li>
				      								<li>1본부 의정부</li>
				      							</ul>
				      						</li>
				      						<li>2본부</li>
				      						<li>3본부</li>
				      						<li>4본부</li>
				      						<li>5본부</li>
				      						<li>6본부</li>
				      					</ul>
				      				</li>
				      				<li>2그룹</li>
				      				<li>3그룹</li>
				      				<li>4그룹</li>
				      				<li>5그룹</li>
				      			</ul>
				      		</li>
				      		<li>PCC 지사
				      			<ul>
				      				<li>구미 PCC</li>
				      				<li>광주 PCC</li>
				      				<li>의정부 PCC</li>
				      				<li>일산 PCC</li>
				      			</ul>
				      		</li>
				      		<li>엔지니어/사무소
				      			<ul>
				      				<li>엔지니어 미팅실(7:15)</li>
				      				<li>엔지니어 미팅실(7:45)</li>
				      				<li>엔지니어-사무</li>
				      			</ul>
				      		</li>
				      		<li>사무소
				      			<ul>
				      				<li>구미사무소</li>
				      				<li>창원사무소</li>
				      				<li>거제사무소</li>
				      			</ul>
				      		</li>
				      	</ul>
				      </li>
				    </ul>
				  </div>
				  <div class="p-10 pull-right">
					  <button class="btn btn-sm btn-alt">그룹 생성</button>
					  <button class="btn btn-sm btn-alt">그룹 변경</button>
					  <button class="btn btn-sm btn-alt">그룹 삭제</button>
	              </div>
	    	</div>
	    	<div class="col-md-10">
		    		<div>
	                  <h3 class="block-title"> 플레너 본부 > 1그룹 > 1본부 구미 </h3>
	                  <div style="float:right;"><input type="text" class="main-search" style="border-bottom:1px solid #FFFFFF;"></div>
	                 </div>
                  	<div class="table-responsive overflow">
                      <table class="table table-bordered table-hover tile">
                          <thead>
                              <tr>
                                  <th>check</th>
                                  <th>MAC</th>
                                  <th>그룹명</th>
                                  <th>아이피주소</th>
                                  <th>관리자</th>
                                  <th>활동상태</th>
                                  <th>장비제어</th>
                                  <th>편집</th>
                              </tr>
                          </thead>
                          <tbody>
                              <tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
                                  <td>
                                  	<label class="checkbox-inline">
                        				<input type="checkbox">
                        			</label>
                                  </td>
                                  <td>00:11:6C:06:14:E6	1</td>
                                  <td>엔지니어 미팅실</td>
                                  <td>192.168.0.75</td>
                                  <td>hanibal0717</td>
                                  <td><span class="label label-success">On</span></td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
				                  		<button type="button" class="btn btn-sm btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
				                        <button type="button" class="btn btn-sm btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
				                    </div>
                                  </td>
                                  <td>
                                  	<div class="btn-group" style="margin:0px;">
				                        <button type="button" class="btn btn-sm icon"><span>&#61952;</span> <span class="text">수정</span></button>
				                        <button type="button" class="btn btn-sm icon"><span>&#61754;</span> <span class="text">삭제</span></button>
				                    </div>
                                  </td>
                              	</tr>
                              	<tr>
	                          	<td colspan="8"style="text-align: center;">
	                          		<div class="btn-group">
			                            <button type="button" class="btn btn-sm btn-alt">1</button>
			                            <button type="button" class="btn btn-sm btn-alt">2</button>
			                            <button type="button" class="btn btn-sm btn-alt">3</button>
			                            <button type="button" class="btn btn-sm btn-alt">2</button>
			                            <button type="button" class="btn btn-sm btn-alt">3</button>
		                    		</div>
	                          	</td>
	                          </tr>
                             </tbody>
                          </table>
                        <div class="pull-left">
	                    	<button type="button" class="btn btn-alt icon"><span>&#61725;</span> <span class="text">재부팅</span></button>
	                       	<button type="button" class="btn btn-alt icon"><span>&#61910;</span> <span class="text">펌웨어 업데이트</span></button>
	                 		<button type="button" class="btn btn-alt icon"><span>&#61751;</span> <span class="text">스케쥴 내려받기</span></button>
	                       	<button type="button" class="btn btn-alt icon"><span>&#61931;</span> <span class="text">TV켜기</span></button>
	                       	<button type="button" class="btn btn-alt icon"><span>&#61834;</span> <span class="text">TV끄기</span></button>
	                    </div>
	                     <div class="pull-right">
	                       	<button type="button" class="btn btn-default icon"><span>&#61844;</span> <span class="text">그룹변경</span></button>
	                       	<button type="button" class="btn btn-default icon"><span>&#61943;</span> <span class="text">STB 추가</span></button>
	                       	<button type="button" class="btn btn-default icon"><span>&#61754;</span> <span class="text">STB 삭제</span></button>
	                   	</div>
              	</div>
	    	</div>
	    </div>
   	</div>
</section>

<!-- Older IE Message -->
<!--[if lt IE 9]>
    <div class="ie-block">
        <h1 class="Ops">Ooops!</h1>
        <p>You are using an outdated version of Internet Explorer, upgrade to any of the following web browser in order to access the maximum functionality of this website. </p>
        <ul class="browsers">
            <li>
                <a href="https://www.google.com/intl/en/chrome/browser/">
                    <img src="img/browsers/chrome.png" alt="">
                    <div>Google Chrome</div>
                </a>
            </li>
            <li>
                <a href="http://www.mozilla.org/en-US/firefox/new/">
                    <img src="img/browsers/firefox.png" alt="">
                    <div>Mozilla Firefox</div>
                </a>
            </li>
            <li>
                <a href="http://www.opera.com/computer/windows">
                    <img src="img/browsers/opera.png" alt="">
                    <div>Opera</div>
                </a>
            </li>
            <li>
                <a href="http://safari.en.softonic.com/">
                    <img src="img/browsers/safari.png" alt="">
                    <div>Safari</div>
                </a>
            </li>
            <li>
                <a href="http://windows.microsoft.com/en-us/internet-explorer/downloads/ie-10/worldwide-languages">
                    <img src="img/browsers/ie.png" alt="">
                    <div>Internet Explorer(New)</div>
                </a>
            </li>
        </ul>
        <p>Upgrade your browser for a Safer and Faster web experience. <br/>Thank you for your patience...</p>
    </div>   
<![endif]-->
