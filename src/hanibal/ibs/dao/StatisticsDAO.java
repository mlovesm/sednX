package hanibal.ibs.dao;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
	
	public List<HashMap<String, Object>> getStatisticsVOD_date(Map<String,Object> paramMap) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("statisticsVOD_date", paramMap);
		return lists;
	}	
	
	public String exportPhotoExcel(List<Map<String, Object>> excel, String excelPath) throws IOException {
		//임의의 VO가 되주는 MAP 객체
		Map<String,Object>map=null;
		//가상 DB조회후 목록을 담을 LIST객체
		ArrayList<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		ArrayList<String> columnList=new ArrayList<String>();
		//DB조회후 데이터를 담았다는 가상의 데이터
		for(int i=0;i<excel.size();i++){
		    map=new HashMap<String,Object>();

		    list.add(map);
		}
		//MAP의 KEY값을 담기위함
		if(list !=null &&list.size() >0){
		    //LIST의 첫번째 데이터의 KEY값만 알면 되므로
		    Map<String,Object>m=list.get(0);
		    //MAP의 KEY값을 columnList객체에 ADD
		    for(String k : m.keySet()){
		        columnList.add(k);
		    }
		}
		
		HSSFWorkbook workbook=new HSSFWorkbook();
		HSSFSheet sheet=workbook.createSheet("sheet");
		HSSFRow row=null;
		HSSFCell cell=null;
		if(list !=null &&list.size() >0){
		    int i=0;
		    for(Map<String,Object>mapobject : list){
		        row=sheet.createRow((short)i);
		        i++;
		        if(columnList !=null &&columnList.size() >0){
		            for(int j=0;j<columnList.size();j++){
		                cell=row.createCell(j);
		                cell.setCellValue(String.valueOf(mapobject.get(columnList.get(j))));
		            }
		        }
		    }
		}
		SimpleDateFormat todayDate=new SimpleDateFormat("yyyyMMddHHmmss");
		Date nowDate=new Date();
		String formatDate=todayDate.format(nowDate);
		/*****************************************************************************************************************/
		FileOutputStream fos=new FileOutputStream("excelPath"+formatDate+".xls");
		/*****************************************************************************************************************/
		workbook.write(fos);
		workbook.close();
		log.info("엑셀만들기 성공");
		return formatDate+".xls";
	}
	
}
