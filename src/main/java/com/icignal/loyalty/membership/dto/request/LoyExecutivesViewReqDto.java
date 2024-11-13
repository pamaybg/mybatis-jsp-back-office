package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyExecutivesViewReqDto extends CommonDataAuthReqDto {
	private String mbrRid;
	private String custRid;
	private String custiRid;
	private String empNo;
	private String empNoNew;
	private String mbrStatCd;
	private String custStatCd;
	private String wrcNm;
	private String deptNm;
	private String wrDeData;
	private String oldMbrStatCd;
	
	
	public String getOldMbrStatCd() {
		return oldMbrStatCd;
	}
	public void setOldMbrStatCd(String oldMbrStatCd) {
		this.oldMbrStatCd = oldMbrStatCd;
	}
	public String getEmpNoNew() {
		return empNoNew;
	}
	public void setEmpNoNew(String empNoNew) {
		this.empNoNew = empNoNew;
	}
	public String getCustiRid() {
		return custiRid;
	}
	public void setCustiRid(String custiRid) {
		this.custiRid = custiRid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getCustRid() {
		return custRid;
	}
	public void setCustRid(String custRid) {
		this.custRid = custRid;
	}
	public String getWrDeData() {
		return wrDeData;
	}
	public void setWrDeData(String wrDeData) {
		this.wrDeData = wrDeData;
	}
	public String getWrcNm() {
		return wrcNm;
	}
	public void setWrcNm(String wrcNm) {
		this.wrcNm = wrcNm;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getCustStatCd() {
		return custStatCd;
	}
	public void setCustStatCd(String custStatCd) {
		this.custStatCd = custStatCd;
	}
}
