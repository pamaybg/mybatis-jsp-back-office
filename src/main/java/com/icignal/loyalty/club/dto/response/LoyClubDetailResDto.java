package com.icignal.loyalty.club.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyClubDetailResDto extends StatusResDto{

	//상세
	private String rid;
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
	
	//속성정보
	private String fieldTypeCd;
	private String reqYn;
	private String code;
	private String val;
	
	//오퍼
	private String ofrNm;
	private String ridOfr;
	private String bnftTypeCd;
	private int ofrAmt;
	private String acrlCycleTypeCd;
	
	//클럽 회원
	private String fileName;
	private String filePName;
	private String fileLName;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getFieldTypeCd() {
		return fieldTypeCd;
	}
	public void setFieldTypeCd(String fieldTypeCd) {
		this.fieldTypeCd = fieldTypeCd;
	}
	public String getReqYn() {
		return reqYn;
	}
	public void setReqYn(String reqYn) {
		this.reqYn = reqYn;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getVal() {
		return val;
	}
	public void setVal(String val) {
		this.val = val;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePName() {
		return filePName;
	}
	public void setFilePName(String filePName) {
		this.filePName = filePName;
	}
	public String getFileLName() {
		return fileLName;
	}
	public void setFileLName(String fileLName) {
		this.fileLName = fileLName;
	}
	public String getBnftTypeCd() {
		return bnftTypeCd;
	}
	public void setBnftTypeCd(String bnftTypeCd) {
		this.bnftTypeCd = bnftTypeCd;
	}
	public int getOfrAmt() {
		return ofrAmt;
	}
	public void setOfrAmt(int ofrAmt) {
		this.ofrAmt = ofrAmt;
	}
	public String getAcrlCycleTypeCd() {
		return acrlCycleTypeCd;
	}
	public void setAcrlCycleTypeCd(String acrlCycleTypeCd) {
		this.acrlCycleTypeCd = acrlCycleTypeCd;
	}
}
