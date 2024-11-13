package com.icignal.loyalty.promotion.ruleset.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYLoyTierListRequestDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 등급 목록 RequestDTO
 */
public class LoyTierListReqDto extends CommonDataAuthReqDto {
	
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
