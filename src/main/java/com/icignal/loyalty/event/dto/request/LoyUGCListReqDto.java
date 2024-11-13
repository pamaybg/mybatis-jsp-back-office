package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyUGCListReqDto extends CommonDataAuthReqDto {
	private String ridMbr;
	private String rid;

    private String cipherKey;

	
	/*public LoyUGCListReqDto() {
        try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }
    }*/
	
	
	

	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
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
