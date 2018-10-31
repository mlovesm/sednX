package hanibal.ibs.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

import hanibal.ibs.library.HanibalWebDev;


//추가 by MGS
public class StatisticsDAO {
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
	
	// 방문자 VOD 재생
	public void insertVODHistory(Map<String, Object> commandMap) {
		sqlTemplate.insert("insertVODHistory",commandMap);
	}
	
	

	public List<HashMap<String, Object>> statisticsVODList(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("statisticsVODList", map);
		return lists;
	}
	
	public HashMap<String, Object> statisticsVODDetail(String idx) {
		Map<String,Object> paramMap= new HashMap<String,Object>();
		paramMap.put("idx", idx);
		
		HashMap<String, Object> map=sqlTemplate.selectOne("statisticsVODDetail", paramMap);
		return map;
	}	
	
	
	
	
}
