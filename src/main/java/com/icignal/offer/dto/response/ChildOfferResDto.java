package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class ChildOfferResDto extends GridPagingItemResDto {
	
	// 시스템
	private String rid;

	// 릴레이션
	private String ridOfr;
	private String ofrNo;
	private String ofrNm;
	private int ofrValAmt;
	
	// 기본 필드
	private int minAmt;
	private int maxAmt;
	private int clickAmt;
	private String reqYn;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getReqYn() {
		return reqYn;
	}
	public void setReqYn(String reqYn) {
		this.reqYn = reqYn;
	}
	public int getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(int ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
	}
	public int getMinAmt() {
		return minAmt;
	}
	public void setMinAmt(int minAmt) {
		this.minAmt = minAmt;
	}
	public int getMaxAmt() {
		return maxAmt;
	}
	public void setMaxAmt(int maxAmt) {
		this.maxAmt = maxAmt;
	}
	public int getClickAmt() {
		return clickAmt;
	}
	public void setClickAmt(int clickAmt) {
		this.clickAmt = clickAmt;
	}

}
