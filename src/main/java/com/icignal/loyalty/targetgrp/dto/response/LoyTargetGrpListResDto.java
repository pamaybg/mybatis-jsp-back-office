/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTargetGrpListResDto.java
 * 2. Package	: com.icignal.loyalty.targetgrp.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 9. 오후 3:09:01
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 9.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.targetgrp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyTargetGrpListResDto
 * 2. 파일명	: LoyTargetGrpListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.targetgrp.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyTargetGrpListResDto extends GridPagingItemResDto{
	private String rid;
	private String tgtGrpNo;
	private String tgtGrpNm;
	private String tgtTypeCd;
	@MarkName(groupCode="PROM_TG_TYPE", codeField="tgtTypeCd")
	private String tgtTypeCdNm;
	@MarkName(groupCode="PROM_TG_SRC_TYPE", codeField="srcTypeCd")
	private String srcTypeCdNm;
	private String srcTypeCd;
	private String statCd;
	@MarkName(groupCode="COM_STAT_TYPE_2_CD", codeField="statCd")
	private String statCdNm;
	private String createDate;
	private String name;
	private String dsNm;
	
	

	public String getDsNm() {
		return dsNm;
	}
	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}
	public String getSrcTypeCdNm() {
		return srcTypeCdNm;
	}

	public void setSrcTypeCdNm(String srcTypeCdNm) {
		this.srcTypeCdNm = srcTypeCdNm;
	}

	public String getTgtGrpNo() {
		return tgtGrpNo;
	}

	public void setTgtGrpNo(String tgtGrpNo) {
		this.tgtGrpNo = tgtGrpNo;
	}

	public String getTgtGrpNm() {
		return tgtGrpNm;
	}

	public void setTgtGrpNm(String tgtGrpNm) {
		this.tgtGrpNm = tgtGrpNm;
	}

	public String getTgtTypeCd() {
		return tgtTypeCd;
	}

	public void setTgtTypeCd(String tgtTypeCd) {
		this.tgtTypeCd = tgtTypeCd;
	}

	public String getTgtTypeCdNm() {
		return tgtTypeCdNm;
	}

	public void setTgtTypeCdNm(String tgtTypeCdNm) {
		this.tgtTypeCdNm = tgtTypeCdNm;
	}

	public String getSrcTypeCd() {
		return srcTypeCd;
	}

	public void setSrcTypeCd(String srcTypeCd) {
		this.srcTypeCd = srcTypeCd;
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

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
