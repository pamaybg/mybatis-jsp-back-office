package com.icignal.loyalty.product.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyEditCategoryListReqDto extends CommonDataAuthReqDto {
	
	private String rid;     			//RID
	private String ridPgm; 
	private String catId; 
	private String catNm; 
	private String parRid; 
	private String catDesctxt;
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
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getCatDesctxt() {
		return catDesctxt;
	}
	public void setCatDesctxt(String catDesctxt) {
		this.catDesctxt = catDesctxt;
	} 
	
	
}