/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlSettleReqDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 25. 오후 1:27:18
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 25.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.request;

import java.sql.Date;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlSettleReqDto
 * 2. 파일명	: LoyChnlSettleReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChnlSettleReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String pgmChnlRid;
	private String settleTypeCd;
	private String hqRate;
	private String chnlRate;
	private Date settleStartDate;
	private String pgmRid;
	private String chnlRid;
	private String descChnlImg;
	private String imgPathId;
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
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	public Date getSettleStartDate() {
		return settleStartDate;
	}
	public void setSettleStartDate(Date settleStartDate) {
		this.settleStartDate = settleStartDate;
	}
	public String getDescChnlImg() {
		return descChnlImg;
	}
	public void setDescChnlImg(String descChnlImg) {
		this.descChnlImg = descChnlImg;
	}
	public String getImgPathId() {
		return imgPathId;
	}
	public void setImgPathId(String imgPathId) {
		this.imgPathId = imgPathId;
	}

	
}
