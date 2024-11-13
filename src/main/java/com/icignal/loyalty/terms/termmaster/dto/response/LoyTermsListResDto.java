package com.icignal.loyalty.terms.termmaster.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyTermsListResDto extends GridPagingItemResDto{

	private String rid;
	private String termRid;

	@MarkName(groupCode = "LOY_TERMS_TYPE_CD", codeField = "termsTypeCd")
	private String termsType;
	private String termsTypeCd;
	
	@MarkName(groupCode = "LOY_CUST_AGRE_TYPE_CD", codeField = "termsTypeSubCd")
	private String termsNm;
	private String termsTypeSubCd;
	private String ver;
	private String verRid;
	private String chnlRid;
	private String startDate;
	@MarkName(groupCode = "COM_STAT_TYPE_2_CD", codeField = "statCd")
	private String statCdNm; 
	private String statCd; 
	private String createBy;
	private String createDate;
	private String modifyBy;
	private String modifyDate;
	private String termsSumry;
	private String termsConts;
	@MarkName(groupCode = "REQUIRED_YN", codeField = "requiredYn")
	private String requiredYnCd;
	private String requiredYn;
	
	private String ridTerms;
	
	private String termsGrpCd;
	@MarkName(groupCode = "LOY_TERMS_GRP_CD", codeField = "termsGrpCd")
	private String termsGrpCdNm;
	
	private String termsNo;
	
	private Integer count;



	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public String getRidTerms() {
		return ridTerms;
	}
	public void setRidTerms(String ridTerms) {
		this.ridTerms = ridTerms;
	}
	public String getTermsGrpCd() {
		return termsGrpCd;
	}
	public void setTermsGrpCd(String termsGrpCd) {
		this.termsGrpCd = termsGrpCd;
	}
	public String getTermsGrpCdNm() {
		return termsGrpCdNm;
	}
	public void setTermsGrpCdNm(String termsGrpCdNm) {
		this.termsGrpCdNm = termsGrpCdNm;
	}
	public String getTermsNo() {
		return termsNo;
	}
	public void setTermsNo(String termsNo) {
		this.termsNo = termsNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTermsType() {
		return termsType;
	}
	public void setTermsType(String termsType) {
		this.termsType = termsType;
	}
	public String getTermsNm() {
		return termsNm;
	}
	public void setTermsNm(String termsNm) {
		this.termsNm = termsNm;
	}
	public String getVer() {
		return ver;
	}
	public void setVer(String ver) {
		this.ver = ver;
	}
	public String getTermsTypeCd() {
		return termsTypeCd;
	}
	public void setTermsTypeCd(String termsTypeCd) {
		this.termsTypeCd = termsTypeCd;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
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
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getTermsTypeSubCd() {
		return termsTypeSubCd;
	}
	public void setTermsTypeSubCd(String termsTypeSubCd) {
		this.termsTypeSubCd = termsTypeSubCd;
	}
	public String getVerRid() {
		return verRid;
	}
	public void setVerRid(String verRid) {
		this.verRid = verRid;
	}
	public String getTermsSumry() {
		return termsSumry;
	}
	public void setTermsSumry(String termsSumry) {
		this.termsSumry = termsSumry;
	}
	public String getTermsConts() {
		return termsConts;
	}
	public void setTermsConts(String termsConts) {
		this.termsConts = termsConts;
	}
	public String getRequiredYn() {
		return requiredYn;
	}
	public void setRequiredYn(String requiredYn) {
		this.requiredYn = requiredYn;
	}
	public String getRequiredYnCd() {
		return requiredYnCd;
	}
	public void setRequiredYnCd(String requiredYnCd) {
		this.requiredYnCd = requiredYnCd;
	}
	public String getTermRid() { return termRid; }
	public void setTermRid(String termRid) { this.termRid = termRid; }
}
