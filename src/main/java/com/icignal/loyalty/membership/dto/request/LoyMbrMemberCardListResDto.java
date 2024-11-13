/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrMemberCardListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 15. 오전 9:05:42
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrMemberCardListResDto
 * 2. 파일명	: LoyMbrMemberCardListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.request
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
public class LoyMbrMemberCardListResDto extends GridPagingItemResDto{
	private String rid;
	private String cardTypeCd;
	@MarkName(groupCode="LOY_CARD_TYPE",codeField="cardTypeCd")
	private String cardTypeCdNm;
	private String cardKindNm;
	private String cardNo;
	private String cardStatCd;
	@MarkName(groupCode="LOY_CARD_MBR_STAT_CD",codeField="cardStatCd")
	private String cardStatCdNm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCardTypeCd() {
		return cardTypeCd;
	}
	public void setCardTypeCd(String cardTypeCd) {
		this.cardTypeCd = cardTypeCd;
	}
	public String getCardTypeCdNm() {
		return cardTypeCdNm;
	}
	public void setCardTypeCdNm(String cardTypeCdNm) {
		this.cardTypeCdNm = cardTypeCdNm;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getCardStatCd() {
		return cardStatCd;
	}
	public void setCardStatCd(String cardStatCd) {
		this.cardStatCd = cardStatCd;
	}
	public String getCardStatCdNm() {
		return cardStatCdNm;
	}
	public void setCardStatCdNm(String cardStatCdNm) {
		this.cardStatCdNm = cardStatCdNm;
	}
	public String getCardKindNm() {
		return cardKindNm;
	}
	public void setCardKindNm(String cardKindNm) {
		this.cardKindNm = cardKindNm;
	}
	
	
	
	
}
