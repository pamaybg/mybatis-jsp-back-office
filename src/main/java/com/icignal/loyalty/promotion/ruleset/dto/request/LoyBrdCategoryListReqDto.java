package com.icignal.loyalty.promotion.ruleset.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYLoyBrdCategoryListRequestDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 브랜드 카테고리 목록 RequestDTO
 */
public class LoyBrdCategoryListReqDto extends CommonDataAuthReqDto {
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
