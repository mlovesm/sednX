package hanibal.ibs.library;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.nio.channels.FileChannel;
import java.nio.file.FileStore;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Properties;
import java.util.Random;
import java.util.TimeZone;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.management.AttributeNotFoundException;
import javax.management.InstanceNotFoundException;
import javax.management.MBeanException;
import javax.management.MalformedObjectNameException;
import javax.management.ReflectionException;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;


public class HanibalWebDev  extends MysqlConnect{
	public static Logger log = Logger.getLogger(HanibalWebDev.class);
	private boolean lowerCheck;
	private int size;
	
	public static String sednEmail(String fromMail,String toMail,String subject, String contents ) {
		String mailResult="";
		Properties p = System.getProperties();
        p.put("mail.smtp.starttls.enable", "true");     // gmail은 무조건 true 고정
        p.put("mail.smtp.host", "smtp.gmail.com");      // smtp 서버 주소
        p.put("mail.smtp.auth","true");                 // gmail은 무조건 true 고정
        p.put("mail.smtp.port", "587");     
        Authenticator auth = new MailAuthentication();
        
        //session 생성 및  MimeMessage생성
        Session session = Session.getDefaultInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
        try{
            //편지보낸시간
            msg.setSentDate(new Date());
            InternetAddress from = new InternetAddress() ;
            from = new InternetAddress(fromMail+"<"+fromMail+">");
             // 이메일 발신자
            msg.setFrom(from);
             // 이메일 수신자
            InternetAddress to = new InternetAddress(toMail);
            msg.setRecipient(Message.RecipientType.TO, to);
             
            // 이메일 제목
            msg.setSubject(subject, "UTF-8");
             
            // 이메일 내용 TEXT
            //msg.setText(contents, "UTF-8");
            // 이메일 헤더
            msg.setHeader("content-Type", "text/html");
            msg.setContent(contents, "text/html; charset=euc-kr"); 
            //메일보내기
            javax.mail.Transport.send(msg);
            mailResult="success";
        }catch (AddressException addr_e) {
            addr_e.printStackTrace();
            mailResult="fail";
        }catch (MessagingException msg_e) {
            msg_e.printStackTrace();
            mailResult="fail";
        }
		return mailResult;
	}
	
	public String getKey(int size,boolean lowerCheck) {
		this.size=size;
		this.lowerCheck=lowerCheck;
		return init();
	}

	private String init() {
		Random ran =new Random();
		StringBuffer sb=new StringBuffer();
		do {
			int num=ran.nextInt(75)+48;
            if((num>=48 && num<=57) || (num>=65 && num<=90) || (num>=97 && num<=122)) {
                sb.append((char)num);
            }else {
                continue;
            }
		}while(sb.length() < size);
		if(lowerCheck) {
            return sb.toString().toLowerCase();
        }
        return sb.toString();
	}
	public String serverIp() throws UnknownHostException {
		return getIp();
	}
	public static  String getIp() throws UnknownHostException {
		InetAddress Address = InetAddress.getLocalHost(); 
        String IP = Address.getHostAddress();
		return IP;
	}

	public static String fileRenameTo(String thisPath, String thisFile, String targetPath,
			String targetName,String extendFolder) {
		//확장자 추출 
		String extension=thisFile.substring(thisFile.lastIndexOf(".")+1,thisFile.length());
		//경로가 같으면 이름 변경 다르면 이동
		File nowFilePath=new File(thisPath+extendFolder+thisFile);
		File targetFilePath=new File(targetPath+extendFolder+targetName+"."+extension);
		if(nowFilePath.exists()) nowFilePath.renameTo(targetFilePath);
		return targetName+"."+extension;
	}

