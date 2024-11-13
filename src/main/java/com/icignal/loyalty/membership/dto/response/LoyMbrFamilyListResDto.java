package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@CommCode
@PersonalData
public class LoyMbrFamilyListResDto extends GridPagingItemResDto{

	private String rid;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "tel")
	private String hhp;
	@MarkName(groupCode = "LOY_FAML_REL_CD", codeField = "relCd")
	private String relCdNm;
	private String relCd;
	@MarkName(groupCode = "LOY_FAML_MBR_STAT_CD", codeField = "statCd")
	private String statCdNm;
	private String statCd;
	private int totalPntAvl;
	private String createDate;
	private String secsnDate;
	
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getRelCdNm() {
		return relCdNm;
	}
	public void setRelCdNm(String relCdNm) {
		this.relCdNm = relCdNm;
	}
	public String getRelCd() {
		return relCd;
	}
	public void setRelCd(String relCd) {
		this.relCd = relCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public int getTotalPntAvl() {
		return totalPntAvl;
	}
	public void setTotalPntAvl(int totalPntAvl) {
		this.totalPntAvl = totalPntAvl;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getSecsnDate() {
		return secsnDate;
	}
	public void setSecsnDate(String secsnDate) {
		this.secsnDate = secsnDate;
	}
}
