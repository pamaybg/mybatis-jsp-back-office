package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrGroupClubListResDto extends GridPagingItemResDto{

	private String mbrNo;
	private String custNm  ;
	private String regDt    ;
	private String delDt    ;
	private String activeFlg;
	private String ridCust  ;
	private String ridMbr;
	private String ridChnl;
	private String rid;


	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getDelDt() {
		return delDt;
	}
	public void setDelDt(String delDt) {
		this.delDt = delDt;
	}
	public String getActiveFlg() {
		return activeFlg;
	}
	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	/**
	* @return the custNm
	*/
	public String getCustNm() {
		return custNm;
	}
	/**
	* @param custNm the custNm to set
	*/
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	/**
	* @return the ridMbr
	*/
	public String getRidMbr() {
		return ridMbr;
	}
	/**
	* @param ridMbr the ridMbr to set
	*/
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	/**
	* @return the ridChnl
	*/
	public String getRidChnl() {
		return ridChnl;
	}
	/**
	* @param ridChnl the ridChnl to set
	*/
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	/**
	* @return the rid
	*/
	public String getRid() {
		return rid;
	}
	/**
	* @param rid the rid to set
	*/
	public void setRid(String rid) {
		this.rid = rid;
	}



}
