package com.icignal.marketing.campaign.dto.response;

/**
 * 캠페인 프로모션 시작&종료일시 조회 Response DTO
 * 
 * @name : infavor.marketing.campaign.dto.response.MktCampaignPromotionDateResDto
 * @date : 2018. 1. 11.
 * @author : jh.kim
 * @description : 
 */
public class MktCampaignPromotionDateResDto {
    
    private String camId;       //캠페인RID
    private String camStartDd;  //캠페인 시작일
    private String camEndDd;    //캠페인 종료일
    private String rulesetId;   //프로모션RID
    private String promStartDt; //프로모션 시작일시
    private String promEndDt;   //프로모션 종료일시
    
    public String getCamId() {
        return camId;
    }
    public void setCamId(String camId) {
        this.camId = camId;
    }
    public String getCamStartDd() {
        return camStartDd;
    }
    public void setCamStartDd(String camStartDd) {
        this.camStartDd = camStartDd;
    }
    public String getCamEndDd() {
        return camEndDd;
    }
    public void setCamEndDd(String camEndDd) {
        this.camEndDd = camEndDd;
    }
    public String getRulesetId() {
        return rulesetId;
    }
    public void setRulesetId(String rulesetId) {
        this.rulesetId = rulesetId;
    }
    public String getPromStartDt() {
        return promStartDt;
    }
    public void setPromStartDt(String promStartDt) {
        this.promStartDt = promStartDt;
    }
    public String getPromEndDt() {
        return promEndDt;
    }
    public void setPromEndDt(String promEndDt) {
        this.promEndDt = promEndDt;
    }
    
}
