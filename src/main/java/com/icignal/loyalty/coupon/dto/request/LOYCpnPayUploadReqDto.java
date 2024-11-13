package com.icignal.loyalty.coupon.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

import java.util.List;

public class LOYCpnPayUploadReqDto extends CommonDataAuthReqDto {
    private String ridMbr;
    private String mbrNo;
    private String qty;
    private String headerRid;
    private List<LOYCpnPayUploadReqDto> array;

    public String getHeaderRid() {
        return headerRid;
    }

    public void setHeaderRid(String headerRid) {
        this.headerRid = headerRid;
    }

    public String getRidMbr() {
        return ridMbr;
    }

    public void setRidMbr(String ridMbr) {
        this.ridMbr = ridMbr;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public List<LOYCpnPayUploadReqDto> getArray() {
        return array;
    }

    public void setArray(List<LOYCpnPayUploadReqDto> array) {
        this.array = array;
    }
}
