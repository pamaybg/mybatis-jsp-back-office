package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyMbrSignInfoResDto extends StatusResDto {

	private String empNo;
	private String sbscTmscnt;
	private String firstSbscDt;
	private String firstCardRegDt;
	private String sbscPointPrvdYn;
	private String sbscPointPrvdDt;
	private String dnatPointPrvdYn;
	private String dnatPointPrvdDt;
	private String fraudCustRegDt;

	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getSbscTmscnt() {
		return sbscTmscnt;
	}
	public void setSbscTmscnt(String sbscTmscnt) {
		this.sbscTmscnt = sbscTmscnt;
	}
	public String getFirstSbscDt() {
		return firstSbscDt;
	}
	public void setFirstSbscDt(String firstSbscDt) {
		this.firstSbscDt = firstSbscDt;
	}
	public String getFirstCardRegDt() {
		return firstCardRegDt;
	}
	public void setFirstCardRegDt(String firstCardRegDt) {
		this.firstCardRegDt = firstCardRegDt;
	}
	public String getSbscPointPrvdYn() {
		return sbscPointPrvdYn;
	}
	public void setSbscPointPrvdYn(String sbscPointPrvdYn) {
		this.sbscPointPrvdYn = sbscPointPrvdYn;
	}
	public String getSbscPointPrvdDt() {
		return sbscPointPrvdDt;
	}
	public void setSbscPointPrvdDt(String sbscPointPrvdDt) {
		this.sbscPointPrvdDt = sbscPointPrvdDt;
	}
	public String getDnatPointPrvdYn() {
		return dnatPointPrvdYn;
	}
	public void setDnatPointPrvdYn(String dnatPointPrvdYn) {
		this.dnatPointPrvdYn = dnatPointPrvdYn;
	}
	public String getDnatPointPrvdDt() {
		return dnatPointPrvdDt;
	}
	public void setDnatPointPrvdDt(String dnatPointPrvdDt) {
		this.dnatPointPrvdDt = dnatPointPrvdDt;
	}
	public String getFraudCustRegDt() {
		return fraudCustRegDt;
	}
	public void setFraudCustRegDt(String fraudCustRegDt) {
		this.fraudCustRegDt = fraudCustRegDt;
	}




}
