package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.util.ObjectUtil;

public class LoyRulesetMbrDtlReqDto extends CommonDataAuthReqDto {
    
    private String rid;                  //RID
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
    	String totAvlPointdata = totAvlPoint;
        if (ObjectUtil.isEmpty(totAvlPointdata)) {
        	totAvlPointdata = "0";
        }
        else {
        	totAvlPointdata = totAvlPointdata.replaceAll(",", "");
        }
        this.totAvlPoint = totAvlPointdata;
    }
    public String getAvlpntComprOptrCd() {
        return avlpntComprOptrCd;
    }
    public void setAvlpntComprOptrCd(String avlpntComprOptrCd) {
        this.avlpntComprOptrCd = avlpntComprOptrCd;
    }
}
