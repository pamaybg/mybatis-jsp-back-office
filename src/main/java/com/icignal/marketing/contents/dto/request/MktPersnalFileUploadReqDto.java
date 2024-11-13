package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktPersnalFileUploadReqDto extends MKTBaseReqDto {
    
    private String contsId;
    private String orgFilePath;
    
    public String getOrgFilePath() {
        return orgFilePath;
    }

    public void setOrgFilePath(String orgFilePath) {
        this.orgFilePath = orgFilePath;
    }

    public String getContsId() {
        return contsId;
    }
    
    public void setContsId(String contsId) {
        this.contsId = contsId;
    }
    
}
