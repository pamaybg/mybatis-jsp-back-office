/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrDetailNewPageResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 12. 오후 5:27:05
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 12.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import java.sql.Date;
import java.util.Calendar;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyMbrDetailNewPageResDto
 * 2. 파일명	: LoyMbrDetailNewPageResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 12.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
//@PersonalData
@CommCode
public class LoyMbrDetailNewPageResDto extends GridPagingItemResDto{
	
	private String rid;
	private String mbrNo;		// 회원번호
	@Decrypted(masked = "tel")
	private String hhp;			// 휴대폰
	private String user_id;		// 웹아이디
	@Decrypted(masked = "custNm")
	private String cust_nm;
	private String tierDt;
	private Date sbscDate;	// 가입일
	private String sbscCoursCd;	// 가입유형?
	private String sbscCoursCdNm;
	private String pntAcrlYn;
	private String pntRdmYn;
	private String pntGftYn;
	private String cardKndNm;
	private String lastChnlNm;
	private String svrDt;
	
	
	private String custTypeCd;
	@MarkName(groupCode="LOY_CUST_TYPE_CD",codeField="custTypeCd")
	private String custTypeCdNm;

	private String mbrTypeCd;
	@MarkName(groupCode="LOY_MBR_TYPE_CD",codeField="mbrTypeCd")
	private String mbrTypeCdNm;
	private String tierNm;
	private String pgmNm;
	private String pathChnlNm;
	private String sbscChnlNm;
	private String mainChnlNm;
	@Decrypted(masked = "email")
	private String email;
	@Decrypted(masked = "none")
	private String zip;
	@Decrypted(masked = "none")
	private String adres;
	@Decrypted(masked = "addr")
	private String bunji;
	private String sbscPathCd;
	@MarkName(groupCode="LOY_SBSC_PATH_CD", codeField="sbscPathCd")
	private String sbscPathCdNm;
	@MarkName(groupCode = "LOY_SBSC_DEVICE_CD", codeField = "sbscDeviceCd")
	private String sbscDeviceCdNm;
	private String sbscDeviceCd;
	
	private String avlPoint;
	private String extncPamPoint;
	private String preAcrlPoint;
	private String pgmRid;
	private String custRid;
	private String pgmNo;
	private String rcmmdNo;
	
	@MarkName(groupCode="LOY_CUST_STAT_CD",codeField="custStatCd")
	private String custStatCd;
	
	@MarkName(groupCode="LOY_MBR_STAT_CD",codeField="mbrStatCd")
	private String mbrStatCd;
	
	@MarkName(groupCode = "LOY_LUNAR_CD", codeField = "lunar_cd")
	private String lunar_cdNm;
	private String lunar_cd;
	
	
	private String svcUseCd;
	@MarkName(groupCode="LOY_SVC_TYPE_CD", codeField="svcUseCd")
	private String svcUseCdNm;
	
	@MarkName(groupCode="LOY_CERT_TYPE_CD", codeField="custCertTypeCd")
	private String certTypeCd;
	private String custCertTypeCd;
	private String certDate;
	 @Decrypted(masked = "none")
	private String cust_nm_add;
	@Decrypted(masked = "none")
	private String zip_add;
	private String adres_add;
	 @Decrypted(masked = "none")
	private String bunji_add;
	private String bCodeAdd;
	@MarkName(groupCode = "COUNTRY_TYPE_CD", codeField = "nltyCd")
	private String nlty;
	private String nltyCd;
	
	private String native_yn;
	@MarkName(groupCode = "LOY_DRMNCY_CHNG_UNIT_CD", codeField = "drmmcyChngUnitCd")
	private String drmncy_chng_unit;
	private String annvrsry;
	@MarkName(groupCode = "LOY_ANNVRSRY_TYPE_CD", codeField = "annvrsryTypeCd")
	private String annvrsry_type_cd;
	private String annvrsryTypeCd;
	
	private String mrrgYn;
	private String wrcNm;
	@MarkName(groupCode = "POSITION", codeField = "pstnCd")
	private String pstn;
	private String pstnCd;
	private String validTierStartDt;
	private String liftTierNm;
	private String validTierLiftTimeStartDt;
	private String lastConChnlNm;
	private String conSvrDt;
	private String lastPurChnlNm;
	private String purSvrDt;
	private String birthdt;
	
