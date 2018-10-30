<!-- ##########ADD SCHEDULE##################### -->
<!-- Schedule Time Resize alert -->
 <div class="modal fade" id="addNew-event">
      <div class="modal-dialog">
           <div class="modal-content">
                <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title">Add Schedule</h4>
                </div>
                <div class="modal-body">
                    <form class="form-validation" role="form" id="liveAddForm">
                        <div class="form-group col-lg-12">
                             <label for="eventName">방송 제목</label>
                             <input type="text" class="input-sm m-b-10  form-control validate[required]" id="eventName" placeholder="방송 제목">
                        </div>
                        <div class="form-group col-lg-6 m-b-10 ">
                        	<label for="getStart">방송 시작</label>
                         	<input type="text" class="input-sm form-control validate[required]" id="getStart-" placeholder="예)2018-01-01 23:12:06:49"/>  
          				</div>
                        <div class="form-group col-lg-6 p-b-10">
                         	<label for="getStart">방송 종료</label>
                          	<input type="text" class="input-sm form-control validate[required,funcCall[uploadFile.checkSchedule]]" id="getEnd-" placeholder="예)2018-01-01 23:12:06:49"/>
                        </div>
                        
                        <!-- 대상  -->
                        <div class="form-group col-lg-12">
                        <label>대상 그룹</label>
                        	<div id="scheduleInsertModel"  style="border:1px solid rgba(255,255,255,0.3);"></div>
                        	<input type="text" id="groupArr" class="input-sm form-control validate[required]" style="width:1px;height:1px;opacity: 0;"/>
                        </div>
                        <!-- 소스  -->
                        <div class="form-group col-lg-12">
                        	<label>영상 소스</label>
                        	<div class="tab-container tile">
                        		<ul class="nav tab nav-tabs">
                        			<li class="sourceTab active" value="LIVE" id="liveTab"><a href="#live">STREAM URL</a></li>
                            		<li class="sourceTab" value="VOD" id="vodTab"><a href="#video">VIDEO</a></li>
                        		</ul>
                        		<div class="tab-content" style="padding:5px;">
                        			<div class="tab-pane active" id="live">
                        				
                        			</div>
                        			<div class="tab-pane" id="video" >
                        				
                        			</div>
                        		</div>
                        	</div>
                        	<input type="hidden" id="live_stream_url"/>
                        </div> 
                        <!-- 자막폼 -->
                        <div class="form-group col-lg-12">
                        	<button class="btn btn-xs btn-alt m-r-5" id="captionView">자 막 설 정 열 기</button>
                        </div>
                       	<div class="clearfix"></div>
                        <div id="captionForm" style="border:1px solid rgba(255,255,255,0.3);display:none;">
                        	<!-- 자막  -->
	                        <div class="col-lg-12 p-b-10">
	                        	<div></div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_size" class="control-label">글자 크기</label>
	                       			<div>
	                       				<select id="caption_size" class="form-control input-sm">
	                       					<option value="1">작게</option>
	                       					<option value="2">보통</option>
	                       					<option value="3">크게</option>
	                       				</select>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_text_color" class="control-label">자막 색상</label>
	                       			<div class="color-pick input-icon">
	                       				<input id="caption_text_color" class="form-control color-picker input-sm" type="text">
	                       				<span class="color-preview"></span>
	                                	<span class="add-on">
	                                    <i class="sa-plus"></i>
	                                	</span>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_bg_color" class="control-label">자막 색상</label>
	                       			<div class="color-pick input-icon">
	                       				<input id="caption_bg_color" class="form-control color-picker input-sm" type="text">
	                       				<span class="color-preview"></span>
	                                	<span class="add-on">
	                                    <i class="sa-plus"></i>
	                                	</span>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_speed" class="control-label">자막 동작</label>
	                       			<div>
	                       				<select id="caption_speed" class="form-control input-sm">
	                       					<option value="1">고정</option>
	                       					<option value="2">보통</option>
	                       					<option value="3">빠르게</option>
	                       					<option value="4">천천히</option>
	                       				</select>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-12">
	                       			<textarea class="form-control overflow" id="caption" tabindex="5001" style="overflow: hidden; outline: none;" placeholder="자막 내용"></textarea>
	                       			<span>자막설정은 최대 255자, 3줄까지만 가능합니다.</span><span style="float:right;"><small id="nowLetter">0</small>/<small>255</small></span>
	                       		</div>
	                       	</div> 
	                       <!-- 자막폼 -->
	                        <div class="clearfix"></div>
                        </div>
                         <!-- 편성 색상  -->
	                        <div class="form-group col-lg-12 p-b-10">
	                        	<div class="form-group col-lg-3">
	                       			<label for="caption_bg_color">편성 색상</label>
	                       			<div class="color-pick input-icon">
	                       				<input id="color" class="form-control color-picker input-sm validate[required]">
	                       				<span class="color-preview"></span>
	                                	<span class="add-on">
	                                    <i class="sa-plus"></i>
	                                	</span>
	                       			</div>
	                       		</div>
	                        </div> 
                        <!-- 대표이미지  -->
	                        <div class="form-group col-lg-12 p-b-10">
	                        	<label for="caption_bg_color">편성 이미지</label>
	                        	<div class="fileupload fileupload-new p-5" data-provides="fileupload">
		       						<div class="fileupload-preview thumbnail form-control" id="imgName_view">편성 이미지를 업로드하세요</div>
		        					<div class="pull-right">
		            					<span class="btn btn-file btn-alt btn-sm">
		                					<span class="fileupload-new">이미지 선택</span>
		                					<span class="fileupload-exists">이미지 바꾸기</span>
		                					<input type="file" id="imgName" onchange="uploadFile.scheduleImg(this,'imgName');" />
		                					
		                				</span>
		            				</div>
		    					</div> 
		    					<input type="text" id="image_path" class="validate[required]" style="opacity: 0;width:1px;height:1px;"> 
	                        </div>
                        <!-- 내용 -->
                        <div class="form-group col-lg-12 p-b-10">
                        	<label for="desc_text">생방송 내용</label>
                        	<textarea class="form-control overflow" id="desc_text" tabindex="5001" style="overflow: hidden; outline: none;"></textarea>
                        </div>
                        <input type="hidden" id="idx"/>
                        <input type="hidden" id="source_type"  value="LIVE"/>
                    	<input type="hidden" id="live_ch_idx" class="form-control"/>
                        <input type="hidden" id="captionYn" value="N">
                        <input type="hidden" id="order">
                     </form>
                </div>
                
                <div class="modal-footer">
                     <input type="button" class="btn btn-info btn-sm" id="addEvent" value="생방송 추가">
                     <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">닫기</button>
                     <button type="button" class="btn btn-info btn-sm" id="deleteEvent" onClick="calClick.deleteEvent();" style="display:none;float:right;">삭 제</button>
                </div>
           </div>
      </div>
 </div>
 <!-- ##########ALL MODAL END SCHEDULE##################### -->   