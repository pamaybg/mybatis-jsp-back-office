package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrPointDropReqDto extends CommonDataAuthReqDto{
	private String custNm;
	private String rid;
	private String reqData;
	private String years;


	public String getReqData() {
		return reqData;
	}

	public void setReqData(String reqData) {
		this.reqData = reqData;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public String getYears() {
		return years;
	}

	public void setYears(String years) {
		this.years = years;
	}


}
