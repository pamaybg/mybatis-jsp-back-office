package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyTransDetailReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String cipherKey;;
	
	public LoyTransDetailReqDto(){
//		try {
//		    this.setCipherKey(CryptoManager.getCipherKey());
//		}catch(Exception e){
//			LogUtil.error(e);
//		}
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
