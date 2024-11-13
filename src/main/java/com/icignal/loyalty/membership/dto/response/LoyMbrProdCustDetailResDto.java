package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyMbrProdCustDetailResDto extends StatusResDto {
	private String srcProdId; // 아이템코드
	private String prodId;
	private String content;
	
	private String purChnl;  // 구입채널
	private String prodNo;   // 자재코드
	private String goodsCode;
	
	
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getSrcProdId() {
		return srcProdId;
	}
	public void setSrcProdId(String srcProdId) {
		this.srcProdId = srcProdId;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	
	public String getPurChnl() {
		return purChnl;
	}
	public void setPurChnl(String purChnl) {
		this.purChnl = purChnl;
	}
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}	
	
	
}
