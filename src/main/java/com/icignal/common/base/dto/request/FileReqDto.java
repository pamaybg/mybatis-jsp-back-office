package com.icignal.common.base.dto.request;

import org.springframework.web.multipart.MultipartFile;

public class FileReqDto extends MKTBaseReqDto {
	
	private String id;				 //아이디
	private String filePath;         //파일경로
	private String fileName;         //파일명
	private String fileType;         //파일유형
	private String fileSize;         //파일크기
	private String oriFileName;      //원본파일명
	private String seq;              //순서
	private String parentId;         //상위아이디
	private String description;      //비고

	private String conid;			 //콘텐츠아이디
	
	private MultipartFile file;		//파일
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getOriFileName() {
		return oriFileName;
	}

	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getConid() {
		return conid;
	}

	public void setConid(String conid) {
		this.conid = conid;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
		
}
