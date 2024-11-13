package com.icignal.loyalty.terms.termmaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyTermsListReqDto extends CommonDataAuthReqDto{

	private String rid;
	private String empId;
	private String parRid;
	private String verRid;
	private String pgmRid;
	private String pgmNo;
	private String statCd;
	private String useYn;
	private String termVerRid;
	
	private String ridTerms;
	private String termsGrpCd;
	private String termsGrpCdChangeVal;
	private String ridTermsChangeVal;
	private String seqNo;

	private String termsTypeSubCd;

	
	
	public String getRidTermsChangeVal() {
		return ridTermsChangeVal;
	}

	public void setRidTermsChangeVal(String ridTermsChangeVal) {
		this.ridTermsChangeVal = ridTermsChangeVal;
	}

	public String getTermsGrpCdChangeVal() {
		return termsGrpCdChangeVal;
	}

	public void setTermsGrpCdChangeVal(String termsGrpCdChangeVal) {
		this.termsGrpCdChangeVal = termsGrpCdChangeVal;
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

	public String getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}

	public String getTermVerRid() {
		return termVerRid;
	}

	public void setTermVerRid(String termVerRid) {
		this.termVerRid = termVerRid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getParRid() {
		return parRid;
	}

	public void setParRid(String parRid) {
		this.parRid = parRid;
	}

	public String getVerRid() {
		return verRid;
	}

	public void setVerRid(String verRid) {
		this.verRid = verRid;
	}

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}

	public String getPgmNo() {
		return pgmNo;
	}

	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}

	public String getStatCd() {
		return statCd;
	}

	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getTermsTypeSubCd() {
		return termsTypeSubCd;
	}

	public void setTermsTypeSubCd(String termsTypeSubCd) {
		this.termsTypeSubCd = termsTypeSubCd;
	}
}
