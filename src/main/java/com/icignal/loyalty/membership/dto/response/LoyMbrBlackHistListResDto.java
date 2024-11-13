/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrBlackHistListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 15. 오전 11:22:54
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LoyMbrBlackHistListResDto
 * 2. 파일명	: LoyMbrBlackHistListResDto.java
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
public class LoyMbrBlackHistListResDto extends GridPagingItemResDto{
	private String rid;
	private String blNm;
	private String blackHistCnt;
	private String blackChnlNm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBlackHistCnt() {
		return blackHistCnt;
	}
	public void setBlackHistCnt(String blackHistCnt) {
		this.blackHistCnt = blackHistCnt;
	}
	public String getBlackChnlNm() {
		return blackChnlNm;
	}
	public void setBlackChnlNm(String blackChnlNm) {
		this.blackChnlNm = blackChnlNm;
	}
	public String getBlNm() {
		return blNm;
	}
	public void setBlNm(String blNm) {
		this.blNm = blNm;
	}
	

	
	
	
}
