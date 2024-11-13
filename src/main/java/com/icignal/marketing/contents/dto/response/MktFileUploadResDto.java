package com.icignal.marketing.contents.dto.response;

/**
 * @name : AccountFileUploadResponseDTO 
 * @date : 2015. 05. 07.
 * @author : 홍성호
 */ 
public class MktFileUploadResDto {
	private String fileId;
	private String fileURL;
	private String type;
	private String fileType;
	private String size;
	private String createDate;
	private String description;
	private String fileName;
	private String dateModified;
	private boolean hasChild;
	private boolean isFile;
	private String name;
	private String id;
	private String memId;
	private String oriName;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getFileURL() {
		return fileURL;
	}
	public void setFileURL(String fileURL) {
		this.fileURL = fileURL;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDateModified() {
		return dateModified;
	}
	public void setDateModified(String dateModified) {
		this.dateModified = dateModified;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public boolean isHasChild() {
		return hasChild;
	}
	public void setHasChild(boolean hasChild) {
		this.hasChild = hasChild;
	}
	public boolean getisFile() {
		return isFile;
	}
	public void setisFile(boolean isFile) {
		this.isFile = isFile;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}

	

	
	
	
}
