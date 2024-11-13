/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBalckMbrDetailResDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 6. 오전 10:46:44
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 6.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyBalckMbrDetailResDto
 * 2. 파일명	: LoyBalckMbrDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
public class LoyBalckMbrDetailResDto extends StatusResDto{
	private String rid;
	private String mbrRid;
	@Decrypted(masked = "none")
	private String custNm;
	private String contents;
	private String statCd;
	private String blackMstRid;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getBlackMstRid() {
		return blackMstRid;
	}
	public void setBlackMstRid(String blackMstRid) {
		this.blackMstRid = blackMstRid;
	}
	
	
}
