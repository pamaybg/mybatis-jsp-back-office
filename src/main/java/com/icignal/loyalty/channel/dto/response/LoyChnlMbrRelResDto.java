/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlMbrRelResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 21. 오후 1:13:50
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 21.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyChnlMbrRelResDto
 * 2. 파일명	: LoyChnlMbrRelResDto.java
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
@PersonalData
@CommCode
public class LoyChnlMbrRelResDto extends GridPagingItemResDto{
	private String rid;
	private String pgmNm;
	private String chnlRelTypeCd;
	@MarkName(groupCode="LOY_CHNL_REL_TYPE_CD", codeField="chnlRelTypeCd")
	private String chnlRelTypeCdNm;
	private String seqNo;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	private String mbrStatCd;
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatCd")
	private String mbrStatCdNm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getChnlRelTypeCd() {
		return chnlRelTypeCd;
	}
	public void setChnlRelTypeCd(String chnlRelTypeCd) {
		this.chnlRelTypeCd = chnlRelTypeCd;
	}
	public String getChnlRelTypeCdNm() {
		return chnlRelTypeCdNm;
	}
	public void setChnlRelTypeCdNm(String chnlRelTypeCdNm) {
		this.chnlRelTypeCdNm = chnlRelTypeCdNm;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
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
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	
	
}
