package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyProdListResDto extends GridPagingItemResDto{
	private String rid;
	private String prodId;
	private String prodNm;
	private String prodAmt;
	private String brdId;
	private String brdNm;
	private String catId;
	private String catNm;
	private String chnlId;
	private String chnlNm;
	private String prodType;
	private String cnt;
	private String baseYmd;
	private String color;
	private String prodColor;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getProdAmt() {
		return prodAmt;
	}
	public void setProdAmt(String prodAmt) {
		this.prodAmt = prodAmt;
	}
	public String getBrdId() {
		return brdId;
	}
	public void setBrdId(String brdId) {
		this.brdId = brdId;
	}
	public String getBrdNm() {
		return brdNm;
	}
	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}
	public String getCatId() {
		return catId;
	}
	public void setCatId(String catId) {
		this.catId = catId;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getBaseYmd() {
		return baseYmd;
	}
	public void setBaseYmd(String baseYmd) {
		this.baseYmd = baseYmd;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getProdColor() {
		return prodColor;
	}
	public void setProdColor(String prodColor) {
		this.prodColor = prodColor;
	}

}
