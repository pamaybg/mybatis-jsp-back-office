package com.icignal.loyalty.loyprogram.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyPgmHistReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String pgmRid;
	private String histType;
	private String chgCol;
	private String chgCate;
	private String chgBfVal;
	private String chgAfVal;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getHistType() {
		return histType;
	}
	public void setHistType(String histType) {
		this.histType = histType;
	}
	public String getChgCate() {
		return chgCate;
	}
	public void setChgCate(String chgCate) {
		this.chgCate = chgCate;
	}
	public String getChgCol() {
		return chgCol;
	}
	public void setChgCol(String chgCol) {
		this.chgCol = chgCol;
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

}
