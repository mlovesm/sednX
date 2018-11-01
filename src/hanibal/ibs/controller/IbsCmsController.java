package hanibal.ibs.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.management.AttributeNotFoundException;
import javax.management.InstanceNotFoundException;
import javax.management.MBeanException;
import javax.management.MalformedObjectNameException;
import javax.management.ReflectionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import hanibal.ibs.dao.IbsCmsDAO;
import hanibal.ibs.library.DataMap;
import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.library.IbsCmsPagingUtil;
import hanibal.ibs.model.cms.BoardDTO;
import hanibal.ibs.model.cms.FileDTO;
import hanibal.ibs.model.cms.LiveDTO;
import hanibal.ibs.model.cms.MemberAccountDTO;
import hanibal.ibs.model.cms.PhotoDTO;
import hanibal.ibs.model.cms.ScheduleDTO;
import hanibal.ibs.model.cms.VodDTO;
import hanibal.ibs.model.stb.StbDTO;
import hanibal.ibs.model.webapi.LayoutDTO;
import hanibal.ibs.model.webapi.TreeMenu;

@SuppressWarnings("unchecked")

@Controller
public class IbsCmsController {
	Logger log = Logger.getLogger(this.getClass());
	ObjectMapper mapper = new ObjectMapper();
	IbsCmsDAO ibsCmsDao;
	
	String repositoryPath;
	String sednIp;
	String mediaIp;

	
	public void setLog(Logger log) {
		this.log = log;
	}
	
	public void setIbsCmsDao(IbsCmsDAO ibsCmsDao) {
		this.ibsCmsDao = ibsCmsDao;
	}
	
	

	public void setRepositoryPath(String repositoryPath) {
		this.repositoryPath = repositoryPath;
	}

	public void setSednIp(String sednIp) {
		this.sednIp = sednIp;
	}

	public void setMediaIp(String mediaIp) {
		this.mediaIp = mediaIp;
	}
	
	@RequestMapping("/cms/login")
	public String login() {
		return "/ibsCmsViews/cmslogin.inc";
	}
	
	@RequestMapping("/cms/join")
	public String join() {
		return "/ibsCmsViews/cmsjoin.inc";
	}
	
	@RequestMapping("/cms/forgetpass")
	public String lostpass() {
		return "/ibsCmsViews/cmspass.inc";
	}
	
