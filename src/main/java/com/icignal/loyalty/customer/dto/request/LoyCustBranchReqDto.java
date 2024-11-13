package com.icignal.loyalty.customer.dto.request;

/*
 * 1. 클래스명	: LoyCustBranchReqDto
 * 2. 파일명	: LoyCustBranchReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.customer.dto.request
 * 4. 작성자명	: 이나현
 * 5. 작성일자	: 2020. 7. 2.
 */

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyCustBranchReqDto extends CommonDataAuthReqDto {
    private String rid;
    private String brNo;
    private String brNm;
    private String ridChnl;
    private String ridMbrC;
    private String charger;
    private String telNo;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getBrNo() {
        return brNo;
    }

    public void setBrNo(String brNo) {
        this.brNo = brNo;
    }

    public String getBrNm() {
        return brNm;
    }

    public void setBrNm(String brNm) {
        this.brNm = brNm;
    }

    public String getRidChnl() {
        return ridChnl;
    }

    public void setRidChnl(String ridChnl) {
        this.ridChnl = ridChnl;
    }

    public String getRidMbrC() {
        return ridMbrC;
    }

    public void setRidMbrC(String ridMbrC) {
        this.ridMbrC = ridMbrC;
    }

    public String getCharger() {
        return charger;
    }

    public void setCharger(String charger) {
        this.charger = charger;
    }

    public String getTelNo() {
        return telNo;
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }
}
