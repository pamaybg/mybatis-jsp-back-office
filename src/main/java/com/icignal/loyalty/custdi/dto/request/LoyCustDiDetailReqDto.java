package com.icignal.loyalty.custdi.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCustDiDetailReqDto extends CommonDataAuthReqDto{
	
	private String rid;
	private String empId;
	private String ridCustDi;
	
	private String diNm;
	private String custTypeCd;
	private String sbscCd;
	private String certTypeCd;
	private String actYn;
	private int mergeScore;
	private int  suspendScore;
	//식별값
	private String fieldCd;
	private int seq;
	private int score;
	//중복 결과
	private String tgtCustNm;
	private String similrCustNm;
	private String tgtCustNo;
	private String similrCustNo;
	private String mrgTypeCd;
	private String statCd;
	private String ridPgm;
	
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
	public String getRidCustDi() {
		return ridCustDi;
	}
	public void setRidCustDi(String ridCustDi) {
		this.ridCustDi = ridCustDi;
	}
	public String getDiNm() {
		return diNm;
	}
	public void setDiNm(String diNm) {
		this.diNm = diNm;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getSbscCd() {
		return sbscCd;
	}
	public void setSbscCd(String sbscCd) {
		this.sbscCd = sbscCd;
	}

	public String getCertTypeCd() {
		return certTypeCd;
	}
	public void setCertTypeCd(String certTypeCd) {
		this.certTypeCd = certTypeCd;
	}
	public String getActYn() {
		return actYn;
	}
	public void setActYn(String actYn) {
		this.actYn = actYn;
	}
	public int getMergeScore() {
		return mergeScore;
	}
	public void setMergeScore(int mergeScore) {
		this.mergeScore = mergeScore;
	}
	public int getSuspendScore() {
		return suspendScore;
	}
	public void setSuspendScore(int suspendScore) {
		this.suspendScore = suspendScore;
	}
	public String getFieldCd() {
		return fieldCd;
	}
	public void setFieldCd(String fieldCd) {
		this.fieldCd = fieldCd;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getTgtCustNm() {
		return tgtCustNm;
	}
	public void setTgtCustNm(String tgtCustNm) {
		this.tgtCustNm = tgtCustNm;
	}
	public String getSimilrCustNm() {
		return similrCustNm;
	}
	public void setSimilrCustNm(String similrCustNm) {
		this.similrCustNm = similrCustNm;
	}
	public String getTgtCustNo() {
		return tgtCustNo;
	}
	public void setTgtCustNo(String tgtCustNo) {
		this.tgtCustNo = tgtCustNo;
	}
	public String getSimilrCustNo() {
		return similrCustNo;
	}
	public void setSimilrCustNo(String similrCustNo) {
		this.similrCustNo = similrCustNo;
	}
	public String getMrgTypeCd() {
		return mrgTypeCd;
	}
	public void setMrgTypeCd(String mrgTypeCd) {
		this.mrgTypeCd = mrgTypeCd;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}	
}
