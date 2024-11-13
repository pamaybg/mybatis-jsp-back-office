package com.icignal.loyalty.stamp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.loyalty.stamp.dto.response.LOYStmpItemListResponseDTO
* @date : 2019. 3. 5.
* @author : hy.jun
* @description :
*/
public class LoyStmpItemListResDto extends GridPagingItemResDto {
	
	private static final long serialVersionUID = -1235298513588360077L;
	
	private String rid;
	private String ridStmp;
	private int itemNo;
	private int stmpAmt;
	private int stmpCnt;
	private String camNo;
	private String camNm;
	private String regDt;
	
	private String camStartDd;
	private String camEndDd;
	private String camStatusCd;
	
	private String itemBnftNm;
	
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
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamStartDd() {
		return camStartDd;
	}
	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}
	public String getCamEndDd() {
		return camEndDd;
	}
	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}
	public String getCamStatusCd() {
		return camStatusCd;
	}
	public void setCamStatusCd(String camStatusCd) {
		this.camStatusCd = camStatusCd;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getItemBnftNm() {
		return itemBnftNm;
	}
	public void setItemBnftNm(String itemBnftNm) {
		this.itemBnftNm = itemBnftNm;
	}
}
