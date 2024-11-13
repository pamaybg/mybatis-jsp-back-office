/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustAgreHistListResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 6. 오전 9:55:45
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 6.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyCustAgreHistListResDto
 * 2. 파일명	: LoyCustAgreHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyCustAgreHistListResDto extends GridPagingItemResDto {
	private String rid;
	private String createDate;
	private String agreTypeCd;
	@MarkName(groupCode="LOY_CUST_AGRE_TYPE_CD", codeField="agreTypeCd")
	private String agreTypeCdNm;
	private String agreYn;
	private String regDate;
	private String termRid;
	private String ver;
	private String termVerRid;
	private String custRid;
	
	
	public String getCustRid() {
		return custRid;
	}
	public void setCustRid(String custRid) {
		this.custRid = custRid;
	}
	public String getTermVerRid() {
		return termVerRid;
	}
	public void setTermVerRid(String termVerRid) {
		this.termVerRid = termVerRid;
	}
	public String getAgreTypeCdNm() {
		return agreTypeCdNm;
	}
	public void setAgreTypeCdNm(String agreTypeCdNm) {
		this.agreTypeCdNm = agreTypeCdNm;
	}
	public String getTermRid() {
		return termRid;
	}
	public void setTermRid(String termRid) {
		this.termRid = termRid;
	}
	public String getVer() {
		return ver;
	}
	public void setVer(String ver) {
		this.ver = ver;
	}
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
	public String getAgreTypeCd() {
		return agreTypeCd;
	}
	public void setAgreTypeCd(String agreTypeCd) {
		this.agreTypeCd = agreTypeCd;
	}
	public String getAgreYn() {
		return agreYn;
	}
	public void setAgreYn(String agreYn) {
		this.agreYn = agreYn;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
}