	@MarkName(groupCode = "LOY_GEN_CD", codeField = "gen_cdNm")
	private String gen_cd;
	private String gen_cdNm;
	
	private String totalPoint;
	
	private String chnlNo;
	
	private int coupon;
	private int ticket;
	
	private String evtNm;
	private String evtDt;
	
	private String prStoreNm;
	private String prStoreCd;

	private String drmmcyChngUnitCd;
	private String pntPwd;
	private String empNo;
	@Decrypted(masked = "none")
	private String telNo;
	private String deptNm;
	
	private String snsTypeCd;
	@MarkName(groupCode = "LOY_SNS_TYPE_CD", codeField = "snsTypeCd")
	private String snsTypeCdNm;
	private String snsAddr;
	
	private String sbscTypeCd;
	@MarkName(groupCode = "LOY_SBSC_TYPE_CD", codeField = "sbscTypeCd")
	private String sbscTypeCdNm;
	
	private String ceo;
	private String bizrNo;
	private String lccTelNo;
	private String charger;
	private String lccZipAdd;
	private String lccAdresAdd;
	private String lccBunjiAdd;
	private String induty;
	private String bizcnd;
	private String accRate;
	private String childYn;
	private String mcardNo;

	private String drmmcyExpDate;
	private String sbscDates;
	
	private String reSbscResn;
	@Decrypted(masked = "custNm")
	private String maskCustNm;
	@Decrypted(masked = "tel")
	private String maskHhp;

	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_DST", codeField = "tierDST")
	private String tierDSTNm;
	private String tierDST;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_UMB", codeField = "tierUMB")
	private String tierUMBNm;
	private String tierUMB;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_LCS", codeField = "tierLCS")
	private String tierLCSNm;
	private String tierLCS;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_DSG", codeField = "tierDSG")
	private String tierDSGNm;
	private String tierDSG;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_LCG", codeField = "tierLCG")
	private String tierLCGNm;
	private String tierLCG;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_MSW", codeField = "tierMSW")
	private String tierMSWNm;
	private String tierMSW;
	private String proGolfYn; //프로골퍼여부
	private String drcYn;	//유료멤버십
	private String age; 	//나이
	private int surveyJoinCnt; //설문참여 건수
	private int surveyTgtCnt; //설문타겟팅 건수
	private int closedCnt; //고객문의 완료건수
	private int vocReqCnt; //고객문의 요청건수

	private int tierDSTMaxLvl;
	private int tierDSTLvl;
	private int tierUMBMaxLvl;
	private int tierUMBLvl;
	private int tierLCSMaxLvl;
	private int tierLCSLvl;
	private int tierDSGMaxLvl;
	private int tierDSGLvl;
	private int tierLCGMaxLvl;
	private int tierLCGLvl;
	private int tierMSWMaxLvl;
	private int tierMSWLvl;

	private int tierMaxLvl;
	private int tierLvl;