	@RequestMapping(value="/cms/loginProcess",method=RequestMethod.POST)
	public String loginProcess(@ModelAttribute MemberAccountDTO dto,HttpSession session,HttpServletRequest req) throws IOException, JSONException {
		String returnPage="";
		//JSONObject json =ibsCmsDao.readJsonFromUrl("http://"+sednIp+":8080/api/web/checkMemberPass?member_email="+dto.getMember_email()+"&member_pass="+dto.getMember_pass());
		//log.info("##############"+json.getString("msg")+"############"+dto.getMember_pass());
		MemberAccountDTO accountDto=ibsCmsDao.memberInfo(dto.getMember_email(),dto.getMember_pass());
		if(accountDto.getMember_id().length()>0) {
			session.setAttribute("member_idx", accountDto.getIdx());
			session.setAttribute("member_id", accountDto.getMember_id());
			session.setAttribute("member_name", accountDto.getMember_name());
			session.setAttribute("member_email",accountDto.getMember_email());
			session.setAttribute("member_last_dt", accountDto.getMember_last_dt());
			session.setAttribute("member_authority",accountDto.getMember_authority());
			session.setAttribute("member_profile",accountDto.getMember_profile());
			ibsCmsDao.updateLastLogin(accountDto.getIdx());
			session.setMaxInactiveInterval(60*60*60);
			
			//추가 by MGS
			String reg_id=String.valueOf(session.getAttribute("member_email"));
			String reg_ip = req.getHeader("X-FORWARDED-FOR");
			if(reg_ip==null) reg_ip=req.getRemoteAddr();
			// (device, reg_dt, reg_id, reg_ip) 
			HashMap<String, Object> commandMap = new HashMap<>();
			commandMap.put("device", "WEB");
			commandMap.put("reg_id", reg_id);
			commandMap.put("reg_ip", reg_ip);
			ibsCmsDao.tb_sedn_logInsert(commandMap);
			
			
			returnPage="redirect:/sednmanager";
		}else{
			returnPage="/ibsCmsViews/cmslogin.inc";
		}
		return returnPage;
	}
	@RequestMapping("/cms/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/cms/login";
	}
	@RequestMapping ("/cms/memberJoin")
	@ResponseBody
	public String memberJoin(@ModelAttribute MemberAccountDTO dto) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException, UnknownHostException {
		//아이디 메일로 셋팅
		if(dto.getMember_id()==null) {
			dto.setMember_id(dto.getMember_email());
		}
		//인증키 발급 
		String key = new HanibalWebDev().getKey(50, false);
		dto.setMember_tempcode(key);
		//데이터 베이스 등록 
		int affectcount=ibsCmsDao.memberJoin(dto);
		//메일 보내기 
		String mailBody="<a href='http://"+sednIp+":8080/api/web/emailConfirm?key="+key+"' target='_blank'>클릭하면 인증이 완료 됩니다.=>"+key+"</a>";
		if(affectcount!=0) {
			HanibalWebDev.sednEmail("inuc@inucreative.com",dto.getMember_email(),"SEDN 관리자 사이트 가입 인증번호 입니다.",mailBody);
		}
		return dto.getMember_email();
	}
	@RequestMapping("/cms/lostpass")
	@ResponseBody
	public String lostpass(@ModelAttribute MemberAccountDTO dto) {
		//임시비밀번호 발급
		String key = new HanibalWebDev().getKey(6, false);
		log.info(key);
		//비밀번호 업데이트
		String mailBody="귀하의 임시 비밀번호가 발급되었습니다. 임시 비밀번호=>"+key;
		int affectcount=ibsCmsDao.updateTempPass(dto.getMember_email(),key);
		if(affectcount!=0){
			HanibalWebDev.sednEmail("inuc@inucreative.com",dto.getMember_email(),"SEDN 관리자 임시 비밀번호 입니다.",mailBody);
		}
		return dto.getMember_email();
	}
	@RequestMapping("/cms/memberEdit")
	@ResponseBody
	public String memberEdit(HttpSession session ,@ModelAttribute MemberAccountDTO dto) {
		int affectcount=ibsCmsDao.editMember(dto);
		if(affectcount!=0) {
			session.setAttribute("member_name", dto.getMember_name());
			session.setMaxInactiveInterval(60*60*60);
			return "success";
		}else {
			return "fail";
		}
	}
	/*cms 전체 리스트*/
	@RequestMapping("/cms/list/{order}")
	public String cmsList(
			@RequestParam(required=false) String authority,
			//공통 파라미터 
			@PathVariable String order,
			ModelMap mav,
			@RequestParam(required=false) String nowPage,
			@RequestParam(required=false) String searchWord,
			@RequestParam(required=false) String childIdx,
			HttpServletResponse res,
			HttpServletRequest req,
			Model model
			)throws Exception {
		String viewPage = "";
		if(searchWord== null) searchWord="";
		int totalRecordCount,totalPage,pageSize,blockPage,start,end;
		if(nowPage == null||Integer.parseInt(nowPage)<1) nowPage="1";
		if(order.equals("member")) {
			if(authority==null) authority="";
			pageSize=20;
			blockPage=20;
			totalRecordCount = ibsCmsDao.getMemberTotalRecordCount(authority,searchWord);
			totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			start = (Integer.parseInt(nowPage)-1)*pageSize;
			end = blockPage;
			List<MemberAccountDTO> lists=ibsCmsDao.memberList(authority,searchWord,start,end);
			model.addAttribute("lists", lists);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("searchWord",searchWord);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("authority",authority);
			String pagingStr = 
					IbsCmsPagingUtil.memberPagingText(req,
							searchWord,
							authority,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/member?");
			model.addAttribute("pagingStr", pagingStr);
			viewPage="/ibsCmsViews/WEB_ManagerAccountList.inc";
		}else if(order.equals("vod")) {
			//pageSize=18;
			//blockPage=18;
			totalRecordCount = ibsCmsDao.getVodTotalRecordCount(searchWord,childIdx);
			//totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			//start = (Integer.parseInt(nowPage)-1)*pageSize;
			//end = blockPage;
			start=0;
			end = totalRecordCount;
			List<VodDTO> lists=ibsCmsDao.vodList(searchWord,childIdx,start,end);
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			}
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setVod_path("http://"+mediaIp+"/"+order.toUpperCase()+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
			}
			model.addAttribute("lists", lists);
			//model.addAttribute("totalPage", totalPage);
			//model.addAttribute("totalRecordCount", totalRecordCount);
			//model.addAttribute("pageSize", pageSize);
			model.addAttribute("searchWord",searchWord);
			//model.addAttribute("nowPage", nowPage);
			/*String pagingStr = 
					IbsCmsPagingUtil.vodPagingText(req,
							searchWord,
							childIdx,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/vod?");
			model.addAttribute("pagingStr", pagingStr);*/
			viewPage="/ibsCmsViews/WEB_MakePage_vod.inc";
		}else if(order.equals("photo")) {
			//pageSize=18;
			//blockPage=18;
			totalRecordCount = ibsCmsDao.getPhotoTotalRecordCount(searchWord,childIdx);
			//totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			//start = (Integer.parseInt(nowPage)-1)*pageSize;
			//end = blockPage;
			start=0;
			end = totalRecordCount;
			List<PhotoDTO> lists=ibsCmsDao.photoList(searchWord,childIdx,start,end);
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setPhoto_path("/REPOSITORY/"+order.toUpperCase()+HanibalWebDev.getDataPath(lists.get(i).getPhoto_path())+lists.get(i).getPhoto_path());
			}
			model.addAttribute("lists", lists);
			model.addAttribute("childIdx", childIdx);
			//model.addAttribute("totalPage", totalPage);
			model.addAttribute("totalRecordCount", totalRecordCount);
			//model.addAttribute("pageSize", pageSize);
			model.addAttribute("searchWord",searchWord);
			//model.addAttribute("nowPage", nowPage);
			/*String pagingStr = 
					IbsCmsPagingUtil.photoPagingText(req,
							searchWord,
							childIdx,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/photo?");
			model.addAttribute("pagingStr", pagingStr);*/
			viewPage="/ibsCmsViews/WEB_Contents_photoPage.inc";
		}else if(order.equals("file")) {
			//pageSize=15;
			//blockPage=15;
			totalRecordCount = ibsCmsDao.getFileTotalRecordCount(searchWord,childIdx);
			//totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			//start = (Integer.parseInt(nowPage)-1)*pageSize;
			//end = blockPage;
			start=0;
			end = totalRecordCount;
			List<FileDTO> lists=ibsCmsDao.fileList(searchWord,childIdx,start,end);
			model.addAttribute("lists", lists);
			model.addAttribute("childIdx", childIdx);
			//model.addAttribute("totalPage", totalPage);
			model.addAttribute("totalRecordCount", totalRecordCount);
			//model.addAttribute("pageSize", pageSize);
			//model.addAttribute("searchWord",searchWord);
			//model.addAttribute("nowPage", nowPage);
			/*String pagingStr = 
					IbsCmsPagingUtil.filePagingText(req,
							searchWord,
							childIdx,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/file?");
			model.addAttribute("pagingStr", pagingStr);*/
			viewPage="/ibsCmsViews/WEB_Contents_filePage.inc";
		}else if(order.equals("stream")) {
			//pageSize=15;
			//blockPage=15;
			totalRecordCount = ibsCmsDao.getLiveTotalRecordCount(searchWord,childIdx);
			//totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			//start = (Integer.parseInt(nowPage)-1)*pageSize;
			//end = blockPage;
			start=0;
			end = totalRecordCount;
			List<LiveDTO> lists=ibsCmsDao.liveList(searchWord,childIdx,start,end);
			model.addAttribute("lists", lists);
			model.addAttribute("childIdx", childIdx);
			//model.addAttribute("totalPage", totalPage);
			model.addAttribute("totalRecordCount", totalRecordCount);
			//model.addAttribute("pageSize", pageSize);
			model.addAttribute("searchWord",searchWord);
			//model.addAttribute("nowPage", nowPage);
			/*String pagingStr = 
					IbsCmsPagingUtil.livePagingText(req,
							searchWord,
							childIdx,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/live?");
			model.addAttribute("pagingStr", pagingStr);*/
			viewPage="/ibsCmsViews/WEB_Contents_streamPage.inc";
		}else if(order.equals("board")) {
			/*pageSize=10;
			blockPage=10;*/
			totalRecordCount = ibsCmsDao.getBoardTotalRecordCount(searchWord,childIdx);
			/*totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			start = (Integer.parseInt(nowPage)-1)*pageSize;
			end = blockPage;*/
			start=0;
			end = totalRecordCount;
			List<BoardDTO> lists=ibsCmsDao.boardList(searchWord,childIdx,start,end);
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setVod_repo("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getVod_repo())+lists.get(i).getVod_repo());
			}
			model.addAttribute("lists", lists);
			/*model.addAttribute("childIdx", childIdx);
			model.addAttribute("totalPage", totalPage);*/
			model.addAttribute("totalRecordCount", totalRecordCount);
			/*model.addAttribute("pageSize", pageSize);
			model.addAttribute("searchWord",searchWord);
			model.addAttribute("nowPage", nowPage);
			String pagingStr = 
					IbsCmsPagingUtil.boardPagingText(req,
							searchWord,
							childIdx,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/board?");
			model.addAttribute("pagingStr", pagingStr);*/
			viewPage="/ibsCmsViews/WEB_MakePage_List.inc";
		}else if(order.equals("stb-controle")) {
			pageSize=10;
			blockPage=10;
			totalRecordCount = ibsCmsDao.getStbTotalRecordCount(searchWord,childIdx);
			totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			start = (Integer.parseInt(nowPage)-1)*pageSize;
			end = blockPage;
			List<StbDTO> lists=ibsCmsDao.stbList(searchWord,childIdx,start,end);
			model.addAttribute("lists", lists);
			model.addAttribute("childIdx", childIdx);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("searchWord",searchWord);
			model.addAttribute("nowPage", nowPage);
			String pagingStr = 
					IbsCmsPagingUtil.stbPagingText(req,
							searchWord,
							childIdx,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/stb-controle?");
			model.addAttribute("pagingStr", pagingStr);
			viewPage="/ibsCmsViews/STB_Controle_List.inc";
		}else if(order.equals("live")) {
			String events="";
			String comma=",";
			pageSize=10;
			blockPage=10;
			totalRecordCount = ibsCmsDao.getScheduleTotalRecordCount(searchWord,childIdx);
			totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
			start = (Integer.parseInt(nowPage)-1)*pageSize;
			end = blockPage;
			List<ScheduleDTO> lists=ibsCmsDao.scheduleList(searchWord,childIdx,start,end);
			for(int i=0;i<lists.size();i++) {
				if(lists.get(i).getImage_path()==null) lists.get(i).setImage_path(""); 
				if(lists.get(i).getImage_path().length()!=0) {
					lists.get(i).setImage_path("/REPOSITORY/SCHIMG/"+lists.get(i).getImage_path());
				}
			}
			List<ScheduleDTO> eventLists=ibsCmsDao.eventList(childIdx);
			for(int i=0;i<eventLists.size();i++) {
				if(i==eventLists.size()-1) comma="";
				events+="{title:'"+eventLists.get(i).getName()+"',"
						+ "url:'javascript:calClick.viewEvent("+eventLists.get(i).getIdx()+");',"
						+ "start:'"+eventLists.get(i).getStart()+"',"
						+ "end:'"+eventLists.get(i).getEnd()+"',"
						+ "allDay:false,"
						+ "idx :'"+eventLists.get(i).getIdx()+"' }"+comma+"";
			}
			List<HashMap<String,Object>> targetList=ibsCmsDao.getTargetList(childIdx);
			boolean stbAll=false;
			boolean internet=false;
			for(int i=0;i<targetList.size();i++) {
				if(targetList.get(i).get("group_idx").equals(0)) {
					internet=true;
				}
			}
			int targetCount=targetList.size();
			if(internet) {
				targetCount=targetCount-1;
			}
			int totalTargetCount=ibsCmsDao.getTotalTargetCount()-1;
			if(totalTargetCount==targetCount) {
				stbAll=true;
			}
			log.info(totalTargetCount+"---------------"+targetCount);
			model.addAttribute("events", events);
			model.addAttribute("lists", lists);
			model.addAttribute("targetLists",targetList);
			model.addAttribute("internet",internet);
			model.addAttribute("stbAll",stbAll);
			model.addAttribute("childIdx", childIdx);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("searchWord",searchWord);
			model.addAttribute("nowPage", nowPage);
			String pagingStr = 
					IbsCmsPagingUtil.schedulePagingText(req,
							searchWord,
							childIdx,
							totalRecordCount, 
							pageSize, 
							blockPage, 
							Integer.parseInt(nowPage),
							req.getContextPath()+"/cms/list/stb-schedule?");
			model.addAttribute("pagingStr", pagingStr);
			viewPage="/ibsCmsViews/STB_Schedule_List.inc";
		}else if(order.equals("stb-log")) {
			viewPage="/ibsCmsViews/STB_Log_List.inc";
		}else if(order.equals("stb-ui")) {
			viewPage="/ibsCmsViews/STB_Ui_List.inc";
		}
		return viewPage;
	}
	@RequestMapping("/cms/makepage/{order}/{idx}")
	public String makePageSetting(@PathVariable String order,@PathVariable String idx,Model model) {
		String viewPage="";
		List<LayoutDTO> lists=ibsCmsDao.getLayoutList(Integer.parseInt(idx));
		model.addAttribute("category",idx);
		model.addAttribute("lists",lists);
		if(order.equals("setting")) {
			viewPage="/ibsCmsViews/WEB_MakePage_Setting.inc";
		}else {
			viewPage="/ibsCmsViews/WEB_MakePage_Preview.inc";
		}
		return viewPage;
	}
	
