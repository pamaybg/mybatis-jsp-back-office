package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 룰셋 > 기념일 (탭) 목록 조회 Request DTO
 * 
 * @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetSdayRequestDTO
 * @date : 2017. 12. 1.
 * @author : jh.kim
 * @description : 
 */
public class LoyRulesetSdayReqDto extends CommonDataAuthReqDto {
    
    private String id;
    private String rulesetId;
    
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getRulesetId() {
        return rulesetId;
    }
    public void setRulesetId(String rulesetId) {
        this.rulesetId = rulesetId;
    }
    
}
