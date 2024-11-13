package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyTransPntItemListReqDto extends CommonDataAuthReqDto {
	
	private String pntTxnRid;
	private String prodNm;
	private String prodQty;
	private String prodPnt;
	
	
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getProdQty() {
		return prodQty;
	}
	public void setProdQty(String prodQty) {
		this.prodQty = prodQty;
	}
	public String getProdPnt() {
		return prodPnt;
	}
	public void setProdPnt(String prodPnt) {
		this.prodPnt = prodPnt;
	}
	public String getPntTxnRid() {
		return pntTxnRid;
	}
	public void setPntTxnRid(String pntTxnRid) {
		this.pntTxnRid = pntTxnRid;
	}
	
	
	
}
