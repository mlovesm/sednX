package hanibal.ibs.dao;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.cms.BoardDTO;
import hanibal.ibs.model.statis.VisitCountVO;
import hanibal.ibs.model.webapi.LayoutDTO;
public class IbsUserDAO {
	Logger log = Logger.getLogger(this.getClass());
	public void setSqlMapper(SqlMapClient sqlMapper) {
	}
	public void setSqlFactory(SqlSessionFactory sqlFactory) {
	}
	private static SqlSessionTemplate sqlTemplate;	
	public void setSqlTemplate(SqlSessionTemplate sqlTemplate) {
		this.sqlTemplate = sqlTemplate;
	}
	SqlMapClientTemplate sqlMapTemplate;
	public void setSqlMapTemplate(SqlMapClientTemplate sqlMapTemplate) {
		this.sqlMapTemplate = sqlMapTemplate;
	}
	

	public int getBoardTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		if(searchWord== null||searchWord.length()==0) searchWord="";
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getBoardTotalRecordCount",map);
		return totalCount;
		
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
	public List<LayoutDTO> getLayoutList(int idx) {
		List<LayoutDTO> lists=sqlTemplate.selectList("getLayoutList",idx);
		return lists;
	}
	public List<BoardDTO> layoutList(String searchWord, String wl_categorys, String wl_attribute, String wl_sort, int start,int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(wl_categorys.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(wl_categorys);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		map.put("wl_attribute", wl_attribute);
		map.put("wl_sort",wl_sort);
		List<BoardDTO> lists=sqlTemplate.selectList("userLayoutList", map);
		return lists;
	}
	public void layoutDeleteAll(String categoryIdx) {
		int category=Integer.parseInt(categoryIdx);
		sqlTemplate.delete("layoutDeleteAll",category);
		
	}
	public void layoutInsert(Map<String, Object> commandMap) {
		log.info("=================="+String.valueOf(commandMap.get("reg_ip")));
		sqlTemplate.insert("layoutInsert",commandMap);
		
	}

	public Map<String,Object> getWebLiveSchedule() {
		List<HashMap<String, String>> lists=sqlTemplate.selectList("getWebSchedule");
		Map<String,Object> data= new HashMap<String,Object>();
		ArrayList<HashMap<String,Object>> newLists=new ArrayList<HashMap<String,Object>>();
		String[] category_idxs=new String[lists.size()];
		for(int i=0;i<lists.size();i++) {
			category_idxs[i]=String.valueOf(lists.get(i).get("id"));
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("name", lists.get(i).get("name"));
			map.put("group","인터넷 방송");
			String idx=String.valueOf(lists.get(i).get("id"));
			List<HashMap<String,String>> tasks=sqlTemplate.selectList("getWebScheduleList",idx); 
			map.put("tasks",tasks);
			newLists.add(map);
		}
		if(category_idxs.length>0) {
			Map<String,Object> queryMap= new HashMap<String,Object>();
			queryMap.put("categoryIdxs", category_idxs);
			List<HashMap<String, String>> taskList=sqlTemplate.selectList("getTaskList",queryMap);
			for(int i=0;i<taskList.size();i++) {
				if(String.valueOf(taskList.get(i).get("color")).equals("true")) {
					taskList.get(i).put("color","#50d371");
				}else {
					taskList.get(i).put("color","#fcd720");
				}
				if(String.valueOf(taskList.get(i).get("tag")).equals("true")) {
					taskList.get(i).put("tag","강제방송");
				}else {
					taskList.get(i).put("tag","일반방송");
				}
				if(String.valueOf(taskList.get(i).get("tagcolor")).equals("true")) {
					taskList.get(i).put("tagcolor","#50d371");
				}else {
					taskList.get(i).put("tagcolor","#d200a5");
				}
			}
			data.put("detail",taskList);
		}
		data.put("tasks",newLists);
		return data;
	}
	public Map<String, Object> getLiveView(String idx, String mediaIp) throws ParseException {
		Map<String,Object> data= new HashMap<String,Object>();
		int schedule=Integer.parseInt(idx);
		List<HashMap<String, String>> live=sqlTemplate.selectList("getLiveView",schedule);
		for(int i=0;i<live.size();i++) {
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date today=new Date();
			Date endDate=format.parse(String.valueOf(live.get(i).get("end")));
			Date startDate=format.parse(String.valueOf(live.get(i).get("start")));
			if(today.compareTo(endDate)<0&&today.compareTo(startDate)>0) {
				live.get(i).put("time",live.get(i).get("time")+" [방송중]");
				live.get(i).put("now","true");
			}else if(today.compareTo(startDate)<0) {
				live.get(i).put("time",live.get(i).get("time")+" [방송예정]");
			}else if(today.compareTo(endDate)>0) {
				live.get(i).put("time",live.get(i).get("time")+" [방송종료]");
			}
			live.get(i).put("img","/REPOSITORY/SCHIMG/"+live.get(i).get("img"));
			if(String.valueOf(live.get(i).get("source_type")).equals("VOD")) {
				Map<String,Object> vodListQuery= new HashMap<String,Object>();
				vodListQuery.put("idx",live.get(i).get("idx"));
				vodListQuery.put("mediaIp",mediaIp);
				List<String> vodUrl=sqlTemplate.selectList("scheduleVodList",vodListQuery);
				String vodStringUrl="";
				for(int k=0;k<vodUrl.size();k++) {
					if(k==vodUrl.size()-1) {
						vodStringUrl+="http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(vodUrl.get(k))+vodUrl.get(k)+"/index.m3u8";
					}else {
						vodStringUrl+="http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(vodUrl.get(k))+vodUrl.get(k)+"/index.m3u8"+",";
					}
					
				}
				live.get(i).put("vod_stream_url",vodStringUrl);
			}
		}
		data.put("live",live);
		return data;
	}
	
	//추가 방문자 로그 by MGS
	public void insertVisitor(VisitCountVO countVO) {		
		sqlTemplate.insert("tb_visitor_insert", countVO);	
	}	

	
}
