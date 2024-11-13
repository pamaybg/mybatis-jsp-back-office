/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCorpDetailResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 4. 27. 오전 11:40:40
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 27.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyCorpDetailResDto
 * 2. 파일명	: LoyCorpDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 4. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
@CommCode
public class LoyCorpDetailResDto extends GridPagingItemResDto{
	private String rid;
	private String custNo;
	private String custTypeCd;
	@MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custTypeCd")
	private String custTypeCdNm;
	private String custStatCd;
	@MarkName(groupCode="LOY_CUST_STAT_CD", codeField="custStatCd")
	private String custStatCdNm;
	private String cmpnyNm;
	private String bizrNo;
	private String jurirNo;
	private String fondDt;
	@Decrypted(masked = "none")
	private String ceo;
	@Decrypted(masked = "none")
	private String charger;
	/*@Decrypted(masked = "none")*/
	private String telNo;
	@Decrypted(masked = "none")
	private String email;
	/*@Decrypted(masked = "none")*/
	private String fax;
	@Decrypted(masked = "none")
	private String zip;
	private String adres;
	@Decrypted(masked = "none")
	private String bunji;
	private String etc;
	
	private String sbscDate;
	private String sbscCoursCd;
	private String chnlNm;
	
	private String custCd;
	@MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custCd")
	private String custCdNm;
	private String sbscCd;
	@MarkName(groupCode="LOY_SBSC_TYPE_CD", codeField="sbscCd")
	private String sbscCdNm;
	
	
	
	private String sbscCertMn;
	@MarkName(groupCode="LOY_SBSC_CERT_MN", codeField="sbscCertMn")
	private String sbscCertMnNm;
	private String fieldCd;
	@MarkName(groupCode="LOY_CUST_DI_FIELD_CD", codeField="fieldCd")
	private String fieldCdNm;
	
	private String drmmcyDate;
	private String lastChnlNm;
	private String sbscPathCd;
	@MarkName(groupCode="LOY_SBSC_PATH_CD", codeField="sbscPathCd")
	private String sbscPathCdNm;
	
	@Decrypted(masked = "none")
	private String webId;
	
	private String svrDt;
	
	@Decrypted(masked = "none")
	private String hhp;
	private String rcmmdNo;
	private String drmmcyChngUnit;
	private String custCertTypeCd;
	@MarkName(groupCode="LOY_CERT_TYPE_CD", codeField="custCertTypeCd")
	private String custCertTypeCdNm;
	
	private String certSubTypeCd;
	@MarkName(groupCode="LOY_CERT_SUB_TYPE_CD", codeField="certSubTypeCd")
	private String certSubTypeCdNm;
	private String certVal;
	private String induty;
	private String bizcnd;
	private String capl;
	private String certDate;
	@Decrypted(masked = "none")
	private String custNm;
	
	private String mcardNo;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCmpnyNm() {
		return cmpnyNm;
	}
	public void setCmpnyNm(String cmpnyNm) {
		this.cmpnyNm = cmpnyNm;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getJurirNo() {
		return jurirNo;
	}
	public void setJurirNo(String jurirNo) {
		this.jurirNo = jurirNo;
	}
	public String getFondDt() {
		return fondDt;
	}
	public void setFondDt(String fondDt) {
		this.fondDt = fondDt;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
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
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}
	public String getSbscCoursCd() {
		return sbscCoursCd;
	}
	public void setSbscCoursCd(String sbscCoursCd) {
		this.sbscCoursCd = sbscCoursCd;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
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
	public String getSbscCertMn() {
		return sbscCertMn;
	}
	public void setSbscCertMn(String sbscCertMn) {
		this.sbscCertMn = sbscCertMn;
	}
	public String getDrmmcyDate() {
		return drmmcyDate;
	}
	public void setDrmmcyDate(String drmmcyDate) {
		this.drmmcyDate = drmmcyDate;
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
	public String getCharger() {
		return charger;
	}
	public void setCharger(String charger) {
		this.charger = charger;
	}
	public String getCustStatCdNm() {
		return custStatCdNm;
	}
	public void setCustStatCdNm(String custStatCdNm) {
		this.custStatCdNm = custStatCdNm;
	}
	public String getCustCdNm() {
		return custCdNm;
	}
	public void setCustCdNm(String custCdNm) {
		this.custCdNm = custCdNm;
	}
	public String getLastChnlNm() {
		return lastChnlNm;
	}
	public void setLastChnlNm(String lastChnlNm) {
		this.lastChnlNm = lastChnlNm;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getFieldCd() {
		return fieldCd;
	}
	public void setFieldCd(String fieldCd) {
		this.fieldCd = fieldCd;
	}
	public String getFieldCdNm() {
		return fieldCdNm;
	}
	public void setFieldCdNm(String fieldCdNm) {
		this.fieldCdNm = fieldCdNm;
	}
	public String getSbscCdNm() {
		return sbscCdNm;
	}
	public void setSbscCdNm(String sbscCdNm) {
		this.sbscCdNm = sbscCdNm;
	}
	public String getSbscCertMnNm() {
		return sbscCertMnNm;
	}
	public void setSbscCertMnNm(String sbscCertMnNm) {
		this.sbscCertMnNm = sbscCertMnNm;
	}
	public String getSvrDt() {
		return svrDt;
	}
	public void setSvrDt(String svrDt) {
		this.svrDt = svrDt;
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
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getRcmmdNo() {
		return rcmmdNo;
	}
	public void setRcmmdNo(String rcmmdNo) {
		this.rcmmdNo = rcmmdNo;
	}
	public String getDrmmcyChngUnit() {
		return drmmcyChngUnit;
	}
	public void setDrmmcyChngUnit(String drmmcyChngUnit) {
		this.drmmcyChngUnit = drmmcyChngUnit;
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
	public String getCapl() {
		return capl;
	}
	public void setCapl(String capl) {
		this.capl = capl;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}
	public String getMcardNo() {
		return mcardNo;
	}
	public void setMcardNo(String mcardNo) {
		this.mcardNo = mcardNo;
	}
	
	
}
