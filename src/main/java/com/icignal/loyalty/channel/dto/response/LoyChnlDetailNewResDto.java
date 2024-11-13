/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlDetailNewResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 18. 오후 1:51:08
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 18.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChnlDetailNewResDto
 * 2. 파일명	: LoyChnlDetailNewResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyChnlDetailNewResDto extends StatusResDto{
	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String chnlRealNm;
	private String chnlTypeCd;
	@MarkName(groupCode="LOY_CHNL_TYPE_CD",codeField="chnlTypeCd")
	private String chnlTypeCdNm;
	private String parChnlRid;
	private String parChnlNm;
	@MarkName(groupCode="COM_STAT_TYPE_1_CD",codeField="statCd")
	private String statCdNm;
	private String statCd;
	private String acrlPointYn;
	private String usePointYn;
	private String eventYn;
	private String lvlCd;
	
	private String chnlSubTypeCd;
	@MarkName(groupCode="LOY_CHNL_SUB_TYPE_CD",codeField="chnlSubTypeCd")
	private String chnlSubTypeCdNm;

	private String brdNm;
	private String brdRid;

	private String empRid;
	private String empNm;
	private String empNo;

	
	
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
	public String getChnlTypeCdNm() {
		return chnlTypeCdNm;
	}
	public void setChnlTypeCdNm(String chnlTypeCdNm) {
		this.chnlTypeCdNm = chnlTypeCdNm;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getLvlCd() {
		return lvlCd;
	}
	public void setLvlCd(String lvlCd) {
		this.lvlCd = lvlCd;
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
	public String getChnlRealNm() {
		return chnlRealNm;
	}
	public void setChnlRealNm(String chnlRealNm) {
		this.chnlRealNm = chnlRealNm;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getParChnlRid() {
		return parChnlRid;
	}
	public void setParChnlRid(String parChnlRid) {
		this.parChnlRid = parChnlRid;
	}
	public String getParChnlNm() {
		return parChnlNm;
	}
	public void setParChnlNm(String parChnlNm) {
		this.parChnlNm = parChnlNm;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getAcrlPointYn() {
		return acrlPointYn;
	}
	public void setAcrlPointYn(String acrlPointYn) {
		this.acrlPointYn = acrlPointYn;
	}
	public String getUsePointYn() {
		return usePointYn;
	}
	public void setUsePointYn(String usePointYn) {
		this.usePointYn = usePointYn;
	}
	public String getEventYn() {
		return eventYn;
	}
	public void setEventYn(String eventYn) {
		this.eventYn = eventYn;
	}

	public String getBrdNm() {
		return brdNm;
	}

	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}

	public String getBrdRid() {
		return brdRid;
	}

	public void setBrdRid(String brdRid) {
		this.brdRid = brdRid;
	}

	public String getEmpRid() {
		return empRid;
	}

	public void setEmpRid(String empRid) {
		this.empRid = empRid;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
}
