/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: CommonSelectBoxListReqDto.java
 * 2. Package	: com.icignal.systemmanagement.commcode.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 22. 오전 10:09:21
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 22.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.commcode.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: CommonSelectBoxListReqDto
 * 2. 파일명	: CommonSelectBoxListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.commcode.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class CommonSelectBoxListReqDto extends CommonDataAuthReqDto{
	private String tableNm;
	private String ddlVwCnCol;
	private String ddlVwMnCol;
	private String tblSchma;
	public String getTableNm() {
		return tableNm;
	}
	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}
	public String getDdlVwCnCol() {
		return ddlVwCnCol;
	}
	public void setDdlVwCnCol(String ddlVwCnCol) {
		this.ddlVwCnCol = ddlVwCnCol;
	}
	public String getDdlVwMnCol() {
		return ddlVwMnCol;
	}
	public void setDdlVwMnCol(String ddlVwMnCol) {
		this.ddlVwMnCol = ddlVwMnCol;
	}
	public String getTblSchma() {
		return tblSchma;
	}
	public void setTblSchma(String tblSchma) {
		this.tblSchma = tblSchma;
	}
	
}
