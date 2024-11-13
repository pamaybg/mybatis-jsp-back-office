package com.icignal.loyalty.customer.dto.request;

/*
 * 1. 클래스명	: LoyCustMbrRel
 * 2. 파일명	: LoyCustMbrRel.java
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

public class LoyCustMbrRelReqDto extends CommonDataAuthReqDto {
    // 릴레이션
    private String ridMbrC;

    // 시스템
    private String rid;

    public String getRidMbrC() {
        return ridMbrC;
    }

    public void setRidMbrC(String ridMbrC) {
        this.ridMbrC = ridMbrC;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }
}
