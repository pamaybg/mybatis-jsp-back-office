package com.icignal.onlineapproval.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : infavor.marketing.elapproval.dto.response.MKTApprovalReportApprResponseDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description :
 */

@CommCode
public class AprvReportAprvResDto {

    private String elecAprvSeq;
    private String aprvId;
    private String aprvNm;
    private String statusCd;
    
    @MarkName(groupCode = "EL_APL_ITEM_STATUS_CD", codeField = "statusCd")
    private String statusNm;
    private String aprvDd;
    private String aprvYn;

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public String getElecAprvSeq() {
        return elecAprvSeq;
    }

    public void setElecAprvSeq(String elecAprvSeq) {
        this.elecAprvSeq = elecAprvSeq;
    }

    public String getAprvId() {
        return aprvId;
    }

    public void setAprvId(String aprvId) {
        this.aprvId = aprvId;
    }

    public String getAprvNm() {
        return aprvNm;
    }

    public void setAprvNm(String aprvNm) {
        this.aprvNm = aprvNm;
    }

    public String getStatusCd() {
        return statusCd;
    }

    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }

    public String getStatusNm() {
        return statusNm;
    }

    public void setStatusNm(String statusNm) {
        this.statusNm = statusNm;
    }

    public String getAprvDd() {
        return aprvDd;
    }

    public void setAprvDd(String aprvDd) {
        this.aprvDd = aprvDd;
    }

    public String getAprvYn() {
        return aprvYn;
    }

    public void setAprvYn(String aprvYn) {
        this.aprvYn = aprvYn;
    }

}
