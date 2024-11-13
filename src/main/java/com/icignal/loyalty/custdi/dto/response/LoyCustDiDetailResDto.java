package com.icignal.loyalty.custdi.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyCustDiDetailResDto extends StatusResDto{

	private String rid;
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
	
	private String parPgmRid;
	private String parPgmNm;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getParPgmRid() {
		return parPgmRid;
	}
	public void setParPgmRid(String parPgmRid) {
		this.parPgmRid = parPgmRid;
	}
	public String getParPgmNm() {
		return parPgmNm;
	}
	public void setParPgmNm(String parPgmNm) {
		this.parPgmNm = parPgmNm;
	}
	
}
