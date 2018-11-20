package hanibal.ibs.dao;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

import hanibal.ibs.library.HanibalWebDev;
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



public class IbsCmsDAO {
	Logger log = Logger.getLogger(this.getClass());
	public void setSqlMapper(SqlMapClient sqlMapper) {
	}
	public void setSqlFactory(SqlSessionFactory sqlFactory) {
	}
	
	private SqlSessionTemplate sqlTemplate;	
	public void setSqlTemplate(SqlSessionTemplate sqlTemplate) {
		this.sqlTemplate = sqlTemplate;
	}
	SqlMapClientTemplate sqlMapTemplate;
	public void setSqlMapTemplate(SqlMapClientTemplate sqlMapTemplate) {
		this.sqlMapTemplate = sqlMapTemplate;
	}
	public JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
		InputStream is = new URL(url).openStream();
	    try {
	      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
	      String jsonText = readAll(rd);
	      JSONObject json = new JSONObject(jsonText);
	      return json;
	    } finally {
	      is.close();
	    }
	}
	private String readAll(BufferedReader rd) throws IOException {
		StringBuilder sb = new StringBuilder();
	    int cp;
	    while ((cp = rd.read()) != -1) {
	      sb.append((char) cp);
	    }
	    return sb.toString();
	}
	public MemberAccountDTO memberInfo(String member_email, String member_pass) {
		Map<String,String> map= new HashMap<String,String>();	
		map.put("member_email",member_email);
		map.put("member_pass", member_pass);
		MemberAccountDTO dto=sqlTemplate.selectOne("memberInfo",map);
		return dto;
	}
	public int memberJoin(MemberAccountDTO dto) {
		int affectcount=sqlTemplate.insert("memberJoin",dto);
		return affectcount;
	}
	public int updateTempPass(String member_email, String key) {
		Map<String,String> map= new HashMap<String,String>();	
		map.put("member_email",member_email);
		map.put("key", key);
		int affectcount=sqlTemplate.update("updateTampPass",map);
		return affectcount;
	}
	public int editMember(MemberAccountDTO dto) {
		int affectcount=sqlTemplate.update("editMember",dto);
		return affectcount;
	}
	public void updateLastLogin(int idx) {
		sqlTemplate.update("updateLastLogin", idx);
	}
	public int getMemberTotalRecordCount(String authority, String searchWord) {
		Map<String,String> map= new HashMap<String,String>();	
		map.put("authority",authority);
		map.put("searchWord",searchWord);
		int totalCount=sqlTemplate.selectOne("getMemberTotalRecordCount",map);
		return totalCount;
	}
	public List<MemberAccountDTO> memberList(String authority,String searchWord,int start,int end) {
		Map<String,Object> map= new HashMap<String,Object>();	
		map.put("authority",authority);
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		List<MemberAccountDTO> list=sqlTemplate.selectList("memberList",map);
		return list;
	}
	public int updateMemberAuthority(String changeVal, int[] checkValArr) {
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("changeVal", changeVal);
		map.put("checkValArr",checkValArr);
		int affectcount=sqlTemplate.update("updateMemberAuthority",map);
		return affectcount;
	}
	public int deleteMemberAuthority(int[] checkValArr) {
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("checkValArr",checkValArr);
		int affectcount=sqlTemplate.update("deleteMemberAuthority",map);
		return affectcount;
	}
	public int getVodTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getVodTotalRecordCount",map);
		return totalCount;
	}
	
	public int getLiveTotalRecordCount(String searchWord,String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getLiveTotalRecordCount",map);
		return totalCount;
	}
	public int getFileTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getFileTotalRecordCount",map);
		return totalCount;
	}
	public int getPhotoTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getPhotoTotalRecordCount",map);
		return totalCount;
	}
	public int getBoardTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getBoardTotalRecordCount",map);
		return totalCount;
	}
	
	public int getStbTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getStbTotalRecordCount",map);
		return totalCount;
	}
	public int getScheduleTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getScheduleTotalRecordCount",map);
		return totalCount;
	}
	public List<VodDTO> vodList(String searchWord, String childIdx, int start, int end, String innerData) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		if(innerData != null) {
			map.put("innerData",innerData);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<VodDTO> lists=sqlTemplate.selectList("vodList", map);
		return lists;
	}
	
	public List<LiveDTO> liveList(String searchWord,String childIdx, int start, int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<LiveDTO> lists=sqlTemplate.selectList("liveList", map);
		return lists;
	}
	public List<FileDTO> fileList(String searchWord, String childIdx, int start, int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<FileDTO> lists=sqlTemplate.selectList("fileList", map);
		return lists;
	}
	public List<PhotoDTO> photoList(String searchWord, String childIdx, int start, int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<PhotoDTO> lists=sqlTemplate.selectList("photoList", map);
		return lists;
	}
	public List<BoardDTO> boardList(String searchWord, String childIdx, int start, int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<BoardDTO> lists=sqlTemplate.selectList("BoardList", map);
		return lists;
	}
	public List<StbDTO> stbList(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("eachFlag",eachFlag);
		List<StbDTO> lists=sqlTemplate.selectList("StbList", map);
		return lists;
	}
	public List<StbDTO> stbList(String searchWord, String childIdx, int start, int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<StbDTO> lists=sqlTemplate.selectList("StbList", map);
		return lists;
	}
	public List<ScheduleDTO> scheduleList(String searchWord, String childIdx, int start, int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<ScheduleDTO> lists=sqlTemplate.selectList("ScheduleList", map);
		return lists;
	}
	public List<ScheduleDTO> eventList(String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("eachFlag",eachFlag);
		List<ScheduleDTO> lists=sqlTemplate.selectList("EventList",map);
		return lists;
	}
	public List<HashMap<String, Object>> getTargetList(String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="N";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("eachFlag",eachFlag);
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getTagetList",map);
		return lists;
	}
	
	public int updateElemCategory(Map<String, Object> commandMap) {
		String repoTable=HanibalWebDev.targetRepoTable(String.valueOf(commandMap.get("sort")));
		int selectedIdx[]=HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("selectedIdx")));
		commandMap.put("repoTable", repoTable);
		commandMap.put("selectedIdx",selectedIdx);
		int affectcount=sqlTemplate.update("updateElemCategory",commandMap);
		return affectcount;
	}
	public HashMap<String, Object> getLiveContents(String idx) {
		HashMap<String, Object> map=sqlTemplate.selectOne("getLiveContents",idx);
		return map;
	}
	public HashMap<String, Object> getFileContents(String idx) {
		HashMap<String, Object> map=sqlTemplate.selectOne("getFileContents",idx);
		return map;
	}
	public HashMap<String, Object> getPhotoContents(String idx) {
		HashMap<String, Object> map=sqlTemplate.selectOne("getPhotoContents",idx);
		return map;
	}
	public HashMap<String, Object> getVodContents(String idx) {
		HashMap<String, Object> map=sqlTemplate.selectOne("getVodContents",idx);
		return map;
	}
	public HashMap<String, Object> getBoardContents(String idx) {
		HashMap<String, Object> map=sqlTemplate.selectOne("getBoardContents",idx);
		return map;
	}
	public HashMap<String, Object> getSettopBox(String idx) {
		HashMap<String, Object> map=sqlTemplate.selectOne("getSettopBox",idx);
		return map;
	}
	
	public int updateLiveContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updateLiveContent",commandMap);
		return affectcount;
	}
	public int updateFileContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updateFileContent",commandMap);
		return affectcount;
	}
	public int updatePhotoContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updatePhotoContent",commandMap);
		return affectcount;
	}
	public int updateVodContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updateVodContent",commandMap);
		String thumbArr[]=HanibalWebDev.StringToStringArray(String.valueOf(commandMap.get("thumnailList")));
		String delVod=String.valueOf(commandMap.get("vod_path"));
		sqlTemplate.delete("deleteThumb",delVod);
		for(int i=0;i<thumbArr.length;i++) {
			Map<String,Object> dataMap =new HashMap<String,Object>();
			dataMap.put("vod_file",commandMap.get("vod_path"));
			dataMap.put("vod_thumbnail",thumbArr[i]);
			sqlTemplate.insert("insertThumnail",dataMap);
		}
		return affectcount;
	}
	public int updateBoardContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updateBoardContent",commandMap);
		return affectcount;
	}
	public int updateSettopBox(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updateSettopBox",commandMap);
		return affectcount;
	}
	public int updateSchedule(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updateSchedule",commandMap);
		return affectcount;
	}
	
	
	public int insertLiveContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertLiveContent",commandMap);
		return affectcount;
	}
	public int insertFileContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertFileContent",commandMap);
		return affectcount;
	}
	public int insertVodContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertVodContent",commandMap);
		String thumbArr[]=HanibalWebDev.StringToStringArray(String.valueOf(commandMap.get("thumnailList")));
		for(int i=0;i<thumbArr.length;i++) {
			Map<String,Object> dataMap =new HashMap<String,Object>();
			dataMap.put("vod_file",commandMap.get("vod_path"));
			dataMap.put("vod_thumbnail",thumbArr[i]);
			sqlTemplate.insert("insertThumnail",dataMap);
		}
		return affectcount;
	}
	public int insertPhotoContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertPhotoContent",commandMap);
		return affectcount;
	}
	public int insertBoardContent(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertBoardContent",commandMap);
		return affectcount;
	}
	public int insertSettopBox(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertSettopBox",commandMap);
		return affectcount;
	}
	public int insertSchedule(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertSchedule",commandMap);
		return affectcount;
	}
	//board_repository 삭제 전용 by MGS
	public int deleteContents(int[] checkValArr) {
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("checkValArr",checkValArr);
		int affectcount=sqlTemplate.delete("boardDeleteContents",map);
		return affectcount;
	}	
	public int deleteContents(String order, int[] checkValArr) {
		Map<String,Object> map= new HashMap<String,Object>();
		String repoTable=HanibalWebDev.targetRepoTable(order);
		map.put("repoTable", repoTable);
		map.put("checkValArr",checkValArr);
		int affectcount=sqlTemplate.update("deleteContents",map);
		return affectcount;
	}
	public int getVodTopIdx(String file ) {
		int vodTopIdx=sqlTemplate.selectOne("getVodTopIdx",file);
		return vodTopIdx;
	}
	public int updateVodBox(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("updateVodBox",commandMap);
		return affectcount;
	}
	public int editUpdateVodBox(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.update("editUpdateVodBox",commandMap);
		return affectcount;
	}
	public int insertMainImage(Map<String, Object> commandMap) {
		int affectcount=sqlTemplate.insert("insertMainImage",commandMap);
		return affectcount;
	}
	public int deleteMainImage(String checkValArr) {
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("checkValArr",HanibalWebDev.StringToIntArray(checkValArr));
		int affectcount=sqlTemplate.update("deleteMainImage",map);
		return affectcount;
	}
	public int insertMainContents(String category_idx) {
		int affectcount=sqlTemplate.insert("insertMainContents",category_idx);
		return affectcount;
	}
	public int deleteMainContents(String idx) {
		int affectcount=sqlTemplate.delete("deleteMainContents",Integer.parseInt(idx));
		return affectcount;
	}
	public HashMap<String, Object> getStbConnection() {
		HashMap<String, Object> map=sqlTemplate.selectOne("getStbConnection");
		return map;
	}
	public List<TreeMenu> getMenuTree(String contents) {
		String table=HanibalWebDev.targetTable(contents);
		String repoTable=HanibalWebDev.targetRepoTable(contents);
		Map<String,Object> map= new HashMap<String,Object>();	
		map.put("table", table);
		map.put("repoTable", repoTable);
		List<TreeMenu> lists=sqlTemplate.selectList("getMenuTree",map);
		return lists;
	}
	public void insertScheduleGroup(int topIdx, int idx) {
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("scheduleId",topIdx);
		map.put("groupId",idx);
		sqlTemplate.insert("insertScheduleGroup",map);
	}
	public void insertScheduleVod(int topIdx, int idx, int i) {
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("scheduleId",topIdx);
		map.put("vodId",idx);
		map.put("playOrder",i);
		sqlTemplate.insert("insertScheduleVod",map);
	}
	public String updateScheduleDate(Map<String, Object> commandMap) {
		String msg="fail";
		int affectcount=sqlTemplate.update("updateScheduleDate", commandMap);
		if(affectcount>0) {
			msg="success";
		}
		return msg;
	}
	public int deleteSchedule(int[] checkValArr) {
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("checkValArr",checkValArr);
		int affectcount=sqlTemplate.update("deleteSchedule",map);
		return affectcount;
	}
	public void deleteScheduleGroup(int topIdx) {
		sqlTemplate.delete("deleteScheduleGroup",topIdx);
	}
	public void deleteScheduleVod(int topIdx) {
		sqlTemplate.delete("deleteScheduleVod",topIdx);
	}
	public List<LayoutDTO> getLayoutList(int idx) {
		List<LayoutDTO> lists=sqlTemplate.selectList("getLayoutList",idx);
		return lists;
	}
	public Map<String, Object> getLayoutDetail(String idx) {
		Map<String, Object> map=sqlTemplate.selectOne("getLayoutDetail",idx);
		return map;
	}
	public void deleteTarget(int channel) {
		sqlTemplate.delete("deleteTarget",channel);
	}
	public void insertTarget(Map<String, Object> commandMap) {
		sqlTemplate.insert("insertTarget", commandMap);
	}
	public int getTotalTargetCount() {
		int count=sqlTemplate.selectOne("targetCount");
		return count;
	}
	public void fileDownLoad(String path, HttpServletResponse res, HttpServletRequest req) throws Exception {
		File f= new File(path);
		res.setContentType("application/x-msdownload");
		res.setContentLength((int)f.length());
		boolean flag=req.getHeader("user-agent").toUpperCase().indexOf("MSIE")!=-1;
		if(flag) res.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(f.getName(),"utf-8"));
		else res.setHeader("Content-Disposition","attachment;filename="+new String(f.getName().getBytes("UTF-8"),"8859_1"));
		BufferedInputStream bis=new BufferedInputStream(new FileInputStream(f));
		BufferedOutputStream bos=new BufferedOutputStream(res.getOutputStream());
		int data=0;
		byte[] buffer=new byte[1024];
		while((data=bis.read(buffer,0,1024))!=-1) {
			bos.write(buffer,0,data);
			bos.flush();
		}
		bos.close();
		bis.close();
		
	}	
	
	public void tb_sedn_logInsert(Map<String, Object> commandMap) {
		sqlTemplate.insert("tb_sedn_logInsert",commandMap);	
	}
	
	
}
