/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyEventProdEnrtyExcelResDto.java
 * 2. Package	: com.icignal.loyalty.event.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 9. 2. 오후 2:53:40
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 9. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyEventProdEnrtyExcelResDto
 * 2. 파일명	: LoyEventProdEnrtyExcelResDto.java
 * 3. 패키지명	: com.icignal.loyalty.event.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 9. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
@CommCode
public class LoyEventProdEnrtyExcelResDto extends GridPagingItemResDto{
	private String rid;
	private String mbrNo;
	@Decrypted(masked="none")
	private String custNm;
	private String mbrStatus;
	private String bnfYn;
	private String bnfTypeCd;
	private String bnfDt;
	private String createDate;
	private String createBy;
	private String webId;
	@Decrypted(masked="none")
	private String hhpNo;
	private String ridMbr;
	private String uploadPath;
	private String bnfTypeDtl;
	@Decrypted(masked="none")
	private String unMaskCustNm;
	@Decrypted(masked="none")
	private String unMaskHhp;
	private String sbscTypeCd;
	@MarkName(groupCode = "LOY_SBSC_TYPE_CD", codeField = "sbscTypeCd")
	private String sbscTypeCdNm;
	private String age;
	
	
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSbscTypeCd() {
		return sbscTypeCd;
	}
	public void setSbscTypeCd(String sbscTypeCd) {
		this.sbscTypeCd = sbscTypeCd;
	}
	public String getSbscTypeCdNm() {
		return sbscTypeCdNm;
	}
	public void setSbscTypeCdNm(String sbscTypeCdNm) {
		this.sbscTypeCdNm = sbscTypeCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMbrStatus() {
		return mbrStatus;
	}
	public void setMbrStatus(String mbrStatus) {
		this.mbrStatus = mbrStatus;
	}
	public String getBnfYn() {
		return bnfYn;
	}
	public void setBnfYn(String bnfYn) {
		this.bnfYn = bnfYn;
	}
	public String getBnfTypeCd() {
		return bnfTypeCd;
	}
	public void setBnfTypeCd(String bnfTypeCd) {
		this.bnfTypeCd = bnfTypeCd;
	}
	public String getBnfDt() {
		return bnfDt;
	}
	public void setBnfDt(String bnfDt) {
		this.bnfDt = bnfDt;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public String getBnfTypeDtl() {
		return bnfTypeDtl;
	}
	public void setBnfTypeDtl(String bnfTypeDtl) {
		this.bnfTypeDtl = bnfTypeDtl;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	
	
}
