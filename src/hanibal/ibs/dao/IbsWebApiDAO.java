package hanibal.ibs.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.cms.FileDTO;
import hanibal.ibs.model.cms.LiveDTO;
import hanibal.ibs.model.cms.PhotoDTO;
import hanibal.ibs.model.cms.ScheduleDTO;
import hanibal.ibs.model.cms.VodDTO;
import hanibal.ibs.model.webapi.AdvenceTree;
import hanibal.ibs.model.webapi.Carousel;
import hanibal.ibs.model.webapi.MainContents;
import hanibal.ibs.model.webapi.TreeMenu;
public class IbsWebApiDAO {
	Logger log = Logger.getLogger(this.getClass());
	String sednIp;
	String mediaIp;
	String table;
	String repoTable;
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
	public int checkEmail(String member_email) {
		int count=sqlTemplate.selectOne("checkEmail", member_email);
		return count;
	}
	public int checkPass(String member_email, String member_pass) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("member_email", member_email);
		map.put("member_pass", member_pass);
		int count=sqlTemplate.selectOne("checkPass",map);
		return count;
	}
	public int emailConfirm(String key) {
		int count=sqlTemplate.selectOne("confirmEmail",key);
		return count;
	}
	public HashMap<String, Object> getIdxByKey(String key) {
		HashMap<String, Object> hashmap=sqlTemplate.selectOne("getIdxByKey",key);
		return hashmap;
	}
	public void confirmUpdate(int idx, String confirmImage) {
		Map<String,Object> map= new HashMap<String,Object>();	
		map.put("idx",idx);
		map.put("confirmImage", confirmImage);
		sqlTemplate.update("confirmUpdate",map);
	}
	public List<HashMap<String,String>> deleteProfileList(String email) {
		List<HashMap<String,String>>  deleteProfileList=sqlTemplate.selectList("deleteProfileList",email);
		return deleteProfileList;
	}
	public void deleteProfile(String profile) {
		sqlTemplate.delete("deleteProfile",profile);
		
	}
	/**
	 * 
	 * relative TREE START....
	 * 
	 */
	public List<TreeMenu> getMenuTree(String order) {
		table=HanibalWebDev.targetTable(order);
		repoTable=HanibalWebDev.targetRepoTable(order);
		Map<String,Object> map= new HashMap<String,Object>();	
		map.put("table", table);
		map.put("repoTable", repoTable);
		List<TreeMenu> lists=sqlTemplate.selectList("getMenuTree",map);
		return lists;
	}
	public List<AdvenceTree> getAdvenceTree(String order) {
		table=HanibalWebDev.targetTable(order);
		repoTable=HanibalWebDev.targetRepoTable(order);
		Map<String,Object> map= new HashMap<String,Object>();	
		map.put("table", table);
		map.put("repoTable", repoTable);
		List<AdvenceTree> lists=sqlTemplate.selectList("getAdvenceTree",map);
		return lists;
	}
	public String createGroup(Map<String, Object> commandMap) {
		String newId="";
		table=HanibalWebDev.targetTable(String.valueOf(commandMap.get("sort")));
		commandMap.put("table",table);
		sqlTemplate.insert("insertMenuBoard",commandMap);
		newId=sqlTemplate.selectOne("topIdxVod",table);
		return newId;
	}
	public int renameGroup(Map<String, Object> commandMap) {
		int affectcount=0;
		table=HanibalWebDev.targetTable(String.valueOf(commandMap.get("sort")));
		commandMap.put("table", table);
		affectcount=sqlTemplate.update("updateGroup",commandMap);
		return affectcount;
	}
	public int deleteGroup(Map<String, Object> commandMap) {
		int affectcount=0;
		int[] groupIdArr=null;
		table=HanibalWebDev.targetTable(String.valueOf(commandMap.get("sort")));
		repoTable=HanibalWebDev.targetRepoTable(String.valueOf(commandMap.get("sort")));
		groupIdArr=HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("groupIdArr")));
		commandMap.put("table", table);
		commandMap.put("repoTable", repoTable);
		commandMap.put("groupIdArr",groupIdArr);
		//1.컨텐츠 소속 변경
		sqlTemplate.update("updateCategoryIdx",commandMap);
		//2.position update
		sqlTemplate.update("updatePosition",commandMap);
		//3.그룹삭제 
		affectcount=sqlTemplate.update("deleteGroup",commandMap);
		return affectcount;
	}
	public int moveCategory(Map<String, Object> commandMap) {
		int affectcount=0;
		Map<String,Object> sqlMap=new HashMap<String,Object>();
		String table=HanibalWebDev.targetTable(String.valueOf(commandMap.get("sort")));
		sqlMap.put("table", table);
		sqlMap.put("parent",commandMap.get("old_parent"));
		sqlMap.put("position",commandMap.get("old_position"));
		sqlTemplate.update("oldPositionUpdate",sqlMap);
		
		sqlMap.put("parent",commandMap.get("parent"));
		sqlMap.put("position",commandMap.get("position"));
		sqlTemplate.update("newPositionUpdate",sqlMap);
		
		sqlMap.put("idx",commandMap.get("idx"));
		affectcount=sqlTemplate.update("moveCategory",sqlMap);
		return affectcount;
	}
	/** 
	relative TREE END...
	 * 
	 */
	public int vodBoxExist(String file) {
		int count=sqlTemplate.selectOne("vodBoxExist",file);
		return count;
	}
	public void vodBoxInsert(String file) {
		sqlTemplate.insert("vodBoxInsertTemp",file);
	}
	public void updateRate(String file,String newFile, int rate) {
		Map<String,Object> map= new HashMap<String,Object>();	
		map.put("file", file);
		map.put("newFile", newFile);
		map.put("rate", rate);
		sqlTemplate.update("updateEncodingRate",map);
	}
	public int getEncodingRate(String file) {
		 File inFile = new File(file);
		 String rate="";
		 BufferedReader br = null;
	        try {
	            br = new BufferedReader(new FileReader(inFile));
	            String line;
	            while ((line = br.readLine()) != null) {
	            	log.info(line);
	                rate=line;
	                if(rate.length()==0||rate.isEmpty()) {
	                	rate="0.0";
	                	log.info("==========================");
	                }
	            }
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }finally {
	            if(br != null) try {br.close(); } catch (IOException e) {}
	        }
		return (int)Double.parseDouble(rate);
	}
	public List<LiveDTO> getLiveSmList(Map<String, Object> commandMap) {
		List<LiveDTO> lists=sqlTemplate.selectList("getLiveSm",commandMap);
		return lists;
	}
	public List<FileDTO> getFileSmList(Map<String, Object> commandMap) {
		List<FileDTO> lists=sqlTemplate.selectList("getFileSm",commandMap);
		return lists;
	}
	public List<PhotoDTO> getPhotoSmList(Map<String, Object> commandMap) {
		List<PhotoDTO> lists=sqlTemplate.selectList("getPhotoSm",commandMap);
		return lists;
	}
	public List<VodDTO> getVodSmList(Map<String, Object> commandMap) {
		String eachFlag="";
		if(commandMap.get("childIdx")!=null) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(commandMap.get("childIdx").toString());
			eachFlag="Y";
			commandMap.put("childIdxArr", childIdxArr);
		}
		commandMap.put("searchWord","");
		commandMap.put("eachFlag",eachFlag);
		List<VodDTO> lists=sqlTemplate.selectList("getVodSm",commandMap);
		return lists;
	}
	public List<VodDTO> getVodByIdxArrList(Map<String, Object> commandMap) {
		int vodIdxArr[]=HanibalWebDev.StringToIntArray(commandMap.get("idxArr").toString());
		commandMap.put("vodIdxArr", vodIdxArr);
		List<VodDTO> lists=sqlTemplate.selectList("getVodIdxList",commandMap);
		return lists;
	}
	public List<Carousel> getCatouselList() {
		List<Carousel> lists=sqlTemplate.selectList("getCatouselList");
		return lists;
	}
	public List<MainContents> getMainContents() {
		List<MainContents> lists=sqlTemplate.selectList("getMainContents");
		return lists;
	}
	public HashMap<String, Object> getScheduleBasic(String idx) {
		HashMap<String, Object> map=sqlTemplate.selectOne("ScheduleBasic",Integer.parseInt(idx));
		return map;
	}
	public List<Integer> getScheduleGroup(String idx) {
		List<Integer> lists=sqlTemplate.selectList("getScheduleGroup",idx);
		return lists;
	}
	public List<Integer> getScheduleVod(String idx) {
		List<Integer> lists=sqlTemplate.selectList("getScheduleVod",idx);
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
	public List<HashMap<String, Object>> getCategoryNames(Map<String, Object> commandMap) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getCategoryNames",commandMap);
		Map<String,Object> addData =new HashMap<String,Object>();
		boolean flag=false;
		int [] idxlist=(int[]) commandMap.get("idxArr");
		for(int i=0;i<idxlist.length;i++) {
			if(idxlist[i]==0) {
				flag=true;
			}
		}
		if(flag) {
			addData.put("category_name","인터넷 방송");
			addData.put("idx","0");
			lists.add((HashMap<String, Object>) addData);
		}
		return lists;
	}
	public List<HashMap<String, Object>> getImgNames(Map<String, Object> commandMap) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getImgNames",commandMap);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).put("img_url","/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(String.valueOf(lists.get(i).get("img_url")))+String.valueOf(lists.get(i).get("img_url")));
		}
		return lists;
	}
	public List<HashMap<String, Object>> getPhotoList(Map<String, Object> commandMap) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getPhotoList",commandMap);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).put("img_url","/REPOSITORY/PHOTO"+HanibalWebDev.getDataPath(String.valueOf(lists.get(i).get("img_url")))+String.valueOf(lists.get(i).get("img_url")));
		}
		return lists;
	}
	
	public List<HashMap<String, Object>> getFileList(Map<String, Object> commandMap) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getFileList",commandMap);
		return lists;
	}
	
	
	public List<HashMap<String, Object>> getTargetView(String childIdx) {
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
	public int getTotalTargetCount() {
		int count=sqlTemplate.selectOne("targetCount");
		return count;
	}
	public List<String> getVodOldList() {
		List<String> lists=sqlTemplate.selectList("vodOldList");
		
		return lists;
	}
	public void insertThumbnail(String vodFile, String thumbnail) {
		Map<String,Object> dataMap =new HashMap<String,Object>();
		dataMap.put("vod_file",vodFile);
		dataMap.put("vod_thumbnail",thumbnail);
		sqlTemplate.insert("insertThumnail",dataMap);
	}
	public Map<String, Object> mediaInfo(String idx) {
		Map<String, Object> info=sqlTemplate.selectOne("vodMediaInfo",idx);
		return info;
	}
	public List<String> thumbList(String vodFile) {
		List<String> thumbList=sqlTemplate.selectList("thumbnailList",vodFile);
		return thumbList;
	}
	public Map<String, Object> photoInfo(String idx) {
		Map<String, Object> info=sqlTemplate.selectOne("photoMediaInfo",idx);
		return info;
	}
	public Map<String, Object> fileInfo(String idx) {
		Map<String, Object> info=sqlTemplate.selectOne("fileMediaInfo",idx);
		return info;
	}
	
	public Map<String, Object> streamInfo(String idx) {
		Map<String, Object> info=sqlTemplate.selectOne("streamMediaInfo",idx);
		return info;
	}
	public Map<String, Object> boardInfo(String idx) {
		Map<String, Object> info=sqlTemplate.selectOne("boardMediaInfo",idx);
		return info;
	}
	public Map<String, Object> vodRelative(String idx) {
		Map<String, Object> info=sqlTemplate.selectOne("vodMediaInfo",idx);
		return info;
	}
	public List<String> getAllSTBList() {
		List<String> list=sqlTemplate.selectList("getAllSTBList");
		return list;
	}
	public List<HashMap<String, Object>> getVodMainDepth(int idx) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getVodMainMenu",idx);
		return lists;
	}
	


	
	
}
