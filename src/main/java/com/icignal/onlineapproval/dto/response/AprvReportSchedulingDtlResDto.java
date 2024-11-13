package com.icignal.onlineapproval.dto.response;

/**
 * 승인레포트 : 캠페인 실행일정 상세 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTAprvReportSchedulingDtlResponseDTO
 * @date : 2018. 3. 1.
 * @author : jh.kim
 * @description : 
 */
public class AprvReportSchedulingDtlResDto {

    private String exeSeq;      // 실행순차
    private String exeDt;       // 실행일시
    private String exeTgtAmt;   // 실행대상수

    public String getExeSeq() {
        return exeSeq;
    }

    public void setExeSeq(String exeSeq) {
        this.exeSeq = exeSeq;
    }

    public String getExeDt() {
        return exeDt;
    }

    public void setExeDt(String exeDt) {
        this.exeDt = exeDt;
    }

    public String getExeTgtAmt() {
        return exeTgtAmt;
    }

    public void setExeTgtAmt(String exeTgtAmt) {
        this.exeTgtAmt = exeTgtAmt;
    }

}
