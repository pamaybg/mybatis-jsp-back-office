package com.icignal.loyalty.stampbingo.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyStampBingoChnlReqDto extends CommonDataAuthReqDto {

    private String rid;

    // 릴레이션
    private String ridStbg;
    private String ridChnl;

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

    public String getRidChnl() {
        return ridChnl;
    }

    public void setRidChnl(String ridChnl) {
        this.ridChnl = ridChnl;
    }
}
