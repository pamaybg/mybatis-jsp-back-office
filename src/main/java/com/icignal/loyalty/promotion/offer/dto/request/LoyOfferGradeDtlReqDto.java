package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyOfferGradeDtlReqDto extends CommonDataAuthReqDto {
    
    private String rid;               //RID
    private String ridMktOfferMst;    //RID_오퍼마스터
    private String ridTier;           //RID_등급
    private String type;              //유형
    private String gradeCd;           //등급코드
    private String stblAmt;           //차감포인트/스탬프
    
    private String dataStatus;        //수정상태

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getRidMktOfferMst() {
        return ridMktOfferMst;
    }

    public void setRidMktOfferMst(String ridMktOfferMst) {
        this.ridMktOfferMst = ridMktOfferMst;
    }

    public String getRidTier() {
        return ridTier;
    }

    public void setRidTier(String ridTier) {
        this.ridTier = ridTier;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getGradeCd() {
        return gradeCd;
    }

    public void setGradeCd(String gradeCd) {
        this.gradeCd = gradeCd;
    }

    public String getStblAmt() {
        return stblAmt;
    }

    public void setStblAmt(String stblAmt) {
        this.stblAmt = stblAmt;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }
    
}