	@RequestMapping("/cms/makepage/editForm/{category}/{index}/{type}/{idx}")
	public String editForm(@PathVariable String category,
			@PathVariable String index,
			@PathVariable String type,
			@PathVariable String idx,
			Model model) {
		if(type.equals("E")) {
			Map<String,Object> detailMap=ibsCmsDao.getLayoutDetail(idx);
			model.addAttribute("resultMap",detailMap);
		}
		model.addAttribute("idx", idx);
		model.addAttribute("type",type);
		model.addAttribute("index",index);
		return "/ibsInclude/editSetting.inc";
	}
	/*UPDATE*/
	@RequestMapping("/cms/update/{order}")
	public void updateData(
			@PathVariable String order,
			@RequestParam(required=false) String changeVal,
			@RequestParam(required=false) String checkValArr,
			@RequestParam Map<String, Object> commandMap,
			ModelMap mav,
			HttpServletResponse res
			) throws JsonGenerationException, JsonMappingException, IOException {
		Map<String,Object> map = new HashMap<String,Object>();
		int affectcount=0;
		res.setCharacterEncoding("utf8");
		if(order.equals("member")) {
			affectcount=ibsCmsDao.updateMemberAuthority(changeVal,HanibalWebDev.StringToIntArray(checkValArr));
			if(affectcount==0) {
				map.put("result", "fail");
			}else{
				map.put("result","success");
			}
		}else if(order.equals("elemCategory")) {
			affectcount=ibsCmsDao.updateElemCategory(commandMap);
			if(affectcount==0) {
				map.put("result", "fail");
			}else{
				map.put("result","success");
				String table=HanibalWebDev.targetTable(String.valueOf(commandMap.get("sort")));
				String oneDepth=HanibalWebDev.getCategoryName(String.valueOf(commandMap.get("sort")),String.valueOf(HanibalWebDev.getParent(table,String.valueOf(commandMap.get("updateIdx")))));
				String twoDepth=HanibalWebDev.getCategoryName(String.valueOf(commandMap.get("sort")),String.valueOf(commandMap.get("updateIdx")));
				map.put("oneDepth",oneDepth);
				map.put("twoDepth",twoDepth);
			}
		}
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	/*DELETE*/
	@RequestMapping("/cms/delete/{order}")
	public void deleteData(
			@PathVariable String order,
			@RequestParam(required=false) String checkValArr,
			ModelMap mav,
			HttpServletResponse res
			) throws JsonGenerationException, JsonMappingException, IOException {
		Map<String,Object> map = new HashMap<String,Object>();
		int affectcount=0;
		res.setCharacterEncoding("utf8");
		if(order.equals("member")) {
			affectcount=ibsCmsDao.deleteMemberAuthority(HanibalWebDev.StringToIntArray(checkValArr));
			if(affectcount>0) {
				map.put("result","success");
			}else{
				map.put("result", "fail");
			}
		}else if(order.equals("stb-schedule")) {
			affectcount=ibsCmsDao.deleteSchedule(HanibalWebDev.StringToIntArray(checkValArr));
			if(affectcount>0) {
				map.put("result","success");
			}else{
				map.put("result", "fail");
			}
		}else if(order.equals("vod")||order.equals("stream")||order.equals("file")||order.equals("photo")||order.equals("board")||order.equals("stb-controle")) {
			affectcount=ibsCmsDao.deleteContents(order,HanibalWebDev.StringToIntArray(checkValArr));
			if(affectcount>0) {
				map.put("result","success");
			}else{
				map.put("result", "fail");
			}
		}
		
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	/*CATEGORY SELECT LIST*/
	@RequestMapping("/cms/categorySelect/{order}/{idx}")
	@ResponseBody
	public String categorySelect(@PathVariable String order,@PathVariable String idx) throws IOException {
		String table=HanibalWebDev.targetTable(order);
		String data=HanibalWebDev.getCategorySelect(table,idx);
		return data;
	}
	/*CONTETS FORM*/
	@RequestMapping("/cms/form/{contents}/{order}/{idx}")
	public String cmsForm(@PathVariable String contents,@PathVariable String order,@PathVariable String idx,Model model,HttpServletRequest req) {
		String returnPage="";
		if(contents.equals("vod")) {
			if(order.equals("update")) {
				HashMap<String,Object> hashmap=ibsCmsDao.getVodContents(idx);
				hashmap.put("vod_url","http://"+mediaIp+"/"+contents.toUpperCase()+HanibalWebDev.getDataPath(String.valueOf(hashmap.get("vod_path")))+hashmap.get("vod_path")+"/index.m3u8");
				hashmap.put("thumbnail_url","/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(String.valueOf(hashmap.get("vod_path")))+hashmap.get("main_thumbnail"));
				hashmap.put("datePath",HanibalWebDev.getDataPath(String.valueOf(hashmap.get("vod_path"))));
				model.addAttribute("resultMap",hashmap);
				model.addAttribute("idx",idx);
			}
			model.addAttribute("order",order);
			returnPage="/ibsInclude/vodForm.inc";
		}
		if(contents.equals("file")) {
			if(order.equals("update")) {
				HashMap<String,Object> hashmap=ibsCmsDao.getFileContents(idx);
				model.addAttribute("resultMap",hashmap);
				model.addAttribute("idx",idx);
			}
			model.addAttribute("order",order);
			returnPage="/ibsInclude/fileForm.inc";
		}
		if(contents.equals("live")) {
			if(order.equals("update")) {
				HashMap<String,Object> hashmap=ibsCmsDao.getLiveContents(idx);
				model.addAttribute("resultMap",hashmap);
				model.addAttribute("idx",idx);
			}
			model.addAttribute("order",order);
			returnPage="/ibsInclude/liveForm.inc";
		}
		if(contents.equals("photo")) {
			if(order.equals("update")) {
				HashMap<String,Object> hashmap=ibsCmsDao.getPhotoContents(idx);
				hashmap.put("photo_url","/REPOSITORY/"+contents.toUpperCase()+HanibalWebDev.getDataPath(String.valueOf(hashmap.get("photo_path"))));
				model.addAttribute("resultMap",hashmap);
				model.addAttribute("idx",idx);
			}
			model.addAttribute("order",order);
			returnPage="/ibsInclude/photoForm.inc";
		}
		if(contents.equals("board")) {
			if(order.equals("update")) {
				HashMap<String,Object> hashmap=ibsCmsDao.getBoardContents(idx);
				model.addAttribute("resultMap",hashmap);
				model.addAttribute("idx",idx);
			}
			model.addAttribute("order",order);
			returnPage="/ibsInclude/boardForm.inc";
		}
		if(contents.equals("stb-controle")) {
			String treeMenu="";
			List<TreeMenu> lists=null;
			lists=ibsCmsDao.getMenuTree(contents);
			lists.get(0).setParent("#");
			for(int i=0;i<lists.size();i++) {
				treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText()+" ["+lists.get(i).getNum()+"]\","
						+ "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\""
						+ ",\"state\":{\"opened\":false";
						treeMenu+="}},";
			}
			model.addAttribute("treeMenu", treeMenu);
			if(order.equals("update")) {
				HashMap<String,Object> hashmap=ibsCmsDao.getSettopBox(idx);
				model.addAttribute("resultMap",hashmap);
				model.addAttribute("idx",idx);
			}
			model.addAttribute("order",order);
			returnPage="/ibsInclude/stbControleForm.inc";
		}
		return returnPage;
	}
	
	
	@RequestMapping("/cms/excute/{contents}/{order}")
	@ResponseBody
	public String excuteContents(@PathVariable String contents,@PathVariable String order,@RequestParam Map<String, Object> commandMap,Model model,HttpServletRequest req,HttpSession session) throws IOException {
		int affectcount=0;
		String msg="success";
		String reg_id=String.valueOf(session.getAttribute("member_email"));
		String reg_ip = req.getHeader("X-FORWARDED-FOR");
		if(reg_ip==null) reg_ip=req.getRemoteAddr();
		if(contents.equals("stream")) {
			if(order.equals("update")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.updateLiveContent(commandMap);
			}else if(order.equals("insert")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.insertLiveContent(commandMap);
			}
		}else if(contents.equals("file")) {
			if(order.equals("update")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.updateFileContent(commandMap);
			}else if(order.equals("insert")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.insertFileContent(commandMap);
			}
		}else if(contents.equals("photo")) {
			if(order.equals("update")) {
				String datePath=HanibalWebDev.getDataPath(String.valueOf(commandMap.get("photo_path")));
				String full_path=repositoryPath+contents.toUpperCase()+datePath+String.valueOf(commandMap.get("photo_path"));
				String resolution=HanibalWebDev.getResolution(full_path);
				commandMap.put("resolution", resolution);
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.updatePhotoContent(commandMap);
			}else if(order.equals("insert")) {
				String datePath=HanibalWebDev.getDataPath(String.valueOf(commandMap.get("photo_path")));
				String full_path=repositoryPath+contents.toUpperCase()+datePath+String.valueOf(commandMap.get("photo_path"));
				String resolution=HanibalWebDev.getResolution(full_path);
				commandMap.put("resolution", resolution);
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.insertPhotoContent(commandMap);
				msg=String.valueOf(HanibalWebDev.getPhotoTop());
				
			}
		}else if(contents.equals("vod")) {
			if(order.equals("update")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				ibsCmsDao.updateVodContent(commandMap);
				affectcount=ibsCmsDao.editUpdateVodBox(commandMap);
			}else if(order.equals("insert")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				ibsCmsDao.insertVodContent(commandMap);
				int topIdx=ibsCmsDao.getVodTopIdx(String.valueOf(commandMap.get("vod_path")));
				commandMap.put("topIdx",topIdx);
				affectcount=ibsCmsDao.updateVodBox(commandMap);
			}
		}else if(contents.equals("board")) {
			if(order.equals("update")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.updateBoardContent(commandMap);
			}else if(order.equals("insert")) {
				commandMap.put("reg_id", reg_id);
				commandMap.put("reg_ip", reg_ip);
				affectcount=ibsCmsDao.insertBoardContent(commandMap);
			}
		}else if(contents.equals("stb-controle")) {
			if(order.equals("update")) {
				affectcount=ibsCmsDao.updateSettopBox(commandMap);
			}else if(order.equals("insert")) {
				affectcount=ibsCmsDao.insertSettopBox(commandMap);
			}
		}else if(contents.equals("stb-schedule")) {
			if(order.equals("update")) {
				int topIdx=Integer.parseInt(String.valueOf(commandMap.get("idx")));
				//바디 업데이트
				affectcount=ibsCmsDao.updateSchedule(commandMap);
				//그룹삭제
				ibsCmsDao.deleteScheduleGroup(topIdx);
				//vod 삭제 
				ibsCmsDao.deleteScheduleVod(topIdx);
				//그룹 VOD 다시 입력 
				/*int groupArr[]=HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("groupArr")));
				for(int idx : groupArr) {
					ibsCmsDao.insertScheduleGroup(topIdx,idx);
				}*/
				if(String.valueOf(commandMap.get("source_type")).equals("VOD")) {
					int vodArr[]=HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("vodArr")));
					for(int i=0;i<vodArr.length;i++) {
						ibsCmsDao.insertScheduleVod(topIdx,vodArr[i],i);
					}
				}
			}else if(order.equals("insert")) {
				affectcount=ibsCmsDao.insertSchedule(commandMap);
				int topIdx=HanibalWebDev.getScheduleTop();
				/*int groupArr[]=HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("groupArr")));
				for(int idx : groupArr) {
					ibsCmsDao.insertScheduleGroup(topIdx,idx);
				}*/
				msg=String.valueOf(topIdx);
				if(String.valueOf(commandMap.get("source_type")).equals("VOD")) {
					int vodArr[]=HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("vodArr")));
					for(int i=0;i<vodArr.length;i++) {
						ibsCmsDao.insertScheduleVod(topIdx,vodArr[i],i);
					}
				}
			}
		}
		
