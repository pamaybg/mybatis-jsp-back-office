package com.icignal.loyalty.club.dto.request;

import java.sql.Date;
import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyClubListReqDto
 * 2. 파일명	: LoyClubListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.club.dto.request
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		멤버십 클럽 Request DTO
 * </PRE>
 */ 
public class LoyClubListReqDto extends CommonDataAuthReqDto{

	private String rid;
	private String empId;
	private String clubMbrRid;
	private String ridPgm;
	private String pgmNo;
	private String statCd;
	private String reason;
	private List<String> ridList;
	
	private Date startDt;
	private Date endDt;

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

	public String getClubMbrRid() {
		return clubMbrRid;
	}

	public void setClubMbrRid(String clubMbrRid) {
		this.clubMbrRid = clubMbrRid;
	}

	public String getRidPgm() {
		return ridPgm;
	}

	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	public String getStatCd() {
		return statCd;
	}

	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public List<String> getRidList() {
		return ridList;
	}

	public void setRidList(List<String> ridList) {
		this.ridList = ridList;
	}

	public Date getStartDt() {
		return startDt;
	}

	public void setStartDt(Date startDt) {
		this.startDt = startDt;
	}

	public Date getEndDt() {
		return endDt;
	}

	public void setEndDt(Date endDt) {
		this.endDt = endDt;
	}

	public String getPgmNo() {
		return pgmNo;
	}

	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	
}
