package com.icignal.loyalty.club.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyClubListResDto
 * 2. 파일명	: LoyClubListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.club.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		멤버십 클럽 Response DTO
 * </PRE>
 */ 
@CommCode
public class LoyClubListResDto extends GridPagingItemResDto{

	private String rid;
	private String pgmNm;
	private String clubNo;
	private String clubNm;
	@MarkName(groupCode = "LOY_CLUB_TYPE_CD", codeField = "ctgCd")
	private String ctgCdNm;
	private String ctgCd;
	@MarkName(groupCode = "LOY_ACTIVE_CD", codeField = "clubStatCd")
	private String clubStatCdNm;
	private String clubStatCd;
	private String atchYn;
	private String createBy;
	private String createDate;
	private String modifyBy;
	private String modifyDate;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
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
	public String getCtgCdNm() {
		return ctgCdNm;
	}
	public void setCtgCdNm(String ctgCdNm) {
		this.ctgCdNm = ctgCdNm;
	}
	public String getClubStatCdNm() {
		return clubStatCdNm;
	}
	public void setClubStatCdNm(String clubStatCdNm) {
		this.clubStatCdNm = clubStatCdNm;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

}
