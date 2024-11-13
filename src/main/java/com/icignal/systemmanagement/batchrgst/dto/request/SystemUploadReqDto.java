package com.icignal.systemmanagement.batchrgst.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemUploadReqDto extends CommonCondReqDto{
	private String ctg;  //카테고리
	private String attr; 
	private String attrVal; 
	private String createBy; 
	private String createDate; 
    private String modifyDate;
    private String modifyBy;
	
	private String rid;
	private String ridLang;

	
	
	private String uploadValidCheck;
	private String fileName;
	private List<SystemUploadReqDto> array;
	private int cnt;
	private boolean message;
	public String getCtg() {
		return ctg;
	}
	public void setCtg(String ctg) {
		this.ctg = ctg;
	}

	public String getAttrVal() {
		return attrVal;
	}
	public void setAttrVal(String attrVal) {
		this.attrVal = attrVal;
	}
	
	
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public boolean isMessage() {
		return message;
	}
	public void setMessage(boolean message) {
		this.message = message;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getAttr() {
		return attr;
	}
	public void setAttr(String attr) {
		this.attr = attr;
	}
	public String getRidLang() {
		return ridLang;
	}
	public void setRidLang(String ridLang) {
		this.ridLang = ridLang;
	}
	/**
	 * @return the createBy
	 */
	public String getCreateBy() {
		return createBy;
	}
	/**
	 * @param createBy the createBy to set
	 */
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	/**
	 * @return the array
	 */
	public List<SystemUploadReqDto> getArray() {
		return array;
	}
	/**
	 * @param array the array to set
	 */
	public void setArray(List<SystemUploadReqDto> array) {
		this.array = array;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}


	
}
