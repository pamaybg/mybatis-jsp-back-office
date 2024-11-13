package com.icignal.marketing.contents.dto.request;

public class BrazeCamApiReqDto {

    private String camNm;
    private String camApiKey;
    private String camCreateDate;
    private String tgtChnlList;

    public String getCamNm() {
        return camNm;
    }

    public void setCamNm(String camNm) {
        this.camNm = camNm;
    }

    public String getCamApiKey() {
        return camApiKey;
    }

    public void setCamApiKey(String camApiKey) {
        this.camApiKey = camApiKey;
    }

    public String getCamCreateDate() {
        return camCreateDate;
    }

    public void setCamCreateDate(String camCreateDate) {
        this.camCreateDate = camCreateDate;
    }

    public String getTgtChnlList() {
        return tgtChnlList;
    }

    public void setTgtChnlList(String tgtChnlList) {
        this.tgtChnlList = tgtChnlList;
    }
}
