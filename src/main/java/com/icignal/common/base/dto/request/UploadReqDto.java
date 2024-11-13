package com.icignal.common.base.dto.request;

import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;

public class UploadReqDto extends BaseReqDto {
	private String owner;
	private String description;
	private String fileName;
	private String filePath;
	private IMAGE_UPLOAD_TYPE category;
	private String rotateAngle;
	private String realName;
	private String oriName;
	private long size;
	private String flag;
	
	public UploadReqDto() {
		super();
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "UploadRequestDTO [owner=" + owner + ", description="
				+ description + ", filename=" + fileName + ", category="
				+ category + "]";
	}

	public IMAGE_UPLOAD_TYPE getCategory() {
		return category;
	}

	public void setCategory(IMAGE_UPLOAD_TYPE category) {
		this.category = category;
	}

	public String getRotateAngle() {
		return rotateAngle;
	}

	public void setRotateAngle(String rotateAngle) {
		this.rotateAngle = rotateAngle;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getOriName() {
		return oriName;
	}

	public void setOriName(String oriName) {
		this.oriName = oriName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	
}
