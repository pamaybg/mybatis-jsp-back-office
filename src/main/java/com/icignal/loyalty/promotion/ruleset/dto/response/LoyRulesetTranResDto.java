package com.icignal.loyalty.promotion.ruleset.dto.response;

/**
 * RuleSet > 조건-거래정보 (탭) Response DTO
 * 
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetTranResponseDTO
 * @date : 2017. 11. 30.
 * @author : jh.kim
 * @description : 
 */
public class LoyRulesetTranResDto {
    
    private String rid;                  //RID
    private String createBy;             //생성자
    private String modifyBy;             //수정자
    private String createDate;           //생성일시
    private String modifyDate;           //수정일시
    private String rulesetId;            //룰셋헤더ID
    private String chargAmt;             //충전금액
    private String chargComprOptrCd;     //충전금액비교연산자코드
    private String dealDowCd;            //거래요일코드
    private String dealCnt;              //거래회차
    private String dealComprOptrCd;      //거래회차비교연산자코드
    private String dealStartDt;          //거래시작일시
    private String dealEndDt;            //거래종료일시
    private String baseDdCd;             //기준일자코드
    private String baseddComprOptrCd;    //기준일자비교연산자코드
    private String aplyDaycnt;           //적용일수
    private String aplyDaycntOptrCd;     //적용일수비교연산자코드
    
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
    public String getChargAmt() {
        return chargAmt;
    }
    public void setChargAmt(String chargAmt) {
        this.chargAmt = chargAmt;
    }
    public String getChargComprOptrCd() {
        return chargComprOptrCd;
    }
    public void setChargComprOptrCd(String chargComprOptrCd) {
        this.chargComprOptrCd = chargComprOptrCd;
    }
    public String getDealDowCd() {
        return dealDowCd;
    }
    public void setDealDowCd(String dealDowCd) {
        this.dealDowCd = dealDowCd;
    }
    public String getDealCnt() {
        return dealCnt;
    }
    public void setDealCnt(String dealCnt) {
        this.dealCnt = dealCnt;
    }
    public String getDealComprOptrCd() {
        return dealComprOptrCd;
    }
    public void setDealComprOptrCd(String dealComprOptrCd) {
        this.dealComprOptrCd = dealComprOptrCd;
    }
    public String getDealStartDt() {
        return dealStartDt;
    }
    public void setDealStartDt(String dealStartDt) {
        this.dealStartDt = dealStartDt;
    }
    public String getDealEndDt() {
        return dealEndDt;
    }
    public void setDealEndDt(String dealEndDt) {
        this.dealEndDt = dealEndDt;
    }
    public String getBaseDdCd() {
        return baseDdCd;
    }
    public void setBaseDdCd(String baseDdCd) {
        this.baseDdCd = baseDdCd;
    }
    public String getBaseddComprOptrCd() {
        return baseddComprOptrCd;
    }
    public void setBaseddComprOptrCd(String baseddComprOptrCd) {
        this.baseddComprOptrCd = baseddComprOptrCd;
    }
    public String getAplyDaycnt() {
        return aplyDaycnt;
    }
    public void setAplyDaycnt(String aplyDaycnt) {
        this.aplyDaycnt = aplyDaycnt;
    }
    public String getAplyDaycntOptrCd() {
        return aplyDaycntOptrCd;
    }
    public void setAplyDaycntOptrCd(String aplyDaycntOptrCd) {
        this.aplyDaycntOptrCd = aplyDaycntOptrCd;
    }
    
    
}
