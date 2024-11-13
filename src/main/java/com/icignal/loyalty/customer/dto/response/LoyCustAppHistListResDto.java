/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustAppHistResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 11. 오전 11:33:42
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 11.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyCustAppHistResDto
 * 2. 파일명	: LoyCustAppHistResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyCustAppHistListResDto extends GridPagingItemResDto {
	private String rid;
	private String mobileDeviceCd;
	@MarkName(groupCode="LOY_MOBILE_DVICE_CD",codeField="mobileDeviceCd")
	private String mobileDeviceCdNm;
	private String verNo;
	private String regDate;
	private String tokenVal;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMobileDeviceCd() {
		return mobileDeviceCd;
	}
	public void setMobileDeviceCd(String mobileDeviceCd) {
		this.mobileDeviceCd = mobileDeviceCd;
	}
	public String getVerNo() {
		return verNo;
	}
	public void setVerNo(String verNo) {
		this.verNo = verNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getTokenVal() {
		return tokenVal;
	}
	public void setTokenVal(String tokenVal) {
		this.tokenVal = tokenVal;
	}
	public String getMobileDeviceCdNm() {
		return mobileDeviceCdNm;
	}
	public void setMobileDeviceCdNm(String mobileDeviceCdNm) {
		this.mobileDeviceCdNm = mobileDeviceCdNm;
	}
	
	
}
