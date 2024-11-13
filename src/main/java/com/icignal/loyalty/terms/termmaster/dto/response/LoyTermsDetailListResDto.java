package com.icignal.loyalty.terms.termmaster.dto.response;

import java.sql.Date;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyTermsDetailListResDto extends StatusResDto{

	private String rid;
	private String verRid;
	private String termsType;
	private String termsTypeSub;
	private Float ver;
	private String createDate;
	private String modifyDate;
	private String ridTermsM;
	private Date startDate;
	private String termsSumry;
	private String termsConts;
	private String useYn;
	private String mktRcvChnlCd;
	private String statCd;
	private String seqNo;
	private String requiredYn;
	private String editMode;
	private String termsNo;
	
	
	public String getTermsNo() {
		return termsNo;
	}
	public void setTermsNo(String termsNo) {
		this.termsNo = termsNo;
	}
	public String getEditMode() {
		return editMode;
	}
	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}
	public String getTermsType() {
		return termsType;
	}
	public void setTermsType(String termsType) {
		this.termsType = termsType;
	}
	public String getTermsTypeSub() {
		return termsTypeSub;
	}
	public void setTermsTypeSub(String termsTypeSub) {
		this.termsTypeSub = termsTypeSub;
	}
	public Float getVer() {
		return ver;
	}
	public void setVer(Float ver) {
		this.ver = ver;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getRidTermsM() {
		return ridTermsM;
	}
	public void setRidTermsM(String ridTermsM) {
		this.ridTermsM = ridTermsM;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
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
	public String getVerRid() {
		return verRid;
	}
	public void setVerRid(String verRid) {
		this.verRid = verRid;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getMktRcvChnlCd() {
		return mktRcvChnlCd;
	}
	public void setMktRcvChnlCd(String mktRcvChnlCd) {
		this.mktRcvChnlCd = mktRcvChnlCd;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getRequiredYn() {
		return requiredYn;
	}
	public void setRequiredYn(String requiredYn) {
		this.requiredYn = requiredYn;
	}
	
}
