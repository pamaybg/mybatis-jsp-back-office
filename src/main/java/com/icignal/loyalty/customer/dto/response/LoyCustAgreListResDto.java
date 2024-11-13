/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustAgreListResDto.java
 * 2. Package	: com.icignal.loyalty.custopmer.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 4. 29. 오전 9:38:53
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 29.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyCustAgreListResDto
 * 2. 파일명	: LoyCustAgreListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 4. 29.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
/*
 * 1. 클래스명	: LoyCustAgreListResDto
 * 2. 파일명	: LoyCustAgreListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.custopmer.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 4. 29.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@CommCode
public class LoyCustAgreListResDto extends GridPagingItemResDto{
	private String rid;
	private String createDate;
	private String agreTypeCd;
	@MarkName(groupCode="LOY_CUST_AGRE_TYPE_CD", codeField="agreTypeCd")
	private String agreTypeCdNm;
	private String agreYn;
	private String regDate;
	private String termsTypeCd;
	@MarkName(groupCode="LOY_CUST_AGRE_TYPE_CD", codeField="termsTypeCd")
	private String termsTypeCdNm;
	@MarkName(groupCode="LOY_CUST_AGRE_TYPE_CD", codeField="termsTypeSubCd")
	private String termsTypeSubCdNm;
	private String termsTypeSubCd;
	private String ver;
	private String custRid;
	private String termRid;
	private String termVerRid;

	
	public String getTermVerRid() {
		return termVerRid;
	}
	public void setTermVerRid(String termVerRid) {
		this.termVerRid = termVerRid;
	}
	public String getTermRid() {
		return termRid;
	}
	public void setTermRid(String termRid) {
		this.termRid = termRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAgreTypeCd() {
		return agreTypeCd;
	}
	public void setAgreTypeCd(String agreTypeCd) {
		this.agreTypeCd = agreTypeCd;
	}
	public String getAgreTypeCdNm() {
		return agreTypeCdNm;
	}
	public void setAgreTypeCdNm(String agreTypeCdNm) {
		this.agreTypeCdNm = agreTypeCdNm;
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
	public String getTermsTypeCd() {
		return termsTypeCd;
	}
	public void setTermsTypeCd(String termsTypeCd) {
		this.termsTypeCd = termsTypeCd;
	}
	public String getTermsTypeSubCd() {
		return termsTypeSubCd;
	}
	public void setTermsTypeSubCd(String termsTypeSubCd) {
		this.termsTypeSubCd = termsTypeSubCd;
	}
	public String getTermsTypeCdNm() {
		return termsTypeCdNm;
	}
	public void setTermsTypeCdNm(String termsTypeCdNm) {
		this.termsTypeCdNm = termsTypeCdNm;
	}
	public String getTermsTypeSubCdNm() {
		return termsTypeSubCdNm;
	}
	public void setTermsTypeSubCdNm(String termsTypeSubCdNm) {
		this.termsTypeSubCdNm = termsTypeSubCdNm;
	}
	public String getVer() {
		return ver;
	}
	public void setVer(String ver) {
		this.ver = ver;
	}
	public String getCustRid() {
		return custRid;
	}
	public void setCustRid(String custRid) {
		this.custRid = custRid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	
}
