/*
 * Copyright 2016-2021 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrDorHistResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2021. 5. 17. 오전 11:35:58
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021. 5. 17.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrDorHistResDto
 * 2. 파일명	: LoyMbrDorHistResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2021. 5. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrDorHistResDto extends GridPagingItemResDto{

	private String dorHistTypeCd;
    @MarkName(groupCode="LOY_DOR_HIST_TYPE_CD", codeField="dorHistTypeCd")
	private String dorHistTypeCdNm;
	private String dorProcTypeCd;	
    @MarkName(groupCode="LOY_DOR_PROC_TYPE_CD", codeField="dorProcTypeCd")
	private String dorProcTypeCdNm;
	private String rid;
	private String regDate;
	
	
	public String getDorHistTypeCdNm() {
		return dorHistTypeCdNm;
	}
	public void setDorHistTypeCdNm(String dorHistTypeCdNm) {
		this.dorHistTypeCdNm = dorHistTypeCdNm;
	}
	public String getDorProcTypeCdNm() {
		return dorProcTypeCdNm;
	}
	public void setDorProcTypeCdNm(String dorProcTypeCdNm) {
		this.dorProcTypeCdNm = dorProcTypeCdNm;
	}
	public String getDorHistTypeCd() {
		return dorHistTypeCd;
	}
	public void setDorHistTypeCd(String dorHistTypeCd) {
		this.dorHistTypeCd = dorHistTypeCd;
	}
	public String getDorProcTypeCd() {
		return dorProcTypeCd;
	}
	public void setDorProcTypeCd(String dorProcTypeCd) {
		this.dorProcTypeCd = dorProcTypeCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
}
