package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyCustBnftResDto extends GridPagingItemResDto {

	// 기본 필드
	private String createDate;
	private String rid;
	private String startDate;
	private String endDate;
	private String qty;

	// 릴레이션
	private String ridOfr;
	private String OfrNm;
	private String OfrNo;

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getRidOfr() {
		return ridOfr;
	}

	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}

	public String getOfrNm() {
		return OfrNm;
	}

	public void setOfrNm(String ofrNm) {
		OfrNm = ofrNm;
	}

	public String getOfrNo() {
		return OfrNo;
	}

	public void setOfrNo(String ofrNo) {
		OfrNo = ofrNo;
	}
}
