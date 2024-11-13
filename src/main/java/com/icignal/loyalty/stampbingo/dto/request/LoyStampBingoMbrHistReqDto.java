package com.icignal.loyalty.stampbingo.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyStampBingoMbrHistReqDto extends CommonDataAuthReqDto {

    // 릴레이션
    private String ridStbgMbr;

    public String getRidStbgMbr() {
        return ridStbgMbr;
    }

    public void setRidStbgMbr(String ridStbgMbr) {
        this.ridStbgMbr = ridStbgMbr;
    }
}
