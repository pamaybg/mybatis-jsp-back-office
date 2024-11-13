package com.icignal.loyalty.channel.dto.response;

/*
 * 1. 클래스명	: LoyChnlAddInfoResDto
 * 2. 파일명	: LoyChnlAddInfoResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 10. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChnlAddInfoResDto {

    private String rid;

    private String flag;

    private String chnlKeySeq;
    private String chnlNo;
    private String chnlNm;
    private String chnlStatCd;
    private String chnlTypeCd;
    private String chnlTypeSubCd;
    private String chnlLvlNo;
    private String parRid;
    private String parRidTop;
    private String partKeySeq;
    private String ridTerms;
    private String parKeySeqTop;
    private String ridPgm;
    private String ridCustPr;
    private String acrlPsblYn;
    private String usePsblYn;
    private String mbrJoinPsblYn;
    private String mbrbsStatusCd;
    private String fraudMbrbsActnDesc;
    private String fraudMbrbsActnDiv;
    private String fraudDiv;
    private String bizrNo;
    private String dnatEndDay;
    private String dnatStartDay;
    private String fndDd;
    private String rmark;
    private String hyndCardApdAcuRate;
    private String plotgNfpy;
    private String cmpetLevel;
    private String trdare;
    private String pointConvYn;
    private String indvTaxiUnionStn;
    private String airgunYn;
    private String autoCwYn;
    private String foyerYn;
    private String matwashYn;
    private String poslYn;
    private String factoryYn;
    private String stnAcuCardOprt;
    private String email;
    private String faxNo;
    private String telNo;
    private String sbscDd;
    private String stnPointAplyMeth;
    private String stnPointAplyUnit;
    private String stnPointBaseAcuPoint;
    private String stnPointOprtYn;
    private String oprtPrps;
    private String parMbrbsYn;
    private String adrDtl;
    private String hpNo;
    private String trmnDd;
    private String mbrbsCdadd;
    private String trmnYn;
    private String pointContType;
    private String roadNmAdr;
    private String roadNmAdrZipcd;
    private String selfWashYn;
    private String vacumYn;
    private String tierPYn;
    private String sinkYn;
    private String vendingYn;
    private String runOnlineYn;
    private String mobileCouponYn;
    private String lowMbrbsCretDivNm;
    private String lowMbrbsCd;
    private String stnDiv;
    private String reprNm;
    private String zipCd;
    private String stnTkcgrCmpno;
    private String stnTkcgr;
    private String ridAcrlRule;
    private String ridAdjRule;
    private String ridRdmRule;
    private String apvSrvrTrmDt;
    private String apvSrvrTrmYn;
    private String ridStnMgmtDiv;
    private String ouTypeCd;
    private String sido;
    private String gugun;
    private String latitude;
    private String longitude;
    private String ridE1Mbr;
    private String ridPerMbr;
    private String acrlRuleCd;
    private String acrlRuleTypeCd;
    private String adjRuleCd;
    private String adjRuleTypeCd;
    private String mbrbsStatusCd2;
    private String parChnlNo;
    private String parChnlNm;

    private String chnlParkingYn;
    private String chnlNamestickerYn;
    private String chnlPhotocardYn;
    private String chnlPyeong;
    private String chnlActStatCd;
    private String ctg;
    private String nextDayOperYn;

    private String chnlOpenTime;
    private String chnlCloseTime;
    
    private String chnlShpPardes; /*주차메모*/
    private String chnlPtstkYn; /*포토스티커여부*/

    public String getChnlOpenTime() {
        return chnlOpenTime;
    }

    public void setChnlOpenTime(String chnlOpenTime) {
        this.chnlOpenTime = chnlOpenTime;
    }

    public String getChnlCloseTime() {
        return chnlCloseTime;
    }

    public void setChnlCloseTime(String chnlCloseTime) {
        this.chnlCloseTime = chnlCloseTime;
    }

    public String getNextDayOperYn() {
        return nextDayOperYn;
    }

    public void setNextDayOperYn(String nextDayOperYn) {
        this.nextDayOperYn = nextDayOperYn;
    }

    public String getCtg() {
        return ctg;
    }

    public void setCtg(String ctg) {
        this.ctg = ctg;
    }

    public String getChnlParkingYn() {
        return chnlParkingYn;
    }

    public void setChnlParkingYn(String chnlParkingYn) {
        this.chnlParkingYn = chnlParkingYn;
    }

    public String getChnlNamestickerYn() {
        return chnlNamestickerYn;
    }

    public void setChnlNamestickerYn(String chnlNamestickerYn) {
        this.chnlNamestickerYn = chnlNamestickerYn;
    }

    public String getChnlPhotocardYn() {
        return chnlPhotocardYn;
    }

    public void setChnlPhotocardYn(String chnlPhotocardYn) {
        this.chnlPhotocardYn = chnlPhotocardYn;
    }

    public String getChnlPyeong() {
        return chnlPyeong;
    }

    public void setChnlPyeong(String chnlPyeong) {
        this.chnlPyeong = chnlPyeong;
    }

    public String getChnlActStatCd() {
        return chnlActStatCd;
    }

    public void setChnlActStatCd(String chnlActStatCd) {
        this.chnlActStatCd = chnlActStatCd;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getChnlKeySeq() {
        return chnlKeySeq;
    }

    public void setChnlKeySeq(String chnlKeySeq) {
        this.chnlKeySeq = chnlKeySeq;
    }

    public String getChnlNo() {
        return chnlNo;
    }

    public void setChnlNo(String chnlNo) {
        this.chnlNo = chnlNo;
    }

    public String getChnlNm() {
        return chnlNm;
    }

    public void setChnlNm(String chnlNm) {
        this.chnlNm = chnlNm;
    }

    public String getChnlStatCd() {
        return chnlStatCd;
    }

    public void setChnlStatCd(String chnlStatCd) {
        this.chnlStatCd = chnlStatCd;
    }

    public String getChnlTypeCd() {
        return chnlTypeCd;
    }

    public void setChnlTypeCd(String chnlTypeCd) {
        this.chnlTypeCd = chnlTypeCd;
    }

    public String getChnlTypeSubCd() {
        return chnlTypeSubCd;
    }

    public void setChnlTypeSubCd(String chnlTypeSubCd) {
        this.chnlTypeSubCd = chnlTypeSubCd;
    }

    public String getChnlLvlNo() {
        return chnlLvlNo;
    }

    public void setChnlLvlNo(String chnlLvlNo) {
        this.chnlLvlNo = chnlLvlNo;
    }

    public String getParRid() {
        return parRid;
    }

    public void setParRid(String parRid) {
        this.parRid = parRid;
    }

    public String getParRidTop() {
        return parRidTop;
    }

    public void setParRidTop(String parRidTop) {
        this.parRidTop = parRidTop;
    }

    public String getPartKeySeq() {
        return partKeySeq;
    }

    public void setPartKeySeq(String partKeySeq) {
        this.partKeySeq = partKeySeq;
    }

    public String getRidTerms() {
        return ridTerms;
    }

    public void setRidTerms(String ridTerms) {
        this.ridTerms = ridTerms;
    }

    public String getParKeySeqTop() {
        return parKeySeqTop;
    }

    public void setParKeySeqTop(String parKeySeqTop) {
        this.parKeySeqTop = parKeySeqTop;
    }

    public String getRidPgm() {
        return ridPgm;
    }

    public void setRidPgm(String ridPgm) {
        this.ridPgm = ridPgm;
    }

    public String getRidCustPr() {
        return ridCustPr;
    }

    public void setRidCustPr(String ridCustPr) {
        this.ridCustPr = ridCustPr;
    }

    public String getAcrlPsblYn() {
        return acrlPsblYn;
    }

    public void setAcrlPsblYn(String acrlPsblYn) {
        this.acrlPsblYn = acrlPsblYn;
    }

    public String getUsePsblYn() {
        return usePsblYn;
    }

    public void setUsePsblYn(String usePsblYn) {
        this.usePsblYn = usePsblYn;
    }

    public String getMbrJoinPsblYn() {
        return mbrJoinPsblYn;
    }

    public void setMbrJoinPsblYn(String mbrJoinPsblYn) {
        this.mbrJoinPsblYn = mbrJoinPsblYn;
    }

    public String getMbrbsStatusCd() {
        return mbrbsStatusCd;
    }

    public void setMbrbsStatusCd(String mbrbsStatusCd) {
        this.mbrbsStatusCd = mbrbsStatusCd;
    }

    public String getFraudMbrbsActnDesc() {
        return fraudMbrbsActnDesc;
    }

    public void setFraudMbrbsActnDesc(String fraudMbrbsActnDesc) {
        this.fraudMbrbsActnDesc = fraudMbrbsActnDesc;
    }

    public String getFraudMbrbsActnDiv() {
        return fraudMbrbsActnDiv;
    }

    public void setFraudMbrbsActnDiv(String fraudMbrbsActnDiv) {
        this.fraudMbrbsActnDiv = fraudMbrbsActnDiv;
    }

    public String getFraudDiv() {
        return fraudDiv;
    }

    public void setFraudDiv(String fraudDiv) {
        this.fraudDiv = fraudDiv;
    }

    public String getBizrNo() {
        return bizrNo;
    }

    public void setBizrNo(String bizrNo) {
        this.bizrNo = bizrNo;
    }

    public String getDnatEndDay() {
        return dnatEndDay;
    }

    public void setDnatEndDay(String dnatEndDay) {
        this.dnatEndDay = dnatEndDay;
    }

    public String getDnatStartDay() {
        return dnatStartDay;
    }

    public void setDnatStartDay(String dnatStartDay) {
        this.dnatStartDay = dnatStartDay;
    }

    public String getFndDd() {
        return fndDd;
    }

    public void setFndDd(String fndDd) {
        this.fndDd = fndDd;
    }

    public String getRmark() {
        return rmark;
    }

    public void setRmark(String rmark) {
        this.rmark = rmark;
    }

    public String getHyndCardApdAcuRate() {
        return hyndCardApdAcuRate;
    }

    public void setHyndCardApdAcuRate(String hyndCardApdAcuRate) {
        this.hyndCardApdAcuRate = hyndCardApdAcuRate;
    }

    public String getPlotgNfpy() {
        return plotgNfpy;
    }

    public void setPlotgNfpy(String plotgNfpy) {
        this.plotgNfpy = plotgNfpy;
    }

    public String getCmpetLevel() {
        return cmpetLevel;
    }

    public void setCmpetLevel(String cmpetLevel) {
        this.cmpetLevel = cmpetLevel;
    }

    public String getTrdare() {
        return trdare;
    }

    public void setTrdare(String trdare) {
        this.trdare = trdare;
    }

    public String getPointConvYn() {
        return pointConvYn;
    }

    public void setPointConvYn(String pointConvYn) {
        this.pointConvYn = pointConvYn;
    }

    public String getIndvTaxiUnionStn() {
        return indvTaxiUnionStn;
    }

    public void setIndvTaxiUnionStn(String indvTaxiUnionStn) {
        this.indvTaxiUnionStn = indvTaxiUnionStn;
    }

    public String getAirgunYn() {
        return airgunYn;
    }

    public void setAirgunYn(String airgunYn) {
        this.airgunYn = airgunYn;
    }

    public String getAutoCwYn() {
        return autoCwYn;
    }

    public void setAutoCwYn(String autoCwYn) {
        this.autoCwYn = autoCwYn;
    }

    public String getFoyerYn() {
        return foyerYn;
    }

    public void setFoyerYn(String foyerYn) {
        this.foyerYn = foyerYn;
    }

    public String getMatwashYn() {
        return matwashYn;
    }

    public void setMatwashYn(String matwashYn) {
        this.matwashYn = matwashYn;
    }

    public String getPoslYn() {
        return poslYn;
    }

    public void setPoslYn(String poslYn) {
        this.poslYn = poslYn;
    }

    public String getFactoryYn() {
        return factoryYn;
    }

    public void setFactoryYn(String factoryYn) {
        this.factoryYn = factoryYn;
    }

    public String getStnAcuCardOprt() {
        return stnAcuCardOprt;
    }

    public void setStnAcuCardOprt(String stnAcuCardOprt) {
        this.stnAcuCardOprt = stnAcuCardOprt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFaxNo() {
        return faxNo;
    }

    public void setFaxNo(String faxNo) {
        this.faxNo = faxNo;
    }

    public String getTelNo() {
        return telNo;
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getSbscDd() {
        return sbscDd;
    }

    public void setSbscDd(String sbscDd) {
        this.sbscDd = sbscDd;
    }

    public String getStnPointAplyMeth() {
        return stnPointAplyMeth;
    }

    public void setStnPointAplyMeth(String stnPointAplyMeth) {
        this.stnPointAplyMeth = stnPointAplyMeth;
    }

    public String getStnPointAplyUnit() {
        return stnPointAplyUnit;
    }

    public void setStnPointAplyUnit(String stnPointAplyUnit) {
        this.stnPointAplyUnit = stnPointAplyUnit;
    }

    public String getStnPointBaseAcuPoint() {
        return stnPointBaseAcuPoint;
    }

    public void setStnPointBaseAcuPoint(String stnPointBaseAcuPoint) {
        this.stnPointBaseAcuPoint = stnPointBaseAcuPoint;
    }

    public String getStnPointOprtYn() {
        return stnPointOprtYn;
    }

    public void setStnPointOprtYn(String stnPointOprtYn) {
        this.stnPointOprtYn = stnPointOprtYn;
    }

    public String getOprtPrps() {
        return oprtPrps;
    }

    public void setOprtPrps(String oprtPrps) {
        this.oprtPrps = oprtPrps;
    }

    public String getParMbrbsYn() {
        return parMbrbsYn;
    }

    public void setParMbrbsYn(String parMbrbsYn) {
        this.parMbrbsYn = parMbrbsYn;
    }

    public String getAdrDtl() {
        return adrDtl;
    }

    public void setAdrDtl(String adrDtl) {
        this.adrDtl = adrDtl;
    }

    public String getHpNo() {
        return hpNo;
    }

    public void setHpNo(String hpNo) {
        this.hpNo = hpNo;
    }

    public String getTrmnDd() {
        return trmnDd;
    }

    public void setTrmnDd(String trmnDd) {
        this.trmnDd = trmnDd;
    }

    public String getMbrbsCdadd() {
        return mbrbsCdadd;
    }

    public void setMbrbsCdadd(String mbrbsCdadd) {
        this.mbrbsCdadd = mbrbsCdadd;
    }

    public String getTrmnYn() {
        return trmnYn;
    }

    public void setTrmnYn(String trmnYn) {
        this.trmnYn = trmnYn;
    }

    public String getPointContType() {
        return pointContType;
    }

    public void setPointContType(String pointContType) {
        this.pointContType = pointContType;
    }

    public String getRoadNmAdr() {
        return roadNmAdr;
    }

    public void setRoadNmAdr(String roadNmAdr) {
        this.roadNmAdr = roadNmAdr;
    }

    public String getRoadNmAdrZipcd() {
        return roadNmAdrZipcd;
    }

    public void setRoadNmAdrZipcd(String roadNmAdrZipcd) {
        this.roadNmAdrZipcd = roadNmAdrZipcd;
    }

    public String getSelfWashYn() {
        return selfWashYn;
    }

    public void setSelfWashYn(String selfWashYn) {
        this.selfWashYn = selfWashYn;
    }

    public String getVacumYn() {
        return vacumYn;
    }

    public void setVacumYn(String vacumYn) {
        this.vacumYn = vacumYn;
    }

    public String getTierPYn() {
        return tierPYn;
    }

    public void setTierPYn(String tierPYn) {
        this.tierPYn = tierPYn;
    }

    public String getSinkYn() {
        return sinkYn;
    }

    public void setSinkYn(String sinkYn) {
        this.sinkYn = sinkYn;
    }

    public String getVendingYn() {
        return vendingYn;
    }

    public void setVendingYn(String vendingYn) {
        this.vendingYn = vendingYn;
    }

    public String getRunOnlineYn() {
        return runOnlineYn;
    }

    public void setRunOnlineYn(String runOnlineYn) {
        this.runOnlineYn = runOnlineYn;
    }

    public String getMobileCouponYn() {
        return mobileCouponYn;
    }

    public void setMobileCouponYn(String mobileCouponYn) {
        this.mobileCouponYn = mobileCouponYn;
    }

    public String getLowMbrbsCretDivNm() {
        return lowMbrbsCretDivNm;
    }

    public void setLowMbrbsCretDivNm(String lowMbrbsCretDivNm) {
        this.lowMbrbsCretDivNm = lowMbrbsCretDivNm;
    }

    public String getLowMbrbsCd() {
        return lowMbrbsCd;
    }

    public void setLowMbrbsCd(String lowMbrbsCd) {
        this.lowMbrbsCd = lowMbrbsCd;
    }

    public String getStnDiv() {
        return stnDiv;
    }

    public void setStnDiv(String stnDiv) {
        this.stnDiv = stnDiv;
    }

    public String getReprNm() {
        return reprNm;
    }

    public void setReprNm(String reprNm) {
        this.reprNm = reprNm;
    }

    public String getZipCd() {
        return zipCd;
    }

    public void setZipCd(String zipCd) {
        this.zipCd = zipCd;
    }

    public String getStnTkcgrCmpno() {
        return stnTkcgrCmpno;
    }

    public void setStnTkcgrCmpno(String stnTkcgrCmpno) {
        this.stnTkcgrCmpno = stnTkcgrCmpno;
    }

    public String getStnTkcgr() {
        return stnTkcgr;
    }

    public void setStnTkcgr(String stnTkcgr) {
        this.stnTkcgr = stnTkcgr;
    }

    public String getRidAcrlRule() {
        return ridAcrlRule;
    }

    public void setRidAcrlRule(String ridAcrlRule) {
        this.ridAcrlRule = ridAcrlRule;
    }

    public String getRidAdjRule() {
        return ridAdjRule;
    }

    public void setRidAdjRule(String ridAdjRule) {
        this.ridAdjRule = ridAdjRule;
    }

    public String getRidRdmRule() {
        return ridRdmRule;
    }

    public void setRidRdmRule(String ridRdmRule) {
        this.ridRdmRule = ridRdmRule;
    }

    public String getApvSrvrTrmDt() {
        return apvSrvrTrmDt;
    }

    public void setApvSrvrTrmDt(String apvSrvrTrmDt) {
        this.apvSrvrTrmDt = apvSrvrTrmDt;
    }

    public String getApvSrvrTrmYn() {
        return apvSrvrTrmYn;
    }

    public void setApvSrvrTrmYn(String apvSrvrTrmYn) {
        this.apvSrvrTrmYn = apvSrvrTrmYn;
    }

    public String getRidStnMgmtDiv() {
        return ridStnMgmtDiv;
    }

    public void setRidStnMgmtDiv(String ridStnMgmtDiv) {
        this.ridStnMgmtDiv = ridStnMgmtDiv;
    }

    public String getOuTypeCd() {
        return ouTypeCd;
    }

    public void setOuTypeCd(String ouTypeCd) {
        this.ouTypeCd = ouTypeCd;
    }

    public String getSido() {
        return sido;
    }

    public void setSido(String sido) {
        this.sido = sido;
    }

    public String getGugun() {
        return gugun;
    }

    public void setGugun(String gugun) {
        this.gugun = gugun;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getRidE1Mbr() {
        return ridE1Mbr;
    }

    public void setRidE1Mbr(String ridE1Mbr) {
        this.ridE1Mbr = ridE1Mbr;
    }

    public String getRidPerMbr() {
        return ridPerMbr;
    }

    public void setRidPerMbr(String ridPerMbr) {
        this.ridPerMbr = ridPerMbr;
    }

    public String getAcrlRuleCd() {
        return acrlRuleCd;
    }

    public void setAcrlRuleCd(String acrlRuleCd) {
        this.acrlRuleCd = acrlRuleCd;
    }

    public String getAcrlRuleTypeCd() {
        return acrlRuleTypeCd;
    }

    public void setAcrlRuleTypeCd(String acrlRuleTypeCd) {
        this.acrlRuleTypeCd = acrlRuleTypeCd;
    }

    public String getAdjRuleCd() {
        return adjRuleCd;
    }

    public void setAdjRuleCd(String adjRuleCd) {
        this.adjRuleCd = adjRuleCd;
    }

    public String getAdjRuleTypeCd() {
        return adjRuleTypeCd;
    }

    public void setAdjRuleTypeCd(String adjRuleTypeCd) {
        this.adjRuleTypeCd = adjRuleTypeCd;
    }

    public String getMbrbsStatusCd2() {
        return mbrbsStatusCd2;
    }

    public void setMbrbsStatusCd2(String mbrbsStatusCd2) {
        this.mbrbsStatusCd2 = mbrbsStatusCd2;
    }

    public String getParChnlNo() {
        return parChnlNo;
    }

    public void setParChnlNo(String parChnlNo) {
        this.parChnlNo = parChnlNo;
    }

    public String getParChnlNm() {
        return parChnlNm;
    }

    public void setParChnlNm(String parChnlNm) {
        this.parChnlNm = parChnlNm;
    }

	public String getChnlShpPardes() {
		return chnlShpPardes;
	}

	public void setChnlShpPardes(String chnlShpPardes) {
		this.chnlShpPardes = chnlShpPardes;
	}

	public String getChnlPtstkYn() {
		return chnlPtstkYn;
	}

	public void setChnlPtstkYn(String chnlPtstkYn) {
		this.chnlPtstkYn = chnlPtstkYn;
	}

}
