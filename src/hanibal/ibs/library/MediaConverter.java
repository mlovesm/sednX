package hanibal.ibs.library;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.regex.Pattern;

public class MediaConverter {
	public static final String FFMPEG_PATH = "C:\\dev\\ffmpeg\\bin";

	public static final String FFMPEG_EXEC_FILE = "C:\\dev\\ffmpeg\\bin\\ffmpeg";

    private String fileName;
    private String filePath;
    private String fileExt;
    
    private String duration;
    private int rate;

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public void setFileExt(String fileExt) {
        this.fileExt = fileExt;
    }
    
    public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}


	 /**
	  * 멀티미디어 파일 변환 
	  *
	  * @return
	  * @throws Exception
	  */
    public String convert() throws Exception {
	    File orgFile = new File(this.filePath + this.fileName);
	    String outputName = this.fileName.substring(0, this.fileName.indexOf(".")) + "." + this.fileExt;
	    String outputFile = this.fileName.substring(0, this.fileName.indexOf("."));
	    File outFile = new File(this.filePath + outputName);
	
	    System.out.println("orgFile getPath="+orgFile.getPath());
	    System.out.println("outFile getPath="+outFile.getPath());
	    System.out.println("outputName="+outputName);
	    System.out.println("filePath="+this.filePath);
	    System.out.println("fileName="+this.fileName);
	    
	    List<String> commands = new ArrayList<String>();
	    commands.add(FFMPEG_EXEC_FILE);

	    // 중복된 파일이 존재할 경우 에러 없이 process가 멈추는 현상 발생. 파일명이 중복되지 않는 방향으로 코딩할 것.
        commands.add("-i");
        commands.add(orgFile.getPath());
        commands.add("-progress");
        commands.add(this.filePath + outputFile+"_process.log");
//        commands.add("-b:a 128k");
//        commands.add("-ar 44100");
//        commands.add("-profile:a aac_low");
//        commands.add("-c: v libx264");
        commands.add("-s");
        commands.add("1280x720");
//        commands.add("-crf 26");
//        commands.add("-maxrate 3072000");
//        commands.add("-bufsize 3072000");
//        commands.add("-profile:v baseline");
//        commands.add("-level 3.1");
//        commands.add("-preset superfast");
//        commands.add("-coder 1");
        commands.add("-y");
        commands.add(outFile.getPath());
//        commands.add("2>");
//        commands.add(this.filePath + outputFile+"_log.log");
//        commands.add("&");
//	        // 파일명이 연속으로 나올 경우 연속된 파일명으로 인코딩함. 그러나 각각 인코딩 하는 것보다 속도는 현저하게 느려짐.
//	        commands.add("C:\\download\\converted\\" + outputName + ".ogg");
//	        commands.add("C:\\download\\converted\\" + outputName + ".webm");

        Process p = null;

        try { 
            ProcessBuilder pb = new ProcessBuilder();
            // 에러 스트림을 분리하지않음(stderr > stdout)
            pb.redirectErrorStream(true);
            pb.directory(new File(FFMPEG_PATH));
            pb.command(commands);

            // 프로세스 작업을 실행함.
            p = pb.start();
            
            // 자식 프로세스에서 발생되는 인풋 스트림+에러 스트림(FFMPEG이 콘솔로 보내는 표준출력 및 표준에러) 처리
            exhaustWithScannerInputStream(p.getInputStream());

            // p의 자식 프로세스의 작업(동영상 등 변환 작업)이 완료될 동안 p를 대기시킴
            int exitValue = p.waitFor();  
     
            if (exitValue == 0) {
                if (outFile.length() == 0) {
                    throw new Exception("* 변환된 파일의 사이즈가 0임!");
                }
            }
            else {
                throw new Exception("* 변환 중 에러 발생(Probably FFMPEG option error)!");
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        finally {
            try { if (p != null) p.destroy(); } catch(Exception e) {}
        }
        return outputName;
	}

    /**
     * 
     * @param is
     */
	/**
    private void exhaustInputStream(final InputStream is) {
        // InputStream.read() 에서 블럭 상태에 빠지기 때문에 따로 쓰레드를 구현하여 스트림을 소비한다.
        new Thread() {
            public void run() {
             BufferedReader br = new BufferedReader(new InputStreamReader(is));
             
                try {
                    String stdout = null;
                    System.out.println("=========================================================================================");
                    while ((stdout = br.readLine()) != null) {
                        System.out.println(stdout);
                    }
                    System.out.println("=========================================================================================");
                } 
                catch(IOException ioe) {
                    ioe.printStackTrace();
                }
                finally {
                 try { if (br != null) br.close(); } catch (IOException e) { e.printStackTrace(); }
                }
            }
        }.start();
    }


    /**
     * 
     * @param is
     */
    private void exhaustWithScannerInputStream(final InputStream is) {
        // InputStream.read() 에서 블럭 상태에 빠지기 때문에 따로 쓰레드를 구현하여 스트림을 소비한다.
        new Thread() {
            @SuppressWarnings("resource")
			public void run() {
	            try {
                    Scanner sc = new Scanner(is);

                    // Find duration         
                    Pattern durPattern = Pattern.compile("(?<=Duration: )[^,]*");
                    String dur = sc.findWithinHorizon(durPattern, 0);         

                    if (dur == null) {
                       throw new RuntimeException("Could not parse duration.");
                    }else{
                    	duration= dur;
                        System.out.println("duration="+duration);
        				int index= duration.lastIndexOf(".");
        				duration= duration.substring(0, index);
                    }

                    String[] hms = duration.split(":");
                    
                    double totalSecs = Integer.parseInt(hms[0])*3600 + Integer.parseInt(hms[1])*60 + Double.parseDouble(hms[2]);
                    System.out.println("* Total duration: " + totalSecs + " seconds.");

                    // Find time as long as possible.         
                    Pattern timePattern = Pattern.compile("(?<=time=)[^ ]*");

                    String match = null;
                    double progress = 0.0;
                    while (null != (match = sc.findWithinHorizon(timePattern, 0))) {
	                    String[] times = match.split(":");
	                    progress = (Integer.parseInt(times[0])*3600 + Integer.parseInt(times[1])*60 + Double.parseDouble(times[2]))/totalSecs;           
	                    System.out.printf("* Progress: %.2f%%%n", progress * 100);
                    }
                    rate= (int) Math.round(progress*100);
                    System.out.println("progress rate="+rate);
                    if(rate == 100) {
                    	System.out.println("인코딩 완료");
                    	String[] hhmmss=HanibalWebDev.getSliceTimeArr(duration);
                    	
                    	for(int i=0;i<hhmmss.length;i++) {
                    		
                    	}
                    }
	            }catch (Exception e) {
	            	e.printStackTrace();
	            }
            }

        }.start();
    }

	    public static void main(String[] args) throws Exception {


//	     long startingTime = System.currentTimeMillis();
//	     MediaConverter mc = new MediaConverter();
////	        mc.setFileName("big_rigs.mp4");
////	        mc.setFileName("cuty_cat.mp4");
//	        mc.setFileName("guild_war2_battle.mp4");
//	     mc.setFilePath("C:\\download");
//	     mc.setFileExt("flv");
//	     mc.convert();
//	     long endingTime = System.currentTimeMillis();
//	     
//	     System.out.println("* FFMPEG processing time: " + ((endingTime-startingTime)/1000) + "초.");
	     
//	     long startingTime = System.currentTimeMillis();
//	     MediaConverter mc = new MediaConverter();
//	        mc.setFileName("guild_war2_battle.mp4");
//	     mc.setFilePath("C:\\download");
//	     mc.setFileExt("flv");
//	     mc.convert();
//	     long endingTime = System.currentTimeMillis();
//	     System.out.println("* FFMPEG processing time: " + ((endingTime-startingTime)/1000) + "초.");
//	     
//	     startingTime = System.currentTimeMillis();
//	     mc = new MediaConverter();
//	        mc.setFileName("cuty_cat.mp4");
//	        mc.setFileName("guild_war2_battle.mp4");
//	     mc.setFilePath("C:\\download");
//	     mc.setFileExt("ogg");
//	     mc.convert();
//	     endingTime = System.currentTimeMillis();
//	     System.out.println("* FFMPEG processing time: " + ((endingTime-startingTime)/1000) + "초.");
//	     
//	     startingTime = System.currentTimeMillis();
//	     mc = new MediaConverter();
//	        mc.setFileName("cuty_cat.mp4");
//	        mc.setFileName("guild_war2_battle.mp4");
//	     mc.setFilePath("C:\\download");
//	     mc.setFileExt("webm");
//	     mc.convert();
//	     endingTime = System.currentTimeMillis();
//	     System.out.println("* FFMPEG processing time: " + ((endingTime-startingTime)/1000) + "초.");
	    }
	    
}//class
