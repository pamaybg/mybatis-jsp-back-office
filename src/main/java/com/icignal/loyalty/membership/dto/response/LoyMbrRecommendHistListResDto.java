/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrRecommendHistListResDTo.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 15. 오후 2:10:11
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyMbrRecommendHistListResDTo
 * 2. 파일명	: LoyMbrRecommendHistListResDTo.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
@PersonalData
public class LoyMbrRecommendHistListResDto extends GridPagingItemResDto{
	private String rid;
	private String rcmmdTypeCd;
	@MarkName(groupCode="LOY_MBR_RCMMD_TYPE_CD",codeField="rcmmdTypeCd")
	private String remmdTypeCdNm;
	@Decrypted(masked = "none")
	private String targetcustNm;
	@Decrypted(masked = "none")
	private String nonTargetcustNm;
	private String regDate;
	private String rcmmHist;
	@Decrypted(masked = "none")
	private String custNm;
	private String mbrNo;
	private String ridMbr; // 추천으로 가입한 회원의 rid
	private String custStatCd; 	
	private String custStatCdNm;
	
	
	
	public String getCustStatCd() {
		return custStatCd;
	}
	public void setCustStatCd(String custStatCd) {
		this.custStatCd = custStatCd;
	}
	public String getCustStatCdNm() {
		return custStatCdNm;
	}
	public void setCustStatCdNm(String custStatCdNm) {
		this.custStatCdNm = custStatCdNm;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRcmmHist() {
		return rcmmHist;
	}
	public void setRcmmHist(String rcmmHist) {
		this.rcmmHist = rcmmHist;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRcmmdTypeCd() {
		return rcmmdTypeCd;
	}
	public void setRcmmdTypeCd(String rcmmdTypeCd) {
		this.rcmmdTypeCd = rcmmdTypeCd;
	}
	public String getRemmdTypeCdNm() {
		return remmdTypeCdNm;
	}
	public void setRemmdTypeCdNm(String remmdTypeCdNm) {
		this.remmdTypeCdNm = remmdTypeCdNm;
	}
	public String getTargetcustNm() {
		return targetcustNm;
	}
	public void setTargetcustNm(String targetcustNm) {
		this.targetcustNm = targetcustNm;
	}
	public String getNonTargetcustNm() {
		return nonTargetcustNm;
	}
	public void setNonTargetcustNm(String nonTargetcustNm) {
		this.nonTargetcustNm = nonTargetcustNm;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
}
