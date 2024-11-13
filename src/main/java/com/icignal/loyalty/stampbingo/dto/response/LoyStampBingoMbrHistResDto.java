package com.icignal.loyalty.stampbingo.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyStampBingoMbrHistResDto extends GridPagingItemResDto {
    private String stepNo;
    private String stepTitle;
    private String promNm;
    private String createDate;
    private String ofrNm;
    private String ofrCnt;
    private String compDate;
    private String canlRsn;

    public String getStepNo() {
        return stepNo;
    }

    public void setStepNo(String stepNo) {
        this.stepNo = stepNo;
    }

    public String getStepTitle() {
        return stepTitle;
    }

    public void setStepTitle(String stepTitle) {
        this.stepTitle = stepTitle;
    }

    public String getPromNm() {
        return promNm;
    }

    public void setPromNm(String promNm) {
        this.promNm = promNm;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getOfrNm() {
        return ofrNm;
    }

    public void setOfrNm(String ofrNm) {
        this.ofrNm = ofrNm;
    }

    public String getOfrCnt() {
        return ofrCnt;
    }

    public void setOfrCnt(String ofrCnt) {
        this.ofrCnt = ofrCnt;
    }

    public String getCompDate() {
        return compDate;
    }

    public void setCompDate(String compDate) {
        this.compDate = compDate;
    }

    public String getCanlRsn() {
        return canlRsn;
    }

    public void setCanlRsn(String canlRsn) {
        this.canlRsn = canlRsn;
    }
}
