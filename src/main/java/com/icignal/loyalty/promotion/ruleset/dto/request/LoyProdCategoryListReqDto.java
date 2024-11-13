package com.icignal.loyalty.promotion.ruleset.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYLoyProdCategoryListRequestDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 상품 카테고리 목록 RequestDTO
 */
public class LoyProdCategoryListReqDto extends CommonDataAuthReqDto {
	
	private String ridBrdCat;		//rid 브랜드 카테고리
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRidBrdCat() {
		return ridBrdCat;
	}

	public void setRidBrdCat(String ridBrdCat) {
		this.ridBrdCat = ridBrdCat;
	}
}
