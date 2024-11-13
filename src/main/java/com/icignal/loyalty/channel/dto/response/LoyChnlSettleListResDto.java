/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlSettleListResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 21. 오후 3:25:30
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 21.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import java.sql.Date;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChnlSettleListResDto
 * 2. 파일명	: LoyChnlSettleListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyChnlSettleListResDto extends GridPagingItemResDto{
	private String rid;
	private String createDate;
	private String pgmNm;
	private String chnlSettleTypeCd;
	@MarkName(groupCode="LOY_SETTLE_TYPE_CD", codeField="chnlSettleTypeCd")
	private String chnlSettleTypeCdNm;
	private String hqRate;
	private String chnlRate;
	private String chnlPgmRid;
	private Date   settleStartDate;
	private String pgmRid;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getChnlSettleTypeCd() {
		return chnlSettleTypeCd;
	}
	public void setChnlSettleTypeCd(String chnlSettleTypeCd) {
		this.chnlSettleTypeCd = chnlSettleTypeCd;
	}
	public String getChnlSettleTypeCdNm() {
		return chnlSettleTypeCdNm;
	}
	public void setChnlSettleTypeCdNm(String chnlSettleTypeCdNm) {
		this.chnlSettleTypeCdNm = chnlSettleTypeCdNm;
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
	public String getChnlPgmRid() {
		return chnlPgmRid;
	}
	public void setChnlPgmRid(String chnlPgmRid) {
		this.chnlPgmRid = chnlPgmRid;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	
	
}
