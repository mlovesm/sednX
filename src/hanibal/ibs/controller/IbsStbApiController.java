package hanibal.ibs.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



import hanibal.ibs.dao.IbsStbApiDAO;
import hanibal.ibs.model.stb.LiveScheduleDTO;
import hanibal.ibs.model.stb.STB_configDTO;
import hanibal.ibs.model.stb.TodayScheduleDTO;
import hanibal.ibs.model.stb.TotalScheduleDTO;
import hanibal.ibs.model.stb.VodListDTO;
import hanibal.ibs.model.stb.VodMenuDTO;

@Controller
public class IbsStbApiController {
	Logger log = Logger.getLogger(this.getClass());
	IbsStbApiDAO stbApiDao;
	ObjectMapper mapper = new ObjectMapper();
	
	String repositoryPath;
	/***
	 * 임시그룹 변
	 */
	int TMPGROUP=1;
	
	
	public void setLog(Logger log) {
		this.log = log;
	}
	public void setStbApiDao(IbsStbApiDAO stbApiDao) {
		this.stbApiDao = stbApiDao;
	}
	public void setMapper(ObjectMapper mapper) {
		this.mapper = mapper;
	}
	public void setRepositoryPath(String repositoryPath) {
		this.repositoryPath = repositoryPath;
	}
	

