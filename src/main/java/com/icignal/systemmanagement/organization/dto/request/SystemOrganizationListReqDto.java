package com.icignal.systemmanagement.organization.dto.request;
import com.icignal.common.base.dto.request.CommonCondReqDto;

/*
 * 1. 클래스명	: SystemOrganizationListReqDto
 * 2. 파일명	: SystemOrganizationListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.organization.dto.request
 * 4. 작성자명	: jun.lee
 * 5. 작성일자	: 2017. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class SystemOrganizationListReqDto extends CommonCondReqDto {
	
	private String rid;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
}
