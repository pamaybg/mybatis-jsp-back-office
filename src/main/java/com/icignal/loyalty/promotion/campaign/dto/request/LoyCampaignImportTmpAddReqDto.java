package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class LoyCampaignImportTmpAddReqDto extends MKTBaseReqDto {

    private String camId;
    private String ridTgtHad;
    private Integer itemSeq;
    private String memId;

    private String prsnlVal01;
    private String prsnlVal02;
    private String prsnlVal03;
    private String prsnlVal04;
    private String prsnlVal05;

    public String getPrsnlVal01() {
        return prsnlVal01;
    }
    public void setPrsnlVal01(String prsnlVal01) {
        this.prsnlVal01 = prsnlVal01;
    }
    public String getPrsnlVal02() {
        return prsnlVal02;
    }
    public void setPrsnlVal02(String prsnlVal02) {
        this.prsnlVal02 = prsnlVal02;
    }
    public String getPrsnlVal03() {
        return prsnlVal03;
    }
    public void setPrsnlVal03(String prsnlVal03) {
        this.prsnlVal03 = prsnlVal03;
    }
    public String getPrsnlVal04() {
        return prsnlVal04;
    }
    public void setPrsnlVal04(String prsnlVal04) {
        this.prsnlVal04 = prsnlVal04;
    }
    public String getPrsnlVal05() {
        return prsnlVal05;
    }
    public void setPrsnlVal05(String prsnlVal05) {
        this.prsnlVal05 = prsnlVal05;
    }
    public String getCamId() {
        return camId;
    }
    public void setCamId(String camId) {
        this.camId = camId;
    }
    public String getRidTgtHad() {
        return ridTgtHad;
    }
    public void setRidTgtHad(String ridTgtHad) {
        this.ridTgtHad = ridTgtHad;
    }
    public Integer getItemSeq() {
        return itemSeq;
    }
    public void setItemSeq(Integer itemSeq) {
        this.itemSeq = itemSeq;
    }
    public String getMemId() {
        return memId;
    }
    public void setMemId(String memId) {
        this.memId = memId;
    }

}
