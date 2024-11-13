package com.icignal.common.base.dto.response;


import com.icignal.common.util.CommonUtil;

/**
 * @name : ImageFileUploadResponseDTO 
 * @date : 2018. 09. 11.
 * @author : 금동우
 */ 
public class ImageFileUploadResDto extends GridPagingItemResDto{
	
	
	private String fileId;
	private String fileURL;
	private String type;
	private String fileType;
	private String imgSize;
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
	private String imgPath;
	
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
	public String getImgSize() {
		return imgSize;
	}
	public void setImgSize(String imgSize) {
		this.imgSize = imgSize;
	}
	public boolean isFile() {
		return isFile;
	}
	public void setFile(boolean isFile) {
		this.isFile = isFile;
	}
	public String getImgPath() {
		imgPath = CommonUtil.getInstance().getServletProp("context.imageServerUrl");
		return imgPath;
	}
	public void setImgPath() {
		this.imgPath = CommonUtil.getInstance().getServletProp("context.imageServerUrl");
	}
	
}