	public static void fileDelete(String repositoryPath, String thisFile, String extendFolder) {
		File file=new File(repositoryPath+extendFolder+thisFile);
		if(file.exists()) {
			file.delete();
		}
	}
	public static String getAuthorityInfo(String systemElement,String authority) throws IOException {
		String returnHtml="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select system_value,system_key from tb_system_code where system_group='"+systemElement+"' order by idx asc";
		
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			returnHtml="<select class=\"form-control input-sm\" style=\"width:150px;\">";			 
			while(rs.next()){
				String selected="";
				if(rs.getString(1).equals(authority)) selected="selected";
				returnHtml+="<option value="+rs.getString(1)+" "+selected+">"+rs.getString(2)+"</option>";
			}
			returnHtml+="</select>";
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return returnHtml;
	}
	public static int[] StringToIntArray(String checkValArr) {
		String[] array=checkValArr.split(",");
		int[] convertInt=new int[array.length];
		if(checkValArr.length()>0) {
			for(int i=0;i<array.length;i++) {
				convertInt[i]=Integer.parseInt(array[i]);
			}
		}
		return convertInt;
	}
	public static String[] StringToStringArray(String checkValArr) {
		String[] array=checkValArr.split(",");
		String[] convertString=new String[array.length];
		if(checkValArr.length()>0) {
			for(int i=0;i<array.length;i++) {
				convertString[i]=String.valueOf(array[i]);
			}
		}
		return convertString;
	}
	public static String targetTable(String sort) {
		String tableName="";
		if(sort.equals("vod")) {
			tableName="tb_content_category";
		}else if(sort.equals("photo")) {
			tableName="tb_content_category";
		}else if(sort.equals("file")) {
			tableName="tb_content_category";
		}else if(sort.equals("stream")) {
			tableName="tb_content_category";
		}else if(sort.equals("live")) {
			tableName="tb_live_category";
		}else if(sort.equals("board")) {
			tableName="tb_board_category";
		}else if(sort.equals("stb-controle")) {
			tableName="tb_stb_category";
		}else if(sort.equals("stb-schedule")) {
			tableName="tb_stb_category";
		}else if(sort.equals("stb-log")) {
			tableName="tb_stb_category";
		}else if(sort.equals("stb-ui")) {
			tableName="tb_stb_category";
		}else if(sort.equals("makePage")) {
			tableName="tb_board_category";
		}
		return tableName;
	}
	public static String targetRepoTable(String sort) {
		String tableName="";
		if(sort.equals("vod")) {
			tableName="tb_vod_repository";
		}else if(sort.equals("photo")) {
			tableName="tb_photo_repository";
		}else if(sort.equals("file")) {
			tableName="tb_file_repository";
		}else if(sort.equals("stream")) {
			tableName="tb_live_repository";
		}else if(sort.equals("live")) {
			tableName="tb_live_repository";
		}else if(sort.equals("board")) {
			tableName="tb_board_repository";
		}else if(sort.equals("stb-controle")) {
			tableName="tb_stb";
		}else if(sort.equals("stb-schedule")) {
			tableName="tb_stb";
		}else if(sort.equals("stb-log")) {
			tableName="tb_stb_log";
		}else if(sort.equals("stb-ui")) {
			tableName="tb_stb";
		}else if(sort.equals("makePage")) {
			tableName="tb_board_repository";
		}
		return tableName;
	}

	public static int getParent(String table, String idx) throws IOException {
		int parent=0;
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select pid from "+table+" where idx="+idx;
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
			parent=rs.getInt(1);
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return parent;
	}

	public static String getCategoryName(String sort,String idx) throws IOException {
		String name="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String table=targetTable(sort);
		String sql="select category_name from "+table+" where idx="+idx;
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
			name=rs.getString(1);
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return name;
	}
	public static String getCategoryNames(String sort,String idx,String index) throws IOException {
		String name="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String table=targetTable(sort);
		String sql="select idx,category_name from "+table+" where idx in("+idx+")";
		log.info(sql);
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
			name+="<div class=\"m-b-15 m-l-10 delCate_"+index+"\" id=\"del_"+rs.getString(1)+"\" style=\"float:left\">"	;
			name+="<div class=\"btn btn-sm\">";
			name+=rs.getString(2);
			name+="<span class=\"del\" onClick=\"layout.delCategorys("+rs.getString(1)+","+index+")\"> ×</span>";
			name+="</div>";
			name+="</div>";
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}

