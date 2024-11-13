/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrSvrHistListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 8. 오후 6:01:54
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 8.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrSvrHistListResDto
 * 2. 파일명	: LoyMbrSvrHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 8.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyCustSvrHistListResDto extends GridPagingItemResDto{
	private String rid;
	private String svrTypeCd;
	@MarkName(groupCode="LOY_SVC_TYPE_CD", codeField="svrTypeCd")
	private String svrTypeCdNm;
	private String chnlNm;
	private String chnlNo;
	private String chnlTypeCd;
	@MarkName(groupCode="LOY_CHNL_TYPE_CD", codeField="chnlTypeCd")
	private String chnlTypeCdNm;
	private String chnlTypeSubCd;
	//@MarkName(groupCode="LOY_CHNL_SUB_TYPE_CD", codeField="chnlTypeSubCd")
	private String chnlTypeSubCdNm;
	private String svrDt;
	private String deviceUuid;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSvrTypeCd() {
		return svrTypeCd;
	}
	public void setSvrTypeCd(String svrTypeCd) {
		this.svrTypeCd = svrTypeCd;
	}
	public String getSvrTypeCdNm() {
		return svrTypeCdNm;
	}
	public void setSvrTypeCdNm(String svrTypeCdNm) {
		this.svrTypeCdNm = svrTypeCdNm;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getChnlTypeCdNm() {
		return chnlTypeCdNm;
	}
	public void setChnlTypeCdNm(String chnlTypeCdNm) {
		this.chnlTypeCdNm = chnlTypeCdNm;
	}
	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}
	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
	}
	public String getChnlTypeSubCdNm() {
		return chnlTypeSubCdNm;
	}
	public void setChnlTypeSubCdNm(String chnlTypeSubCdNm) {
		this.chnlTypeSubCdNm = chnlTypeSubCdNm;
	}
	public String getSvrDt() {
		return svrDt;
	}
	public void setSvrDt(String svrDt) {
		this.svrDt = svrDt;
	}
	public String getDeviceUuid() {
		return deviceUuid;
	}
	public void setDeviceUuid(String deviceUuid) {
		this.deviceUuid = deviceUuid;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
}
