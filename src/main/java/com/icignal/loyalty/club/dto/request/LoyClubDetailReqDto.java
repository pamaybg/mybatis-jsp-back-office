package com.icignal.loyalty.club.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyClubDetailReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String empId;
	private String clubNo;
	private String clubNm;
	private String ctgCd;
	private String clubStatCd;
	private String atchYn;
	private String publicYn;
	private String rejoinLimitYn;
	private String rejoinLimitDaycnt;
	private String ridPgm;
	private String pgmNm;
	private String periodMm;
	private String createBy;
	private String createDate;
	private String etc;
	
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
	public String getClubNo() {
		return clubNo;
	}
	public void setClubNo(String clubNo) {
		this.clubNo = clubNo;
	}
	public String getClubNm() {
		return clubNm;
	}
	public void setClubNm(String clubNm) {
		this.clubNm = clubNm;
	}
	public String getCtgCd() {
		return ctgCd;
	}
	public void setCtgCd(String ctgCd) {
		this.ctgCd = ctgCd;
	}
	public String getClubStatCd() {
		return clubStatCd;
	}
	public void setClubStatCd(String clubStatCd) {
		this.clubStatCd = clubStatCd;
	}
	public String getAtchYn() {
		return atchYn;
	}
	public void setAtchYn(String atchYn) {
		this.atchYn = atchYn;
	}
	public String getPublicYn() {
		return publicYn;
	}
	public void setPublicYn(String publicYn) {
		this.publicYn = publicYn;
	}
	public String getRejoinLimitYn() {
		return rejoinLimitYn;
	}
	public void setRejoinLimitYn(String rejoinLimitYn) {
		this.rejoinLimitYn = rejoinLimitYn;
	}
	public String getRejoinLimitDaycnt() {
		return rejoinLimitDaycnt;
	}
	public void setRejoinLimitDaycnt(String rejoinLimitDaycnt) {
		this.rejoinLimitDaycnt = rejoinLimitDaycnt;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getPeriodMm() {
		return periodMm;
	}
	public void setPeriodMm(String periodMm) {
		this.periodMm = periodMm;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
}
