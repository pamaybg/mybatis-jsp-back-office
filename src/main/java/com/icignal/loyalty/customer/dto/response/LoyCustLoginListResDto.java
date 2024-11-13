/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustLoginListResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 4. 28. 오후 5:47:21
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 28.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyCustLoginListResDto
 * 2. 파일명	: LoyCustLoginListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 4. 28.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyCustLoginListResDto extends GridPagingItemResDto {
	private String rid;
	private String custNo;
	
	private String webUseCd;
	@MarkName(groupCode="LOY_WEB_USE_CD", codeField="webUseCd")
	private String webUseCdNm;
	
	private String webInputCd;
	@MarkName(groupCode="LOY_INPUT_CD", codeField="webInputCd")
	private String webInputCdNm;
	
	private String createDate;

	private String regDate;
	
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getWebUseCd() {
		return webUseCd;
	}
	public void setWebUseCd(String webUseCd) {
		this.webUseCd = webUseCd;
	}
	public String getWebUseCdNm() {
		return webUseCdNm;
	}
	public void setWebUseCdNm(String webUseCdNm) {
		this.webUseCdNm = webUseCdNm;
	}
	public String getWebInputCd() {
		return webInputCd;
	}
	public void setWebInputCd(String webInputCd) {
		this.webInputCd = webInputCd;
	}
	public String getWebInputCdNm() {
		return webInputCdNm;
	}
	public void setWebInputCdNm(String webInputCdNm) {
		this.webInputCdNm = webInputCdNm;
	}

	
}
