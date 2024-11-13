package com.icignal.systemmanagement.apispec.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemApiSpecFileListResDto extends GridPagingItemResDto{
	
	private String rid;
	private String fileNm;
	private String filePath;
	private String createDate;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
}
