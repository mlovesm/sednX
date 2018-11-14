package hanibal.ibs.dao;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSSigner;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWT;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;

import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.app.FavoriteListDTO;
import hanibal.ibs.model.app.VodListAppDTO;
import hanibal.ibs.model.cms.BoardDTO;

public class IbsAppDAO {
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

	public String checkLogin(Map<String, Object> commandMap) throws Exception {
		String result="";
		//아이디 체크
		String auth_id=java.net.URLDecoder.decode((String) commandMap.get("auth_id"),"UFT-8");
		commandMap.put("auth_pass",java.net.URLDecoder.decode((String)commandMap.get("auth_pass"),"UFT-8"));
		log.info(auth_id+"/"+commandMap.get("auth_pass"));
		int idCount=sqlTemplate.selectOne("checkId",auth_id);
		if(idCount==0) {
			result="missId";
		}else{
			//비밀번호 체크
			String auth_token=sqlTemplate.selectOne("auth_token",commandMap);
			if(auth_token==null) {
				result="missPass";
			}else {
				result="success";

			}
		}
		
		return result;
	}
	public String getToken(Map<String, Object> commandMap) throws JOSEException, Throwable {
		SecureRandom random = new SecureRandom();
		byte[] sharedSecret = new byte[32];
		random.nextBytes(sharedSecret);
		JWSSigner signer=new MACSigner(sharedSecret);
		JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                .claim("member_id",commandMap.get("auth_id"))
                .claim("mamber_pass",commandMap.get("auth_pass"))
                .build();
		SignedJWT signedJWT = new SignedJWT(new JWSHeader(JWSAlgorithm.HS256), claimsSet);
		try {
			signedJWT.sign(signer);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String jwtString = signedJWT.serialize();
		sqlTemplate.insert("insertToken",jwtString);
		/*JWT signeJWTReturn = (SignedJWT)SignedJWT.parse(jwtString);
		log.info(signeJWTReturn.getJWTClaimsSet().getClaim("id"));*/
		
		return jwtString;
	}
	public int checkToken(String token) {
		int affectCount=sqlTemplate.selectOne("checkToken",token);
		return affectCount;
	}
	public List<VodListAppDTO> getBannerList(String category, String mediaIp) {
		HashMap<String,Object> resultMap=sqlTemplate.selectOne("getLayOutCategorys",Integer.parseInt(category));
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(((String)resultMap.get("wl_categorys")).length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray((String)resultMap.get("wl_categorys"));
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		log.info((String)resultMap.get("wl_sort"));
		map.put("wl_sort",(String)resultMap.get("wl_sort"));
		map.put("eachFlag",eachFlag);
		List<VodListAppDTO> lists=sqlTemplate.selectList("bannerlist",map);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			lists.get(i).setVod_path("http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		return lists;
	}


	public List<VodListAppDTO> getMainList(String mediaIp) throws Exception {
		int category=1;
		List<Integer> layoutLists=sqlTemplate.selectList("getChildIdx",category);
		List<VodListAppDTO> lists=new ArrayList<VodListAppDTO>(); 
		for(int i=0;i<layoutLists.size();i++) {
			log.info(layoutLists.get(i));
		}
		for(int i=0;i<layoutLists.size();i++) {
			Map<String,Object> map= new HashMap<String,Object>();
			String eachFlag="";
			log.info(layoutLists.get(i));
			int childIdxArr[]=HanibalWebDev.StringToIntArray(HanibalWebDev.getChildIdx(layoutLists.get(i)));
			if(childIdxArr.length!=0) {
				eachFlag="Y";
				map.put("childIdxArr", childIdxArr);
				map.put("wl_sort","R");
				map.put("eachFlag",eachFlag);
				List<VodListAppDTO> addlists=sqlTemplate.selectList("mainLayoutlist",map);
				lists.addAll(addlists);
			}
		}
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			lists.get(i).setVod_path("http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		return lists;
	}
	public List<VodListAppDTO> getSubist(Map<String, Object> commandMap, String mediaIp) throws Exception {
		int start=0;
		int end=start+10;
		if(Integer.parseInt((String) commandMap.get("start_num"))>-1) {
			start=Integer.parseInt((String) commandMap.get("start_num"));
		}
		int category=Math.abs(Integer.parseInt((String) commandMap.get("board_cate_idx")));
		List<Integer> layoutLists=sqlTemplate.selectList("getChildIdx",category);
		List<VodListAppDTO> lists=new ArrayList<VodListAppDTO>(); 
		if(layoutLists.size()==0) {
			layoutLists.add(category);
		}
		for(int i=0;i<layoutLists.size();i++) {
			Map<String,Object> map= new HashMap<String,Object>();
			String eachFlag="";
			eachFlag="Y";
			int [] childIdxArr;
			if(category==1) {
				childIdxArr=HanibalWebDev.StringToIntArray(HanibalWebDev.getChildIdx(layoutLists.get(i)));
			}else{
				childIdxArr=HanibalWebDev.StringToIntArray(String.valueOf(layoutLists.get(i)));
			}
			map.put("childIdxArr",childIdxArr);
			map.put("wl_sort","R");
			map.put("start",start);
			map.put("end",end);
			map.put("eachFlag",eachFlag);
			log.info("map :"+String.valueOf(map.get("childIdxArr")));
			List<VodListAppDTO> addlists=sqlTemplate.selectList("subLayoutlist",map);
			lists.addAll(addlists);
		}
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			lists.get(i).setVod_path("http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		return lists;
	}
	public List<HashMap<String, Object>> getParentList(int category) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getParentList",category);
		return lists;
	}
	public List<HashMap<String, Object>> getSibling(int category) throws IOException {
		category=Math.abs(category);
		List<HashMap<String, Object>> lists=new ArrayList<HashMap<String, Object>>(); 
		if(category==1) {
			lists=sqlTemplate.selectList("getParentList",category);
		}else {
			category=HanibalWebDev.getParent("tb_board_category",String.valueOf(category));
			lists=sqlTemplate.selectList("getParentList",category);
		}
		return lists;
	}
	public Map<String, Object> getDetailView(Map<String, Object> commandMap) throws ParseException {
		JWT signeJWTReturn = (SignedJWT)SignedJWT.parse((String) commandMap.get("token"));
		commandMap.put("member_id",signeJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		Map<String, Object> map=sqlTemplate.selectOne("getDetailView",commandMap);
		String fileName=(String)map.get("vod_path");
		map.put("vod_down_path","/api/app/download/vod/mp4/"+fileName.replace(".mp4",""));
		map.put("main_thumbnail","/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath((String)map.get("main_thumbnail"))+(String)map.get("main_thumbnail"));
		map.put("vod_path","http://"+commandMap.get("mediaIp")+"/VOD"+HanibalWebDev.getDataPath((String)map.get("vod_path"))+(String)map.get("vod_path")+"/index.m3u8");
		if(Integer.parseInt(String.valueOf(map.get("favorite_yn")))==0) {
			map.put("favorite_yn","N");
		}else {
			map.put("favorite_yn","Y");
		}
		map.put("vod_volume", Long.parseLong((String)map.get("vod_volume")));
		return map;
	}
	
	public int insertFavorite(Map<String, Object> commandMap) throws ParseException {
		JWT signeJWTReturn = (SignedJWT)SignedJWT.parse((String) commandMap.get("token"));
		commandMap.put("member_id",signeJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		int count=sqlTemplate.selectOne("favorite_count", commandMap);
		int affectCount=0;
		if(count==0) {
			affectCount=sqlTemplate.insert("insertFavorite", commandMap);
		}
		return affectCount;
	}
	
	public void deleteFavorite(Map<String, Object> commandMap) throws ParseException {
		JWT signeJWTReturn = (SignedJWT)SignedJWT.parse((String) commandMap.get("token"));
		commandMap.put("member_id",signeJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		sqlTemplate.update("deleteFavorite",commandMap);
	}
	//다운로드 
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
	
	public List<HashMap<String, Object>> getFileInfo(Map<String, Object> commandMap) {
		// board repository에서 각각 file, photo repository의 idx 값을 가져와서
		String fileList = sqlTemplate.selectOne("getFileRepoIdx", commandMap);
		String photoList = sqlTemplate.selectOne("getPhotoRepoIdx", commandMap);
		
		// file, photo repository에서 해당 idx값으로 데이터 조회한 후, lists에 담아온다
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("file_idx", HanibalWebDev.StringToIntArray(fileList));
		map.put("photo_idx", HanibalWebDev.StringToIntArray(photoList));
		List<HashMap<String, Object>> fileLists = sqlTemplate.selectList("getFileInfo", map);
		List<HashMap<String, Object>> photoLists = sqlTemplate.selectList("getPhotoInfo", map);
		
		for(int i=0;i<fileLists.size();i++) {
			String ext = (String)fileLists.get(i).get("file_sort");
			String filename = String.valueOf(fileLists.get(i).get("file_path")).replace("." + ext, "");
			fileLists.get(i).put("file_path", "/api/app/filedown/file/" + ext + "/" + filename);
			fileLists.get(i).put("file_sort", "file");
		}
		
		for(int i=0;i<photoLists.size();i++) {
			String name = (String)photoLists.get(i).get("file_path");
			int index = name.indexOf(".");
			String filename = name.substring(0, index);
			String ext = name.substring(index + 1);
			photoLists.get(i).put("file_path", "/api/app/filedown/photo/" + ext + "/" + filename);
			photoLists.get(i).put("file_sort", "img");
		}
		
		// 담아온 lists를 하나로 합쳐서 리턴
		List<HashMap<String, Object>> lists = new ArrayList<HashMap<String, Object>>();
		lists.addAll(fileLists);
		lists.addAll(photoLists);
		
		return lists;
	}

	public List<FavoriteListDTO> getFavoriteList(Map<String, Object> commandMap) throws ParseException {
		// token에 담긴 member_id를 풀어내어 해당 정보를 조회한다
		JWT signeJWTReturn = (SignedJWT)SignedJWT.parse((String) commandMap.get("token"));
		commandMap.put("member_id",signeJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		List<FavoriteListDTO> favoriteList = sqlTemplate.selectList("getFavoriteIdx", commandMap);

		for(int i=0;i<favoriteList.size();i++) {
			String vodName = (String)favoriteList.get(i).getVod_path();
			String thumbName = (String)favoriteList.get(i).getMain_thumbnail();
			favoriteList.get(i).setVod_path("http://" + commandMap.get("mediaIp") + "/VOD" + HanibalWebDev.getDataPath((String)favoriteList.get(i).getVod_path()) + vodName + "/index.m3u8");
			favoriteList.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL" + HanibalWebDev.getDataPath((String)favoriteList.get(i).getMain_thumbnail()) + thumbName);		
		}
		return favoriteList;
	}
	
	public List<HashMap<String, Object>> getLivePairing(Map<String, Object> commandMap) throws ParseException {
		List<String> liveChannelTartgetListArray = sqlTemplate.selectList("getLiveChannelTarget");
		String liveChannelTargetList = liveChannelTartgetListArray.toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\\s", "");
		System.out.println("liveChannelTargetList=" + liveChannelTargetList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category_idx", HanibalWebDev.StringToIntArray(liveChannelTargetList));
		map.put("date", (String)commandMap.get("date"));
		List<HashMap<String, Object>> channelList = sqlTemplate.selectList("getChannelList", map);
		System.out.println("channelList=" + channelList);
		
		map.put("searchWord", commandMap.get("searchWord"));
		for(int i=0;i<channelList.size();i++) {
			map.put("ch_idx", channelList.get(i).get("ch_idx"));
			List<HashMap<String, Object>> schList = sqlTemplate.selectList("getSchList", map);
			System.out.println("schList=" + schList);
			
			for(int n=0;n<schList.size();n++) {
				schList.get(n).put("sch_thumbnail", "/REPOSITORY/THUMBNAIL" + HanibalWebDev.getDataPath((String)schList.get(n).get("sch_thumbnail")) + (String)schList.get(n).get("sch_thumbnail"));
				map.put("vod_idx", schList.get(n).get("sch_idx"));
				List<HashMap<String, Object>> vodList = sqlTemplate.selectList("getVodList", map);
				schList.get(n).put("vodList", vodList);

				for(int j=0;j<vodList.size();j++) {
					String vodName = (String)vodList.get(j).get("vod_path");
					String vodPlayTime = (String)vodList.get(j).get("vod_play_time");
					SimpleDateFormat transFormat = new SimpleDateFormat("HH:mm:ss");
					Date transVodPlayTime = transFormat.parse(vodPlayTime);
					String transVodPlayTimeSet = String.valueOf((transVodPlayTime.getHours() * 3600 + transVodPlayTime.getMinutes() * 60 + transVodPlayTime.getSeconds()) * 1000);
					vodList.get(j).put("vod_path", "http://" + commandMap.get("mediaIp") + "/VOD" + HanibalWebDev.getDataPath((String)vodList.get(j).get("vod_path")) + vodName);	
					vodList.get(j).put("vod_play_time", transVodPlayTimeSet);
				}				
			}
			channelList.get(i).put("schList", schList);
		}
		return channelList;
	}
	
	public HashMap<String, Object> getUserinfo(Map<String, Object> commandMap) throws ParseException {
		// token에 담긴 member_id를 풀어내여 해당 정보를 조회한다
		JWT signJWTReturn = (SignedJWT)SignedJWT.parse((String)commandMap.get("token"));
		commandMap.put("member_id", signJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		HashMap<String, Object> map = sqlTemplate.selectOne("getUserinfo", commandMap);
		map.put("user_profile_img", "/REPOSITORY/PROFILE/" + (String)map.get("user_profile_img"));
		return map;
	}
	
	public HashMap<String, Object> getUpdateVer() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recommend_version", 1);
		map.put("force_version", 1);
		map.put("link_url", "");
		map.put("title", "업데이트");
		map.put("contents", "업데이트가 필요합니다.");
		
		return map;
	}
	
	public HashMap<String, Object> getSettingInfo() {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("start_page", "vod");
		map.put("conf_server_ip", "182.162.172.133");
		map.put("conf_server_port", "8443");
		
		return map;
	}	
	
	//추가 by MGS
	public void tb_sedn_logInsert(Map<String, Object> commandMap) {
		sqlTemplate.insert("tb_sedn_logInsert",commandMap);	
	}
	
	public List<VodListAppDTO> getVodList(Map<String, Object> paramMap, String mediaIp) throws Exception {
		System.out.println(paramMap);
		String sql="vod_searchList";
		if(paramMap.get("type")!=null) sql= "vod_"+paramMap.get("type")+"List";
		List<VodListAppDTO> lists=sqlTemplate.selectList(sql, paramMap);
		
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			lists.get(i).setVod_path("http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		
		return lists;
	}
}
