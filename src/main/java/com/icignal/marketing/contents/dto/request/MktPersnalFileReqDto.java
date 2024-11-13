package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktPersnalFileReqDto extends MKTBaseReqDto {
    
    private String contsId;
    
    public String getContsId() {
        return contsId;
    }

    public void setContsId(String contsId) {
        this.contsId = contsId;
    }

}
