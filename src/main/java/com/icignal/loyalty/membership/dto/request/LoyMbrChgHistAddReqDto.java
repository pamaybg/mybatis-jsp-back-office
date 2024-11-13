package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class LoyMbrChgHistAddReqDto extends MKTBaseReqDto {

    private String cipherKey;
    private String chgTbl;
    private String bchngData;
    private String bchngEnYn;
    private String achngData;
    private String achngEnYn;
    private String chgCol;
    private String rmark;
    private String mbrNo;
    private String chgColLov;
    private String chgPstn;
    private String rsltMsg;
    private String resultFlg;

    public LoyMbrChgHistAddReqDto() {
      /*  try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch (Exception e) {
            LogUtil.error(e);
        }*/
    }

    public String getCipherKey() {
        return cipherKey;
    }

    public void setCipherKey(String cipherKey) {
        this.cipherKey = cipherKey;
    }

    public String getChgTbl() {
        return chgTbl;
    }

    public void setChgTbl(String chgTbl) {
        this.chgTbl = chgTbl;
    }

    public String getBchngData() {
        return bchngData;
    }

    public void setBchngData(String bchngData) {
        this.bchngData = bchngData;
    }

    public String getBchngEnYn() {
        return bchngEnYn;
    }

    public void setBchngEnYn(String bchngEnYn) {
        this.bchngEnYn = bchngEnYn;
    }

    public String getAchngData() {
        return achngData;
    }

    public void setAchngData(String achngData) {
        this.achngData = achngData;
    }

    public String getAchngEnYn() {
        return achngEnYn;
    }

    public void setAchngEnYn(String achngEnYn) {
        this.achngEnYn = achngEnYn;
    }

    public String getChgCol() {
        return chgCol;
    }

    public void setChgCol(String chgCol) {
        this.chgCol = chgCol;
    }

    public String getRmark() {
        return rmark;
    }

    public void setRmark(String rmark) {
        this.rmark = rmark;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    public String getChgColLov() {
        return chgColLov;
    }

    public void setChgColLov(String chgColLov) {
        this.chgColLov = chgColLov;
    }

    public String getChgPstn() {
        return chgPstn;
    }

    public void setChgPstn(String chgPstn) {
        this.chgPstn = chgPstn;
    }

    public String getRsltMsg() {
        return rsltMsg;
    }

    public void setRsltMsg(String rsltMsg) {
        this.rsltMsg = rsltMsg;
    }

    public String getResultFlg() {
        return resultFlg;
    }

    public void setResultFlg(String resultFlg) {
        this.resultFlg = resultFlg;
    }

}
