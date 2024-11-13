package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyDupMbrReqDto extends CommonDataAuthReqDto{
	private String cipherKey;
	private String rid;

	public LoyDupMbrReqDto() throws Exception {
//		cipherKey = CryptoManager.getCipherKey();
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
