package com.icignal.onlineapproval.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 승인레포트 : 프로모션 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTApprovalReportPromInfoResponseDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description :
 */

@CommCode
public class AprvReportPromInfoResDto {
    
    private String promStartDt;     //시작일       
    private String promEndDt;       //종료일       
    private String acrlType;        //보상유형코드
    
    @MarkName(groupCode = "OBJECT_OPER_CODE", codeField = "acrlType")
    private String acrlTypeNm;      //보상유형명
    private String acrlAmt;         //금액(율)
    private String allianceTypeCd;  //제휴사코드
    
    @MarkName(groupCode = "CPRT_TYPE_CD", codeField = "allianceTypeCd")
    private String allianceTypeNm;  //제휴사명
    private String monthLmtPoint;   //월한도포인트
    private String rulesetDesc;     //내용

    private String promTypeCd;      //프로모션 유형코드
    
    @MarkName(groupCode = "LOY_PROMO_TYPE", codeField = "promTypeCd")
    private String promTypeNm;      //프로모션 유형명

    private String promCyclTypeCd;  // 반복주기
    private String promCyclStartDd; // 시작일
    private String promCyclEndDd;   // 종료일
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getPromCyclTypeCd() {
        return promCyclTypeCd;
    }

    public void setPromCyclTypeCd(String promCyclTypeCd) {
        this.promCyclTypeCd = promCyclTypeCd;
    }

    public String getPromCyclStartDd() {
        return promCyclStartDd;
    }

    public void setPromCyclStartDd(String promCyclStartDd) {
        this.promCyclStartDd = promCyclStartDd;
    }

    public String getPromCyclEndDd() {
        return promCyclEndDd;
    }

    public void setPromCyclEndDd(String promCyclEndDd) {
        this.promCyclEndDd = promCyclEndDd;
    }

    public String getPromTypeCd() {
        return promTypeCd;
    }

    public void setPromTypeCd(String promTypeCd) {
        this.promTypeCd = promTypeCd;
    }

    public String getPromTypeNm() {
        return promTypeNm;
    }

    public void setPromTypeNm(String promTypeNm) {
        this.promTypeNm = promTypeNm;
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
    public String getAcrlType() {
        return acrlType;
    }
    public void setAcrlType(String acrlType) {
        this.acrlType = acrlType;
    }
    public String getAcrlTypeNm() {
        return acrlTypeNm;
    }
    public void setAcrlTypeNm(String acrlTypeNm) {
        this.acrlTypeNm = acrlTypeNm;
    }
    public String getAcrlAmt() {
        return acrlAmt;
    }
    public void setAcrlAmt(String acrlAmt) {
        this.acrlAmt = acrlAmt;
    }
    public String getAllianceTypeCd() {
        return allianceTypeCd;
    }
    public void setAllianceTypeCd(String allianceTypeCd) {
        this.allianceTypeCd = allianceTypeCd;
    }
    public String getAllianceTypeNm() {
        return allianceTypeNm;
    }
    public void setAllianceTypeNm(String allianceTypeNm) {
        this.allianceTypeNm = allianceTypeNm;
    }
    public String getMonthLmtPoint() {
        return monthLmtPoint;
    }
    public void setMonthLmtPoint(String monthLmtPoint) {
        this.monthLmtPoint = monthLmtPoint;
    }
    public String getRulesetDesc() {
        return rulesetDesc;
    }
    public void setRulesetDesc(String rulesetDesc) {
        this.rulesetDesc = rulesetDesc;
    }
    
    
}
