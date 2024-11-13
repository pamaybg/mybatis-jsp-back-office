package com.icignal.loyalty.promotion.ruleset.dto.response;

/**
 * RuleSet > 조건-고객정보 (탭) Response DTO
 * 
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetMbrResponseDTO
 * @date : 2017. 11. 30.
 * @author : jh.kim
 * @description : 
 */
public class LoyRulesetMbrResDto {
    
    private String rid;                  //RID
    private String createBy;             //생성자
    private String modifyBy;             //수정자
    private String createDate;           //생성일시
    private String modifyDate;           //수정일시
    private String rulesetId;            //룰셋헤더ID
    private String custTypeCd;           //고객유형코드
    private String custGradeCd;          //고객등급코드
    private String sexCd;                //성별코드
    private String vipDivCd;             //VIP구분코드
    private String totAvlPoint;          //총 가용포인트
    private String avlpntComprOptrCd;    //비교연산자코드
    
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
    public String getCustTypeCd() {
        return custTypeCd;
    }
    public void setCustTypeCd(String custTypeCd) {
        this.custTypeCd = custTypeCd;
    }
    public String getCustGradeCd() {
        return custGradeCd;
    }
    public void setCustGradeCd(String custGradeCd) {
        this.custGradeCd = custGradeCd;
    }
    public String getSexCd() {
        return sexCd;
    }
    public void setSexCd(String sexCd) {
        this.sexCd = sexCd;
    }
    public String getVipDivCd() {
        return vipDivCd;
    }
    public void setVipDivCd(String vipDivCd) {
        this.vipDivCd = vipDivCd;
    }
    public String getTotAvlPoint() {
        return totAvlPoint;
    }
    public void setTotAvlPoint(String totAvlPoint) {
        this.totAvlPoint = totAvlPoint;
    }
    public String getAvlpntComprOptrCd() {
        return avlpntComprOptrCd;
    }
    public void setAvlpntComprOptrCd(String avlpntComprOptrCd) {
        this.avlpntComprOptrCd = avlpntComprOptrCd;
    }
    
}
