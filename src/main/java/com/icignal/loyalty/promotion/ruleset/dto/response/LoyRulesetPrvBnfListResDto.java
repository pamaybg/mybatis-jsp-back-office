package com.icignal.loyalty.promotion.ruleset.dto.response;

/**
 * RuleSet > 제공 혜택수량 (탭) 목록 Response DTO
 * 
 * @name : infavor.loyalty.ruleSet.dto.response.LoyRulesetPrvBnfListResponseDTO
 * @date : 2017. 11. 30.
 * @author : jh.kim
 * @description : 
 */
public class LoyRulesetPrvBnfListResDto {
    
    private String rid;              //RID
    private String createBy;         //생성자
    private String modifyBy;         //수정자
    private String createDate;       //생성일시
    private String modifyDate;       //수정일시
    private String rulesetId;        //룰셋헤더ID
    private String minMat;           //최소금액
    private String maxAmt;           //최대금액
    private String acrlType;         //적립유형
    private String acrlTypeNm;       //적립유형
    private String acrlAmt;          //적립금액
    
    public String getAcrlTypeNm() {
        return acrlTypeNm;
    }
    public void setAcrlTypeNm(String acrlTypeNm) {
        this.acrlTypeNm = acrlTypeNm;
    }
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
    public String getMinMat() {
        return minMat;
    }
    public void setMinMat(String minMat) {
        this.minMat = minMat;
    }
    public String getMaxAmt() {
        return maxAmt;
    }
    public void setMaxAmt(String maxAmt) {
        this.maxAmt = maxAmt;
    }
    public String getAcrlType() {
        return acrlType;
    }
    public void setAcrlType(String acrlType) {
        this.acrlType = acrlType;
    }
    public String getAcrlAmt() {
        return acrlAmt;
    }
    public void setAcrlAmt(String acrlAmt) {
        this.acrlAmt = acrlAmt;
    }
    
}
