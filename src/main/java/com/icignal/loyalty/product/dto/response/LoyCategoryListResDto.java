package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyCategoryListResDto extends GridPagingItemResDto{
	private String rid;
	private String ridPgm;
	private String parRid;
	private String parCatId;
	private String parCatNm;
	private String catId;
	private String catNm;
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
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getParCatId() {
		return parCatId;
	}
	public void setParCatId(String parCatId) {
		this.parCatId = parCatId;
	}
	public String getParCatNm() {
		return parCatNm;
	}
	public void setParCatNm(String parCatNm) {
		this.parCatNm = parCatNm;
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
	public String getCatDesctxt() {
		return catDesctxt;
	}
	public void setCatDesctxt(String catDesctxt) {
		this.catDesctxt = catDesctxt;
	}

}
