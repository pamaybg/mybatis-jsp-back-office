package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyDormancyReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String custNm;
	private String cipherKey;


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

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}


}
