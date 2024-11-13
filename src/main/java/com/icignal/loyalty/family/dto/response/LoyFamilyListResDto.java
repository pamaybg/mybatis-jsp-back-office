package com.icignal.loyalty.family.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@PersonalData
@CommCode
public class LoyFamilyListResDto extends GridPagingItemResDto{

	private String rid;
	private String mbrRid;
	private String pgmNm;
	private String fmlyNm;
	@MarkName(groupCode = "LOY_FAML_STAT_CD",codeField = "statCd")
	private String statCdNm;
	private String statCd;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "email")
	private String email;
	@Decrypted(masked = "tel")
	private String hhp;
	private String fmlyCnt;
	private String applDate;
	private String apprDate;
	private String canlDate;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	@Decrypted(masked = "none")
	private String unMaskEmail;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getFmlyNm() {
		return fmlyNm;
	}
	public void setFmlyNm(String fmlyNm) {
		this.fmlyNm = fmlyNm;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getFmlyCnt() {
		return fmlyCnt;
	}
	public void setFmlyCnt(String fmlyCnt) {
		this.fmlyCnt = fmlyCnt;
	}
	public String getApplDate() {
		return applDate;
	}
	public void setApplDate(String applDate) {
		this.applDate = applDate;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getCanlDate() {
		return canlDate;
	}
	public void setCanlDate(String canlDate) {
		this.canlDate = canlDate;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getUnMaskEmail() {
		return unMaskEmail;
	}
	public void setUnMaskEmail(String unMaskEmail) {
		this.unMaskEmail = unMaskEmail;
	}
	
}