	public String getMaskCustNm() {
		return maskCustNm;
	}
	public void setMaskCustNm(String maskCustNm) {
		this.maskCustNm = maskCustNm;
	}
	public String getMaskHhp() {
		return maskHhp;
	}
	public void setMaskHhp(String maskHhp) {
		this.maskHhp = maskHhp;
	}
	public String getReSbscResn() {
		return reSbscResn;
	}
	public void setReSbscResn(String reSbscResn) {
		this.reSbscResn = reSbscResn;
	}
	public String getSbscDates() {
		return sbscDates;
	}
	public void setSbscDates(String sbscDates) {
		this.sbscDates = sbscDates;
	}
	public String getAccRate() {
		return accRate;
	}
	public void setAccRate(String accRate) {
		this.accRate = accRate;
	}
	
	
	public String getChildYn() {
		return childYn;
	}
	public void setChildYn(String childYn) {
		this.childYn = childYn;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getLccTelNo() {
		return lccTelNo;
	}
	public void setLccTelNo(String lccTelNo) {
		this.lccTelNo = lccTelNo;
	}
	public String getCharger() {
		return charger;
	}
	public void setCharger(String charger) {
		this.charger = charger;
	}
	public String getLccZipAdd() {
		return lccZipAdd;
	}
	public void setLccZipAdd(String lccZipAdd) {
		this.lccZipAdd = lccZipAdd;
	}
	public String getLccAdresAdd() {
		return lccAdresAdd;
	}
	public void setLccAdresAdd(String lccAdresAdd) {
		this.lccAdresAdd = lccAdresAdd;
	}
	public String getLccBunjiAdd() {
		return lccBunjiAdd;
	}
	public void setLccBunjiAdd(String lccBunjiAdd) {
		this.lccBunjiAdd = lccBunjiAdd;
	}
	public String getInduty() {
		return induty;
	}
	public void setInduty(String induty) {
		this.induty = induty;
	}
	public String getBizcnd() {
		return bizcnd;
	}
	public void setBizcnd(String bizcnd) {
		this.bizcnd = bizcnd;
	}
	public String getSbscTypeCdNm() {
		return sbscTypeCdNm;
	}
	public void setSbscTypeCdNm(String sbscTypeCdNm) {
		this.sbscTypeCdNm = sbscTypeCdNm;
	}
	public String getSbscTypeCd() {
		return sbscTypeCd;
	}
	public void setSbscTypeCd(String sbscTypeCd) {
		this.sbscTypeCd = sbscTypeCd;
	}
	public String getSnsTypeCd() {
		return snsTypeCd;
	}
	public void setSnsTypeCd(String snsTypeCd) {
		this.snsTypeCd = snsTypeCd;
	}
	public String getSnsTypeCdNm() {
		return snsTypeCdNm;
	}
	public void setSnsTypeCdNm(String snsTypeCdNm) {
		this.snsTypeCdNm = snsTypeCdNm;
	}
	public String getSnsAddr() {
		return snsAddr;
	}
	public void setSnsAddr(String snsAddr) {
		this.snsAddr = snsAddr;
	}
	public String getCustStatCd() {
		return custStatCd;
	}
	public void setCustStatCd(String custStatCd) {
		this.custStatCd = custStatCd;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getPntPwd() {
		return pntPwd;
	}
	public void setPntPwd(String pntPwd) {
		this.pntPwd = pntPwd;
	}
	public String getRcmmdNo() {
		return rcmmdNo;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public void setRcmmdNo(String rcmmdNo) {
		this.rcmmdNo = rcmmdNo;
	}
	public String getSvcUseCd() {
		return svcUseCd;
	}
	public void setSvcUseCd(String svcUseCd) {
		this.svcUseCd = svcUseCd;
	}
	public String getSvcUseCdNm() {
		return svcUseCdNm;
	}
	public void setSvcUseCdNm(String svcUseCdNm) {
		this.svcUseCdNm = svcUseCdNm;
	}
	public String getAvlPoint() {
		return avlPoint;
	}
	public void setAvlPoint(String avlPoint) {
		this.avlPoint = avlPoint;
	}
	public String getExtncPamPoint() {
		return extncPamPoint;
	}
	public void setExtncPamPoint(String extncPamPoint) {
		this.extncPamPoint = extncPamPoint;
	}

	public String getPreAcrlPoint() {
		return preAcrlPoint;
	}
	public void setPreAcrlPoint(String preAcrlPoint) {
		this.preAcrlPoint = preAcrlPoint;
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
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getSbscCoursCd() {
		return sbscCoursCd;
	}
	public void setSbscCoursCd(String sbscCoursCd) {
		this.sbscCoursCd = sbscCoursCd;
	}
	public String getPntAcrlYn() {
		return pntAcrlYn;
	}
	public void setPntAcrlYn(String pntAcrlYn) {
		this.pntAcrlYn = pntAcrlYn;
	}
	public String getPntRdmYn() {
		return pntRdmYn;
	}
	public void setPntRdmYn(String pntRdmYn) {
		this.pntRdmYn = pntRdmYn;
	}
	public String getPntGftYn() {
		return pntGftYn;
	}
	public void setPntGftYn(String pntGftYn) {
		this.pntGftYn = pntGftYn;
	}
	public String getCardKndNm() {
		return cardKndNm;
	}
	public void setCardKndNm(String cardKndNm) {
		this.cardKndNm = cardKndNm;
	}
	public String getLastChnlNm() {
		return lastChnlNm;
	}
	public void setLastChnlNm(String lastChnlNm) {
		this.lastChnlNm = lastChnlNm;
	}
	public String getSvrDt() {
		return svrDt;
	}
	public void setSvrDt(String svrDt) {
		this.svrDt = svrDt;
	}
	public String getTierDt() {
		return tierDt;
	}
	public void setTierDt(String tierDt) {
		this.tierDt = tierDt;
	}
	public String getSbscCoursCdNm() {
		return sbscCoursCdNm;
	}
	public void setSbscCoursCdNm(String sbscCoursCdNm) {
		this.sbscCoursCdNm = sbscCoursCdNm;
	}

	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getSbscChnlNm() {
		return sbscChnlNm;
	}
	public void setSbscChnlNm(String sbscChnlNm) {
		this.sbscChnlNm = sbscChnlNm;
	}
	public String getMainChnlNm() {
		return mainChnlNm;
	}
	public void setMainChnlNm(String mainChnlNm) {
		this.mainChnlNm = mainChnlNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}
	public String getBunji() {
		return bunji;
	}
	public void setBunji(String bunji) {
		this.bunji = bunji;
	}
	public String getPathChnlNm() {
		return pathChnlNm;
	}
	public void setPathChnlNm(String pathChnlNm) {
		this.pathChnlNm = pathChnlNm;
	}
	public String getSbscPathCd() {
		return sbscPathCd;
	}
	public void setSbscPathCd(String sbscPathCd) {
		this.sbscPathCd = sbscPathCd;
	}
	public String getSbscPathCdNm() {
		return sbscPathCdNm;
	}
	public void setSbscPathCdNm(String sbscPathCdNm) {
		this.sbscPathCdNm = sbscPathCdNm;
	}
	public Date getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(Date sbscDate) {
		this.sbscDate = sbscDate;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrTypeCdNm() {
		return mbrTypeCdNm;
	}
	public void setMbrTypeCdNm(String mbrTypeCdNm) {
		this.mbrTypeCdNm = mbrTypeCdNm;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getCustRid() {
		return custRid;
	}
	public void setCustRid(String custRid) {
		this.custRid = custRid;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	public String getSbscDeviceCdNm() {
		return sbscDeviceCdNm;
	}
	public void setSbscDeviceCdNm(String sbscDeviceCdNm) {
		this.sbscDeviceCdNm = sbscDeviceCdNm;
	}
	public String getSbscDeviceCd() {
		return sbscDeviceCd;
	}
	public void setSbscDeviceCd(String sbscDeviceCd) {
		this.sbscDeviceCd = sbscDeviceCd;
	}
	public String getCertTypeCd() {
		return certTypeCd;
	}
	public void setCertTypeCd(String certTypeCd) {
		this.certTypeCd = certTypeCd;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}
	public String getCust_nm_add() {
		return cust_nm_add;
	}
	public void setCust_nm_add(String cust_nm_add) {
		this.cust_nm_add = cust_nm_add;
	}
	public String getZip_add() {
		return zip_add;
	}
	public void setZip_add(String zip_add) {
		this.zip_add = zip_add;
	}
	public String getAdres_add() {
		return adres_add;
	}
	public void setAdres_add(String adres_add) {
		this.adres_add = adres_add;
	}
	public String getBunji_add() {
		return bunji_add;
	}
	public void setBunji_add(String bunji_add) {
		this.bunji_add = bunji_add;
	}
	public String getbCodeAdd() {
		return bCodeAdd;
	}
	public void setbCodeAdd(String bCodeAdd) {
		this.bCodeAdd = bCodeAdd;
	}
	public String getNlty() {
		return nlty;
	}
	public void setNlty(String nlty) {
		this.nlty = nlty;
	}
	public String getNltyCd() {
		return nltyCd;
	}
	public void setNltyCd(String nltyCd) {
		this.nltyCd = nltyCd;
	}
	public String getNative_yn() {
		return native_yn;
	}
	public void setNative_yn(String native_yn) {
		this.native_yn = native_yn;
	}
	public String getDrmncy_chng_unit() {
		return drmncy_chng_unit;
	}
	public void setDrmncy_chng_unit(String drmncy_chng_unit) {
		this.drmncy_chng_unit = drmncy_chng_unit;
	}
	public String getAnnvrsry() {
		return annvrsry;
	}
	public void setAnnvrsry(String annvrsry) {
		this.annvrsry = annvrsry;
	}
	public String getAnnvrsry_type_cd() {
		return annvrsry_type_cd;
	}
	public void setAnnvrsry_type_cd(String annvrsry_type_cd) {
		this.annvrsry_type_cd = annvrsry_type_cd;
	}
	public String getAnnvrsryTypeCd() {
		return annvrsryTypeCd;
	}
	public void setAnnvrsryTypeCd(String annvrsryTypeCd) {
		this.annvrsryTypeCd = annvrsryTypeCd;
	}
	
	public String getMrrgYn() {
		return mrrgYn;
	}
	public void setMrrgYn(String mrrgYn) {
		this.mrrgYn = mrrgYn;
	}
	public String getWrcNm() {
		return wrcNm;
	}
	public void setWrcNm(String wrcNm) {
		this.wrcNm = wrcNm;
	}
	public String getPstn() {
		return pstn;
	}
	public void setPstn(String pstn) {
		this.pstn = pstn;
	}
	public String getPstnCd() {
		return pstnCd;
	}
	public void setPstnCd(String pstnCd) {
		this.pstnCd = pstnCd;
	}
	public String getValidTierStartDt() {
		return validTierStartDt;
	}
	public void setValidTierStartDt(String validTierStartDt) {
		this.validTierStartDt = validTierStartDt;
	}
	public String getLiftTierNm() {
		return liftTierNm;
	}
	public void setLiftTierNm(String liftTierNm) {
		this.liftTierNm = liftTierNm;
	}
	public String getValidTierLiftTimeStartDt() {
		return validTierLiftTimeStartDt;
	}
	public void setValidTierLiftTimeStartDt(String validTierLiftTimeStartDt) {
		this.validTierLiftTimeStartDt = validTierLiftTimeStartDt;
	}
	public String getLastConChnlNm() {
		return lastConChnlNm;
	}
	public void setLastConChnlNm(String lastConChnlNm) {
		this.lastConChnlNm = lastConChnlNm;
	}
	public String getConSvrDt() {
		return conSvrDt;
	}
	public void setConSvrDt(String conSvrDt) {
		this.conSvrDt = conSvrDt;
	}
	public String getLastPurChnlNm() {
		return lastPurChnlNm;
	}
	public void setLastPurChnlNm(String lastPurChnlNm) {
		this.lastPurChnlNm = lastPurChnlNm;
	}
	public String getPurSvrDt() {
		return purSvrDt;
	}
	public void setPurSvrDt(String purSvrDt) {
		this.purSvrDt = purSvrDt;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getCustTypeCdNm() {
		return custTypeCdNm;
	}
	public void setCustTypeCdNm(String custTypeCdNm) {
		this.custTypeCdNm = custTypeCdNm;
	}
	public String getTotalPoint() {
		return totalPoint;
	}
	public void setTotalPoint(String totalPoint) {
		this.totalPoint = totalPoint;
	}
	public String getBirthdt() {
		return birthdt;
	}
	public void setBirthdt(String birthdt) {
		this.birthdt = birthdt;
	}
	public String getGen_cd() {
		return gen_cd;
	}
	public void setGen_cd(String gen_cd) {
		this.gen_cd = gen_cd;
	}
	public String getGen_cdNm() {
		return gen_cdNm;
	}
	public void setGen_cdNm(String gen_cdNm) {
		this.gen_cdNm = gen_cdNm;
	}
	public int getCoupon() {
		return coupon;
	}
	public void setCoupon(int coupon) {
		this.coupon = coupon;
	}
	public int getTicket() {
		return ticket;
	}
	public void setTicket(int ticket) {
		this.ticket = ticket;
	}
	public String getEvtNm() {
		return evtNm;
	}
	public void setEvtNm(String evtNm) {
		this.evtNm = evtNm;
	}
	public String getEvtDt() {
		return evtDt;
	}
	public void setEvtDt(String evtDt) {
		this.evtDt = evtDt;
	}
	public String getPrStoreNm() {
		return prStoreNm;
	}
	public void setPrStoreNm(String prStoreNm) {
		this.prStoreNm = prStoreNm;
	}
	public String getLunar_cdNm() {
		return lunar_cdNm;
	}
	public void setLunar_cdNm(String lunar_cdNm) {
		this.lunar_cdNm = lunar_cdNm;
	}
	public String getLunar_cd() {
		return lunar_cd;
	}
	public void setLunar_cd(String lunar_cd) {
		this.lunar_cd = lunar_cd;
	}
	public String getCustCertTypeCd() {
		return custCertTypeCd;
	}
	public void setCustCertTypeCd(String custCertTypeCd) {
		this.custCertTypeCd = custCertTypeCd;
	}
	public String getDrmmcyChngUnitCd() {
		return drmmcyChngUnitCd;
	}
	public void setDrmmcyChngUnitCd(String drmmcyChngUnitCd) {
		this.drmmcyChngUnitCd = drmmcyChngUnitCd;
	}
	public String getMcardNo() {
		return mcardNo;
	}
	public void setMcardNo(String mcardNo) {
		this.mcardNo = mcardNo;
	}
	public String getDrmmcyExpDate() {
		return drmmcyExpDate;
	}
	public void setDrmmcyExpDate(String drmmcyExpDate) {
		this.drmmcyExpDate = drmmcyExpDate;
	}

	public String getTierDST() {
		return tierDST;
	}

	public void setTierDST(String tierDST) {
		this.tierDST = tierDST;
	}

	public String getTierUMB() {
		return tierUMB;
	}

	public void setTierUMB(String tierUMB) {
		this.tierUMB = tierUMB;
	}

	public String getTierLCS() {
		return tierLCS;
	}

	public void setTierLCS(String tierLCS) {
		this.tierLCS = tierLCS;
	}

	public String getTierDSG() {
		return tierDSG;
	}

	public void setTierDSG(String tierDSG) {
		this.tierDSG = tierDSG;
	}

	public String getTierLCG() {
		return tierLCG;
	}

	public void setTierLCG(String tierLCG) {
		this.tierLCG = tierLCG;
	}

	public String getTierMSW() {
		return tierMSW;
	}

	public void setTierMSW(String tierMSW) {
		this.tierMSW = tierMSW;
	}

	public String getProGolfYn() {
		return proGolfYn;
	}

	public void setProGolfYn(String proGolfYn) {
		this.proGolfYn = proGolfYn;
	}

	public String getDrcYn() {
		return drcYn;
	}

	public void setDrcYn(String drcYn) {
		this.drcYn = drcYn;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public int getSurveyJoinCnt() {
		return surveyJoinCnt;
	}

	public void setSurveyJoinCnt(int surveyJoinCnt) {
		this.surveyJoinCnt = surveyJoinCnt;
	}

	public int getSurveyTgtCnt() {
		return surveyTgtCnt;
	}

	public void setSurveyTgtCnt(int surveyTgtCnt) {
		this.surveyTgtCnt = surveyTgtCnt;
	}

	public int getClosedCnt() {
		return closedCnt;
	}

	public void setClosedCnt(int closedCnt) {
		this.closedCnt = closedCnt;
	}

	public int getVocReqCnt() {
		return vocReqCnt;
	}

	public void setVocReqCnt(int vocReqCnt) {
		this.vocReqCnt = vocReqCnt;
	}

	public int getTierDSTMaxLvl() {
		return tierDSTMaxLvl;
	}

	public void setTierDSTMaxLvl(int tierDSTMaxLvl) {
		this.tierDSTMaxLvl = tierDSTMaxLvl;
	}

	public int getTierDSTLvl() {
		return tierDSTLvl;
	}

	public void setTierDSTLvl(int tierDSTLvl) {
		this.tierDSTLvl = tierDSTLvl;
	}

	public int getTierUMBMaxLvl() {
		return tierUMBMaxLvl;
	}

	public void setTierUMBMaxLvl(int tierUMBMaxLvl) {
		this.tierUMBMaxLvl = tierUMBMaxLvl;
	}

	public int getTierUMBLvl() {
		return tierUMBLvl;
	}

	public void setTierUMBLvl(int tierUMBLvl) {
		this.tierUMBLvl = tierUMBLvl;
	}

	public int getTierLCSMaxLvl() {
		return tierLCSMaxLvl;
	}

	public void setTierLCSMaxLvl(int tierLCSMaxLvl) {
		this.tierLCSMaxLvl = tierLCSMaxLvl;
	}

	public int getTierLCSLvl() {
		return tierLCSLvl;
	}

	public void setTierLCSLvl(int tierLCSLvl) {
		this.tierLCSLvl = tierLCSLvl;
	}

	public int getTierDSGMaxLvl() {
		return tierDSGMaxLvl;
	}

	public void setTierDSGMaxLvl(int tierDSGMaxLvl) {
		this.tierDSGMaxLvl = tierDSGMaxLvl;
	}

	public int getTierDSGLvl() {
		return tierDSGLvl;
	}

	public void setTierDSGLvl(int tierDSGLvl) {
		this.tierDSGLvl = tierDSGLvl;
	}

	public int getTierLCGMaxLvl() {
		return tierLCGMaxLvl;
	}

	public void setTierLCGMaxLvl(int tierLCGMaxLvl) {
		this.tierLCGMaxLvl = tierLCGMaxLvl;
	}

	public int getTierLCGLvl() {
		return tierLCGLvl;
	}

	public void setTierLCGLvl(int tierLCGLvl) {
		this.tierLCGLvl = tierLCGLvl;
	}

	public int getTierMSWMaxLvl() {
		return tierMSWMaxLvl;
	}

	public void setTierMSWMaxLvl(int tierMSWMaxLvl) {
		this.tierMSWMaxLvl = tierMSWMaxLvl;
	}

	public int getTierMSWLvl() {
		return tierMSWLvl;
	}

	public void setTierMSWLvl(int tierMSWLvl) {
		this.tierMSWLvl = tierMSWLvl;
	}

	public int getTierMaxLvl() {
		return tierMaxLvl;
	}

	public void setTierMaxLvl(int tierMaxLvl) {
		this.tierMaxLvl = tierMaxLvl;
	}

	public int getTierLvl() {
		return tierLvl;
	}

	public void setTierLvl(int tierLvl) {
		this.tierLvl = tierLvl;
	}

	public String getTierDSTNm() {
		return tierDSTNm;
	}

	public void setTierDSTNm(String tierDSTNm) {
		this.tierDSTNm = tierDSTNm;
	}

	public String getTierUMBNm() {
		return tierUMBNm;
	}

	public void setTierUMBNm(String tierUMBNm) {
		this.tierUMBNm = tierUMBNm;
	}

	public String getTierLCSNm() {
		return tierLCSNm;
	}

	public void setTierLCSNm(String tierLCSNm) {
		this.tierLCSNm = tierLCSNm;
	}

	public String getTierDSGNm() {
		return tierDSGNm;
	}

	public void setTierDSGNm(String tierDSGNm) {
		this.tierDSGNm = tierDSGNm;
	}

	public String getTierLCGNm() {
		return tierLCGNm;
	}

	public void setTierLCGNm(String tierLCGNm) {
		this.tierLCGNm = tierLCGNm;
	}

	public String getTierMSWNm() {
		return tierMSWNm;
	}

	public void setTierMSWNm(String tierMSWNm) {
		this.tierMSWNm = tierMSWNm;
	}

	public String getPrStoreCd() {
		return prStoreCd;
	}

	public void setPrStoreCd(String prStoreCd) {
		this.prStoreCd = prStoreCd;
	}
}
