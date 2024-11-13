package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTransSearchTestInfoReqDto
 * 2. 파일명	: LoyTransSearchTestInfoReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.dto.request
 * 4. 작성자명	: 김민준
 * 5. 작성일자	: 2018. 7. 20. 
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyTransSearchTestInfoReqDto extends CommonDataAuthReqDto{

	private String rid ;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
}
