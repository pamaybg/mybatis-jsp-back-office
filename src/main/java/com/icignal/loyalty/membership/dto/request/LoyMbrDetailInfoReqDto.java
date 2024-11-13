package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyMbrDetailInfoReqDto extends CommonDataAuthReqDto {
    private String marryYn;
    private String marryAniv; //다이소 기념일필드 - Loy_mbr.ANIV_DT로 변경
    private String job;
    // private String jobMarkName ;
    private String genGbnCdMarkName;
    private String genGbnCd;
    private String addr1JiZip;
    private String ownhomeAdrChgDt;
    private String addr1JiDflt;
    private String addr1JiDtl;
    private String ridMnbsnStn;
    // private String pstmatrRecvDeskMarkName ;
    private String pstmatrRecvDesk;
    private String offTelNo;
    private String hpChgDt;
    private String faxNo;
    @Encrypted
    private String emailAddr;
    private String emailChgDt;
    private String realnmCertiYn;
    private String hpErrYn;
    private String emailErrYn;
    private String smartphPssnYn;
    private String chnlAgreSms;
    private String chnlAgreEmail;
    private String appNewsYn;
    private String appBenefitYn;
    private String appDownlYn;
    private String iparkInfoPrvAgreeYn;
    private String autordmAgreeYn;
    private String autordmPoint;
    private String autordmChgDt;
    private String pclrMtr;
    private String identiTypeCd;
    // private String identiTypeCdMarkName;
    private String wbSbscDt;
    private String calCentrSbscDt;
    // private String fraudMemDivMarkName ;
    private String fraudMemDiv;
    // private String actnDivMarkName ;
    private String actnDiv;
    private String wkplcNm;
    private String deptNm;
    private String addr2JiZip;
    private String wkplcAdrChgDt;
    private String addr2JiDflt;
    private String addr2JiDtl;
    // private String intrstFild1MarkName ;
    private String intrstFild1;
    // private String intrstFild2MarkName ;
    private String intrstFild2;
    private String addr2Zip;
    private String addr2Dflt;
    private String addr2Dtl;
    private String indvTaxiConvRqt;
    private String ipinNo;
    private String altrVrfMsg;
    private String authAgegrd;
    // private String authAgegrdMarkName ;
    private String authReslt;
    // private String authResltMarkName ;
    private String rqtNo;
    private String ipadr;
    // private String mbrTypeCdMarkName ;
    private String mbrTypeCd;
    // private String mbrStatCdMarkName ;
    private String mbrStatCd;
    private String camTgtMem;
    // private String camTgtMemMarkName ;
    private String pmonChargAmt;
    // private String spousLunarGbnCdCode ;
    private String spousLunarGbnCd;
    private String childFlg;
    private String custValue;
    private String memLcStage;
    private String carUsePurp;
    private String spousBthday;
    private String ownhomeTelErrYn;
    private String cmpnTelErrYn;
    private String chnlAgreDm;
    private String chnlAgreTel;
    private String pmonChagrQnt;
    // private String foreignCdMarkName ;
    private String foreignCd;
    private String chnlNm;
    private String rid;
    private String mbrNo;
    private String phCertiYn;
    private String addr1Zip;
    private String addr1Dflt;
    private String addr1Dtl;
    private String hCity;
    private String hGu;
    private String mktAgrePrmEvt;
    private String mktAgrePrvInfoOpt;
    private String chnlAgreKkatlk;
    private String cipherKey;
    private String kkatlkRcvYn;
    private String homeTelNo;

    private String chnlAgrePush;    //푸시 기본 동의여부
    private String chnlAgreKakao;   //카카오톡 수신동의여부
    private String eReceiptUseYn;   //전자영수증사용여부
    private String mktAgrePrvInfo;  //개인정보수집이용동의
    private String mktAgreLbsBiz;   //위치정보수집동의
    private String mktAgreUse;      //마케팅활동동의
    private String mktAgreThirdSnd; //개인정보제3자제공동의
    private String mbrTermsAgre;    //다이소멤버십이용동의
    
    private String anivDt; //(다이소) 기념일
    
    private String pntAcrlYn;
    private String pntUseYn;
    private String pntAcrlNMsg;
    private String pntUserNMsg;

    public String getChnlAgrePush() {
        return chnlAgrePush;
    }

    public void setChnlAgrePush(String chnlAgrePush) {
        this.chnlAgrePush = chnlAgrePush;
    }

    public String getChnlAgreKakao() {
        return chnlAgreKakao;
    }

    public void setChnlAgreKakao(String chnlAgreKakao) {
        this.chnlAgreKakao = chnlAgreKakao;
    }

    public String geteReceiptUseYn() {
        return eReceiptUseYn;
    }

    public void seteReceiptUseYn(String eReceiptUseYn) {
        this.eReceiptUseYn = eReceiptUseYn;
    }

    public String getMktAgrePrvInfo() {
        return mktAgrePrvInfo;
    }

    public void setMktAgrePrvInfo(String mktAgrePrvInfo) {
        this.mktAgrePrvInfo = mktAgrePrvInfo;
    }

    public LoyMbrDetailInfoReqDto() {
    /*    try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch (Exception e) {
            LogUtil.error(e);
        }*/
    }

    public String getMarryYn() {
        return marryYn;
    }

    public void setMarryYn(String marryYn) {
        this.marryYn = marryYn;
    }

    public String getMarryAniv() {
        return marryAniv;
    }

    public void setMarryAniv(String marryAniv) {
        this.marryAniv = marryAniv;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getGenGbnCdMarkName() {
        return genGbnCdMarkName;
    }

    public void setGenGbnCdMarkName(String genGbnCdMarkName) {
        this.genGbnCdMarkName = genGbnCdMarkName;
    }

    public String getGenGbnCd() {
        return genGbnCd;
    }

    public void setGenGbnCd(String genGbnCd) {
        this.genGbnCd = genGbnCd;
    }

    public String getAddr1JiZip() {
        return addr1JiZip;
    }

    public void setAddr1JiZip(String addr1JiZip) {
        this.addr1JiZip = addr1JiZip;
    }

    public String getOwnhomeAdrChgDt() {
        return ownhomeAdrChgDt;
    }

    public void setOwnhomeAdrChgDt(String ownhomeAdrChgDt) {
        this.ownhomeAdrChgDt = ownhomeAdrChgDt;
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

    public String getRidMnbsnStn() {
        return ridMnbsnStn;
    }

    public void setRidMnbsnStn(String ridMnbsnStn) {
        this.ridMnbsnStn = ridMnbsnStn;
    }

    public String getPstmatrRecvDesk() {
        return pstmatrRecvDesk;
    }

    public void setPstmatrRecvDesk(String pstmatrRecvDesk) {
        this.pstmatrRecvDesk = pstmatrRecvDesk;
    }

    public String getOffTelNo() {
        return offTelNo;
    }

    public void setOffTelNo(String offTelNo) {
        this.offTelNo = offTelNo;
    }

    public String getHpChgDt() {
        return hpChgDt;
    }

    public void setHpChgDt(String hpChgDt) {
        this.hpChgDt = hpChgDt;
    }

    public String getFaxNo() {
        return faxNo;
    }

    public void setFaxNo(String faxNo) {
        this.faxNo = faxNo;
    }

    public String getEmailAddr() {
        return emailAddr;
    }

    public void setEmailAddr(String emailAddr) {
        this.emailAddr = emailAddr;
    }

    public String getEmailChgDt() {
        return emailChgDt;
    }

    public void setEmailChgDt(String emailChgDt) {
        this.emailChgDt = emailChgDt;
    }

    public String getRealnmCertiYn() {
        return realnmCertiYn;
    }

    public void setRealnmCertiYn(String realnmCertiYn) {
        this.realnmCertiYn = realnmCertiYn;
    }

    public String getHpErrYn() {
        return hpErrYn;
    }

    public void setHpErrYn(String hpErrYn) {
        this.hpErrYn = hpErrYn;
    }

    public String getEmailErrYn() {
        return emailErrYn;
    }

    public void setEmailErrYn(String emailErrYn) {
        this.emailErrYn = emailErrYn;
    }

    public String getSmartphPssnYn() {
        return smartphPssnYn;
    }

    public void setSmartphPssnYn(String smartphPssnYn) {
        this.smartphPssnYn = smartphPssnYn;
    }

    public String getChnlAgreSms() {
        return chnlAgreSms;
    }

    public void setChnlAgreSms(String chnlAgreSms) {
        this.chnlAgreSms = chnlAgreSms;
    }

    public String getChnlAgreEmail() {
        return chnlAgreEmail;
    }

    public void setChnlAgreEmail(String chnlAgreEmail) {
        this.chnlAgreEmail = chnlAgreEmail;
    }

    public String getAppNewsYn() {
        return appNewsYn;
    }

    public void setAppNewsYn(String appNewsYn) {
        this.appNewsYn = appNewsYn;
    }

    public String getAppBenefitYn() {
        return appBenefitYn;
    }

    public void setAppBenefitYn(String appBenefitYn) {
        this.appBenefitYn = appBenefitYn;
    }

    public String getAppDownlYn() {
        return appDownlYn;
    }

    public void setAppDownlYn(String appDownlYn) {
        this.appDownlYn = appDownlYn;
    }

    public String getIparkInfoPrvAgreeYn() {
        return iparkInfoPrvAgreeYn;
    }

    public void setIparkInfoPrvAgreeYn(String iparkInfoPrvAgreeYn) {
        this.iparkInfoPrvAgreeYn = iparkInfoPrvAgreeYn;
    }

    public String getAutordmAgreeYn() {
        return autordmAgreeYn;
    }

    public void setAutordmAgreeYn(String autordmAgreeYn) {
        this.autordmAgreeYn = autordmAgreeYn;
    }

    public String getAutordmPoint() {
        return autordmPoint;
    }

    public void setAutordmPoint(String autordmPoint) {
        this.autordmPoint = autordmPoint;
    }

    public String getAutordmChgDt() {
        return autordmChgDt;
    }

    public void setAutordmChgDt(String autordmChgDt) {
        this.autordmChgDt = autordmChgDt;
    }

    public String getPclrMtr() {
        return pclrMtr;
    }

    public void setPclrMtr(String pclrMtr) {
        this.pclrMtr = pclrMtr;
    }

    public String getIdentiTypeCd() {
        return identiTypeCd;
    }

    public void setIdentiTypeCd(String identiTypeCd) {
        this.identiTypeCd = identiTypeCd;
    }

    public String getWbSbscDt() {
        return wbSbscDt;
    }

    public void setWbSbscDt(String wbSbscDt) {
        this.wbSbscDt = wbSbscDt;
    }

    public String getCalCentrSbscDt() {
        return calCentrSbscDt;
    }

    public void setCalCentrSbscDt(String calCentrSbscDt) {
        this.calCentrSbscDt = calCentrSbscDt;
    }

    public String getFraudMemDiv() {
        return fraudMemDiv;
    }

    public void setFraudMemDiv(String fraudMemDiv) {
        this.fraudMemDiv = fraudMemDiv;
    }

    public String getActnDiv() {
        return actnDiv;
    }

    public void setActnDiv(String actnDiv) {
        this.actnDiv = actnDiv;
    }

    public String getWkplcNm() {
        return wkplcNm;
    }

    public void setWkplcNm(String wkplcNm) {
        this.wkplcNm = wkplcNm;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getAddr2JiZip() {
        return addr2JiZip;
    }

    public void setAddr2JiZip(String addr2JiZip) {
        this.addr2JiZip = addr2JiZip;
    }

    public String getWkplcAdrChgDt() {
        return wkplcAdrChgDt;
    }

    public void setWkplcAdrChgDt(String wkplcAdrChgDt) {
        this.wkplcAdrChgDt = wkplcAdrChgDt;
    }

    public String getAddr2JiDflt() {
        return addr2JiDflt;
    }

    public void setAddr2JiDflt(String addr2JiDflt) {
        this.addr2JiDflt = addr2JiDflt;
    }

    public String getAddr2JiDtl() {
        return addr2JiDtl;
    }

    public void setAddr2JiDtl(String addr2JiDtl) {
        this.addr2JiDtl = addr2JiDtl;
    }

    public String getIntrstFild1() {
        return intrstFild1;
    }

    public void setIntrstFild1(String intrstFild1) {
        this.intrstFild1 = intrstFild1;
    }

    public String getIntrstFild2() {
        return intrstFild2;
    }

    public void setIntrstFild2(String intrstFild2) {
        this.intrstFild2 = intrstFild2;
    }

    public String getAddr2Zip() {
        return addr2Zip;
    }

    public void setAddr2Zip(String addr2Zip) {
        this.addr2Zip = addr2Zip;
    }

    public String getAddr2Dflt() {
        return addr2Dflt;
    }

    public void setAddr2Dflt(String addr2Dflt) {
        this.addr2Dflt = addr2Dflt;
    }

    public String getAddr2Dtl() {
        return addr2Dtl;
    }

    public void setAddr2Dtl(String addr2Dtl) {
        this.addr2Dtl = addr2Dtl;
    }

    public String getIndvTaxiConvRqt() {
        return indvTaxiConvRqt;
    }

    public void setIndvTaxiConvRqt(String indvTaxiConvRqt) {
        this.indvTaxiConvRqt = indvTaxiConvRqt;
    }

    public String getIpinNo() {
        return ipinNo;
    }

    public void setIpinNo(String ipinNo) {
        this.ipinNo = ipinNo;
    }

    public String getAltrVrfMsg() {
        return altrVrfMsg;
    }

    public void setAltrVrfMsg(String altrVrfMsg) {
        this.altrVrfMsg = altrVrfMsg;
    }

    public String getAuthAgegrd() {
        return authAgegrd;
    }

    public void setAuthAgegrd(String authAgegrd) {
        this.authAgegrd = authAgegrd;
    }

    public String getAuthReslt() {
        return authReslt;
    }

    public void setAuthReslt(String authReslt) {
        this.authReslt = authReslt;
    }

    public String getRqtNo() {
        return rqtNo;
    }

    public void setRqtNo(String rqtNo) {
        this.rqtNo = rqtNo;
    }

    public String getIpadr() {
        return ipadr;
    }

    public void setIpadr(String ipadr) {
        this.ipadr = ipadr;
    }

    public String getMbrTypeCd() {
        return mbrTypeCd;
    }

    public void setMbrTypeCd(String mbrTypeCd) {
        this.mbrTypeCd = mbrTypeCd;
    }

    public String getMbrStatCd() {
        return mbrStatCd;
    }

    public void setMbrStatCd(String mbrStatCd) {
        this.mbrStatCd = mbrStatCd;
    }

    public String getCamTgtMem() {
        return camTgtMem;
    }

    public void setCamTgtMem(String camTgtMem) {
        this.camTgtMem = camTgtMem;
    }

    public String getPmonChargAmt() {
        return pmonChargAmt;
    }

    public void setPmonChargAmt(String pmonChargAmt) {
        this.pmonChargAmt = pmonChargAmt;
    }

    public String getSpousLunarGbnCd() {
        return spousLunarGbnCd;
    }

    public void setSpousLunarGbnCd(String spousLunarGbnCd) {
        this.spousLunarGbnCd = spousLunarGbnCd;
    }

    public String getChildFlg() {
        return childFlg;
    }

    public void setChildFlg(String childFlg) {
        this.childFlg = childFlg;
    }

    public String getCustValue() {
        return custValue;
    }

    public void setCustValue(String custValue) {
        this.custValue = custValue;
    }

    public String getMemLcStage() {
        return memLcStage;
    }

    public void setMemLcStage(String memLcStage) {
        this.memLcStage = memLcStage;
    }

    public String getCarUsePurp() {
        return carUsePurp;
    }

    public void setCarUsePurp(String carUsePurp) {
        this.carUsePurp = carUsePurp;
    }

    public String getSpousBthday() {
        return spousBthday;
    }

    public void setSpousBthday(String spousBthday) {
        this.spousBthday = spousBthday;
    }

    public String getOwnhomeTelErrYn() {
        return ownhomeTelErrYn;
    }

    public void setOwnhomeTelErrYn(String ownhomeTelErrYn) {
        this.ownhomeTelErrYn = ownhomeTelErrYn;
    }

    public String getCmpnTelErrYn() {
        return cmpnTelErrYn;
    }

    public void setCmpnTelErrYn(String cmpnTelErrYn) {
        this.cmpnTelErrYn = cmpnTelErrYn;
    }

    public String getChnlAgreDm() {
        return chnlAgreDm;
    }

    public void setChnlAgreDm(String chnlAgreDm) {
        this.chnlAgreDm = chnlAgreDm;
    }

    public String getChnlAgreTel() {
        return chnlAgreTel;
    }

    public void setChnlAgreTel(String chnlAgreTel) {
        this.chnlAgreTel = chnlAgreTel;
    }

    public String getPmonChagrQnt() {
        return pmonChagrQnt;
    }

    public void setPmonChagrQnt(String pmonChagrQnt) {
        this.pmonChagrQnt = pmonChagrQnt;
    }

    public String getForeignCd() {
        return foreignCd;
    }

    public void setForeignCd(String foreignCd) {
        this.foreignCd = foreignCd;
    }

    public String getChnlNm() {
        return chnlNm;
    }

    public void setChnlNm(String chnlNm) {
        this.chnlNm = chnlNm;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    /**
     * @return the phCertiYn
     */
    public String getPhCertiYn() {
        return phCertiYn;
    }

    /**
     * @param phCertiYn
     *            the phCertiYn to set
     */
    public void setPhCertiYn(String phCertiYn) {
        this.phCertiYn = phCertiYn;
    }

    public String getAddr1Zip() {
        return addr1Zip;
    }

    public void setAddr1Zip(String addr1Zip) {
        this.addr1Zip = addr1Zip;
    }

    public String getAddr1Dflt() {
        return addr1Dflt;
    }

    public void setAddr1Dflt(String addr1Dflt) {
        this.addr1Dflt = addr1Dflt;
    }

    public String getAddr1Dtl() {
        return addr1Dtl;
    }

    public void setAddr1Dtl(String addr1Dtl) {
        this.addr1Dtl = addr1Dtl;
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

    public String getMktAgrePrmEvt() {
        return mktAgrePrmEvt;
    }

    public void setMktAgrePrmEvt(String mktAgrePrmEvt) {
        this.mktAgrePrmEvt = mktAgrePrmEvt;
    }

    public String getChnlAgreKkatlk() {
        return chnlAgreKkatlk;
    }

    public void setChnlAgreKkatlk(String chnlAgreKkatlk) {
        this.chnlAgreKkatlk = chnlAgreKkatlk;
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
     * @return the kkatlkRcvYn
     */
    public String getKkatlkRcvYn() {
        return kkatlkRcvYn;
    }

    /**
     * @param kkatlkRcvYn
     *            the kkatlkRcvYn to set
     */
    public void setKkatlkRcvYn(String kkatlkRcvYn) {
        this.kkatlkRcvYn = kkatlkRcvYn;
    }

    /**
     * @return the homeTelNo
     */
    public String getHomeTelNo() {
        return homeTelNo;
    }

    /**
     * @param homeTelNo
     *            the homeTelNo to set
     */
    public void setHomeTelNo(String homeTelNo) {
        this.homeTelNo = homeTelNo;
    }

	public String getAnivDt() {
		return anivDt;
	}

	public void setAnivDt(String anivDt) {
		this.anivDt = anivDt;
	}

	public String getMktAgreLbsBiz() {
		return mktAgreLbsBiz;
	}

	public void setMktAgreLbsBiz(String mktAgreLbsBiz) {
		this.mktAgreLbsBiz = mktAgreLbsBiz;
	}

	public String getMktAgreUse() {
		return mktAgreUse;
	}

	public void setMktAgreUse(String mktAgreUse) {
		this.mktAgreUse = mktAgreUse;
	}

	public String getMktAgreThirdSnd() {
		return mktAgreThirdSnd;
	}

	public void setMktAgreThirdSnd(String mktAgreThirdSnd) {
		this.mktAgreThirdSnd = mktAgreThirdSnd;
	}

	public String getMbrTermsAgre() {
		return mbrTermsAgre;
	}

	public void setMbrTermsAgre(String mbrTermsAgre) {
		this.mbrTermsAgre = mbrTermsAgre;
	}

	public String getPntAcrlYn() {
		return pntAcrlYn;
	}

	public void setPntAcrlYn(String pntAcrlYn) {
		this.pntAcrlYn = pntAcrlYn;
	}

	public String getPntUseYn() {
		return pntUseYn;
	}

	public void setPntUseYn(String pntUseYn) {
		this.pntUseYn = pntUseYn;
	}

	public String getPntAcrlNMsg() {
		return pntAcrlNMsg;
	}

	public void setPntAcrlNMsg(String pntAcrlNMsg) {
		this.pntAcrlNMsg = pntAcrlNMsg;
	}

	public String getPntUserNMsg() {
		return pntUserNMsg;
	}

	public void setPntUserNMsg(String pntUserNMsg) {
		this.pntUserNMsg = pntUserNMsg;
	}

}
