package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyMbrProcReqDto extends CommonDataAuthReqDto {

	private String name;
	private String wbMemYn;
	private String wbMemId;
	private String identiTypeCd;
	private String diNo;
	private String identiVal;
	private String ipinNo;
	private String rqtNo;
	private String authAgegrd;
	private String altrVrfMsg;
	private String authReslt;
	private String ipadr;
	private String foreignFlg;
	private String sex;
	private String ridMnbsnStn;
	private String homeTelNo;
	private String hhpNo;
	private String emailAddr;
	private String chnlAgreSms;
	private String chnlAgreEmail;
	private String appNewsYn;
	private String appBenefitYn;
	private String addr1JiZip;
	private String hCity;
	private String hGu;
	private String addr1JiDflt;
	private String addr1JiDtl;
	private String addr1Zip;
	private String addr1Dflt;
	private String addr1Dtl;
	private String rdAddrConfirm;
	private String pstmatrRecvDesk;
	private String lunarGbnCd;
	private String birthDay;
	private String marryYn;
	private String marryAniv;
	private String spousLunarGbnCd;
	private String spousBthday;
	private String carModel;
	private String mkngYy;
	private String usePrps;
	private String mktAgreThirdSnd;
	private String termsAgreeFlg;
	private String mktAgrePrvInfo;
	private String cprtCmpnDiv;
	private String smartphPssnYn;
	private String carNo;
	private String pntUsePw;
	private String phCertiYn;
	private String phCertDt;
	private String sbscChnlCd;
	private String cipherKey;
	private String mbrNo;

	private String pResultFlg;
	private String pRslt;
	private String pRsltMsg;
	private String pMbrRid;
	private String pMbrNo;
	private String rsltMsg;


	private String telecomCode;
	private String mobile;
	private String mypinNum;


	private String requestDate;
	private String serviceNo;
	private String tranSerialNum;
	private String mobileCertiSeq;
	private String certiSeq;
	private String certiNo;
	private String smsendSeq;

	private String ridMbr;



	//카드 등록 추가 필드
	private String empId;
	private String cardNo;

	//qim호출여부
	private String qimUseYn;


	public LoyMbrProcReqDto() {
        /*try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
    }
	public String getWbMemYn() {
		return wbMemYn;
	}
	public void setWbMemYn(String wbMemYn) {
		this.wbMemYn = wbMemYn;
	}
	public String getWbMemId() {
		return wbMemId;
	}
	public void setWbMemId(String wbMemId) {
		this.wbMemId = wbMemId;
	}
	public String getIdentiTypeCd() {
		return identiTypeCd;
	}
	public void setIdentiTypeCd(String identiTypeCd) {
		this.identiTypeCd = identiTypeCd;
	}
	public String getDiNo() {
		return diNo;
	}
	public void setDiNo(String diNo) {
		this.diNo = diNo;
	}
	public String getIdentiVal() {
		return identiVal;
	}
	public void setIdentiVal(String identiVal) {
		this.identiVal = identiVal;
	}
	public String getIpinNo() {
		return ipinNo;
	}
	public void setIpinNo(String ipinNo) {
		this.ipinNo = ipinNo;
	}
	public String getRqtNo() {
		return rqtNo;
	}
	public void setRqtNo(String rqtNo) {
		this.rqtNo = rqtNo;
	}
	public String getAuthAgegrd() {
		return authAgegrd;
	}
	public void setAuthAgegrd(String authAgegrd) {
		this.authAgegrd = authAgegrd;
	}
	public String getAltrVrfMsg() {
		return altrVrfMsg;
	}
	public void setAltrVrfMsg(String altrVrfMsg) {
		this.altrVrfMsg = altrVrfMsg;
	}
	public String getAuthReslt() {
		return authReslt;
	}
	public void setAuthReslt(String authReslt) {
		this.authReslt = authReslt;
	}
	public String getIpadr() {
		return ipadr;
	}
	public void setIpadr(String ipadr) {
		this.ipadr = ipadr;
	}
	public String getForeignFlg() {
		return foreignFlg;
	}
	public void setForeignFlg(String foreignCd) {
		this.foreignFlg = foreignCd;
	}
	public String getRidMnbsnStn() {
		return ridMnbsnStn;
	}
	public void setRidMnbsnStn(String ridMnbsnStn) {
		this.ridMnbsnStn = ridMnbsnStn;
	}
	public String getHomeTelNo() {
		return homeTelNo;
	}
	public void setHomeTelNo(String homeTelNo) {
		this.homeTelNo = homeTelNo;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
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
	public String getAddr1JiZip() {
		return addr1JiZip;
	}
	public void setAddr1JiZip(String addr1JiZip) {
		this.addr1JiZip = addr1JiZip;
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
	public String getRdAddrConfirm() {
		return rdAddrConfirm;
	}
	public void setRdAddrConfirm(String rdAddrConfirm) {
		this.rdAddrConfirm = rdAddrConfirm;
	}
	public String getPstmatrRecvDesk() {
		return pstmatrRecvDesk;
	}
	public void setPstmatrRecvDesk(String pstmatrRecvDesk) {
		this.pstmatrRecvDesk = pstmatrRecvDesk;
	}
	public String getLunarGbnCd() {
		return lunarGbnCd;
	}
	public void setLunarGbnCd(String lunarGbnCd) {
		this.lunarGbnCd = lunarGbnCd;
	}
	public String getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(String birthDt) {
		this.birthDay = birthDt;
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
	public String getSpousLunarGbnCd() {
		return spousLunarGbnCd;
	}
	public void setSpousLunarGbnCd(String spousLunarGbnCd) {
		this.spousLunarGbnCd = spousLunarGbnCd;
	}
	public String getSpousBthday() {
		return spousBthday;
	}
	public void setSpousBthday(String spousBthday) {
		this.spousBthday = spousBthday;
	}
	public String getCarModel() {
		return carModel;
	}
	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}
	public String getMkngYy() {
		return mkngYy;
	}
	public void setMkngYy(String mkngYy) {
		this.mkngYy = mkngYy;
	}
	public String getUsePrps() {
		return usePrps;
	}
	public void setUsePrps(String usePrps) {
		this.usePrps = usePrps;
	}
	public String getMktAgreThirdSnd() {
		return mktAgreThirdSnd;
	}
	public void setMktAgreThirdSnd(String mktAgreThirdSnd) {
		this.mktAgreThirdSnd = mktAgreThirdSnd;
	}
	public String getTermsAgreeFlg() {
		return termsAgreeFlg;
	}
	public void setTermsAgreeFlg(String termsAgreeFlg) {
		this.termsAgreeFlg = termsAgreeFlg;
	}
	public String getMktAgrePrvInfo() {
		return mktAgrePrvInfo;
	}
	public void setMktAgrePrvInfo(String mktAgrePrvInfo) {
		this.mktAgrePrvInfo = mktAgrePrvInfo;
	}
	public String getCprtCmpnDiv() {
		return cprtCmpnDiv;
	}
	public void setCprtCmpnDiv(String cprtCmpnDiv) {
		this.cprtCmpnDiv = cprtCmpnDiv;
	}
	public String getSmartphPssnYn() {
		return smartphPssnYn;
	}
	public void setSmartphPssnYn(String smartphPssnYn) {
		this.smartphPssnYn = smartphPssnYn;
	}
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	public String getPntUsePw() {
		return pntUsePw;
	}
	public void setPntUsePw(String pntUsePw) {
		this.pntUsePw = pntUsePw;
	}
	public String getPhCertiYn() {
		return phCertiYn;
	}
	public void setPhCertiYn(String phCertiYn) {
		this.phCertiYn = phCertiYn;
	}
	public String getPhCertDt() {
		return phCertDt;
	}
	public void setPhCertDt(String phCertDt) {
		this.phCertDt = phCertDt;
	}
	public String getSbscChnlCd() {
		return sbscChnlCd;
	}
	public void setSbscChnlCd(String sbscChnlCd) {
		this.sbscChnlCd = sbscChnlCd;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	public String getpResultFlg() {
		return pResultFlg;
	}
	public void setpResultFlg(String pResultFlg) {
		this.pResultFlg = pResultFlg;
	}
	public String getpRslt() {
		return pRslt;
	}
	public void setpRslt(String pRslt) {
		this.pRslt = pRslt;
	}
	public String getpRsltMsg() {
		return pRsltMsg;
	}
	public void setpRsltMsg(String pRsltMsg) {
		this.pRsltMsg = pRsltMsg;
	}
	public String getpMbrRid() {
		return pMbrRid;
	}
	public void setpMbrRid(String pMbrRid) {
		this.pMbrRid = pMbrRid;
	}
	public String getpMbrNo() {
		return pMbrNo;
	}
	public void setpMbrNo(String pMbrNo) {
		this.pMbrNo = pMbrNo;
	}
	public String getRsltMsg() {
		return rsltMsg;
	}
	public void setRsltMsg(String rsltMsg) {
		this.rsltMsg = rsltMsg;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getTelecomCode() {
		return telecomCode;
	}
	public void setTelecomCode(String telecomCode) {
		this.telecomCode = telecomCode;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getMypinNum() {
		return mypinNum;
	}
	public void setMypinNum(String mypinNum) {
		this.mypinNum = mypinNum;
	}
	/**
	* @return the requestDate
	*/
	public String getRequestDate() {
		return requestDate;
	}
	/**
	* @param requestDate the requestDate to set
	*/
	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}
	/**
	* @return the serviceNo
	*/
	public String getServiceNo() {
		return serviceNo;
	}
	/**
	* @param serviceNo the serviceNo to set
	*/
	public void setServiceNo(String serviceNo) {
		this.serviceNo = serviceNo;
	}
	/**
	* @return the tranSerialNum
	*/
	public String getTranSerialNum() {
		return tranSerialNum;
	}
	/**
	* @param tranSerialNum the tranSerialNum to set
	*/
	public void setTranSerialNum(String tranSerialNum) {
		this.tranSerialNum = tranSerialNum;
	}
	/**
	* @return the mobileCertiSeq
	*/
	public String getMobileCertiSeq() {
		return mobileCertiSeq;
	}
	/**
	* @param mobileCertiSeq the mobileCertiSeq to set
	*/
	public void setMobileCertiSeq(String mobileCertiSeq) {
		this.mobileCertiSeq = mobileCertiSeq;
	}
	/**
	* @return the certiSeq
	*/
	public String getCertiSeq() {
		return certiSeq;
	}
	/**
	* @param certiSeq the certiSeq to set
	*/
	public void setCertiSeq(String certiSeq) {
		this.certiSeq = certiSeq;
	}
	/**
	* @return the certiNo
	*/
	public String getCertiNo() {
		return certiNo;
	}
	/**
	* @param certiNo the certiNo to set
	*/
	public void setCertiNo(String certiNo) {
		this.certiNo = certiNo;
	}
	/**
	* @return the name
	*/
	public String getName() {
		return name;
	}
	/**
	* @param name the name to set
	*/
	public void setName(String name) {
		this.name = name;
	}
	/**
	* @return the smsendSeq
	*/
	public String getSmsendSeq() {
		return smsendSeq;
	}
	/**
	* @param smsendSeq the smsendSeq to set
	*/
	public void setSmsendSeq(String smsendSeq) {
		this.smsendSeq = smsendSeq;
	}
	/**
	* @return the sex
	*/
	public String getSex() {
		return sex;
	}
	/**
	* @param sex the sex to set
	*/
	public void setSex(String sex) {
		this.sex = sex;
	}
	/**
	* @return the ridMbr
	*/
	public String getRidMbr() {
		return ridMbr;
	}
	/**
	* @param ridMbr the ridMbr to set
	*/
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getQimUseYn() {
		return qimUseYn;
	}
	public void setQimUseYn(String qimUseYn) {
		this.qimUseYn = qimUseYn;
	}





}
