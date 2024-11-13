/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustLoginInfoListResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 13. 오후 5:57:31
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyCustLoginInfoListResDto
 * 2. 파일명	: LoyCustLoginInfoListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
@PersonalData
public class LoyCustLoginInfoListResDto extends GridPagingItemResDto{
	private String rid;
	private String loginTypeCd;
	@MarkName(groupCode="LOY_LOGIN_TYPE_CD",codeField="loginTypeCd")
	private String loginTypeCdNm;
	@Decrypted(masked="none")
	private String userId;
	private String failCnt;
	private String failDate;

	private String deviceTypeCd;
	@MarkName(groupCode="LOY_MOBILE_DVICE_CD",codeField="deviceTypeCd")
	private String deviceTypeCdNm;
	private String token;
	private String regDate;
	
	private String mobileDeviceCd;
	@MarkName(groupCode="LOY_MOBILE_DVICE_CD",codeField="mobileDeviceCd")
	private String mobileDeviceCdNm;
	private String verNo;
	private String tokenVal;
	private String deviceAgreYn;

	private String deviceUuid;
	private String deviceArgeDate;
	private String createDate;
	private String repYn;

	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getMobileDeviceCdNm() {
		return mobileDeviceCdNm;
	}
	public void setMobileDeviceCdNm(String mobileDeviceCdNm) {
		this.mobileDeviceCdNm = mobileDeviceCdNm;
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
	public String getTokenVal() {
		return tokenVal;
	}
	public void setTokenVal(String tokenVal) {
		this.tokenVal = tokenVal;
	}
	public String getDeviceAgreYn() {
		return deviceAgreYn;
	}
	public void setDeviceAgreYn(String deviceAgreYn) {
		this.deviceAgreYn = deviceAgreYn;
	}
	public String getDeviceTypeCdNm() {
		return deviceTypeCdNm;
	}
	public void setDeviceTypeCdNm(String deviceTypeCdNm) {
		this.deviceTypeCdNm = deviceTypeCdNm;
	}
	public String getLoginTypeCdNm() {
		return loginTypeCdNm;
	}
	public void setLoginTypeCdNm(String loginTypeCdNm) {
		this.loginTypeCdNm = loginTypeCdNm;
	}
	public String getDeviceTypeCd() {
		return deviceTypeCd;
	}
	public void setDeviceTypeCd(String deviceTypeCd) {
		this.deviceTypeCd = deviceTypeCd;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getLoginTypeCd() {
		return loginTypeCd;
	}
	public void setLoginTypeCd(String loginTypeCd) {
		this.loginTypeCd = loginTypeCd;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFailCnt() {
		return failCnt;
	}
	public void setFailCnt(String failCnt) {
		this.failCnt = failCnt;
	}
	public String getFailDate() {
		return failDate;
	}
	public void setFailDate(String failDate) {
		this.failDate = failDate;
	}
	public String getDeviceUuid() {
		return deviceUuid;
	}
	public void setDeviceUuid(String deviceUuid) {
		this.deviceUuid = deviceUuid;
	}
	public String getDeviceArgeDate() {
		return deviceArgeDate;
	}
	public void setDeviceArgeDate(String deviceArgeDate) {
		this.deviceArgeDate = deviceArgeDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getRepYn() {
		return repYn;
	}
	public void setRepYn(String repYn) {
		this.repYn = repYn;
	}
	
	
	
}