		return name;
	}
	public static String getCategorySelect(String table, String idx) throws IOException {
		String returnHtml="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx,category_name from "+table+" where pid="+idx+" order by idx asc";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			int count=0;
			returnHtml="<select class=\"form-control input-sm cateValue\"  style=\"width:150px;\" onChange=\"layout.selectList(this)\">";
			returnHtml+="<option value=\"\">선택</option>";
			while(rs.next()){
				returnHtml+="<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>";
				count++;
			}
			returnHtml+="</select>";
			con.commit();
			if(count==0) {
				returnHtml="";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return returnHtml;
	}

	public static String getResolution(String path) throws IOException {
		File file = new File(path);
	    ImageInputStream iis = ImageIO.createImageInputStream(file);
	        Iterator<ImageReader> readers = ImageIO.getImageReaders(iis);
	        String resolution="";
	        if (readers.hasNext()) {
	          //Get the first available ImageReader
	            ImageReader reader = readers.next();
	            reader.setInput(iis, true);
	            resolution=reader.getWidth(0)+"x"+reader.getHeight(0);
	        }

		return resolution;
	}

	public static String getDataPath(String file) {
		return "/"+file.substring(0,4)+"/"+file.substring(4,6)+"/"+file.substring(6,8)+"/";
	}

	public static String[] getSliceTimeArr(String hhmmss) {
		String[] resultArr=new String[10];
		String[] split = hhmmss.split(":");
		int miliSecond=0;
		miliSecond += Integer.parseInt(split[0])*60*60;  
		miliSecond += Integer.parseInt(split[1])*60;  
		miliSecond += Integer.parseInt(split[2]);
		TimeZone tz = TimeZone.getTimeZone("UTC");
		SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
		df.setTimeZone(tz);
		int thumbTime=miliSecond*1000/10;
		int convertSecond=0;
		for(int i=0;i<10;i++) {
		    	convertSecond=(thumbTime*(i+1))-10;
		    	resultArr[i]=df.format(new Date(convertSecond));
	
		}
		return resultArr;
	}

	public static String getMediaRuntime(String shellPath,String mediaPath) {
		String result="";  
		Runtime rt = Runtime.getRuntime();
		Process proc = null;
		InputStream is = null;
		BufferedReader bf = null;
		log.info(shellPath+"="+mediaPath);
		try{
			  String[] cmd = {"/bin/sh",shellPath,mediaPath};     
			  proc = rt.exec(cmd);
		      proc.getInputStream();
		      is = proc.getInputStream();
		      bf = new BufferedReader(new InputStreamReader(is));
		      while(true){
			  String info = bf.readLine();
				  if(info == null || info.equals("")){
					  break;
				  }
				  log.info(info);
				  result=info;
		   		}
		      
			}catch(Exception e){
			  log.info("EXCEPTION : "+e.getMessage());
		 }
		return result;
	}
	public static String mediaEncoding(String shellPath,String inputFile,String outPutFile,String logOne,String logTwo) {
		String result="";  
		Runtime rt = Runtime.getRuntime();
		Process proc = null;
		try{
			  String[] cmd = {"/bin/sh",shellPath,inputFile,outPutFile,logOne,logTwo};     
			  proc = rt.exec(cmd);
		      proc.getInputStream();
		      while(true){
			  String info ="";
				  if(info == null || info.equals("")){
					  break;
				  }
				  log.info(info);
				  result=info;
		   		}
		      
			}catch(Exception e){
			  log.info("EXCEPTION : "+e.getMessage());
		 }
		return result;
	}
	public static String getSystemCommand(String command) {
		String result = "";
        Runtime rt = Runtime.getRuntime();
        Process p = null;
        StringBuffer sb = new StringBuffer();
        try{
            p=rt.exec(command);
            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String cl = null;
            while((cl=in.readLine())!=null){
                sb.append(cl);
            }
            result = sb.toString();
            in.close();
        }catch(IOException e){
            e.printStackTrace();
            return "fail";
        }
        return result;
	}

	public static String getFileSize(String path) {
		String file_size="";
		File file=new File(path);
		if(file.exists()) {
			long longSize=file.length();
			file_size=Long.toString(longSize);
		}else {
			file_size="none";
		}
		return file_size;
	}

	public static void getRateProcess(String shellPath, String origin,String process,String rate) throws IOException {
		String[] cmd = new String[]{shellPath,origin,process,rate,"&"}; 
		ProcessBuilder pb = new ProcessBuilder(cmd);
		pb.redirectErrorStream(true);
		Process p=pb.start();
		if (cmd.length==0) {
			p.destroy();
			log.info("***********************ERROR************************************");
		 }
	}
	public static String getThumbnail(String shellPath, String filePath, String time, String output) {
		String result="";
		Runtime rt = Runtime.getRuntime();
		Process proc = null;
		try{
			  String[] cmd = {"/bin/sh",shellPath,filePath,time,output};     
			  proc = rt.exec(cmd);
		      proc.getInputStream();
		      while(true){
			  String info ="";
				  if(info == null || info.equals("")){
					  break;
				  }
				  log.info(info);
				  result=info;
		   		}
		      
			}catch(Exception e){
			  log.info("EXCEPTION : "+e.getMessage());
		 }
		return result;

	}
	public static String getFileLayout(String fileIdx) throws  IOException {
		String result="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx,file_title from tb_file_repository where idx in ("+fileIdx+")";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			int count=0;
			while(rs.next()){
				result+="<span class=\"label label-success fileSpan\" id=\"fileSpan_"+rs.getString(1)+"\" > <i class=\"icon\">&#61836;</i> "+rs.getString(2)+"</span>&nbsp;";
				count++;
			}
			con.commit();
			if(count==0) {
				result="";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return result;
	}
	public static String getPhotoLayout(String photoIdx) throws  IOException {
		String result="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx,photo_path from tb_photo_repository where idx in ("+photoIdx+")";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			int count=0;
			while(rs.next()){
				result+="<div class=\"superbox-list photoSpan\" id=\"photoSpan_"+rs.getString(1)+"\"><img src=\"/REPOSITORY/PHOTO"+getDataPath(rs.getString(2))+rs.getString(2)+"\" class=\"superbox-img\" id=\"photoImg_"+rs.getString(1)+"\" /></div>";
				count++;
			}
			con.commit();
			if(count==0) {
				result="";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return result;
	}
	public static String getLiveLayout(String idx) throws  IOException {
		String result="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx,live_path from tb_live_repository where idx in ("+idx+")";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			int count=0;
			while(rs.next()){
				result = "<video id='my-player_board' class='video-js'  controls preload='auto'  poster='/img/live.jpg'  data-setup='{}' style='width: 100% !important; height: 100% !important;'>";
				result += "<source  src='"+rs.getString(2) +"'  type='application/x-mpegURL'></source>";
				result += "</video>";
				count++;
			}
			con.commit();
			if(count==0) {
				result="";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return result;
	}
	public static String getVodLayout(String idx) throws  IOException {
		String result="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx,vod_path,main_thumbnail from tb_vod_repository where idx in ("+idx+")";
		log.info(sql);
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			int count=0;
			while(rs.next()){
				result = "<video id='my-player_vodBoard' class='video-js'  controls preload='auto'  poster='/REPOSITORY/THUMBNAIL"+getDataPath(rs.getString(2))+rs.getString(3)+"'  data-setup='{}' style='width: 100% !important; height: 100% !important;'>";
				result += "<source  src='http://"+String.valueOf(object.get("mediaIp"))+"/vod"+getDataPath(rs.getString(2))+rs.getString(2)+"/index.m3u8'  type='application/x-mpegURL'></source>";
				result += "</video>";
				count++;
			}
			con.commit();
			if(count==0) {
				result="";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return result;
	}

	public static void sendCommandToSTB(String command, String stbMAC) {
		String OS=System.getProperty("os.name").toLowerCase();
		String mqttPath="";
		if(OS.indexOf("mac")>=0) {
			mqttPath="/usr/local/bin/mosquitto_pub";
		}else {
			mqttPath="mosquitto_pub";
		}
		try {
    		StringBuilder arg = new StringBuilder();
    		arg.append(mqttPath);	// run on the localhost
    		arg.append(" -t /" + stbMAC);
    		arg.append(" -m " + command); 
    		Process p = Runtime.getRuntime().exec(arg.toString());
    		p.waitFor();
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
	}

	public static String getTotalDiskSpace() {
		String totalSpace="";
		for(Path root:FileSystems.getDefault().getRootDirectories()) {
			FileStore store;
			try {
				store = Files.getFileStore(root);
				totalSpace+=store.getTotalSpace();
			} catch (IOException e) {
				e.printStackTrace();
			}
	        
		}
		return totalSpace;
	}
	public static String getUsedDiskSpace() {
		String freeSpace="";
		for(Path root:FileSystems.getDefault().getRootDirectories()) {
			FileStore store;
			try {
				store = Files.getFileStore(root);
				freeSpace+=String.valueOf((long)store.getTotalSpace()-(long)store.getUsableSpace());
			} catch (IOException e) {
				e.printStackTrace();
			}
	        
		}
		return freeSpace;
	}

	public static String getPercent(String totalDiskSpace, String usedDiskSpace) {
		double x=Double.parseDouble(totalDiskSpace);
		double y=Double.parseDouble(usedDiskSpace);
		double result = y/x * 100;
		return String.valueOf((int)result);
	}

	public static String getTotalMemory() throws InstanceNotFoundException, AttributeNotFoundException, MalformedObjectNameException, ReflectionException, MBeanException {
		com.sun.management.OperatingSystemMXBean os = (com.sun.management.OperatingSystemMXBean)
			     java.lang.management.ManagementFactory.getOperatingSystemMXBean();
			long physicalMemorySize = os.getTotalPhysicalMemorySize();

		return String.valueOf(physicalMemorySize) ;
	}

	public static String getUsedMemory() {
		com.sun.management.OperatingSystemMXBean os = (com.sun.management.OperatingSystemMXBean)
			     java.lang.management.ManagementFactory.getOperatingSystemMXBean();
			long usedSize=os.getTotalPhysicalMemorySize()-os.getFreePhysicalMemorySize();
		return String.valueOf(usedSize);
	}
	
	public static String getLiveTimeExpress(String start, String end) throws ParseException {
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		SimpleDateFormat viewDf=new SimpleDateFormat("MM월dd일 HH시mm분");
		Date beginDate=format.parse(start);
		Date endDate=format.parse(end);
		Date today=new Date();
		int compareEnd=today.compareTo(endDate);
		int compareStart=today.compareTo(beginDate);
		String express="";
		if(compareStart>0&&compareEnd<0) {
			/*진행중*/
			express="<span class=\"label label-new\">현재 방송중</span>";
		}else if(compareEnd>0) {
			/*종료*/
			express="<span class=\"label label-gray\">"+viewDf.format(endDate)+" 방송 종료</span>";
		}else {
			/*방송시간*/
			long diff=endDate.getTime()-beginDate.getTime();
			long minnute=diff/(60*1000);
			/*예정*/
			express="<span class=\"label label-green\">"+viewDf.format(beginDate)+" "+minnute+"분간 "+" 방송 예정</span>";
		}
		
		
		return express;
	}
	public static String  getLiveSource() throws IOException {
		String optionList="<select class=\"form-control m-b-10\" id=\"selectLive\">";
		optionList+="<option value=\"\">선택 해 주세요.</option>";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="SELECT idx,category_idx,live_path,live_title FROM tb_live_repository where del_flag='N';";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				optionList+="<option value='"+rs.getString(3)+"' title='"+rs.getString(1)+"'>"+rs.getString(4)+"</option>";
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		
		optionList+="</select>";
		return optionList;
	}
	
	
	public static int getScheduleTop() throws IOException {
		int topIdx=0;
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx from tb_stb_schedule order by idx desc limit 1;";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				topIdx=Integer.parseInt(rs.getString(1));
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return topIdx;
	}
	public static int getPhotoTop() throws IOException {
		int topIdx=0;
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx from tb_photo_repository order by idx desc limit 1;";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				topIdx=Integer.parseInt(rs.getString(1));
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return topIdx;
	}
	
	public static String getBoardSelect()  throws Exception{
		String selectTag="";
		int depthCount=-1;
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="SELECT t1.category_name AS lev1, t2.category_name as lev2, t3.category_name as lev3,t3.idx as idx,t3.pid as pid,t2.position as position,t3.position as subPosition\n" + 
				"FROM tb_board_category AS t1\n" + 
				"LEFT JOIN tb_board_category AS t2 ON t2.pid = t1.idx\n" + 
				"LEFT JOIN tb_board_category AS t3 ON t3.pid = t2.idx\n" + 
				"where t1.idx=1 order by position asc, subPosition asc;";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				if(depthCount==-1) {
					selectTag+=" <optgroup label=\""+rs.getString(2)+"\">";
					selectTag+="<option value=\""+rs.getString(4)+"\">"+rs.getString(3)+"</option>";
					depthCount=Integer.parseInt(rs.getString(6));
				}else if(depthCount==Integer.parseInt(rs.getString(6))){
					selectTag+="<option value=\""+rs.getString(4)+"\">"+rs.getString(3)+"</option>";
				}else if(depthCount<Integer.parseInt(rs.getString(6))) {
					selectTag+="</optgroup>";
					selectTag+=" <optgroup label=\""+rs.getString(2)+"\">";
					selectTag+="<option value=\""+rs.getString(4)+"\">"+rs.getString(3)+"</option>";
					depthCount=Integer.parseInt(rs.getString(6));
				}else if(rs.last()) {
					selectTag+="</optgroup>";
				}
				
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return selectTag;
	}
	public static String getChildIdx(int parent) throws Exception {
		String childIdx="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx as idx from tb_board_category where pid="+parent+" order by position asc";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
					childIdx+=rs.getString(1)+",";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		if(childIdx.length()!=0) {
			return childIdx.substring(0,childIdx.length()-1);
		}else {
			return childIdx;
		}
			
	}
	public static String getDefaultLiveIdx() throws Exception {
		String idx="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx from tb_live_category where pid=1 and position=0";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				idx=String.valueOf(rs.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return idx;
	}
	public static String getDefaultLiveName() throws Exception {
		String name="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select category_name from tb_live_category where pid=1 and position=0";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				name=rs.getString(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return name;
	}
	
	public static String getDefaultContentsIdx() throws Exception {
		String idx="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select idx from  tb_content_category where pid not in(1,0) order  by pid desc,position desc limit 1";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				idx=String.valueOf(rs.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return idx;
	}
	public static String getDefaultContentsName() throws Exception {
		String name="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select category_name from  tb_content_category where pid not in(1,0) order  by pid desc,position desc limit 1;";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				name=rs.getString(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return name;
	}
	
	public static String getDefaultContentsParentName() throws Exception {
		String name="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select category_name from tb_content_category  where idx in (select * from (select idx from tb_content_category where pid  order by position desc limit 0,1 ) as tmpTable);";
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				name=rs.getString(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return name;
	}
	
	public static String getFileVolume(long volume) {
		String CalcuSize=null;
		int i=0;
		double calcu=(double) volume;
		while(calcu>=1024&&i<5) {
			calcu=calcu/1024;
			i++;
		}
		DecimalFormat df = new DecimalFormat("##0.0");
	    switch (i) {
	        case 0:
	            CalcuSize = df.format(calcu) + "Byte";
	            break;
	        case 1:
	            CalcuSize = df.format(calcu) + "KB";
	            break;
	        case 2:
	            CalcuSize = df.format(calcu) + "MB";
	            break;
	        case 3:
	            CalcuSize = df.format(calcu) + "GB";
	            break;
	        case 4:
	            CalcuSize = df.format(calcu) + "TB";
	            break;
	        default:
	            CalcuSize="XX"; //용량표시 불가

	    }
	    return CalcuSize;
	}
	public static String getPhotoPath(String photoIdx) throws  IOException {
		String result="";
		URL url = new URL("http://localhost:8080/api/seqKeyList");
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject)JSONValue.parse(isr);
		String dbProps=String.valueOf(object.get("dbProperties"));
		dbConnect(dbProps);
		String sql="select photo_path from tb_photo_repository where idx="+photoIdx;
		try {
			con.setAutoCommit(false);
			psmt=con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				result+=getDataPath(rs.getString(1))+rs.getString(1);
			}
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return result;
	}
	public static void fileRenameMoveTo(String thisPath,String targetPath) throws IOException {
		FileInputStream inputStream = new FileInputStream(thisPath);        
		FileOutputStream outputStream = new FileOutputStream(targetPath);
		  
		FileChannel fcin =  inputStream.getChannel();
		FileChannel fcout = outputStream.getChannel();
		long size = fcin.size();
		fcin.transferTo(0, size, fcout);
		  
		fcout.close();
		fcin.close();
		  
		outputStream.close();
		inputStream.close();
	}
	/*****sung a*****/
	public static String toString(String text) {
		if( text == null) {
				text = ""; 
			}
			return text;
		}

	

	
}

	
