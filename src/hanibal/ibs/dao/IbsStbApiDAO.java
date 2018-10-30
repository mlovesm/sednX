package hanibal.ibs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.stb.LiveScheduleDTO;
import hanibal.ibs.model.stb.STB_configDTO;
import hanibal.ibs.model.stb.TodayScheduleDTO;
import hanibal.ibs.model.stb.TotalScheduleDTO;
import hanibal.ibs.model.stb.VodListDTO;
import hanibal.ibs.model.stb.VodMenuDTO;
import hanibal.ibs.model.stb.VodSchduleDTO;

public class IbsStbApiDAO {
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
	
	public HashMap<String, Object> apkVersion(String repositoryPath) {
		HashMap<String, Object>  hashMap=sqlTemplate.selectOne("apiVersion",repositoryPath);
		return hashMap;
	}
	public HashMap<String, Object> getServerInfo() {
		HashMap<String, Object> serverIp=sqlTemplate.selectOne("serverInfo");
		return serverIp;
	}
	public HashMap<String, Object> logoInfo(String repositoryPath, int TMPGROUP) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("repositoryPath", repositoryPath);
		map.put("TMPGROUP", TMPGROUP);
		HashMap<String, Object>  hashMap=sqlTemplate.selectOne("logoInfo",map);
		return hashMap;
	}
	public HashMap<String, Object> bgInfo(String repositoryPath, int TMPGROUP) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("repositoryPath", repositoryPath);
		map.put("TMPGROUP", TMPGROUP);
		HashMap<String, Object>  hashMap=sqlTemplate.selectOne("bgInfo",map);
		return hashMap;
	}
	public int insertVodHistory(String vod_idx, String stb_idx, String play_time) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vod_idx", vod_idx);
		map.put("stb_idx", stb_idx);
		map.put("play_time",play_time);
		int affectCount=sqlTemplate.insert("insertVodHistory",map);
		return affectCount;
	}
	public HashMap<String, Object> stbInfo(String mac) {
		HashMap<String, Object> stbInfo=sqlTemplate.selectOne("stbInfo",mac);
		return stbInfo;
	}
	public void insertStbInfo(String name, String mac, String ip, int group, String status) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("name",name);
		map.put("mac",mac);
		map.put("ip",ip);
		map.put("group",group);
		map.put("status",status);
		sqlTemplate.insert("insertStbInfo",map);
	}
	public int updateStbStatus(String mac, String status, String timestamp) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mac",mac);
		map.put("status",status);
		map.put("timestamp",timestamp);
		int affectCount=sqlTemplate.update("updateStbStatus",map);
		return affectCount;
	}
	public int updateSendPing(String mac) {
		int affectCount=sqlTemplate.update("updateSendPing",mac);
		return affectCount;
	}
	public HashMap<String, Object> stbBannerInfo(int TMPGROUP, String repositoryPath) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("TMPGROUP",TMPGROUP);
		map.put("repositoryPath",repositoryPath);
		HashMap<String, Object> bannerInfo=sqlTemplate.selectOne("stbBannerInfo",map);
		return bannerInfo;
	}
	public List<VodMenuDTO> vodMenuInfo() {
		List<VodMenuDTO> dto=sqlTemplate.selectList("vodMenuInfo"); 
		return dto;
	}
	public List<VodListDTO> vodListInfo(String repositoryPath) {
		List<VodListDTO> dto=sqlTemplate.selectList("vodListInfo",repositoryPath);
		for(int i=0;i<dto.size();i++) {
			dto.get(i).setThumbnail_path(repositoryPath+"THUMBNAIL"+HanibalWebDev.getDataPath(dto.get(i).getVideo_path())+dto.get(i).getThumbnail_path());
			dto.get(i).setVideo_path(repositoryPath+"VOD"+HanibalWebDev.getDataPath(dto.get(i).getVideo_path())+dto.get(i).getVideo_path());
		}
		return dto;
	}
	public List<HashMap<String, Object>> stbChannelList(String groupId) {
		List<HashMap<String, Object>> list=sqlTemplate.selectList("stbChannelList",groupId);
		return list;
	}
	public List<TodayScheduleDTO> todayScheduleInfo(String groupId, String repositoryPath) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("groupId",Integer.parseInt(groupId));
		map.put("repositoryPath",repositoryPath);
		List<TodayScheduleDTO> dto=sqlTemplate.selectList("todayScheduleInfo",map);
		return dto;
	}
	public String groupSchArray(int id) {
		List<String> groupNameList=sqlTemplate.selectList("idByGroupName",id);
		String[] listArray=new String[groupNameList.size()];
		String returnString="";
		listArray=groupNameList.toArray(listArray);
		if(groupNameList.size()>1) {
			returnString=listArray[0]+" 외"+(groupNameList.size()-1)+"";
		}else if(groupNameList.size()==1){
			returnString=listArray[0];
		}
		for(int i=0;i<groupNameList.size();i++) {
			log.info(groupNameList.size()+"/"+i+"============"+groupNameList.get(i));
		}
		return returnString;
	}
	public List<LiveScheduleDTO> liveScheduleInfo(String chIdx) {
		List<LiveScheduleDTO> dto=sqlTemplate.selectList("liveScheduleInfo",Integer.parseInt(chIdx));
		return dto;
	}
	public List<TotalScheduleDTO> totalScheduleInfo(String groupId) {
		List<TotalScheduleDTO> lists=sqlTemplate.selectList("totalScheduleInfo",groupId);
		return lists;
	}
	public List<VodSchduleDTO> relativeVodList(String repositoryPath,int id) {
		List<VodSchduleDTO> lists=sqlTemplate.selectList("relativeVodList",id);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setFile_path(repositoryPath+"VOD"+HanibalWebDev.getDataPath(lists.get(i).getFile_path())+lists.get(i).getFile_path());
		}
		return lists;
	}
	public STB_configDTO configInfo(String repositoryPath, String groupId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("groupId",groupId);
		map.put("repositoryPath",repositoryPath);
		STB_configDTO dto=sqlTemplate.selectOne("configInfo",map);
		return dto;
	}
	public String getPlayTime(int vodId) {
		String play_time=sqlTemplate.selectOne("getPlayTime",vodId);
		return play_time;
	}
	public int getVodId(int vod_idx) {
		int vodId=sqlTemplate.selectOne("getVodId",vod_idx);
		return vodId;
	}
	
}
