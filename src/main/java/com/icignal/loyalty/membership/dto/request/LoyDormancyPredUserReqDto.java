package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyDormancyPredUserReqDto extends CommonDataAuthReqDto{
	private String custNm;
	private String rid;
	private String dorTerm ;


	public String getDorTerm() {
		return dorTerm;
	}
	public void setDorTerm(String dorTerm) {
		this.dorTerm = dorTerm;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}


}
