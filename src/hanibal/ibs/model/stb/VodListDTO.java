package hanibal.ibs.model.stb;

public class VodListDTO {
	int id;
	int board_id;
	String title;
	String menu;
	String thumbnail_path; 
	String video_path;
	String register_dt;
	String vod_play_time;
   	String resolution;
   	String bitrate;
   	String video_codec;
   	String audio_codec;
   	String vod_content;
   	
   	int hit;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getThumbnail_path() {
		return thumbnail_path;
	}
	public void setThumbnail_path(String thumbnail_path) {
		this.thumbnail_path = thumbnail_path;
	}
	public String getVideo_path() {
		return video_path;
	}
	public void setVideo_path(String video_path) {
		this.video_path = video_path;
	}
	public String getRegister_dt() {
		return register_dt;
	}
	public void setRegister_dt(String register_dt) {
		this.register_dt = register_dt;
	}
	public String getVod_play_time() {
		return vod_play_time;
	}
	public void setVod_play_time(String vod_play_time) {
		this.vod_play_time = vod_play_time;
	}
	public String getResolution() {
		return resolution;
	}
	public void setResolution(String resolution) {
		this.resolution = resolution;
	}
	public String getBitrate() {
		return bitrate;
	}
	public void setBitrate(String bitrate) {
		this.bitrate = bitrate;
	}
	public String getVideo_codec() {
		return video_codec;
	}
	public void setVideo_codec(String video_codec) {
		this.video_codec = video_codec;
	}
	public String getAudio_codec() {
		return audio_codec;
	}
	public void setAudio_codec(String audio_codec) {
		this.audio_codec = audio_codec;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getVod_content() {
		return vod_content;
	}
	public void setVod_content(String vod_content) {
		this.vod_content = vod_content;
	}
	
   	
   	
}
