package com.icignal.marketing.contents.dto.response;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MKTSyncFileUploadResponseDTO
 * @date : 2015. 12. 07.
 * @author : 박지열
 */ 
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktSyncFileUploadResDto extends GridPagingItemResDto{
	private List<MktFileUploadResDto> files;
	private String Detail;
	
	public List<MktFileUploadResDto> getFiles() {
		return files;
	}
	public void setFiles(List<MktFileUploadResDto> files) {
		this.files = files;
	}
	public String getDetail() {
		return Detail;
	}
	public void setDetail(String detail) {
		Detail = detail;
	}
	
	
}
