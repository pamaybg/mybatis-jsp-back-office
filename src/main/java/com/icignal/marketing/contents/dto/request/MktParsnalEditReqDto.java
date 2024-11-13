package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktParsnalEditReqDto extends MKTBaseReqDto {
    
    private String id;               //아이디
    private String contsId;          //콘텐츠ID
    private String targetId;         //대상ID
    private String prsnlCd;          //개인화코드
    private String prsnlVal;         //개인화값
    
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getContsId() {
        return contsId;
    }
    public void setContsId(String contsId) {
        this.contsId = contsId;
    }
    public String getTargetId() {
        return targetId;
    }
    public void setTargetId(String targetId) {
        this.targetId = targetId;
    }
    public String getPrsnlCd() {
        return prsnlCd;
    }
    public void setPrsnlCd(String prsnlCd) {
        this.prsnlCd = prsnlCd;
    }
    public String getPrsnlVal() {
        return prsnlVal;
    }
    public void setPrsnlVal(String prsnlVal) {
        this.prsnlVal = prsnlVal;
    }
    
}
