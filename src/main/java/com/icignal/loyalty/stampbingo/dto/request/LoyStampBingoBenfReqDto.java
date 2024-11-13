package com.icignal.loyalty.stampbingo.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyStampBingoBenfReqDto extends CommonDataAuthReqDto {
    // 시스템
    private String rid;

    // 릴레이션
    private String ridStbg;
    private String ridOfr;

    // 기본필드
    private String bnfTypeCd;
    private String title;
    private String ofrCnt;
    private String validStDd;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getRidStbg() {
        return ridStbg;
    }

    public void setRidStbg(String ridStbg) {
        this.ridStbg = ridStbg;
    }

    public String getRidOfr() {
        return ridOfr;
    }

    public void setRidOfr(String ridOfr) {
        this.ridOfr = ridOfr;
    }

    public String getBnfTypeCd() {
        return bnfTypeCd;
    }

    public void setBnfTypeCd(String bnfTypeCd) {
        this.bnfTypeCd = bnfTypeCd;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOfrCnt() {
        return ofrCnt;
    }

    public void setOfrCnt(String ofrCnt) {
        this.ofrCnt = ofrCnt;
    }

    public String getValidStDd() {
        return validStDd;
    }

    public void setValidStDd(String validStDd) {
        this.validStDd = validStDd;
    }
}
