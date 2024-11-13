package com.icignal.loyalty.stampbingo.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyStampBingoMbrReqDto extends CommonDataAuthReqDto {
    // 시스템
    private String rid;

    // 릴레이션
    private String ridStbg;

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
}
