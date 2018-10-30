package hanibal.ibs.library;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public class DataMap {
	public static Map<String, Object> getDataMap(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>(); 

		String key; 
		//System.out.println(request.getParameterNames());
		for(Enumeration<String> e = request.getParameterNames(); e.hasMoreElements(); map.put(key, request.getParameter(key))) { 
		key = (String)e.nextElement(); 
		} 
		return map;
	}
	
	public static Map<String, Object> getDataMap(MultipartHttpServletRequest multi){
		Map<String, Object> map = new HashMap<String, Object>(); 

		String key; 
		//System.out.println(request.getParameterNames());
		for(Enumeration<String> e = multi.getParameterNames(); e.hasMoreElements(); map.put(key, multi.getParameter(key))) { 
		key = (String)e.nextElement(); 
		} 
		return map;
	}
	
    public static String getMD5(String str){
        String rtnMD5 = "";
        try {

            //MessageDigest 인스턴스 생성
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            //해쉬값 업데이트
            md.update(str.getBytes());

            //해쉬값(다이제스트) 얻기
            byte byteData[] = md.digest();

            StringBuffer sb = new StringBuffer();

            //출력
            for(byte byteTmp : byteData) {
                sb.append(Integer.toString((byteTmp&0xff) + 0x100, 16).substring(1));
            }
            rtnMD5 = sb.toString();
        } catch (Exception e) {
            e.printStackTrace(); 
            rtnMD5 = null; 
        }
        return rtnMD5;
    } 

    //SHA-256    

    public static String getSHA256(String str) {
        String rtnSHA = "";

        try{
            MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
            sh.update(str.getBytes()); 
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer(); 

            for(int i = 0 ; i < byteData.length ; i++){

                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

            }

            rtnSHA = sb.toString();

        }catch(NoSuchAlgorithmException e){

            e.printStackTrace(); 

            rtnSHA = null; 

        }
        return rtnSHA;

    } 	
}
