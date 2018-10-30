package hanibal.ibs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hanibal.ibs.dao.IbsUserDAO;
import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.app.VodListAppDTO;
import hanibal.ibs.model.cms.BoardDTO;
import hanibal.ibs.model.statis.VisitCountVO;
import hanibal.ibs.model.webapi.LayoutDTO;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

@Controller
public class IbsUserController {
	Logger log = Logger.getLogger(this.getClass());
	ObjectMapper mapper = new ObjectMapper();
	IbsUserDAO ibsUserDAO;
	String repositoryPath;
	String sednIp;
	String mediaIp;
	String dbProperties;

	public void setLog(Logger log) {
		this.log = log;
	}
	public void setIbsUserDAO(IbsUserDAO ibsUserDAO) {
		this.ibsUserDAO = ibsUserDAO;
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
	
	//첫 화면 페이지 
	@RequestMapping("/")
	public String mainIndex(HttpServletRequest req) {
        VisitCountVO countVO = new VisitCountVO();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();
        countVO.setVisit_ip(ip);
        countVO.setVisit_agent(req.getHeader("User-Agent"));//브라우저 정보
        countVO.setVisit_refer(req.getHeader("referer"));//접속 전 사이트 정보
		ibsUserDAO.insertVisitor(countVO);
		return "/ibsUserViews/VOD_Layout.usr";
	}
	@RequestMapping("/user/live")
	public String livePage() {
		return "/ibsUserViews/Live_Layout.usr";
	}
	
	@RequestMapping("/user/subList")
	public String subList(HttpServletResponse res,@RequestParam Map<String, Object> commandMap,Model model) throws IOException {
		String searchWord=String.valueOf(commandMap.get("searchWord"));
		if(searchWord== null) searchWord="";
		int totalRecordCount = ibsUserDAO.getBoardTotalRecordCount(searchWord,String.valueOf(commandMap.get("idxArr")));
		int start=0;
		int end = totalRecordCount;
		List<BoardDTO> lists=ibsUserDAO.boardList(searchWord,String.valueOf(commandMap.get("idxArr")),start,end);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setVod_repo("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getVod_repo())+lists.get(i).getVod_repo());
		}
		model.addAttribute("lists", lists);
		model.addAttribute("categoryName",HanibalWebDev.getCategoryName("board",String.valueOf(commandMap.get("idxArr"))));
		model.addAttribute("categoryIdx",String.valueOf(commandMap.get("idxArr")));
		model.addAttribute("parentIdx",HanibalWebDev.getParent(HanibalWebDev.targetTable("board"),String.valueOf(commandMap.get("idxArr"))));
		return "/ibsInclude/userSubList.usr";
	}
	@RequestMapping("/user/layout")
	public void layoutSet(HttpServletResponse res,@RequestParam Map<String, Object> commandMap) throws JsonGenerationException, JsonMappingException, IOException {
		String categoryIdx=String.valueOf(commandMap.get("categoryIdx"));
		if(categoryIdx== null) categoryIdx="";
		List<LayoutDTO> lists=ibsUserDAO.getLayoutList(Integer.parseInt(categoryIdx));
		Map<String,Object> mainData =new HashMap<String,Object>();
		mainData.put("layout",lists);
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	@RequestMapping("/user/style")
	public String userStyle(@RequestParam Map<String, Object> commandMap,Model model) {
		String type=String.valueOf(commandMap.get("wl_type"));
		String searchWord="";
		int start=0;
		int end =20;
		List<BoardDTO> lists=ibsUserDAO.layoutList(searchWord,String.valueOf(commandMap.get("wl_categorys")),String.valueOf(commandMap.get("wl_attribute")),String.valueOf(commandMap.get("wl_sort")),start,end);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setVod_repo("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getVod_repo())+lists.get(i).getVod_repo());
		}
		model.addAttribute("lists", lists);
		model.addAttribute("mainTitle",String.valueOf(commandMap.get("wl_title")));
		model.addAttribute("wl_link_idx",String.valueOf(commandMap.get("wl_link_idx")));
		model.addAttribute("wl_attribute",String.valueOf(commandMap.get("wl_attribute")));
		return "/layout/"+type+".inc";
	}
	@RequestMapping("/user/layoutUpdate/{option}")
	@ResponseBody
	public String layoutUdate(@PathVariable String option,@RequestParam Map<String, Object> commandMap,HttpServletRequest req) {
		if(option.equals("del")) {
			//모든 데이터지우기 집어 넣기 
			ibsUserDAO.layoutDeleteAll(String.valueOf(commandMap.get("wl_category")));
		}
		String reg_ip = req.getHeader("X-FORWARDED-FOR");
		if(reg_ip==null) reg_ip=req.getRemoteAddr();
		commandMap.put("reg_ip", reg_ip);
		ibsUserDAO.layoutInsert(commandMap);
		return String.valueOf(commandMap.get("wl_category"));
	}
	@RequestMapping("/user/channelTask")
	public void channelWeb(HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		Map<String,Object> channelTasks=ibsUserDAO.getWebLiveSchedule();
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(channelTasks));
	}
	@RequestMapping("/user/liveView/{idx}")
	public void liveView(@PathVariable String idx,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException, ParseException {
		Map<String,Object> liveView=ibsUserDAO.getLiveView(idx,mediaIp);
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(liveView));
	}
	
}
