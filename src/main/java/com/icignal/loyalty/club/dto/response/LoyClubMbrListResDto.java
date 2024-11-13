package com.icignal.loyalty.club.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyClubMbrListResDto
 * 2. 파일명	: LoyClubMbrListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.club.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *		클럽 회원 Response DTO
 * </PRE>
 */ 
@PersonalData
@CommCode
public class LoyClubMbrListResDto extends GridPagingItemResDto {
	
	private String rid;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "tel")
	private String hhp;
	@MarkName(groupCode = "LOY_CLUB_MEM_STAT_CD", codeField = "statCd")
	private String statCdNm;
	private String statCd;
	private String fileName;
	private String createDate;
	private String processDate;
	private String modifyBy;
	private String path;
	private String clubMbrDir = "clubMbrFile/";
	private String fileLName;
	private String validStartDate;
	private String validEndDate;
	private String unMaskCustNm;
	private String unMaskHhp;
	
	
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getStatCd() {
		return statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getProcessDate() {
		return processDate;
	}
	public void setProcessDate(String processDate) {
		this.processDate = processDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getClubMbrDir() {
		return clubMbrDir;
	}
	public void setClubMbrDir(String clubMbrDir) {
		this.clubMbrDir = clubMbrDir;
	}
	public String getFileLName() {
		return fileLName;
	}
	public void setFileLName(String fileLName) {
		this.fileLName = fileLName;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}

}
