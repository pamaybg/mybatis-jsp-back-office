package com.icignal.loyalty.operationpolicymgt.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OperationPolicyReqDto extends CommonDataAuthReqDto {
	// 멤버 필드
	
	private String rid; 
	private String createDate;
	private String modifyDate;
	private String flag;
	private String ridPgm;
	private String ctg1Cd;
	private String ctg2Cd;
	private String plcyCd;
	private String contents;
	private String useYn;

	private String pgmNm; // 로열티 프로그램 명


	// 게터세터
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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getRidPgm() {
		return ridPgm;
	}

	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	public String getCtg1Cd() {
		return ctg1Cd;
	}

	public void setCtg1Cd(String ctg1Cd) {
		this.ctg1Cd = ctg1Cd;
	}

	public String getCtg2Cd() {
		return ctg2Cd;
	}

	public void setCtg2Cd(String ctg2Cd) {
		this.ctg2Cd = ctg2Cd;
	}

	public String getPlcyCd() {
		return plcyCd;
	}

	public void setPlcyCd(String plcyCd) {
		this.plcyCd = plcyCd;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getPgmNm() {
		return pgmNm;
	}

	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	
	
	
}
