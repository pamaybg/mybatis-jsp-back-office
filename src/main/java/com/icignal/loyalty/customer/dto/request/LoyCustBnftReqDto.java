package com.icignal.loyalty.customer.dto.request;

/*
 * 1. 클래스명	: LoyCustBnftReqDto
 * 2. 파일명	: LoyCustBnftReqDto.java
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

public class LoyCustBnftReqDto extends CommonDataAuthReqDto {
    private String rid;
    private String startDate;
    private String endDate;
    private String qty;
    private String ridOfr;
    private String ridMbrC;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getRidOfr() {
        return ridOfr;
    }

    public void setRidOfr(String ridOfr) {
        this.ridOfr = ridOfr;
    }

    public String getRidMbrC() {
        return ridMbrC;
    }

    public void setRidMbrC(String ridMbrC) {
        this.ridMbrC = ridMbrC;
    }
}
