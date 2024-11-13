package com.icignal.loyalty.promotion.ruleset.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYLoyProdListRequestDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 상품 목록 RequestDTO
 */
public class LoyProdListReqDto extends CommonDataAuthReqDto {
	
	private String ridBrdCat;		//rid 브랜드 카테고리
	private String ridProdCat;		//rid 카테고리
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRidBrdCat() {
		return ridBrdCat;
	}

	public void setRidBrdCat(String ridBrdCat) {
		this.ridBrdCat = ridBrdCat;
	}

	public String getRidProdCat() {
		return ridProdCat;
	}

	public void setRidProdCat(String ridProdCat) {
		this.ridProdCat = ridProdCat;
	}
}
