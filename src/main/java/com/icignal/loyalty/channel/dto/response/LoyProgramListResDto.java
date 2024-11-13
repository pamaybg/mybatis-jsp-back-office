/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProgramListResDto.java
 * 2. Package	: com.icignal.loyalty.channel.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 20. 오전 10:03:22
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 20.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyProgramListResDto
 * 2. 파일명	: LoyProgramListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyProgramListResDto extends GridPagingItemResDto{
	private String rid;
	private String pgmNo;
	private String pgmNm;
	private String pgmStat;
	@MarkName(groupCode="LOY_PGM_STAT_CD", codeField="pgmStat")
	private String pgmStatNm;
	
	
	public String getPgmStat() {
		return pgmStat;
	}
	public void setPgmStat(String pgmStat) {
		this.pgmStat = pgmStat;
	}
	public String getPgmStatNm() {
		return pgmStatNm;
	}
	public void setPgmStatNm(String pgmStatNm) {
		this.pgmStatNm = pgmStatNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
