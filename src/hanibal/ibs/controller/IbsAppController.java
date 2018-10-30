package hanibal.ibs.controller;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import hanibal.ibs.dao.IbsAppDAO;
import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.app.FavoriteListDTO;
import hanibal.ibs.model.app.VodListAppDTO;

@Controller
public class IbsAppController {
	Logger log = Logger.getLogger(this.getClass());
	ObjectMapper mapper = new ObjectMapper();
	IbsAppDAO ibsAppDAO;
	String sednIp;
	String mediaIp;
	String repositoryPath;
	
	public void setSednIp(String sednIp) {
		this.sednIp = sednIp;
	}

	public void setMediaIp(String mediaIp) {
		this.mediaIp = mediaIp;
	}

	public Logger getLog() {
		return log;
	}

	public void setLog(Logger log) {
		this.log = log;
	}

	public IbsAppDAO getIbsAppDAO() {
		return ibsAppDAO;
	}

	public void setIbsAppDAO(IbsAppDAO ibsAppDAO) {
		this.ibsAppDAO = ibsAppDAO;
	}
	
	public void setRepositoryPath(String repositoryPath) {
		this.repositoryPath = repositoryPath;
	}

	Map<String,Object> mainData =new HashMap<String,Object>();
	Map<String,Object> subData =new HashMap<String,Object>();
	@RequestMapping("/api/app/login")
	public void appLogin(@RequestParam(required=false) Map<String, Object> commandMap,
			HttpServletRequest req, HttpServletResponse res,HttpSession session) throws Throwable {
		String result="";
		subData.clear();
		mainData.clear();
		try {
			result=ibsAppDAO.checkLogin(commandMap);
			if(result.equals("missId")) {
				mainData.put("code","400");
				mainData.put("type","1");
				mainData.put("msg", "입력하신 아이디가 존재하지 않습니다.");
				mainData.put("ret",subData);
			}
			else if(result.equals("missPass")) {
				mainData.put("code","400");
				mainData.put("type","1");
				mainData.put("msg", "비밀번호가 일치하지 않습니다.");
				mainData.put("ret",subData);
			}
			else {
				mainData.put("code","200");
				mainData.put("type","0");
				mainData.put("msg", "");
				String token=ibsAppDAO.getToken(commandMap);
				subData.put("auth_token",token);
				mainData.put("ret",subData);
				
				//추가 App 로그인 Log by MGS
				String reg_id=String.valueOf(commandMap.get("auth_id"));
				String reg_ip = req.getHeader("X-FORWARDED-FOR");
				if(reg_ip==null) reg_ip=req.getRemoteAddr();
				// (device, reg_dt, reg_id, reg_ip) 
				HashMap<String, Object> paramMap = new HashMap<>();
				paramMap.put("device", "APP");
				paramMap.put("reg_id", reg_id);
				paramMap.put("reg_ip", reg_ip);
				ibsAppDAO.tb_sedn_logInsert(paramMap);
			}
		} 
		catch (Exception e) {
			mainData.put("code","400");
			mainData.put("type","1");
			mainData.put("msg", "앱을 로딩하는데 오류가 있습니다.");
			mainData.put("ret", subData);
		}
		
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	
	//Vod API
	@RequestMapping("/api/app/vod/{order}")
	public void vodApi(@PathVariable String order, @RequestParam(required=false) Map<String, Object> commandMap, ModelMap mav, HttpServletResponse res, HttpServletRequest req) throws Exception {
		subData.clear();
		mainData.clear();
		int tokenCount=ibsAppDAO.checkToken((String)commandMap.get("token"));
		if(tokenCount==0) {
			mainData.put("code","000");
			mainData.put("type","1");
			mainData.put("msg", "로그인을 해주세요.");
			mainData.put("ret", subData);
		}
		else {
			// 메인 배너형 리스트 
			if(order.equals("bannerlist")) {
				try {
					List<VodListAppDTO> lists=ibsAppDAO.getBannerList("1",mediaIp);
					subData.put("vodList",lists);
					mainData.put("code","200");
					mainData.put("type","0");
					mainData.put("msg","");
					mainData.put("ret", subData);
				} 
				catch (Exception e) {
					mainData.put("code","400");
					mainData.put("type","1");
					mainData.put("msg", "앱을 로딩하는데 오류가 있습니다.");
					mainData.put("ret", subData);
				}
			}
			else if(order.equals("mainlist")) {
				try {
					List<VodListAppDTO> lists=ibsAppDAO.getMainList(mediaIp);
					subData.put("vodList",lists);
					mainData.put("code","200");
					mainData.put("type","0");
					mainData.put("msg","");
					mainData.put("ret", subData);
				} 
				catch (Exception e) {
					mainData.put("code","400");
					mainData.put("type","1");
					mainData.put("msg", "앱을 로딩하는데 오류가 있습니다.");
					mainData.put("ret", subData);
					System.out.println(e.getMessage());
				}
			}
			else if(order.equals("sublist")) {
				try {
					List<VodListAppDTO> lists=ibsAppDAO.getSubist(commandMap,mediaIp);
					List<HashMap<String,Object>> vodCategory=ibsAppDAO.getSibling(Integer.parseInt((String) commandMap.get("board_cate_idx")));			
					subData.put("vodSubList",lists);
					subData.put("vodCategory",vodCategory);
					mainData.put("code","200");
					mainData.put("type","0");
					mainData.put("msg","");
					mainData.put("ret", subData);
				} 
				catch (Exception e) {
					mainData.put("code","400");
					mainData.put("type","1");
					mainData.put("msg", "앱을 로딩하는데 오류가 있습니다.");
					mainData.put("ret", subData);
				}
			}
			else if(order.equals("detailView")){
				try {
					commandMap.put("mediaIp",mediaIp);
					Map<String,Object> detailMap=ibsAppDAO.getDetailView(commandMap);
					subData.put("vodInfo",detailMap);
					mainData.put("code","200");
					mainData.put("type","0");
					mainData.put("msg","");
					mainData.put("ret", subData);
				} 
				catch (Exception e) {
					mainData.put("code","400");
					mainData.put("type","1");
					mainData.put("msg", "상세 페이지에 오류가 있습니다.");
					mainData.put("ret", subData);
				}
			}
			else if(order.equals("favoriteAdd")) {
				try {
					int affectCount=ibsAppDAO.insertFavorite(commandMap);
					if(affectCount>0) {
						subData.put("favorite_yn","Y");
						mainData.put("code","200");
						mainData.put("type","0");
						mainData.put("msg","");
					}
					else {
						mainData.put("code","400");
						mainData.put("type","1");
						mainData.put("msg","이미 등록한 컨텐츠 입니다.");
					}
					mainData.put("ret", subData);
				} 
				catch (Exception e) {
					mainData.put("code","400");
					mainData.put("type","1");
					mainData.put("msg", "즐겨찾기 추가에 오류가 있습니다.");
					mainData.put("ret", subData);
				}
			}
			else if(order.equals("favoriteDel")) {
				try {
					ibsAppDAO.deleteFavorite(commandMap);
					subData.put("favorite_yn","N");
					mainData.put("code","200");
					mainData.put("type","0");
					mainData.put("msg","");
					mainData.put("ret", subData);
				} 
				catch (Exception e) {
					mainData.put("code","400");
					mainData.put("type","1");
					mainData.put("msg", "즐겨찾기 삭제에 오류가 있습니다.");
					mainData.put("ret", subData);
				}
			}
			else if(order.equals("filesinfo")) {
				try {
					List<HashMap<String, Object>> filesInfoMap = ibsAppDAO.getFileInfo(commandMap);
					subData.put("fileList", filesInfoMap);
					mainData.put("code", "200");
					mainData.put("type", "0");
					mainData.put("msg", "");
					mainData.put("ret", subData);
				}
				catch (Exception e) {
					mainData.put("code", "400");
					mainData.put("type", "0");
					mainData.put("msg", "파일 정보를 불러올 수 없습니다.");
					mainData.put("ret", subData);
				}
			}
		}
		
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	
	@SuppressWarnings("resource")
	@RequestMapping("/api/app/download/{type}/{ext}/{fileName}")
	public void downLoad(@PathVariable String type,@PathVariable String ext,@PathVariable String fileName, HttpServletResponse res, HttpServletRequest req) throws Exception{
		fileName=fileName+"."+ext;
		String path=repositoryPath+"/"+type.toUpperCase()+HanibalWebDev.getDataPath(fileName)+fileName;
		String range = req.getHeader("Range");
		log.info("range : "+range);
		int i = range.indexOf("=");
		int j = range.indexOf("-");
		File file = new File(path);
		long start = Long.parseLong(range.substring(i + 1, j));
		long end = 0;
		if (end == 0) {
		  end = file.length()-1;
		}
		res.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT); 
		//res.setContentType("video/mp4");
		if (file.length() <= Integer.MAX_VALUE) {
		  res.setContentLength((int)file.length());
		}
		else {
		  res.addHeader("Content-Length", Long.toString(file.length()));
		}
		res.setHeader("Accept-Ranges", "bytes");
		res.setHeader("Content-Range", "bytes " + start + "-" + end + "/" + file.length());
		RandomAccessFile rf = new RandomAccessFile(file, "r");
		rf.seek(start);
		byte[] buffer = new byte[1024];
		int num = 0;
		ServletOutputStream out = res.getOutputStream();
		while (start < end && (num = rf.read(buffer)) != -1) {
		  out.write(buffer, 0, num);
		  out.flush();
		  start += 1024;
		}
	}
	@RequestMapping("/api/app/filedown/{type}/{ext}/{fileName}")
	public void fileDownLoad(@PathVariable String type,@PathVariable String ext,@PathVariable String fileName, HttpServletResponse res, HttpServletRequest req) throws Exception {
		fileName=fileName+"."+ext;
		String path=repositoryPath+"/"+type.toUpperCase()+HanibalWebDev.getDataPath(fileName)+fileName;
		ibsAppDAO.fileDownLoad(path,res,req);
	}
	//LIVE API
	@RequestMapping("/api/app/live/{order}")
	public void liveApi(@PathVariable String order, @RequestParam(required=false) Map<String, Object> commandMap, ModelMap mav, HttpServletResponse res, HttpServletRequest req) throws JsonGenerationException, JsonMappingException, IOException {
		subData.clear();
		mainData.clear();
		int tokenCount = ibsAppDAO.checkToken((String)commandMap.get("token"));
		if(tokenCount == 0) {
			mainData.put("code","000");
			mainData.put("type","1");
			mainData.put("msg", "로그인을 해주세요.");
			mainData.put("ret", subData);
		}
		else {
			if(order.equals("pairing")) {
				try {
					commandMap.put("mediaIp", mediaIp);
					List<HashMap<String, Object>> getLivePairingList = ibsAppDAO.getLivePairing(commandMap);
					subData.put("chList", getLivePairingList);
					subData.put("currentTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(System.currentTimeMillis()));
					mainData.put("code", "200");
					mainData.put("type", "0");
					mainData.put("msg", "");
					mainData.put("ret", subData);
				}
				catch (Exception e) {
					mainData.put("code", "400");
					mainData.put("type", "0");
					mainData.put("msg", "라이브 편성표를 불러올 수 없습니다.");
					mainData.put("ret", subData);			
				}
			}
		}
		
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	
	//UCC API
	@RequestMapping("/api/app/ucc/{order}")
	public void uccApi(@PathVariable String order, @RequestParam(required=false) Map<String, Object> commandMap, ModelMap mav, HttpServletResponse res, HttpServletRequest req) {
		
	}
	
	//컨퍼런스 API
	@RequestMapping("/api/app/conf/{order}")
	public void confApi(@PathVariable String order, @RequestParam(required=false) Map<String, Object> commandMap, ModelMap mav, HttpServletResponse res, HttpServletRequest req) {		
	
	}
	
	//마이페이지 API
	@RequestMapping("/api/app/my/{order}")
	public void myApi(@PathVariable String order, @RequestParam(required=false) Map<String, Object> commandMap, ModelMap mav, HttpServletResponse res, HttpServletRequest req) throws Exception, JsonMappingException, IOException {
		subData.clear();
		mainData.clear();
		int tokenCount = ibsAppDAO.checkToken((String)commandMap.get("token"));
		if(tokenCount == 0) {
			mainData.put("code","000");
			mainData.put("type","1");
			mainData.put("msg", "로그인을 해주세요.");
			mainData.put("ret", subData);
		}
		else {
			if(order.equals("favoriteList")) {
				try {
					commandMap.put("mediaIp", mediaIp);
					List<FavoriteListDTO> getFavoriteListMap = ibsAppDAO.getFavoriteList(commandMap);
					subData.put("vodFavoriteList", getFavoriteListMap);
					mainData.put("code", "200");
					mainData.put("type", "0");
					mainData.put("msg", "");
					mainData.put("ret", subData);
				}
				catch (Exception e) {
					mainData.put("code", "400");
					mainData.put("type", "0");
					mainData.put("msg", "즐겨찾기 추가에 오류가 발생했습니다.");
					mainData.put("ret", subData);					
				}
			}
		}
		
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	
	//공통 API
	@RequestMapping("/api/app/common/{order}")
	public void commonApi(@PathVariable String order, @RequestParam(required=false) Map<String, Object> commandMap, ModelMap mav, HttpServletResponse res, HttpServletRequest req) throws JsonGenerationException, JsonMappingException, IOException {
		subData.clear();
		mainData.clear();
		int tokenCount = ibsAppDAO.checkToken((String)commandMap.get("token"));
		if(tokenCount == 0) {
			mainData.put("code","000");
			mainData.put("type","1");
			mainData.put("msg", "로그인을 해주세요.");
			mainData.put("ret", subData);
		}
		else {
			if(order.equals("userinfo")) {
				try {
					HashMap<String, Object> map = ibsAppDAO.getUserinfo(commandMap);
					subData.put("user_info", map);
					mainData.put("code", "200");
					mainData.put("type", "0");
					mainData.put("msg", "");
					mainData.put("ret", subData);
				}
				catch (Exception e) {
					mainData.put("code", "400");
					mainData.put("type", "0");
					mainData.put("msg", "유저이름 조회에 오류가 발생했습니다.");
					mainData.put("ret", subData);					
				}
			}
			else if(order.equals("settings")) {
				try {
					HashMap<String, Object> map = ibsAppDAO.getSettingInfo();
					mainData.put("code", "200");
					mainData.put("type", "0");
					mainData.put("msg", "");
					mainData.put("ret", map);
				}
				catch (Exception e) {
					mainData.put("code", "400");
					mainData.put("type", "0");
					mainData.put("msg", "설정파일 조회에 실패했습니다.");
					mainData.put("ret", subData);					
				}
			}			
		}
		
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}
	
	// 기본 API
	@RequestMapping("/api/app/{order}")
	public void defaultAPI(@PathVariable String order, @RequestParam(required=false) Map<String, Object> commandMap, ModelMap mav, HttpServletResponse res, HttpServletRequest req) throws JsonGenerationException, JsonMappingException, IOException {
		subData.clear();
		mainData.clear();
		if(order.equals("forceUpdate")) {
			try {
				HashMap<String, Object> map = ibsAppDAO.getUpdateVer();
				mainData.put("code", "200");
				mainData.put("type", "0");
				mainData.put("msg", "");
				mainData.put("ret", map);
			}
			catch (Exception e) {
				mainData.put("code", "400");
				mainData.put("type", "0");
				mainData.put("msg", "업데이트 버전 확인에 실패했습니다.");
				mainData.put("ret", subData);						
			}
		}
		
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
	}	
}
