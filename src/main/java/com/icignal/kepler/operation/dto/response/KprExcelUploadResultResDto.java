package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprExcelUploadResultResDto extends StatusResDto {
	
	private int allCnt;
	private int okCnt;
	private int noCnt;
	private String fileNm;
	private String id;
	private String accntId;
	private String createBy;
	private String createDate;
	private String uploadTime;
	private String createByName;
	
	
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	public int getAllCnt() {
		return allCnt;
	}
	public void setAllCnt(int allCnt) {
		this.allCnt = allCnt;
	}
	public int getOkCnt() {
		return okCnt;
	}
	public void setOkCnt(int okCnt) {
		this.okCnt = okCnt;
	}
	public int getNoCnt() {
		return noCnt;
	}
	public void setNoCnt(int noCnt) {
		this.noCnt = noCnt;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}
	
}