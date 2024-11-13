package com.icignal.systemmanagement.organization.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: SystemOrganizationInfoListResDto
 * 2. 파일명	: SystemOrganizationInfoListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.organization.dto.response
 * 4. 작성자명	: jun.lee
 * 5. 작성일자	: 2017. 2. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@CommCode
public class SystemOrganizationInfoListResDto extends GridPagingItemResDto {
	
	private String rid;
	@MarkName(groupCode = "COM_DIVISION_TYPE_CD", codeField = "divTypeCd")
	private String divTypeCd;
	private String divNo;
	private String divNm;
	private String divLvl;
	private String ridParDiv;
	@MarkName(groupCode = "ACCOUNT_STATUS", codeField = "divStatus")
	private String divStatus;
	private String modifyDate;
	private String modifyBy;
	private String xBrandCd;

	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getDivTypeCd() {
		return divTypeCd;
	}
	public void setDivTypeCd(String divTypeCd) {
		this.divTypeCd = divTypeCd;
	}
	public String getDivNo() {
		return divNo;
	}
	public void setDivNo(String divNo) {
		this.divNo = divNo;
	}
	public String getDivNm() {
		return divNm;
	}
	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}
	public String getDivLvl() {
		return divLvl;
	}
	public void setDivLvl(String divLvl) {
		this.divLvl = divLvl;
	}
	public String getRidParDiv() {
		return ridParDiv;
	}
	public void setRidParDiv(String ridParDiv) {
		this.ridParDiv = ridParDiv;
	}
	public String getDivStatus() {
		return divStatus;
	}
	public void setDivStatus(String divStatus) {
		this.divStatus = divStatus;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getxBrandCd() {
		return xBrandCd;
	}

	public void setxBrandCd(String xBrandCd) {
		this.xBrandCd = xBrandCd;
	}
}
