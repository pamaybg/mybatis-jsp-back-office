package com.icignal.loyalty.product.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyEditProdListReqDto extends CommonDataAuthReqDto {
	
	private String rid;     			//RID
	private String ridPgm; 
	private String ridBrdCat; 
	private String brdNm; 
	private String ridProdCat; 
	private String catNm; 
	private String ridChnl; 
	private String chnlNm; 
	private String prodId; 
	private String prodNm; 
	private Integer prodAmt;
	private String  prodType;
	private String prodColor;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getRidBrdCat() {
		return ridBrdCat;
	}
	public void setRidBrdCat(String ridBrdCat) {
		this.ridBrdCat = ridBrdCat;
	}
	public String getBrdNm() {
		return brdNm;
	}
	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}
	public String getRidProdCat() {
		return ridProdCat;
	}
	public void setRidProdCat(String ridProdCat) {
		this.ridProdCat = ridProdCat;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
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
	public Integer getProdAmt() {
		return prodAmt;
	}
	public void setProdAmt(Integer prodAmt) {
		this.prodAmt = prodAmt;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public String getProdColor() {
		return prodColor;
	}
	public void setProdColor(String prodColor) {
		this.prodColor = prodColor;
	}
	
	
}