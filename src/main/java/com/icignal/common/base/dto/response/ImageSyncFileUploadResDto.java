package com.icignal.common.base.dto.response;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @name : ImageSyncFileUploadResponseDTO
 * @date : 2018. 09. 11.
 * @author : 금동우
 */ 
@JsonIgnoreProperties(ignoreUnknown = true)
public class ImageSyncFileUploadResDto extends GridPagingItemResDto{
	
	private List<ImageFileUploadResDto> files;
	private String Detail;
	private String imgPath;
	
	public List<ImageFileUploadResDto> getFiles() {
		return files;
	}
	public void setFiles(List<ImageFileUploadResDto> files) {
		this.files = files;
	}
	public String getDetail() {
		return Detail;
	}
	public void setDetail(String detail) {
		Detail = detail;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	
}
