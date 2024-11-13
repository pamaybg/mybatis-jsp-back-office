package com.icignal.systemmanagement.organization.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;


/*
 * 1. 클래스명	: SystemOrganizationInfoListReqDto
 * 2. 파일명	: SystemOrganizationInfoListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.organization.dto.request
 * 4. 작성자명	: jun.lee
 * 5. 작성일자	: 2017. 2. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class SystemOrganizationInfoListReqDto extends CommonCondReqDto {
	
	private String rid;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
