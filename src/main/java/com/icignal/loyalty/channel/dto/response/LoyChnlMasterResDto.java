package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


/*
 * 1. 클래스명	: LoyChnlMasterResDto
 * 2. 파일명	: LoyChnlMasterResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: hy.jun
 * 5. 작성일자	: 2018. 10. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *  loy.loy_channel
 * </PRE>
 */ 
@PersonalData
public class LoyChnlMasterResDto extends StatusResDto{
	private String rid;
	private String chnlKeySeq;
	private String chnlNo;
	private String chnlNm;
	private String chnlRealNm;
	private String chnlTypeSubCd;
	private String chnlLvlNo;
	private String parRid;
	private String parRidTop;
	private String partKeySeq;
	private String ridTerms;
	private String parKeySeqTop;
	private String parCustPr;
	private String acrlPsblYn;
	private String usePsblYn;
	private String mbrJoinPsblYn;
	private String mbrbsStatusCd;
	private String fraudMbrbsActnDesc;
	private String fraudMbrbsActnDiv;
	private String fraudDiv;
	private String bizrNo;
	private String fndDd;
	private String rmark;
	private String plotgNfpy;
	private String cmpetLevel;
	private String trdare;
	private String pointConvYn;
	private String email;
	private String faxNo;
	private String telNo;
	private String sbscDd;
	private String oprtPrps;
	private String parMbrbsYn;
	private String adrDtl;
	
	@Decrypted(masked = "tel")
	private String hpNo;
	
	private String trmnDd;
	private String mbrbsCdadd;
	private String trmnYn;
	private String pointContType;
	private String roadNmAdrZipCd;
	private String roadNmAdr;
	private String lowMbrbsCertDivNm;
	private String lowMbrbsCd;
	private String reprNm;
	private String zipCd;
	private String sido;
	private String gugun;
	private String latitude;
	private String longitude;
	private String ridDivn;
	private String bizCd;
	private String reprRealNm;
	private String area1Name;
	private String area2Name;
	private String ctg;
	private String chnlStatCd;
	private String chnlTypeCd;
	private String parKeySeq;
	private String chnlOpenTime;
	private String chnlCloseTime;
	private String chnlParkingYn;
	private String chnlNamestickerYn;
	private String chnlPhotocardYn;
	private String chnlPyeong;
	private String chnlActStatCd;
	private String receiptPrintYn;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlKeySeq() {
		return chnlKeySeq;
	}
	public void setChnlKeySeq(String chnlKeySeq) {
		this.chnlKeySeq = chnlKeySeq;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlRealNm() {
		return chnlRealNm;
	}
	public void setChnlRealNm(String chnlRealNm) {
		this.chnlRealNm = chnlRealNm;
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
	public String getParCustPr() {
		return parCustPr;
	}
	public void setParCustPr(String parCustPr) {
		this.parCustPr = parCustPr;
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
	public String getRoadNmAdrZipCd() {
		return roadNmAdrZipCd;
	}
	public void setRoadNmAdrZipCd(String roadNmAdrZipCd) {
		this.roadNmAdrZipCd = roadNmAdrZipCd;
	}
	public String getRoadNmAdr() {
		return roadNmAdr;
	}
	public void setRoadNmAdr(String roadNmAdr) {
		this.roadNmAdr = roadNmAdr;
	}
	public String getLowMbrbsCertDivNm() {
		return lowMbrbsCertDivNm;
	}
	public void setLowMbrbsCertDivNm(String lowMbrbsCertDivNm) {
		this.lowMbrbsCertDivNm = lowMbrbsCertDivNm;
	}
	public String getLowMbrbsCd() {
		return lowMbrbsCd;
	}
	public void setLowMbrbsCd(String lowMbrbsCd) {
		this.lowMbrbsCd = lowMbrbsCd;
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
	public String getRidDivn() {
		return ridDivn;
	}
	public void setRidDivn(String ridDivn) {
		this.ridDivn = ridDivn;
	}
	public String getBizCd() {
		return bizCd;
	}
	public void setBizCd(String bizCd) {
		this.bizCd = bizCd;
	}
	public String getReprRealNm() {
		return reprRealNm;
	}
	public void setReprRealNm(String reprRealNm) {
		this.reprRealNm = reprRealNm;
	}
	public String getArea1Name() {
		return area1Name;
	}
	public void setArea1Name(String area1Name) {
		this.area1Name = area1Name;
	}
	public String getArea2Name() {
		return area2Name;
	}
	public void setArea2Name(String area2Name) {
		this.area2Name = area2Name;
	}
	public String getCtg() {
		return ctg;
	}
	public void setCtg(String ctg) {
		this.ctg = ctg;
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
	public String getParKeySeq() {
		return parKeySeq;
	}
	public void setParKeySeq(String parKeySeq) {
		this.parKeySeq = parKeySeq;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
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
	public String getReceiptPrintYn() {
		return receiptPrintYn;
	}
	public void setReceiptPrintYn(String receiptPrintYn) {
		this.receiptPrintYn = receiptPrintYn;
	}
}
