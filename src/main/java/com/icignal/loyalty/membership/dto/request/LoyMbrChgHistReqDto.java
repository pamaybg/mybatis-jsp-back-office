package com.icignal.loyalty.membership.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrChgHistReqDto extends CommonDataAuthReqDto {

    private String ridMbr;
    private String mbrNo;
    private String chgTbl;
    private String chgCol;
    private String bchngData;
    private String achngData;
    private String chgPstn;
    private String tmpBcData;
    private String tmpAcData;
    private String cipherKey;

    private List<LoyMbrChgHistReqDto> chgHistList;

    public LoyMbrChgHistReqDto() {
     /*   try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch (Exception e) {
            LogUtil.error(e);
        }*/
    }

    public String getRidMbr() {
        return ridMbr;
    }

    public void setRidMbr(String ridMbr) {
        this.ridMbr = ridMbr;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    public String getChgTbl() {
        return chgTbl;
    }

    public void setChgTbl(String chgTbl) {
        this.chgTbl = chgTbl;
    }

    public String getChgCol() {
        return chgCol;
    }

    public void setChgCol(String chgCol) {
        this.chgCol = chgCol;
    }

    public String getBchngData() {
        return bchngData;
    }

    public void setBchngData(String bchngData) {
        this.bchngData = bchngData;
    }

    public String getAchngData() {
        return achngData;
    }

    public void setAchngData(String achngData) {
        this.achngData = achngData;
    }

    public List<LoyMbrChgHistReqDto> getChgHistList() {
        return chgHistList;
    }

    public void setChgHistList(List<LoyMbrChgHistReqDto> chgHistList) {
        this.chgHistList = chgHistList;
    }

    public String getChgPstn() {
        return chgPstn;
    }

    public void setChgPstn(String chgPstn) {
        this.chgPstn = chgPstn;
    }

    public String getTmpBcData() {
        return tmpBcData;
    }

    public void setTmpBcData(String tmpBcData) {
        this.tmpBcData = tmpBcData;
    }

    public String getTmpAcData() {
        return tmpAcData;
    }

    public void setTmpAcData(String tmpAcData) {
        this.tmpAcData = tmpAcData;
    }

    /**
     * @return the cipherKey
     */
    public String getCipherKey() {
        return cipherKey;
    }

    /**
     * @param cipherKey
     *            the cipherKey to set
     */
    public void setCipherKey(String cipherKey) {
        this.cipherKey = cipherKey;
    }

}
