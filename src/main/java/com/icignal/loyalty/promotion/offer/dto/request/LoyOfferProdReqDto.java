package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyOfferProdReqDto extends CommonDataAuthReqDto {
	
	private String id;
	private String rid;
	private String memId;
	private String offerid;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getOfferid() {
		return offerid;
	}
	public void setOfferid(String offerid) {
		this.offerid = offerid;
	}
	
}
