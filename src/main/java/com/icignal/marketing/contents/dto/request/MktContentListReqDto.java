package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktContentListReqDto extends MKTBaseReqDto {

    private String camId;

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

}
