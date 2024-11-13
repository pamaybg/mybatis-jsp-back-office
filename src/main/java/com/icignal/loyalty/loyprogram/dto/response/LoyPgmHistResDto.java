package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyPgmHistResDto extends GridPagingItemResDto {
  
	private String chgCol;
	private String chgCate;
	private String chgBfVal;       
	private String chgAfVal;       

	// 코드
	private String histType;
	@MarkName(groupCode = "LOG_PGM_CHG_TYPE_CD", codeField = "histType")
	private String histTypeNm;
  
	// 릴레이션
	private String pgmRid;  
	
	// 시스템
	private String rid;
	private String modifyDate;       
	private String modifyBy;
	
	public String getChgCol() {
		return chgCol;
	}
	public void setChgCol(String chgCol) {
		this.chgCol = chgCol;
	}
	public String getChgCate() {
		return chgCate;
	}
	public void setChgCate(String chgCate) {
		this.chgCate = chgCate;
	}
	public String getChgBfVal() {
		return chgBfVal;
	}
	public void setChgBfVal(String chgBfVal) {
		this.chgBfVal = chgBfVal;
	}
	public String getChgAfVal() {
		return chgAfVal;
	}
	public void setChgAfVal(String chgAfVal) {
		this.chgAfVal = chgAfVal;
	}

	public String getHistType() {
		return histType;
	}
	public void setHistType(String histType) {
		this.histType = histType;
	}
	public String getHistTypeNm() {
		return histTypeNm;
	}
	public void setHistTypeNm(String histTypeNm) {
		this.histTypeNm = histTypeNm;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

}
