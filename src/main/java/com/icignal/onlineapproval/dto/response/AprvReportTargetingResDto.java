package com.icignal.onlineapproval.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 승인레포트 : 대상자 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTApprovalReportTargetingResponseDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description : 
 */

@CommCode
public class AprvReportTargetingResDto {
    
    private String camTgtTypeCd;    //타겟팅유형코드
    
    @MarkName(groupCode = "MKT_TGT_TYPE", codeField = "camTgtTypeCd")
    private String camTgtTypeNm;    //타겟팅유형명
    private String camTgtCnt;       //타겟팅건수
    private String tgtGroupDesc;    //설명

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getCamTgtTypeCd() {
        return camTgtTypeCd;
    }

    public void setCamTgtTypeCd(String camTgtTypeCd) {
        this.camTgtTypeCd = camTgtTypeCd;
    }

    public String getCamTgtTypeNm() {
        return camTgtTypeNm;
    }

    public void setCamTgtTypeNm(String camTgtTypeNm) {
        this.camTgtTypeNm = camTgtTypeNm;
    }

    public String getCamTgtCnt() {
        return camTgtCnt;
    }

    public void setCamTgtCnt(String camTgtCnt) {
        this.camTgtCnt = camTgtCnt;
    }

    public String getTgtGroupDesc() {
        return tgtGroupDesc;
    }

    public void setTgtGroupDesc(String tgtGroupDesc) {
        this.tgtGroupDesc = tgtGroupDesc;
    }
    
}
