package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyStoreListReqDto extends CommonDataAuthReqDto {

	private String startDt;
	
	private String endDt;
	
	private String storeNm;
	
	private String chnlNm;
	
	private String cipherKey;
	
	private String rid;
	
	private String shopType;
	
	public String getStartDt() {
		return startDt;
	}
	
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	
	public String getStoreNm() {
		return storeNm;
	}

	public void setStoreNm(String storeNm) {
		this.storeNm = storeNm;
	}

	public String getEndDt() {
		return endDt;
	}
	
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}	
	
	/*public LoyStoreListReqDto() {
        try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }
    }*/
	
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

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getShopType() {
		return shopType;
	}

	public void setShopType(String shopType) {
		this.shopType = shopType;
	}
	
}
