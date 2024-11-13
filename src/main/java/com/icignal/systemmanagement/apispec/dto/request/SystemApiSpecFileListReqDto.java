package com.icignal.systemmanagement.apispec.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class SystemApiSpecFileListReqDto extends CommonDataAuthReqDto{

	private String apiUpRid;
	private String rid;
	private String uploadValidCheck;
	private String fileNm;
	private String filePath;
	private String createDate;

	public String getApiUpRid() {
		return apiUpRid;
	}

	public void setApiUpRid(String apiUpRid) {
		this.apiUpRid = apiUpRid;
	}

	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	private List<SystemApiSpecFileListReqDto> array;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
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
	public List<SystemApiSpecFileListReqDto> getArray() {
		return array;
	}
	public void setArray(List<SystemApiSpecFileListReqDto> array) {
		this.array = array;
	}
	
	
	
	
}
