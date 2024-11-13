package com.icignal.common.base.dto.request;

import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;

/**
 * @file UploadImageRequestDTO.java
 * @date 2012.10.09
 * @author 김정석
 */
public class UploadImageReqDto extends BaseReqDto {

	private String id;
	private String empId;
	private String oriImageFileName;
	private String imageLang;
	private String type;
	private String imageFileType;
	private String imageFolder;
	private int imageFlag;
	private int seq;
	private IMAGE_UPLOAD_TYPE imageType;
	private String imageFileName;
	private String parentId;
	private String memId;
	private long size;
	private String Description;
	private String multiTableName;
	private String schemas;
	
	public String getOriImageFileName() {
		return oriImageFileName;
	}

	public void setOriImageFileName(String oriImageFileName) {
		this.oriImageFileName = oriImageFileName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {return type;}

	public void setType(String type) {this.type = type;}

	public String getImageFolder() {
		return imageFolder;
	}

	public void setImageFolder(String imageFolder) {
		this.imageFolder = imageFolder;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getParentId() {
		return parentId;
	}

	public int getImageFlag() {
		return imageFlag;
	}

	public void setImageFlag(int imageFlag) {
		this.imageFlag = imageFlag;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getImageFileType() {
		return imageFileType;
	}

	public void setImageFileType(String imageFileType) {
		this.imageFileType = imageFileType;
	}

	public IMAGE_UPLOAD_TYPE getImageType() {
		return imageType;
	}

	public void setImageType(IMAGE_UPLOAD_TYPE imageType) {
		this.imageType = imageType;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getMultiTableName() {
		return multiTableName;
	}

	public void setMultiTableName(String multiTableName) {
		this.multiTableName = multiTableName;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}


	public String getSchemas() {
		if (schemas == null)
			schemas = "beacon";
		return schemas;
	}

	public void setSchemas(String schemas) {
		this.schemas = schemas;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getImageLang() {
		return imageLang;
	}

	public void setImageLang(String imageLang) {
		this.imageLang = imageLang;
	}

}
