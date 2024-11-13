package com.icignal.loyalty.promotion.ruleset.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : LOYLoyProdCategoryListResponseDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 상품 카테고리 목록 ResponseDTO
 */
public class LoyProdCategoryListResDto extends GridPagingItemResDto {
	private String rid;              //RID
	private String ridPgm;           //RID 프로그램
	private String catId;            //범주 ID
	private String catNm;            //범주 명
	private String parRid;           //PAR_RID
	private String catDesctxt;       //범주 설명
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

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
