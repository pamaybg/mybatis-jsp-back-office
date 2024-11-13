package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class LoyMbrItemResDto extends StatusResDto {

	@Decrypted(masked = "none")
    private String custNm;
    private String mbrNo;
    private String memDiv;
    // private String ridTierCur ;
    private String tierCd;
    private String tierNm;
    private String HomeTelNo;
    @Decrypted(masked = "tel")
    private String hhpNo;      //암호화된 휴대폰번호
    @Decrypted(masked = "tel")
    private String hhpNoIn;    //부분 복호화된 휴대폰번호
    @Decrypted(masked = "none")
    private String hhpNoDec;   //모두 복호화된 휴대폰번호
    private String lunarGbnCd;
    private String birthDt;
    private String addr1Zip;
    private String ownhomeAdrChgDt;
    private String addr1Dflt;
    
    @Decrypted(masked = "none")
    private String addr1Dtl;
    private String ecomMbrNo;
    private String avlPoint;
    private String totChangePoint;
    private String giftPoint;
    private String giftAvlPoint;
    private String extncPamMonth;
    private String extncPamPoint;
    private String preAcrlPoint; //적립예정포인트

    @Decrypted(masked = "none")
    private String wbMemId;
    //private String wbMemYn;
    private String e1MemYn;
    private String sbscChnlCd;
    private String sbscChnlDtlCd;
    private String eventTgtYn;
    private String corpTaxiYn;
    private String mbrStatCd;
    
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatCd")
    private String mbrStatNm;
    private String rid;
    private String ridCust;
    private String addr1JiDflt;
    private String addr1JiDtl;
    private String hCity;
    private String hGu;
    private String addr1JiZip;
    private String emailAddr;      //암호화된 이메일
    @Decrypted(masked = "email")
    private String emailAddrIn;    //부분 복호화된 이메일
    @Decrypted(masked = "none")
    private String emailAddrDec;   //모두 복호화된 이메일
    private String chnlAgreSms;
    private String chnlAgreEmail;
    private String appNewsYn;
    private String appBenefitYn;
    private String semiVipStartDt;
    private String semiVipEndDt;
    private String pntUsePw;
    private String chnlAgreEmailDt;
    private String mktAgrePrvInfoOpt;
    private String marryYn;
    private String marryAniv;
    private String chnlJoinNm; //가입채널명
    private String joinRcmmdNm; //가입 추천 회원 (웹회원ID + 회원명)
    private String simpleMbrSwitchYn; //간편가입 전환회원

    private String custTypeCd;
    @Decrypted(masked = "none")
    private String identiVal;
    private String identiTypeCd;
    private String realnmCertiDate;
    private String famNo;
    private String deviceFailCnt;
    private String rcmmdCd;
    private String smokingYn;
    private String realNmCertiYn;
    private String reqlNmCertiDate;
    private String newuserYn;
    private Integer oneYearBeforeAcrlPoint;
    private Integer lastYearBeforeAcrlPoint;
    
    private String ticketCnt;
    private String genGbnCd;
    
    private String totalPoint;
    private String dataVAl;
    private String bfPwd;
    private String plcyCd;
    private String contRid;

	public String getGenGbnCd() {
		return genGbnCd;
	}

	public void setGenGbnCd(String genGbnCd) {
		this.genGbnCd = genGbnCd;
	}

	public Integer getOneYearBeforeAcrlPoint() {
		return oneYearBeforeAcrlPoint;
	}

	public void setOneYearBeforeAcrlPoint(Integer oneYearBeforeAcrlPoint) {
		this.oneYearBeforeAcrlPoint = oneYearBeforeAcrlPoint;
	}

	public Integer getLastYearBeforeAcrlPoint() {
		return lastYearBeforeAcrlPoint;
	}

	public void setLastYearBeforeAcrlPoint(Integer lastYearBeforeAcrlPoint) {
		this.lastYearBeforeAcrlPoint = lastYearBeforeAcrlPoint;
	}

	public String getRcmmdCd() {
		return rcmmdCd;
	}

	public void setRcmmdCd(String rcmmdCd) {
		this.rcmmdCd = rcmmdCd;
	}

	public String getSmokingYn() {
		return smokingYn;
	}

	public void setSmokingYn(String smokingYn) {
		this.smokingYn = smokingYn;
	}

	public String getRealNmCertiYn() {
		return realNmCertiYn;
	}

	public void setRealNmCertiYn(String realNmCertiYn) {
		this.realNmCertiYn = realNmCertiYn;
	}

	public String getReqlNmCertiDate() {
		return reqlNmCertiDate;
	}

	public void setReqlNmCertiDate(String reqlNmCertiDate) {
		this.reqlNmCertiDate = reqlNmCertiDate;
	}

	public String getFamNo() {
		return famNo;
	}

	public void setFamNo(String famNo) {
		this.famNo = famNo;
	}

	public String getHhpNoIn() {
        return hhpNoIn;
    }

    public void setHhpNoIn(String hhpNoIn) {
        this.hhpNoIn = hhpNoIn;
    }

    public String getEmailAddrIn() {
        return emailAddrIn;
    }

    public void setEmailAddrIn(String emailAddrIn) {
        this.emailAddrIn = emailAddrIn;
    }

    public String getEmailAddrDec() {
        return emailAddrDec;
    }

    public void setEmailAddrDec(String emailAddrDec) {
        this.emailAddrDec = emailAddrDec;
    }

    public String getMbrStatNm() {
        return mbrStatNm;
    }

    public void setMbrStatNm(String mbrStatNm) {
        this.mbrStatNm = mbrStatNm;
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
        if (ObjectUtil.isNotEmpty(this.wbMemId)) {
            return "Y";
        }
        else {
            return "N";
        }
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

    public String getAddr1JiDtl() {
        return addr1JiDtl;
    }

    public void setAddr1JiDtl(String addr1JiDtl) {
        this.addr1JiDtl = addr1JiDtl;
    }

    public String getAddr1JiDflt() {
        return addr1JiDflt;
    }

    public void setAddr1JiDflt(String addr1JiDflt) {
        this.addr1JiDflt = addr1JiDflt;
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

    public String getPntUsePw() {
        return pntUsePw;
    }

    public void setPntUsePw(String pntUsePw) {
        this.pntUsePw = pntUsePw;
    }

    public String getHhpNoDec() {
        return hhpNoDec;
    }

    public void setHhpNoDec(String hhpNoDec) {
        this.hhpNoDec = hhpNoDec;
    }

    /**
     * @return the chnlAgreEmailDt
     */
    public String getChnlAgreEmailDt() {
        return chnlAgreEmailDt;
    }

    /**
     * @param chnlAgreEmailDt
     *            the chnlAgreEmailDt to set
     */
    public void setChnlAgreEmailDt(String chnlAgreEmailDt) {
        this.chnlAgreEmailDt = chnlAgreEmailDt;
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

	public String getPreAcrlPoint() {
		return preAcrlPoint;
	}

	public void setPreAcrlPoint(String preAcrlPoint) {
		this.preAcrlPoint = preAcrlPoint;
	}

	public String getChnlJoinNm() {
		return chnlJoinNm;
	}

	public void setChnlJoinNm(String chnlJoinNm) {
		this.chnlJoinNm = chnlJoinNm;
	}

	public String getJoinRcmmdNm() {
		return joinRcmmdNm;
	}

	public void setJoinRcmmdNm(String joinRcmmdNm) {
		this.joinRcmmdNm = joinRcmmdNm;
	}

	public String getSimpleMbrSwitchYn() {
		return simpleMbrSwitchYn;
	}

	public void setSimpleMbrSwitchYn(String simpleMbrSwitchYn) {
		this.simpleMbrSwitchYn = simpleMbrSwitchYn;
	}

	public String getCustTypeCd() {
		return custTypeCd;
	}

	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}

	public String getIdentiVal() {
		return identiVal;
	}

	public void setIdentiVal(String identiVal) {
		this.identiVal = identiVal;
	}

	public String getIdentiTypeCd() {
		return identiTypeCd;
	}

	public void setIdentiTypeCd(String identiTypeCd) {
		this.identiTypeCd = identiTypeCd;
	}

	public String getRealnmCertiDate() {
		return realnmCertiDate;
	}

	public void setRealnmCertiDate(String realnmCertiDate) {
		this.realnmCertiDate = realnmCertiDate;
	}

	public String getTierNm() {
		return tierNm;
	}

	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	public String getDeviceFailCnt() {
		return deviceFailCnt;
	}

	public void setDeviceFailCnt(String deviceFailCnt) {
		this.deviceFailCnt = deviceFailCnt;
	}

	public String getNewuserYn() {
		return newuserYn;
	}

	public void setNewuserYn(String newuserYn) {
		this.newuserYn = newuserYn;
	}

	public String getEcomMbrNo() {
		return ecomMbrNo;
	}

	public void setEcomMbrNo(String ecomMbrNo) {
		this.ecomMbrNo = ecomMbrNo;
	}

	public String getTicketCnt() {
		return ticketCnt;
	}

	public void setTicketCnt(String ticketCnt) {
		this.ticketCnt = ticketCnt;
	}

	public String getTotalPoint() {
		return totalPoint;
	}

	public void setTotalPoint(String totalPoint) {
		this.totalPoint = totalPoint;
	}

	public String getDataVAl() {
		return dataVAl;
	}

	public void setDataVAl(String dataVAl) {
		this.dataVAl = dataVAl;
	}

	public String getBfPwd() {
		return bfPwd;
	}

	public void setBfPwd(String bfPwd) {
		this.bfPwd = bfPwd;
	}

	public String getPlcyCd() {
		return plcyCd;
	}

	public void setPlcyCd(String plcyCd) {
		this.plcyCd = plcyCd;
	}

	public String getContRid() {
		return contRid;
	}

	public void setContRid(String contRid) {
		this.contRid = contRid;
	}

}
