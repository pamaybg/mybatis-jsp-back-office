/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustDetailNewResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 4. 23. 오후 4:34:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyCustDetailNewResDto
 * 2. 파일명	: LoyCustDetailNewResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 4. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
/*
 * 1. 클래스명	: LoyCustDetailNewResDto
 * 2. 파일명	: LoyCustDetailNewResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@PersonalData
@CommCode
public class LoyCustDetailNewResDto{
	private String rid;
	private String custNo;
	private String custTypeCd;
	private String custStatCd;
    @MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custTypeCd")
	private String custTypeCdNm;
    @MarkName(groupCode="LOY_CUST_STAT_CD", codeField="custStatCd")
	private String custStatCdNm;
	@Decrypted(masked = "none")
	private String cust_nm;
	@Decrypted(masked = "none")
	private String cust_nm_add;
	
	private String sbscPathCd;
	@MarkName(groupCode="LOY_SBSC_PATH_CD", codeField="sbscPathCd")
	private String sbscPathCdNm;
	@MarkName(groupCode = "LOY_SBSC_DEVICE_CD", codeField = "sbscDeviceCd")
	private String sbscDeviceCdNm;
	private String sbscDeviceCd;
	
    @MarkName(groupCode="LOY_GEN_CD", codeField="gen_cdNm")
    private String gen_cd;
	private String gen_cdNm;
	
    @MarkName(groupCode="COUNTRY_TYPE_CD", codeField="nltyCd")
    private String nlty;
	private String nltyCd;
	
	@Decrypted(masked = "none")
	private String custNmEng;
	private String birthdt;
	private String age;
	@Decrypted(masked = "none")
	private String hhp;
	@Decrypted(masked = "none")
	private String email;
	private String zip;
	private String adres;
	@Decrypted(masked = "none")
	private String bunji;
	
	@MarkName(groupCode = "LOY_LUNAR_CD", codeField = "lunar_cd")
	private String lunar_cdNm;
	private String lunar_cd;
	
	private String sbscDate;
	private String sbscChnlNm;
	private String lastChnlNm;
	private String custCd;
	@MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custCd")
	private String custCdNm;
	private String sbscCd;
	
	@MarkName(groupCode="LOY_SBSC_TYPE_CD", codeField="sbscCd")
	private String sbscCdNm;
	private String certTypeCd;
	
	@MarkName(groupCode="LOY_CERT_TYPE_CD", codeField="certTypeCd")
	private String certTypeCdNm;
	private String fieldCd;
	@MarkName(groupCode="LOY_CUST_DI_FIELD_CD", codeField="fieldCd")
	private String field;
	
	private String drmmcyDate;
	@MarkName(groupCode = "LOY_DRMNCY_CHNG_UNIT_CD", codeField = "drmmcyChngUnitCd")
	private String drmncy_chng_unit;
	private String drmmcyChngUnitCd;
	private String rcmmdNo;
	@Decrypted(masked = "none")
	private String user_id;
	private String slfCertYn;
	
	private String svrDt;

	private String custCertTypeCd;
	@MarkName(groupCode="LOY_CERT_TYPE_CD", codeField="custCertTypeCd")
	private String custCertTypeCdNm;
	
	private String certSubTypeCd;
	@MarkName(groupCode="LOY_CERT_SUB_TYPE_CD", codeField="certSubTypeCd")
	private String certSubTypeCdNm;
	private String certVal;
	private String certDate;
	
	private String annvrsry;
	@MarkName(groupCode="LOY_ANNVRSRY_TYPE_CD", codeField="annvrsryTypeCd")
	private String annvrsry_type_cd;
	private String annvrsryTypeCd;
	private String wrc_nm;
	
	@MarkName(groupCode="POSITION", codeField="pstnCd")
	private String pstn;
	private String pstnCd;
	private String mrrg_yn;
	private String native_yn;
	
	private String lastConChnlNm;
	private String conSvrDt;
	private String lastPurChnlNm;
	private String purSvrDt;
	
	private String zip_add;
	private String adres_add;
	 @Decrypted(masked = "none")
	private String bunji_add;
	private String bCodeAdd;
	
	private String joinMembership;
	private String mcardNo;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCustCertTypeCd() {
		return custCertTypeCd;
	}
	public void setCustCertTypeCd(String custCertTypeCd) {
		this.custCertTypeCd = custCertTypeCd;
	}
	public String getCustCertTypeCdNm() {
		return custCertTypeCdNm;
	}
	public void setCustCertTypeCdNm(String custCertTypeCdNm) {
		this.custCertTypeCdNm = custCertTypeCdNm;
	}
	public String getCertSubTypeCd() {
		return certSubTypeCd;
	}
	public void setCertSubTypeCd(String certSubTypeCd) {
		this.certSubTypeCd = certSubTypeCd;
	}
	public String getCertSubTypeCdNm() {
		return certSubTypeCdNm;
	}
	public void setCertSubTypeCdNm(String certSubTypeCdNm) {
		this.certSubTypeCdNm = certSubTypeCdNm;
	}
	public String getCertVal() {
		return certVal;
	}
	public void setCertVal(String certVal) {
		this.certVal = certVal;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}
	public String getBirthdt() {
		return birthdt;
	}
	public void setBirthdt(String birthdt) {
		this.birthdt = birthdt;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getCustStatCd() {
		return custStatCd;
	}
	public void setCustStatCd(String custStatCd) {
		this.custStatCd = custStatCd;
	}
	public String getCustTypeCdNm() {
		return custTypeCdNm;
	}
	public void setCustTypeCdNm(String custTypeCdNm) {
		this.custTypeCdNm = custTypeCdNm;
	}
	public String getCustStatCdNm() {
		return custStatCdNm;
	}
	public void setCustStatCdNm(String custStatCdNm) {
		this.custStatCdNm = custStatCdNm;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	public String getCust_nm_add() {
		return cust_nm_add;
	}
	public void setCust_nm_add(String cust_nm_add) {
		this.cust_nm_add = cust_nm_add;
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
	public String getNlty() {
		return nlty;
	}
	public void setNlty(String nlty) {
		this.nlty = nlty;
	}
	public String getCustNmEng() {
		return custNmEng;
	}
	public void setCustNmEng(String custNmEng) {
		this.custNmEng = custNmEng;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}
	public String getSbscChnlNm() {
		return sbscChnlNm;
	}
	public void setSbscChnlNm(String sbscChnlNm) {
		this.sbscChnlNm = sbscChnlNm;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getSbscCd() {
		return sbscCd;
	}
	public void setSbscCd(String sbscCd) {
		this.sbscCd = sbscCd;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getDrmmcyDate() {
		return drmmcyDate;
	}
	public void setDrmmcyDate(String drmmcyDate) {
		this.drmmcyDate = drmmcyDate;
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
	public String getCustCdNm() {
		return custCdNm;
	}
	public void setCustCdNm(String custCdNm) {
		this.custCdNm = custCdNm;
	}
	public String getSbscCdNm() {
		return sbscCdNm;
	}
	public void setSbscCdNm(String sbscCdNm) {
		this.sbscCdNm = sbscCdNm;
	}
	public String getRcmmdNo() {
		return rcmmdNo;
	}
	public void setRcmmdNo(String rcmmdNo) {
		this.rcmmdNo = rcmmdNo;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getLastChnlNm() {
		return lastChnlNm;
	}
	public void setLastChnlNm(String lastChnlNm) {
		this.lastChnlNm = lastChnlNm;
	}
	public String getSlfCertYn() {
		return slfCertYn;
	}
	public void setSlfCertYn(String slfCertYn) {
		this.slfCertYn = slfCertYn;
	}
	public String getSvrDt() {
		return svrDt;
	}
	public void setSvrDt(String svrDt) {
		this.svrDt = svrDt;
	}
	public String getFieldCd() {
		return fieldCd;
	}
	public void setFieldCd(String fieldCd) {
		this.fieldCd = fieldCd;
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
	public String getCertTypeCd() {
		return certTypeCd;
	}
	public void setCertTypeCd(String certTypeCd) {
		this.certTypeCd = certTypeCd;
	}
	public String getCertTypeCdNm() {
		return certTypeCdNm;
	}
	public void setCertTypeCdNm(String certTypeCdNm) {
		this.certTypeCdNm = certTypeCdNm;
	}
	public String getAnnvrsry() {
		return annvrsry;
	}
	public void setAnnvrsry(String annvrsry) {
		this.annvrsry = annvrsry;
	}
	public String getPstn() {
		return pstn;
	}
	public void setPstn(String pstn) {
		this.pstn = pstn;
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
	public String getDrmmcyChngUnitCd() {
		return drmmcyChngUnitCd;
	}
	public void setDrmmcyChngUnitCd(String drmmcyChngUnitCd) {
		this.drmmcyChngUnitCd = drmmcyChngUnitCd;
	}
	public String getNltyCd() {
		return nltyCd;
	}
	public void setNltyCd(String nltyCd) {
		this.nltyCd = nltyCd;
	}
	public String getWrc_nm() {
		return wrc_nm;
	}
	public void setWrc_nm(String wrc_nm) {
		this.wrc_nm = wrc_nm;
	}
	public String getPstnCd() {
		return pstnCd;
	}
	public void setPstnCd(String pstnCd) {
		this.pstnCd = pstnCd;
	}
	public String getMrrg_yn() {
		return mrrg_yn;
	}
	public void setMrrg_yn(String mrrg_yn) {
		this.mrrg_yn = mrrg_yn;
	}
	public String getNative_yn() {
		return native_yn;
	}
	public void setNative_yn(String native_yn) {
		this.native_yn = native_yn;
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
	public String getDrmncy_chng_unit() {
		return drmncy_chng_unit;
	}
	public void setDrmncy_chng_unit(String drmncy_chng_unit) {
		this.drmncy_chng_unit = drmncy_chng_unit;
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
	public String getJoinMembership() {
		return joinMembership;
	}
	public void setJoinMembership(String joinMembership) {
		this.joinMembership = joinMembership;
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
	public String getMcardNo() {
		return mcardNo;
	}
	public void setMcardNo(String mcardNo) {
		this.mcardNo = mcardNo;
	}
	
}
