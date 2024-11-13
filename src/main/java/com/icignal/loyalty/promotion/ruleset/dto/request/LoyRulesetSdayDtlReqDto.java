package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyRulesetSdayDtlReqDto extends CommonDataAuthReqDto {
    
    private String rid;                //RID
    private String rulesetId;          //룰셋헤더ID
    private String cmrtnTypeCd;        //기념일유형코드
    private String sdayComprOptrCd;    //비교연산자코드
    private String dealDd;             //거래일자
    
    public String getRid() {
        return rid;
    }
    public void setRid(String rid) {
        this.rid = rid;
    }
    public String getRulesetId() {
        return rulesetId;
    }
    public void setRulesetId(String rulesetId) {
        this.rulesetId = rulesetId;
    }
    public String getCmrtnTypeCd() {
        return cmrtnTypeCd;
    }
    public void setCmrtnTypeCd(String cmrtnTypeCd) {
        this.cmrtnTypeCd = cmrtnTypeCd;
    }
    public String getSdayComprOptrCd() {
        return sdayComprOptrCd;
    }
    public void setSdayComprOptrCd(String sdayComprOptrCd) {
        this.sdayComprOptrCd = sdayComprOptrCd;
    }
    public String getDealDd() {
        return dealDd;
    }
    public void setDealDd(String dealDd) {
        this.dealDd = dealDd;
    }
}
