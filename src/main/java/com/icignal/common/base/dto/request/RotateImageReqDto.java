package com.icignal.common.base.dto.request;

/**
 @file RotateImageRequestDTO.java
 @date 2013.04.01
 @author 김정석
 */
public class RotateImageReqDto extends BaseReqDto {
	private String filePath;
	private Boolean isUploadFile;
	private Boolean isRight;

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Boolean getIsUploadFile() {
		return isUploadFile;
	}

	public void setIsUploadFile(Boolean isUploadFile) {
		this.isUploadFile = isUploadFile;
	}

	public Boolean getIsRight() {
		return isRight;
	}

	public void setIsRight(Boolean isRight) {
		this.isRight = isRight;
	}
	
}
