package com.icignal.loyalty.promotion.ruleset.dto.response;

/**
 * RuleSet > 조건-기념일 (탭) Response DTO
 * 
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetSdayResponseDTO
 * @date : 2017. 11. 30.
 * @author : jh.kim
 * @description : 
 */
public class LoyRulesetSdayResDto {
    
    private String rid;                //RID
    private String createBy;           //생성자
    private String modifyBy;           //수정자
    private String createDate;         //생성일시
    private String modifyDate;         //수정일시
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
    public String getCreateBy() {
        return createBy;
    }
    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
    public String getModifyBy() {
        return modifyBy;
    }
    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }
    public String getCreateDate() {
        return createDate;
    }
    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
    public String getModifyDate() {
        return modifyDate;
    }
    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
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
