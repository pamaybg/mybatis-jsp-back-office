package com.icignal.marketing.campaignhome.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: CampaignHomeReqDto
 * 2. 파일명	: CampaignHomeReqDto.java
 * 3. 패키지명	: com.icignal.marketing.campaignhome.dto.request
 * 4. 작성자명	: wjlee
 * 5. 작성일자	: 2016. 11. 24. 
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class CampaignHomeReqDto extends CommonDataAuthReqDto {
	
	private String empId;
	private String authType;
	private String brandCd;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getAuthType() {return authType;}

	public void setAuthType(String authType) {this.authType = authType;}

	public String getBrandCd() {return brandCd;}

	public void setBrandCd(String brandCd) {this.brandCd = brandCd;}
}
