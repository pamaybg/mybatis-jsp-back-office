package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyCustBranchResDto extends GridPagingItemResDto {

	// 기본 필드
	private String createDate;
	private String rid;
	private String brNo;
	private String brNm;
	private String charger;
	private String telNo;

	// 릴레이션
	private String ridChnl;
	private String chnlNm;
	private String chnlNo;

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

	public String getBrNo() {
		return brNo;
	}

	public void setBrNo(String brNo) {
		this.brNo = brNo;
	}

	public String getBrNm() {
		return brNm;
	}

	public void setBrNm(String brNm) {
		this.brNm = brNm;
	}

	public String getCharger() {
		return charger;
	}

	public void setCharger(String charger) {
		this.charger = charger;
	}

	public String getTelNo() {
		return telNo;
	}

	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
}