		return msg;
	}
	
	@RequestMapping("/cms/update/ScheduleDate")
	@ResponseBody
	public String ScheduleDate(@RequestParam Map<String, Object> commandMap) throws ParseException {
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//Date beginDate=format.parse(String.valueOf(commandMap.get("start")));
		//Date endDate=format.parse(String.valueOf(commandMap.get("end")));
		//Date today=new Date();
		//int compareEnd=today.compareTo(endDate);
		//int compareStart=today.compareTo(beginDate);
		String msg="";
		msg=ibsCmsDao.updateScheduleDate(commandMap);
		return msg;
	}
	
	/*page View*/
	@RequestMapping("/sedn/web/{section}")
	public String webSection(@PathVariable String section,Model model) throws Exception {
		String returnPage="";
		if(section.equals("dashboard")) {
			returnPage="/ibsCmsViews/WEB_Dashboard.cms";
		}
		if(section.equals("contents")) returnPage="/ibsCmsViews/WEB_Contents.cms";
		if(section.equals("communicate")) returnPage="/ibsCmsViews/WEB_Communicate.cms";
		if(section.equals("layout")) returnPage="/ibsCmsViews/WEB_Layout.cms";
		if(section.equals("managerAccount")) returnPage="/ibsCmsViews/WEB_ManagerAccount.cms";
		if(section.equals("statistics")) returnPage="/ibsCmsViews/WEB_Statistics.cms";
		if(section.equals("makepage")) returnPage="/ibsCmsViews/WEB_MakePage.cms";
		if(section.equals("liveManages")) {
			String childIdx=HanibalWebDev.getDefaultLiveIdx();
			List<HashMap<String,Object>> targetList=ibsCmsDao.getTargetList(childIdx);
			boolean stbAll=false;
			boolean internet=false;
			for(int i=0;i<targetList.size();i++) {
				if(targetList.get(i).get("group_idx").equals(0)) {
					internet=true;
				}
			}
			int targetCount=targetList.size();
			if(internet) {
				targetCount=targetCount-1;
			}
			int totalTargetCount=ibsCmsDao.getTotalTargetCount()-1;
			if(totalTargetCount==targetCount) {
				stbAll=true;
			}
			model.addAttribute("targetLists",targetList);
			model.addAttribute("internet",internet);
			model.addAttribute("stbAll",stbAll);
			returnPage="/ibsCmsViews/WEB_LiveManages.cms";
		}
			
		if(section.equals("media")) returnPage="/ibsCmsViews/WEB_Media.cms";
		return returnPage;
	}
	@RequestMapping("/sedn/stb/{section}")
	public String stbSection(@PathVariable String section) {
		String returnPage="";
		if(section.equals("controle")) returnPage="/ibsCmsViews/STB_Controle.cms";
		if(section.equals("schedule")) returnPage="/ibsCmsViews/STB_Schedule.cms";
		if(section.equals("log")) returnPage="/ibsCmsViews/STB_Log.cms";
		if(section.equals("ui")) returnPage="/ibsCmsViews/STB_Ui.cms";
		return returnPage;
	}
	@RequestMapping("/cms/layout/{contents}/insert")
	public void insertLayout(@PathVariable String contents,
			@RequestParam Map<String, Object> commandMap,
			HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		Map<String,Object> map = new HashMap<String,Object>();
		int affectcount=0;
		res.setCharacterEncoding("utf8");
		if(contents.equals("mainImage")) {
			affectcount=ibsCmsDao.insertMainImage(commandMap);
		}else if(contents.equals("mainContents")) {
			affectcount=ibsCmsDao.insertMainContents(String.valueOf(commandMap.get("idx")));
		}
		if(affectcount==0) {
			map.put("result", "fail");
		}else{
			map.put("result","success");
		}
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	@RequestMapping("/cms/layout/{contents}/delete")
	public void deleteLayout(@PathVariable String contents,
			@RequestParam Map<String, Object> commandMap,
			HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		Map<String,Object> map = new HashMap<String,Object>();
		int affectcount=0;
		res.setCharacterEncoding("utf8");
		if(contents.equals("mainImage")) {
			affectcount=ibsCmsDao.deleteMainImage(String.valueOf(commandMap.get("checkValArr")));
		}else if(contents.equals("mainContents")) {
			affectcount=ibsCmsDao.deleteMainContents(String.valueOf(commandMap.get("idx")));
		}
		if(affectcount==0) {
			map.put("result", "fail");
		}else{
			map.put("result","success");
		}
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	@RequestMapping("/cms/category/select/{order}")
	@ResponseBody
	public String getCategorySelect(@PathVariable String order) throws IOException {
		return HanibalWebDev.getCategorySelect("tb_board_category",order);
	}
	@RequestMapping("/cms/system/current")
	public void systemInfo(HttpServletResponse res) throws InstanceNotFoundException, AttributeNotFoundException, MalformedObjectNameException, ReflectionException, MBeanException, JsonGenerationException, JsonMappingException, IOException {
		String totalDiskSpace=HanibalWebDev.getTotalDiskSpace();
		String usedDiskSpace=HanibalWebDev.getUsedDiskSpace();
		String diskPercent=HanibalWebDev.getPercent(totalDiskSpace,usedDiskSpace);
		String totalMemory=HanibalWebDev.getTotalMemory();
		String usedMemory=HanibalWebDev.getUsedMemory();
		String memoryPercent=HanibalWebDev.getPercent(totalMemory,usedMemory);
		HashMap<String,Object> resultMap=ibsCmsDao.getStbConnection();
		String stbPercent=HanibalWebDev.getPercent(String.valueOf(resultMap.get("totalcount")),String.valueOf(resultMap.get("connected")));
		res.setCharacterEncoding("utf8");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("diskPercent",diskPercent);
		map.put("memoryPercent", memoryPercent);
		map.put("stbPercent", stbPercent);
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	@RequestMapping("/cms/liveTarget/{idx}")
	public void targetList(@PathVariable String idx,HttpServletResponse res) throws IOException {
		Map<String,Object> mainData =new HashMap<String,Object>();
		Map<String,Object> subData =new HashMap<String,Object>();
		String channelName=HanibalWebDev.getCategoryName("live", idx);
		List<HashMap<String,Object>> targetList=ibsCmsDao.getTargetList(idx);
		subData.put("targetList", targetList);
		mainData.put("categoryName", channelName);
		mainData.put("ret",subData);
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	@RequestMapping("/cms/target/insert")
	public void targetInsert(@RequestParam Map<String, Object> commandMap,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		ibsCmsDao.deleteTarget(Integer.parseInt(String.valueOf(commandMap.get("categoryIdx")))); 
		if(String.valueOf(commandMap.get("groupArr")).length()!=0) {
			commandMap.put("groupArr",HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("groupArr"))));
			ibsCmsDao.insertTarget(commandMap);
		}
		Map<String,Object> mainData =new HashMap<String,Object>();
		mainData.put("msg","200");
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	@RequestMapping("/sedn/download/{sort}/{type}/{file}")
	public void sednFileDownLoad(@PathVariable String sort,@PathVariable String type,@PathVariable String file, HttpServletResponse res, HttpServletRequest req) throws Exception {
		file=file+"."+type;
		String path=repositoryPath+"/"+sort.toUpperCase()+HanibalWebDev.getDataPath(file)+file;
		ibsCmsDao.fileDownLoad(path,res,req);
	}
	
	// by MGS 2018.11.01
	/* PAGE VOD 영상 가져오기 */
	@RequestMapping("/cms/makePageList/{order}")
	public String makePageVODList(
			@RequestParam(required=false) String authority,
			//공통 파라미터 
			@PathVariable String order,
			ModelMap mav,
			@RequestParam(required=false) String nowPage,
			@RequestParam(required=false) String searchWord,
			@RequestParam(required=false) String childIdx,
			HttpServletResponse res,
			HttpServletRequest req,
			Model model
			)throws Exception {
		
		String viewPage = "";
		if(searchWord== null) searchWord="";
		int totalRecordCount, start,end;
		if(nowPage == null||Integer.parseInt(nowPage)<1) nowPage="1";

		totalRecordCount = ibsCmsDao.getVodTotalRecordCount(searchWord,childIdx);

		start=0;
		end = totalRecordCount;
		List<VodDTO> lists=ibsCmsDao.vodList(searchWord,childIdx,start,end);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
		}
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setVod_path("http://"+mediaIp+"/"+order.toUpperCase()+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		model.addAttribute("lists", lists);
		model.addAttribute("searchWord",searchWord);

		viewPage="/ibsCmsViews/WEB_MakePage_vod.inc";
		
		return viewPage;
	}
	
	
}
