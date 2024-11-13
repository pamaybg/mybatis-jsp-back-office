package com.icignal.loyalty.club.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyClubAttrListResDto
 * 2. 파일명	: LoyClubAttrListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.club.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *		클럽 속성 Response DTO
 * </PRE>
 */ 
@CommCode
public class LoyClubAttrListResDto extends GridPagingItemResDto {

	private String rid;
	@MarkName(groupCode = "LOY_CLUB_FIELD_CD", codeField = "fieldTypeCd")
	private String fieldTypeCdNm;
	private String fieldTypeCd;
	@MarkName(groupCode = "LOY_CLUB_SUB_TYPE_CD", codeField = "code")
	private String codeNm;
	private String code;
	private String val;
	private String modifyBy;
	private String modifyDate;
	private String reqYn;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFieldTypeCd() {
		return fieldTypeCd;
	}
	public void setFieldTypeCd(String fieldTypeCd) {
		this.fieldTypeCd = fieldTypeCd;
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
	public String getFieldTypeCdNm() {
		return fieldTypeCdNm;
	}
	public void setFieldTypeCdNm(String fieldTypeCdNm) {
		this.fieldTypeCdNm = fieldTypeCdNm;
	}
	public String getCodeNm() {
		return codeNm;
	}
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}
	public String getReqYn() {
		return reqYn;
	}
	public void setReqYn(String reqYn) {
		this.reqYn = reqYn;
	}
	
}
