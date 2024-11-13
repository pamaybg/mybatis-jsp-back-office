/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlNewDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 18. 오전 10:28:36
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 18.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlNewDetailReqDto
 * 2. 파일명	: LoyChnlNewDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChnlNewDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String chnlRealNm;
	private String chnlTypeCd;
	private String parChnlTypeCd;
	private String parChnlRid;
	private String statCd;
	private String lvlCd;
	private String chnlSubTypeCd;
	private String brdNm;
	private String brdRid;
	private String empNo;
	private String empNm;
	private String empRid;

	
	public String getChnlSubTypeCd() {
		return chnlSubTypeCd;
	}
	public void setChnlSubTypeCd(String chnlSubTypeCd) {
		this.chnlSubTypeCd = chnlSubTypeCd;
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
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getParChnlTypeCd() {
		return parChnlTypeCd;
	}
	public void setParChnlTypeCd(String parChnlTypeCd) {
		this.parChnlTypeCd = parChnlTypeCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getParChnlRid() {
		return parChnlRid;
	}
	public void setParChnlRid(String parChnlRid) {
		this.parChnlRid = parChnlRid;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getChnlRealNm() {
		return chnlRealNm;
	}
	public void setChnlRealNm(String chnlRealNm) {
		this.chnlRealNm = chnlRealNm;
	}
	public String getLvlCd() {
		return lvlCd;
	}
	public void setLvlCd(String lvlCd) {
		this.lvlCd = lvlCd;
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

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getEmpRid() {
		return empRid;
	}

	public void setEmpRid(String empRid) {
		this.empRid = empRid;
	}
}
