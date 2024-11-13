package com.icignal.loyalty.stamp.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpItemDetailRequestDTO
* @date : 2019. 3. 5.
* @author : hy.jun
* @description :
*/
public class LoyStmpItemDetailReqDto extends MKTBaseReqDto {
	private String rid;
	private String ridStmp;
	private int itemNo;
	private int stmpAmt;
	private int stmpCnt;
	private String camNo;
	private String regDt;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public int getStmpAmt() {
		return stmpAmt;
	}
	public void setStmpAmt(int stmpAmt) {
		this.stmpAmt = stmpAmt;
	}
	public int getStmpCnt() {
		return stmpCnt;
	}
	public void setStmpCnt(int stmpCnt) {
		this.stmpCnt = stmpCnt;
	}
	public String getCamNo() {
		return camNo;
	}
	public void setCamNo(String camNo) {
		this.camNo = camNo;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
}
