package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyOfferUseDeskDtlReqDto extends CommonDataAuthReqDto {

    private String ridMktOfferMst;          // 오퍼 마스터 rid
    
    private String rid;
    private String ouTypeCd;                //가맹점유형
    private String ridChnl;                 //RID_CHNL
    
    private String dataStatus;              //수정상태
    
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
    public String getDataStatus() {
        return dataStatus;
    }
    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }
    public String getOuTypeCd() {
        return ouTypeCd;
    }
    public void setOuTypeCd(String ouTypeCd) {
        this.ouTypeCd = ouTypeCd;
    }
    public String getRidChnl() {
        return ridChnl;
    }
    public void setRidChnl(String ridChnl) {
        this.ridChnl = ridChnl;
    }
    
}
