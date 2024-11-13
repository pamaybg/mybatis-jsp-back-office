package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyMbrItemReqDto extends CommonDataAuthReqDto {

    private String custNm;
    private String mbrNo;
    private String memDiv;
    // private String ridTierCur ;
    private String tierCd;
    private String HomeTelNo;
    @Encrypted
    private String hhpNo;
    private String lunarGbnCd;
    private String birthDt;
    private String addr1Zip;
    private String ownhomeAdrChgDt;
    private String addr1Dflt;
    private String addr1Dtl;
    private String avlPoint;
    private String totChangePoint;
    private String giftPoint;
    private String giftAvlPoint;
    private String extncPamMonth;
    private String extncPamPoint;
    private String wbMemId;
    private String wbMemYn;
    private String e1MemYn;
    private String sbscChnlCd;
    private String sbscChnlDtlCd;
    private String eventTgtYn;
    private String corpTaxiYn;
    private String mbrStatCd;
    private String rid;
    private String ridCust;
    private String addr1JiDflt;
    private String addr1JiDtl;
    private String addr1JiZip;
    private String hCity;
    private String hGu;
    private String cipherKey;
    @Encrypted
    private String emailAddr;
    private String chnlAgreSms;
    private String chnlAgreEmail;
    private String appNewsYn;
    private String appBenefitYn;
    private String semiVipStartDt;
    private String semiVipEndDt;
    private String mktAgrePrvInfoOpt;
    private String marryYn;
    private String marryAniv;

    private String hhpNoTail;
    private String identiVal; //2019.03.18 hy.jun

    public LoyMbrItemReqDto() {
      /*  try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch (Exception e) {
            LogUtil.error(e);
        }*/
    }

    public String getHhpNoTail() {
        return hhpNoTail;
    }

    public void setHhpNoTail(String hhpNoTail) {
        this.hhpNoTail = hhpNoTail;
    }

    public String getCustNm() {
        return custNm;
    }

    public void setCustNm(String custNm) {
        this.custNm = custNm;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    public String getMemDiv() {
        return memDiv;
    }

    public void setMemDiv(String memDiv) {
        this.memDiv = memDiv;
    }

    public String getTierCd() {
        return tierCd;
    }

    public void setTierCd(String tierCd) {
        this.tierCd = tierCd;
    }

    public String getHomeTelNo() {
        return HomeTelNo;
    }

    public void setHomeTelNo(String homeTelNo) {
        HomeTelNo = homeTelNo;
    }

    public String getHhpNo() {
        return hhpNo;
    }

    public void setHhpNo(String hhpNo) {
        this.hhpNo = hhpNo;
    }

    public String getLunarGbnCd() {
        return lunarGbnCd;
    }

    public void setLunarGbnCd(String lunarGbnCd) {
        this.lunarGbnCd = lunarGbnCd;
    }

    public String getBirthDt() {
        return birthDt;
    }

    public void setBirthDt(String birthDt) {
        this.birthDt = birthDt;
    }

    public String getAddr1Zip() {
        return addr1Zip;
    }

    public void setAddr1Zip(String addr1Zip) {
        this.addr1Zip = addr1Zip;
    }

    public String getOwnhomeAdrChgDt() {
        return ownhomeAdrChgDt;
    }

    public void setOwnhomeAdrChgDt(String ownhomeAdrChgDt) {
        this.ownhomeAdrChgDt = ownhomeAdrChgDt;
    }

    public String getAddr1Dtl() {
        return addr1Dtl;
    }

    public void setAddr1Dtl(String addr1Dtl) {
        this.addr1Dtl = addr1Dtl;
    }

    public String getAvlPoint() {
        return avlPoint;
    }

    public void setAvlPoint(String avlPoint) {
        this.avlPoint = avlPoint;
    }

    public String getTotChangePoint() {
        return totChangePoint;
    }

    public void setTotChangePoint(String totChangePoint) {
        this.totChangePoint = totChangePoint;
    }

    public String getGiftPoint() {
        return giftPoint;
    }

    public void setGiftPoint(String giftPoint) {
        this.giftPoint = giftPoint;
    }

    public String getGiftAvlPoint() {
        return giftAvlPoint;
    }

    public void setGiftAvlPoint(String giftAvlPoint) {
        this.giftAvlPoint = giftAvlPoint;
    }

    public String getExtncPamMonth() {
        return extncPamMonth;
    }

    public void setExtncPamMonth(String extncPamMonth) {
        this.extncPamMonth = extncPamMonth;
    }

    public String getExtncPamPoint() {
        return extncPamPoint;
    }

    public void setExtncPamPoint(String extncPamPoint) {
        this.extncPamPoint = extncPamPoint;
    }

    public String getWbMemId() {
        return wbMemId;
    }

    public void setWbMemId(String wbMemId) {
        this.wbMemId = wbMemId;
    }

    public String getWbMemYn() {
        return wbMemYn;
    }

    public void setWbMemYn(String wbMemYn) {
        this.wbMemYn = wbMemYn;
    }

    public String getE1MemYn() {
        return e1MemYn;
    }

    public void setE1MemYn(String e1MemYn) {
        this.e1MemYn = e1MemYn;
    }

    public String getSbscChnlCd() {
        return sbscChnlCd;
    }

    public void setSbscChnlCd(String sbscChnlCd) {
        this.sbscChnlCd = sbscChnlCd;
    }

    public String getSbscChnlDtlCd() {
        return sbscChnlDtlCd;
    }

    public void setSbscChnlDtlCd(String sbscChnlDtlCd) {
        this.sbscChnlDtlCd = sbscChnlDtlCd;
    }

    public String getEventTgtYn() {
        return eventTgtYn;
    }

    public void setEventTgtYn(String eventTgtYn) {
        this.eventTgtYn = eventTgtYn;
    }

    public String getCorpTaxiYn() {
        return corpTaxiYn;
    }

    public void setCorpTaxiYn(String corpTaxiYn) {
        this.corpTaxiYn = corpTaxiYn;
    }

    public String getMbrStatCd() {
        return mbrStatCd;
    }

    public void setMbrStatCd(String mbrStatCd) {
        this.mbrStatCd = mbrStatCd;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getRidCust() {
        return ridCust;
    }

    public void setRidCust(String ridCust) {
        this.ridCust = ridCust;
    }

    public String getAddr1Dflt() {
        return addr1Dflt;
    }

    public void setAddr1Dflt(String addr1Dflt) {
        this.addr1Dflt = addr1Dflt;
    }

    public String getAddr1JiDflt() {
        return addr1JiDflt;
    }

    public void setAddr1JiDflt(String addr1JiDflt) {
        this.addr1JiDflt = addr1JiDflt;
    }

    public String getAddr1JiDtl() {
        return addr1JiDtl;
    }

    public void setAddr1JiDtl(String addr1JiDtl) {
        this.addr1JiDtl = addr1JiDtl;
    }

    public String gethCity() {
        return hCity;
    }

    public void sethCity(String hCity) {
        this.hCity = hCity;
    }

    public String gethGu() {
        return hGu;
    }

    public void sethGu(String hGu) {
        this.hGu = hGu;
    }

    public String getAddr1JiZip() {
        return addr1JiZip;
    }

    public void setAddr1JiZip(String addr1JiZip) {
        this.addr1JiZip = addr1JiZip;
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

    /**
     * @return the emailAddr
     */
    public String getEmailAddr() {
        return emailAddr;
    }

    /**
     * @param emailAddr
     *            the emailAddr to set
     */
    public void setEmailAddr(String emailAddr) {
        this.emailAddr = emailAddr;
    }

    /**
     * @return the chnlAgreSms
     */
    public String getChnlAgreSms() {
        return chnlAgreSms;
    }

    /**
     * @param chnlAgreSms
     *            the chnlAgreSms to set
     */
    public void setChnlAgreSms(String chnlAgreSms) {
        this.chnlAgreSms = chnlAgreSms;
    }

    /**
     * @return the chnlAgreEmail
     */
    public String getChnlAgreEmail() {
        return chnlAgreEmail;
    }

    /**
     * @param chnlAgreEmail
     *            the chnlAgreEmail to set
     */
    public void setChnlAgreEmail(String chnlAgreEmail) {
        this.chnlAgreEmail = chnlAgreEmail;
    }

    /**
     * @return the appNewsYn
     */
    public String getAppNewsYn() {
        return appNewsYn;
    }

    /**
     * @param appNewsYn
     *            the appNewsYn to set
     */
    public void setAppNewsYn(String appNewsYn) {
        this.appNewsYn = appNewsYn;
    }

    /**
     * @return the appBenefitYn
     */
    public String getAppBenefitYn() {
        return appBenefitYn;
    }

    /**
     * @param appBenefitYn
     *            the appBenefitYn to set
     */
    public void setAppBenefitYn(String appBenefitYn) {
        this.appBenefitYn = appBenefitYn;
    }

    /**
     * @return the semiVipStartDt
     */
    public String getSemiVipStartDt() {
        return semiVipStartDt;
    }

    /**
     * @param semiVipStartDt
     *            the semiVipStartDt to set
     */
    public void setSemiVipStartDt(String semiVipStartDt) {
        this.semiVipStartDt = semiVipStartDt;
    }

    /**
     * @return the semiVipEndDt
     */
    public String getSemiVipEndDt() {
        return semiVipEndDt;
    }

    /**
     * @param semiVipEndDt
     *            the semiVipEndDt to set
     */
    public void setSemiVipEndDt(String semiVipEndDt) {
        this.semiVipEndDt = semiVipEndDt;
    }

    /**
     * @return the mktAgrePrvInfoOpt
     */
    public String getMktAgrePrvInfoOpt() {
        return mktAgrePrvInfoOpt;
    }

    /**
     * @param mktAgrePrvInfoOpt
     *            the mktAgrePrvInfoOpt to set
     */
    public void setMktAgrePrvInfoOpt(String mktAgrePrvInfoOpt) {
        this.mktAgrePrvInfoOpt = mktAgrePrvInfoOpt;
    }

    /**
     * @return the marryYn
     */
    public String getMarryYn() {
        return marryYn;
    }

    /**
     * @param marryYn
     *            the marryYn to set
     */
    public void setMarryYn(String marryYn) {
        this.marryYn = marryYn;
    }

    /**
     * @return the marryAniv
     */
    public String getMarryAniv() {
        return marryAniv;
    }

    /**
     * @param marryAniv
     *            the marryAniv to set
     */
    public void setMarryAniv(String marryAniv) {
        this.marryAniv = marryAniv;
    }

	public String getIdentiVal() {
		return identiVal;
	}

	public void setIdentiVal(String identiVal) {
		this.identiVal = identiVal;
	}

}
