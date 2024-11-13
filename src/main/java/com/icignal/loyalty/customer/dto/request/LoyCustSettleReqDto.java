package com.icignal.loyalty.customer.dto.request;

/*
 * 1. 클래스명	: LoyCustSettleReqDto
 * 2. 파일명	: LoyCustSettleReqDto.java
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

public class LoyCustSettleReqDto extends CommonDataAuthReqDto {

    private String rid;
    private String stlCycleCd;
    private String shaChnlCd;
    private String chnlShaRate;
    private String ridMbrC;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getStlCycleCd() {
        return stlCycleCd;
    }

    public void setStlCycleCd(String stlCycleCd) {
        this.stlCycleCd = stlCycleCd;
    }

    public String getShaChnlCd() {
        return shaChnlCd;
    }

    public void setShaChnlCd(String shaChnlCd) {
        this.shaChnlCd = shaChnlCd;
    }

    public String getChnlShaRate() {
        return chnlShaRate;
    }

    public void setChnlShaRate(String chnlShaRate) {
        this.chnlShaRate = chnlShaRate;
    }

    public String getRidMbrC() {
        return ridMbrC;
    }

    public void setRidMbrC(String ridMbrC) {
        this.ridMbrC = ridMbrC;
    }
}
