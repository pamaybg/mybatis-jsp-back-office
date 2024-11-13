package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktSchePermitReqDto extends MKTBaseReqDto {
    private String chnlType;

    public String getChnlType() {
        return chnlType;
    }

    public void setChnlType(String chnlType) {
        this.chnlType = chnlType;
    }
}
