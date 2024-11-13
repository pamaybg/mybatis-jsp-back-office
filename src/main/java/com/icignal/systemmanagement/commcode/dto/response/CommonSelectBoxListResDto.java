/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: CommonSelectBoxListResDto.java
 * 2. Package	: com.icignal.systemmanagement.commcode.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 22. 오전 10:04:23
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 22.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.commcode.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: CommonSelectBoxListResDto
 * 2. 파일명	: CommonSelectBoxListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.commcode.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class CommonSelectBoxListResDto extends GridPagingItemResDto{
	private String codeName;
	private String markName;
	private String flag;
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}



	
}
