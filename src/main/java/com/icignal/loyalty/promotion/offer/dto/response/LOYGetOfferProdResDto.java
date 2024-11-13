package com.icignal.loyalty.promotion.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


public class LOYGetOfferProdResDto extends GridPagingItemResDto {

	private String id;
	
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
	private String createBy; 
	private String createDate;
	
	private Integer cnt;
	
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
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public Integer getCnt() {
		return cnt;
	}
	public void setCnt(Integer cnt) {
		this.cnt = cnt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

}
