package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprSetUploadResultReqDto extends StatusResDto {

	private String accntId;
	private String id;
	private String createBy;
	private String fileNm;
	private Integer allCnt;
	private Integer okCnt;
	private Integer noCnt;
	private String uploadTime;
	private String uploadStartTime;
	private String uploadEndTime;
	private String tableType;
	private String tblNm;
	
	public String getTblNm() {
		return tblNm;
	}
	public void setTblNm(String tblNm) {
		this.tblNm = tblNm;
	}
	public String getTableType() {
		return tableType;
	}
	public void setTableType(String tableType) {
		this.tableType = tableType;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public Integer getAllCnt() {
		return allCnt;
	}
	public void setAllCnt(Integer allCnt) {
		this.allCnt = allCnt;
	}
	public Integer getOkCnt() {
		return okCnt;
	}
	public void setOkCnt(Integer okCnt) {
		this.okCnt = okCnt;
	}
	public Integer getNoCnt() {
		return noCnt;
	}
	public void setNoCnt(Integer noCnt) {
		this.noCnt = noCnt;
	}
	public String getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getUploadStartTime() {
		return uploadStartTime;
	}
	public void setUploadStartTime(String uploadStartTime) {
		this.uploadStartTime = uploadStartTime;
	}
	public String getUploadEndTime() {
		return uploadEndTime;
	}
	public void setUploadEndTime(String uploadEndTime) {
		this.uploadEndTime = uploadEndTime;
	}
}
