package com.icignal.loyalty.product.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class LoyProductByBrdDto extends MKTGridPagingReqDto {

    private String brdId;
    private String code;
    private String value;

    public String getBrdId() {
        return brdId;
    }

    public void setBrdId(String brdId) {
        this.brdId = brdId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