	@SuppressWarnings("unchecked")
	@RequestMapping("/api/stb/{order}")
	public void apiStb(
			@PathVariable String order,
			ModelMap mav,
			@RequestParam(required=false) String vod_idx,
			@RequestParam(required=false) String stb_idx,
			@RequestParam(required=false) String mac,
			@RequestParam(required=false) String ip,
			@RequestParam(required=false) String timestamp,
			@RequestParam(required=false) String status,
			@RequestParam(required=false) String groupId,
			@RequestParam(required=false) String chIdx,
			HttpServletResponse res
		) throws JsonGenerationException, JsonMappingException, IOException {
		HashMap<String, Object> hashMap;
		Map<String, Object> msg=new HashMap<String, Object>();
		res.setCharacterEncoding("utf8");
		if(groupId==null) groupId=String.valueOf(TMPGROUP);
		if(chIdx==null) chIdx=String.valueOf(TMPGROUP);
		//펌웨어 업데이트 정보 
		if(order.equals("check_for_update")) {
			hashMap=stbApiDao.apkVersion(repositoryPath);
			res.getWriter().print(mapper.writeValueAsString(hashMap));
		//웹서버 정보
		}else if(order.equals("get_server_config")) {
			hashMap=stbApiDao.getServerInfo();
			res.getWriter().print(mapper.writeValueAsString(hashMap));
		//로고 정보	
		}else if(order.equals("get_logo_config")) {
			hashMap=stbApiDao.logoInfo(repositoryPath,TMPGROUP);
			res.getWriter().print(mapper.writeValueAsString(hashMap));
		//백그라운드 이미지 정보
		}else if(order.equals("get_bg_config")) {
			hashMap=stbApiDao.bgInfo(repositoryPath,TMPGROUP);
			res.getWriter().print(mapper.writeValueAsString(hashMap));
		//위의 총괄 정보*********************셋탑박스 스킨 TMPGROUP 셋탑 소속 그굽에 따라 바뀜**********************
		}else if(order.equals("get_config")) {
			STB_configDTO dto=stbApiDao.configInfo(repositoryPath,groupId);
			res.getWriter().print(mapper.writeValueAsString(dto));
		//비디오 플레이 히스토리#####동장 않함########
		}else if(order.equals("insert_vod_history")) {
			//vod_idx 구하기 
			int vodId=stbApiDao.getVodId(Integer.parseInt(vod_idx));
			//플레이 타임 얻어오기 
			String play_time=stbApiDao.getPlayTime(vodId);
			int affectCount=stbApiDao.insertVodHistory(vod_idx,stb_idx,play_time);
			if(affectCount!=0){
				msg.put("insert", "success");
			}else{
				msg.put("insert", "fail");
			}
			res.getWriter().print(mapper.writeValueAsString(msg));
		//셋탑박스 정보
		}else if(order.equals("get_stb_info")) {
			hashMap=stbApiDao.stbInfo(mac);
			if(hashMap==null) {
				stbApiDao.insertStbInfo("신규 장비", mac,ip, 1, "2");
				hashMap=stbApiDao.stbInfo(mac);
			}
			res.getWriter().print(mapper.writeValueAsString(hashMap));
		//셋탑박스 상태 업데이트
		}else if(order.equals("update_stb_status")) {
			int affectCount=stbApiDao.updateStbStatus(mac,status,timestamp);
			if(affectCount!=0){
				msg.put("update", "success");
			}else{
				msg.put("update", "fail");
			}
			res.getWriter().print(mapper.writeValueAsString(msg));
		//최송 핑시간
		}else if(order.equals("send_ping")){
			int affectCount=stbApiDao.updateSendPing(mac);
			if(affectCount!=0){
				msg.put("update", "success");
			}else{
				msg.put("update", "fail");
			}
			res.getWriter().print(mapper.writeValueAsString(msg));
		//VOD 카테고리와 관련 영상 리스트 와 배너*********************셋탑박스 배너  TMPGROUP 셋탑 소속 그룹에 따라 바뀜**********************
		}else if(order.equals("get_stb_data")) {
			List<VodMenuDTO> vodMenuDto=stbApiDao.vodMenuInfo();
			List<VodListDTO> vodListDto=stbApiDao.vodListInfo(repositoryPath);
			hashMap=stbApiDao.stbBannerInfo(TMPGROUP,repositoryPath);
			mav.put("menu", vodMenuDto);
			mav.put("vod", vodListDto);
			mav.put("banner", hashMap);
			res.getWriter().print(mapper.writeValueAsString(mav));
		//라이브 채널리스트
		}else if(order.equals("get_channel_list")) {
			List<HashMap<String, Object>> chList=stbApiDao.stbChannelList(groupId);
			res.getWriter().print(mapper.writeValueAsString(chList));
		//스케줄리스트 
		}else if(order.equals("get_today_schedule")) {
			List<TodayScheduleDTO> todaySch=stbApiDao.todayScheduleInfo(groupId,repositoryPath);
			for(int i=0;i<todaySch.size();i++) {
				if(todaySch.get(i).getTarget_type().equals("GROUP")) {
					todaySch.get(i).setTarget_type(stbApiDao.groupSchArray(todaySch.get(i).getId()));
				}else {
					todaySch.get(i).setTarget_type("본사전체");
				}
			}
			res.getWriter().print(mapper.writeValueAsString(todaySch));
		//EPG  라이브 리스트
		}else if(order.equals("get_live_schedule")) {
			List<LiveScheduleDTO> liveSch=stbApiDao.liveScheduleInfo(chIdx);
			for(int i=0;i<liveSch.size();i++) {
				liveSch.get(i).setImage_path(repositoryPath+"SCHIMG/"+liveSch.get(i).getImage_path());
				if(liveSch.get(i).getTarget_type().equals("GROUP")) {
					liveSch.get(i).setTarget_type(stbApiDao.groupSchArray(liveSch.get(i).getId()));
				}else {
					liveSch.get(i).setTarget_type("본사전체");
				}
			}
			res.getWriter().print(mapper.writeValueAsString(liveSch));
		//라이브 스케쥴
		}else if(order.equals("get_schedule")) {
			List<TotalScheduleDTO> totalSch=stbApiDao.totalScheduleInfo(groupId);
			ArrayList<Object> total = new ArrayList<Object>();
				
			for(int i=0;i<totalSch.size();i++) {
				if(totalSch.get(i).getSource_type().equals("VOD")) {
					Map<String, Object> map = mapper.convertValue(totalSch.get(i), Map.class);
					map.put("vodlist",stbApiDao.relativeVodList(repositoryPath,totalSch.get(i).getId()));
					total.add(map);
				}else {
					Map<String, Object> map = mapper.convertValue(totalSch.get(i), Map.class);
					total.add(map);
				}
			}
			res.getWriter().print(mapper.writeValueAsString(total));
		}
	}
}
