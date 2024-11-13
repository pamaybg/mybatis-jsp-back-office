/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustChangeHistListResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 11. 오후 2:24:59
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 11.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyCustChangeHistListResDto
 * 2. 파일명	: LoyCustChangeHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyCustChangeHistListResDto extends GridPagingItemResDto {
	private String rid;
	private String createDate;
	private String chgCol;
	@MarkName(groupCode="HISTORY_MEMBER_COLUMN", codeField="chgCol")
	private String chgColNm;
	private String bchngData;
	private String achngData;
	private String employName;
	
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
	public String getChgCol() {
		return chgCol;
	}
	public void setChgCol(String chgCol) {
		this.chgCol = chgCol;
	}
	public String getBchngData() {
		return bchngData;
	}
	public void setBchngData(String bchngData) {
		this.bchngData = bchngData;
	}
	public String getAchngData() {
		return achngData;
	}
	public void setAchngData(String achngData) {
		this.achngData = achngData;
	}
	public String getChgColNm() {
		return chgColNm;
	}
	public void setChgColNm(String chgColNm) {
		this.chgColNm = chgColNm;
	}
	public String getEmployName() {
		return employName;
	}
	public void setEmployName(String employName) {
		this.employName = employName;
	}
	
	

}
