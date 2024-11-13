/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCertCustResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 4. 28. 오후 3:46:28
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
 * 1. 클래스명	: LoyCertCustResDto
 * 2. 파일명	: LoyCertCustResDto.java
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
public class LoyCertCustResDto extends GridPagingItemResDto{
	private String rid;
	private String certTypeCd;
	@MarkName(groupCode="LOY_CUST_CERT_TYPE_CD",codeField="certTypeCd")
	private String certTypeCdNm;
	private String certVal;
	private String certDate;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCertTypeCd() {
		return certTypeCd;
	}
	public void setCertTypeCd(String certTypeCd) {
		this.certTypeCd = certTypeCd;
	}
	public String getCertTypeCdNm() {
		return certTypeCdNm;
	}
	public void setCertTypeCdNm(String certTypeCdNm) {
		this.certTypeCdNm = certTypeCdNm;
	}
	public String getCertVal() {
		return certVal;
	}
	public void setCertVal(String certVal) {
		this.certVal = certVal;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}
	
	
}
