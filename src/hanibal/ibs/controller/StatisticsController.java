package hanibal.ibs.controller;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import hanibal.ibs.dao.IbsWebApiDAO;
import hanibal.ibs.dao.StatisticsDAO;
import hanibal.ibs.library.DataMap;
import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.webapi.AdvenceTree;

@SuppressWarnings("unchecked")
@Controller
public class StatisticsController {
	Logger log = Logger.getLogger(this.getClass());
	ObjectMapper mapper = new ObjectMapper();
	StatisticsDAO statisticsDAO;
	IbsWebApiDAO webApiDao;
	String repositoryPath;
	String sednIp;
	String mediaIp;
	String tomcatPort;
	String dbProperties;
	
	public void setLog(Logger log) {
		this.log = log;
	}
	public void setWebApiDao(IbsWebApiDAO webApiDao) {
		this.webApiDao = webApiDao;
	}	
	public void setStatisticsDAO(StatisticsDAO statisticsDAO) {
		this.statisticsDAO = statisticsDAO;
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
	public void setTomcatPort(String tomcatPort) {
		this.tomcatPort = tomcatPort;
	}
	public String getDbProperties() {
		return dbProperties;
	}
	public void setDbProperties(String dbProperties) {
		this.dbProperties = dbProperties;
	}
	
	// 메인 VOD 조회
	@RequestMapping(value="/api/vod/insertHistory", method=RequestMethod.POST)
	public ModelAndView insertVODHistory(HttpServletRequest request, HttpServletResponse res,
			HttpSession session) {
		Map<String, Object> dataMap = DataMap.getDataMap(request);
		System.out.println("dataMap= "+dataMap);

		JSONObject jsonObject = new JSONObject();
		String reg_id="";
		if ( session.getAttribute("member_email") != null ){
			reg_id= (String)session.getAttribute("member_email");
		}
		System.out.println("reg_id= "+ reg_id);
		dataMap.put("reg_id", reg_id);

		statisticsDAO.insertVODHistory(dataMap);
		jsonObject.put("result", true);
		
		ModelAndView mv = new ModelAndView("jsonView");
		mv.addObject("response", jsonObject);
		return mv;
	}
	
	//추가 MGS
	@RequestMapping("/sedn/statistics/{section}")
	public String statisticsMenu(@PathVariable String section, HttpServletRequest request, Model model) {
		Map<String, Object> dataMap = DataMap.getDataMap(request);
		
		String returnPage="";
		if(section.equals("vod")) returnPage="/statisticsView/VOD_statistics.statis";
		if(section.equals("vodDetail")) {
			String idx = dataMap.get("idx").toString();
			HashMap<String,Object> map= statisticsDAO.statisticsVODDetail(idx);
			map.put("main_thumbnail", "/REPOSITORY/THUMBNAIL"+ HanibalWebDev.getDataPath(map.get("main_thumbnail").toString())+ map.get("main_thumbnail"));
			map.put("vod_path", "http://"+mediaIp+"/"+"vod".toUpperCase()+HanibalWebDev.getDataPath(map.get("vod_path").toString())+ map.get("vod_path")+"/index.m3u8");		
			
			model.addAttribute("map", map);
			returnPage="/statisticsView/VOD_statisticsDetail.statis";
		}
		if(section.equals("live")) returnPage="/statisticsView/LIVE_statistics.statis";
		if(section.equals("user")) returnPage="/statisticsView/USER_statistics.statis";
		if(section.equals("vis")) returnPage="/statisticsView/vis_statistics.statis";
		
		model.addAttribute("sednIp", sednIp);
		model.addAttribute("tomcatPort", tomcatPort);
		
		return returnPage;
	}
	
	// VOD 통계
//	@RequestMapping("/statistics/vod/VODListData/{categoryIdx}")
//	public void getVODListData(@RequestParam(required=false) Map<String, Object> paramMap,  @PathVariable String categoryIdx,HttpServletResponse res) throws IOException, JSONException {
//		JSONObject jsonObject = new JSONObject();
//		JSONObject jsonContents = new JSONObject();
//		
//		System.out.println("paramMap="+paramMap);
//		int page= 1;
//		int perPage= 10;
//		if(paramMap.get("page")!=null) {
//			page= Integer.parseInt(paramMap.get("page").toString());
//		}
//		if(paramMap.get("perPage")!=null) {
//			perPage= Integer.parseInt(paramMap.get("perPage").toString());
//		}
//		int pageStart= (page - 1) * perPage;
//		int pageEnd= perPage;
//		
//		List<HashMap<String,Object>> statisticsVODList=statisticsDAO.statisticsVODList("", categoryIdx, pageStart, pageEnd);
//		int totalCount= statisticsDAO.totalCountRecords("", categoryIdx);
//		System.out.println("totalCount="+totalCount);
//		
//		res.setContentType("application/json; charset=UTF-8");
//		jsonContents.put("contents", statisticsVODList);
//		
//		jsonObject.put("result", true);
//		jsonObject.put("totalCount", totalCount);
//		jsonObject.put("data", jsonContents);
//		
//		res.getWriter().print(mapper.writeValueAsString(jsonObject));
//	}
	
	@RequestMapping(value="/statistics/vod/VODListData", method=RequestMethod.POST)
	public ModelAndView getVODListDataPOST(HttpServletRequest request, HttpServletResponse res) throws IOException, JSONException {
		Map<String, Object> dataMap = DataMap.getDataMap(request);		
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonContents = new JSONObject();
		JSONObject jsonPagination = new JSONObject();
		
		ModelAndView mv = new ModelAndView("jsonView");
		
//		String childIdx = String.valueOf(dataMap.get("childIdx"));
		String childIdx = "237";
		System.out.println("dataMap= "+dataMap);
		int page= 1;
		int perPage= 10;
		if(dataMap.get("page")!=null) {
			page= Integer.parseInt(dataMap.get("page").toString());
		}
		if(dataMap.get("perPage")!=null) {
			perPage= Integer.parseInt(dataMap.get("perPage").toString());
		}
		int pageStart= (page - 1) * perPage;
		int pageEnd= perPage;
		
		List<HashMap<String,Object>> statisticsVODList=statisticsDAO.statisticsVODList("", childIdx, pageStart, pageEnd);
		int totalCount= statisticsDAO.totalCountRecords("", childIdx);
		System.out.println("totalCount="+totalCount);
		
		res.setContentType("application/json; charset=UTF-8");
		jsonPagination.put("page", page);
		jsonPagination.put("totalCount", totalCount);
		jsonContents.put("contents", statisticsVODList);
		jsonContents.put("pagination", jsonPagination);
		
		jsonObject.put("result", true);
		jsonObject.put("totalCount", totalCount);
		jsonObject.put("data", jsonContents);
		
		mv.addObject("response", jsonObject);
		mv.addObject("totalCount", totalCount);
		return mv;
	}
	
	@RequestMapping(value="/statistics/vod/getChartData")
	public ModelAndView getChartData(HttpServletRequest request, HttpServletResponse res) throws IOException, JSONException {
		Map<String, Object> dataMap = DataMap.getDataMap(request);		
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonContents = new JSONObject();
		JSONObject jsonPagination = new JSONObject();
		
		ModelAndView mv = new ModelAndView("jsonView");
		
		System.out.println("dataMap= "+dataMap);
		List<HashMap<String,Object>> statisticsVODHitList=statisticsDAO.getStatisticsVOD_date(dataMap);
		res.setContentType("application/json; charset=UTF-8");
		jsonPagination.put("totalCount", statisticsVODHitList.size());
		jsonContents.put("contents", statisticsVODHitList);
		
		jsonObject.put("result", true);
		jsonObject.put("data", jsonContents);
		
		mv.addObject("response", jsonObject);
		return mv;
	}
	
	
	@RequestMapping("/api/statisticsTree/{order}/{idx}")
	public String statisticsTree(@PathVariable String order,@PathVariable String idx,Model model,HttpServletRequest req) throws Exception {
		String selected_node_id =idx;
		
		String treeMenu="";
		List<AdvenceTree> lists=webApiDao.getAdvenceTree(order);
		if(order.equals("live")) {
			selected_node_id=lists.get(1).getId();
		}
		log.info("-------"+order+"--------->"+selected_node_id);
		lists.get(0).setParent("#");
		for(int i=0;i<lists.size();i++) {
			treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText();
			if(lists.get(i).getProperty().equals("1")) {
				treeMenu+=" ["+lists.get(i).getNum()+"]";
			}
			treeMenu+="\",";
			treeMenu+= "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\",\"property\":\""+lists.get(i).getProperty()+"\",";
			if(i==0) {
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/root.png\"";
			}else if(lists.get(i).getProperty().equals("0")) {
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/menu.png\"";
			}else{
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/list.png\"";
			}		
			treeMenu+= ",\"state\":{\"opened\":true";
			if(lists.get(i).getId().equals(selected_node_id)) {
					treeMenu+=",\"selected\":true";	
			}
			treeMenu+="}},";
		}
		model.addAttribute("treeMenu", treeMenu);
		model.addAttribute("sort", order);
		return "/ibsInclude/statisticsTree.inc";
	}


}


