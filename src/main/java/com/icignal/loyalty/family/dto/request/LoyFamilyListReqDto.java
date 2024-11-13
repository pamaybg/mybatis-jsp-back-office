package com.icignal.loyalty.family.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyFamilyListReqDto extends CommonDataAuthReqDto{

	private String rid;
	private String empId;
	private String ridMbr;
	private String custNm;
	private String ridPgm;
	
	private String repMbrNo;
	private String relCd;
	private String fmlyNm;
	private String mbrNo;
	
	private String rst;
	private String rstCd;
	private String rstMsg;
	
	
	//패밀리 승인/ 해제
	private List<String> ridList;
	private String statCd;
	private String canlRsnDesc;
	
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
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
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
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getFmlyNm() {
		return fmlyNm;
	}
	public void setFmlyNm(String fmlyNm) {
		this.fmlyNm = fmlyNm;
	}
	public List<String> getRidList() {
		return ridList;
	}
	public void setRidList(List<String> ridList) {
		this.ridList = ridList;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getCanlRsnDesc() {
		return canlRsnDesc;
	}
	public void setCanlRsnDesc(String canlRsnDesc) {
		this.canlRsnDesc = canlRsnDesc;
	}
	public String getRepMbrNo() {
		return repMbrNo;
	}
	public void setRepMbrNo(String repMbrNo) {
		this.repMbrNo = repMbrNo;
	}
	public String getRst() {
		return rst;
	}
	public void setRst(String rst) {
		this.rst = rst;
	}
	public String getRstCd() {
		return rstCd;
	}
	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}
	public String getRstMsg() {
		return rstMsg;
	}
	public void setRstMsg(String rstMsg) {
		this.rstMsg = rstMsg;
	}
	public String getRelCd() {
		return relCd;
	}
	public void setRelCd(String relCd) {
		this.relCd = relCd;
	}
}
