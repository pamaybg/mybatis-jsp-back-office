/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlSettleResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 25. 오후 1:57:43
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 25.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import java.sql.Date;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChnlSettleResDto
 * 2. 파일명	: LoyChnlSettleResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyChnlSettleResDto extends StatusResDto{
	private String rid;
	private String pgmChnlRid;
	private String settleTypeCd;
	@MarkName(groupCode="LOY_SETTLE_TYPE_CD",codeField="settleTypeCd")
	private String settleTypeCdNm;
	private String hqRate;
	private String chnlRate;
	private Date settleStartDate;
	private String pgmRid;
	private String pgmNo;
	private String pgmNm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmChnlRid() {
		return pgmChnlRid;
	}
	public void setPgmChnlRid(String pgmChnlRid) {
		this.pgmChnlRid = pgmChnlRid;
	}
	public String getSettleTypeCd() {
		return settleTypeCd;
	}
	public void setSettleTypeCd(String settleTypeCd) {
		this.settleTypeCd = settleTypeCd;
	}
	public String getHqRate() {
		return hqRate;
	}
	public void setHqRate(String hqRate) {
		this.hqRate = hqRate;
	}
	public String getChnlRate() {
		return chnlRate;
	}
	public void setChnlRate(String chnlRate) {
		this.chnlRate = chnlRate;
	}
	public Date getSettleStartDate() {
		return settleStartDate;
	}
	public void setSettleStartDate(Date settleStartDate) {
		this.settleStartDate = settleStartDate;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	
	
}
