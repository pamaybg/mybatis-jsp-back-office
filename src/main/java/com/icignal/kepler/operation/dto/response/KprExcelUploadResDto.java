package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprExcelUploadResDto extends StatusResDto {
	
	private int allCnt;
	private int successCnt;
	private int failCnt;
	private String errorMessage;
	private String fileName;
	private String creatNm;
	private String time;
	private String updateDt;
	private List<String> fvId;
	private String id;
	
	public KprExcelUploadResDto(){
		this.successCnt = 0;
		this.failCnt = 0;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<String> getFvId() {
		return fvId;
	}
	public void setFvId(List<String> fvId) {
		this.fvId = fvId;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public int getAllCnt() {
		return allCnt;
	}
	public void setAllCnt(int allCnt) {
		this.allCnt = allCnt;
	}
	public int getSuccessCnt() {
		return successCnt;
	}
	public void setSuccessCnt(int successCnt) {
		this.successCnt = successCnt;
	}
	public int getFailCnt() {
		return failCnt;
	}
	public void setFailCnt(int failCnt) {
		this.failCnt = failCnt;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreatNm() {
		return creatNm;
	}
	public void setCreatNm(String creatNm) {
		this.creatNm = creatNm;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getUpdateDt() {
		return updateDt;
	}
	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}
	
	
}