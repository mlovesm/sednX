package hanibal.ibs.model.webapi;

import org.springframework.web.multipart.MultipartFile;

public class UploadFile {
	private MultipartFile uploadFile;

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	
}
