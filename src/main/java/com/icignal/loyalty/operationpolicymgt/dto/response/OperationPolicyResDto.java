package com.icignal.loyalty.operationpolicymgt.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class OperationPolicyResDto extends GridPagingItemResDto {
	// 멤버 필드
	private String rid;
	private String createBy;
	private String modifyBy;
	private String createDate;
	private String modifyDate;
	private String flag;
	private String ridPgm;
	private String ctg1Cd;
    //@MarkName(groupCode="LOY_OPR_PLCY_CTG_1_CD", codeField="ctg1Cd")
	private String ctg1CdNm;
	private String ctg2Cd;
    //@MarkName(groupCode="LOY_OPR_PLCY_CTG_2_CD", codeField="ctg2Cd")
	private String ctg2CdNm;
	private String plcyCd;
    //@MarkName(groupCode="LOY_OPR_PLCY_CD", codeField="plcyCd")
	private String plcyCdNm;
	private String contents;
	private String useYn;

	private String pgmNm; // 로열티 프로그램 명
	private String pgmMarkNm;
	
	
	// 게터세터
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
	public String getCtg1CdNm() {
		return ctg1CdNm;
	}
	public void setCtg1CdNm(String ctg1CdNm) {
		this.ctg1CdNm = ctg1CdNm;
	}
	public String getCtg2Cd() {
		return ctg2Cd;
	}
	public void setCtg2Cd(String ctg2Cd) {
		this.ctg2Cd = ctg2Cd;
	}
	public String getCtg2CdNm() {
		return ctg2CdNm;
	}
	public void setCtg2CdNm(String ctg2CdNm) {
		this.ctg2CdNm = ctg2CdNm;
	}
	public String getPlcyCd() {
		return plcyCd;
	}
	public void setPlcyCd(String plcyCd) {
		this.plcyCd = plcyCd;
	}
	public String getPlcyCdNm() {
		return plcyCdNm;
	}
	public void setPlcyCdNm(String plcyCdNm) {
		this.plcyCdNm = plcyCdNm;
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
	public String getPgmMarkNm() {
		return pgmMarkNm;
	}
	public void setPgmMarkNm(String pgmMarkNm) {
		this.pgmMarkNm = pgmMarkNm;
	}
    

	
}
