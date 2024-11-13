/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChannelListResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 15. 오후 5:17:00
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChannelListResDto
 * 2. 파일명	: LoyChannelListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
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
public class LoyChannelListPageResDto extends GridPagingItemResDto{
	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String statCd;
	@MarkName(groupCode="COM_STAT_TYPE_1_CD",codeField="statCd")
	private String statCdNm;
	private String chnlTypeCd;
	@MarkName(groupCode="LOY_CHNL_TYPE_CD",codeField="chnlTypeCd")
	private String chnlTypeCdNm;
	private String ridParChnl;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	private String chnlSubTypeCd;
	@MarkName(groupCode="LOY_CHNL_SUB_TYPE_CD",codeField="chnlSubTypeCd")
	private String chnlSubTypeCdNm;
	
	private String relTypeCd;
	private String prodUseType;
	private String prodRid;
	private String ridOfr;
	private String ridChnl;
	private String brdRid;
	private String brdNm;

	private String empNo;
	private String empRid;

	public String getChnlSubTypeCd() {
		return chnlSubTypeCd;
	}
	public void setChnlSubTypeCd(String chnlSubTypeCd) {
		this.chnlSubTypeCd = chnlSubTypeCd;
	}
	public String getChnlSubTypeCdNm() {
		return chnlSubTypeCdNm;
	}
	public void setChnlSubTypeCdNm(String chnlSubTypeCdNm) {
		this.chnlSubTypeCdNm = chnlSubTypeCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
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
	public String getRidParChnl() {
		return ridParChnl;
	}
	public void setRidParChnl(String ridParChnl) {
		this.ridParChnl = ridParChnl;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getRelTypeCd() {
		return relTypeCd;
	}
	public void setRelTypeCd(String relTypeCd) {
		this.relTypeCd = relTypeCd;
	}
	public String getProdUseType() {
		return prodUseType;
	}
	public void setProdUseType(String prodUseType) {
		this.prodUseType = prodUseType;
	}
	public String getProdRid() {
		return prodRid;
	}
	public void setProdRid(String prodRid) {
		this.prodRid = prodRid;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getBrdRid() {
		return brdRid;
	}

	public void setBrdRid(String brdRid) {
		this.brdRid = brdRid;
	}

	public String getBrdNm() {
		return brdNm;
	}

	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getEmpRid() {
		return empRid;
	}

	public void setEmpRid(String empRid) {
		this.empRid = empRid;
	}
}
