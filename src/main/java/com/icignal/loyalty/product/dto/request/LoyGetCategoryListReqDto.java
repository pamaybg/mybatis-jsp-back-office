package com.icignal.loyalty.product.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LOYgetCategoryListRequestDTO
 * 2. 파일명	: LOYgetCategoryListRequestDTO.java
 * 3. 패키지명	: com.icignal.loyalty.product.dto.request
 * 4. 작성자명	: wjlee 
 * 5. 작성일자	: 2016. 12. 14. 
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyGetCategoryListReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String catId;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCatId() {
		return catId;
	}

	public void setCatId(String catId) {
		this.catId = catId;
	}

	
}