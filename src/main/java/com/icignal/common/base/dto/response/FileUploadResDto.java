package com.icignal.common.base.dto.response;


/**
 * @name : infavor.base.dto.response.MKTFileUploadResponseDTO
 * @date : 2017. 6. 28.
 * @author : "dg.ryu"
 * @description : 파일업로드
 */
public class FileUploadResDto extends StatusResDto{
	private String id;				//아이디
	private String fileName;		//파일명
	private String oriFileName;		//원본파일명
	private String filePath;		//파일경로
	private long fileSize;			//파일크기
	private String fileType;		//파일유형
	
	public FileUploadResDto(String id, String fileName, String oriFileName, String filePath, long fileSize, String fileType) {
		super();
		this.setId(id);
		this.setFileName(fileName);
		this.setOriFileName(oriFileName);
		this.setFilePath(filePath);
		this.setFileSize(fileSize);
		this.setFileType(fileType);
	}

	public FileUploadResDto() {
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOriFileName() {
		return oriFileName;
	}

	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}


	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}


