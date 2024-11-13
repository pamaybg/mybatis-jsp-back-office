/*
 * Copyright 2016-2021 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdRevwHistListResDto.java
 * 2. Package	: com.icignal.loyalty.benefit.point.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2021. 7. 6. 오전 11:36:42
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021. 7. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyProdRevwHistListResDto
 * 2. 파일명	: LoyProdRevwHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2021. 7. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
@CommCode
public class LoyProdRevwHistListResDto extends GridPagingItemResDto{
	private String rDate;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "tel")
	private String hhp;
	private String mbrTypeCd;
    @MarkName(groupCode="LOY_MBR_TYPE_CD", codeField="mbrTypeCd")
	private String mbrTypeCdNm;
	private String sbscTypeCd;
    @MarkName(groupCode="LOY_SBSC_TYPE_CD", codeField="sbscTypeCd")
	private String sbscTypeCdNm;
	private String custTypeCd;
    @MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custTypeCd")
	private String custTypeCdNm;
	private String reviewTypeCd;
    @MarkName(groupCode="REVIEW_TYPE_CD", codeField="reviewTypeCd")
	private String reviewTypeCdNm;
    private String custStatCd;
    @MarkName(groupCode="LOY_CUST_STAT_CD", codeField="custStatCd")
    private String custStatCdNm;
	private String prodNo;
	private String goodsCode;
	private String prodNm;
	private String subject;
	private String score;
	private String uploadImgPath;
	private String uploadImgPathYn;
	private String ridMbr;
	private String ridCust;
	private String catNm;
	private String parCatNm;
	private String content;
	private String rid;
	private String mmGroup;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	public String getParCatNm() {
		return parCatNm;
	}
	public void setParCatNm(String parCatNm) {
		this.parCatNm = parCatNm;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getUploadImgPathYn() {
		return uploadImgPathYn;
	}
	public void setUploadImgPathYn(String uploadImgPathYn) {
		this.uploadImgPathYn = uploadImgPathYn;
	}
	public String getCustStatCd() {
		return custStatCd;
	}
	public void setCustStatCd(String custStatCd) {
		this.custStatCd = custStatCd;
	}
	public String getCustStatCdNm() {
		return custStatCdNm;
	}
	public void setCustStatCdNm(String custStatCdNm) {
		this.custStatCdNm = custStatCdNm;
	}
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
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
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrTypeCdNm() {
		return mbrTypeCdNm;
	}
	public void setMbrTypeCdNm(String mbrTypeCdNm) {
		this.mbrTypeCdNm = mbrTypeCdNm;
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
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getCustTypeCdNm() {
		return custTypeCdNm;
	}
	public void setCustTypeCdNm(String custTypeCdNm) {
		this.custTypeCdNm = custTypeCdNm;
	}
	public String getReviewTypeCd() {
		return reviewTypeCd;
	}
	public void setReviewTypeCd(String reviewTypeCd) {
		this.reviewTypeCd = reviewTypeCd;
	}
	public String getReviewTypeCdNm() {
		return reviewTypeCdNm;
	}
	public void setReviewTypeCdNm(String reviewTypeCdNm) {
		this.reviewTypeCdNm = reviewTypeCdNm;
	}
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getUploadImgPath() {
		return uploadImgPath;
	}
	public void setUploadImgPath(String uploadImgPath) {
		this.uploadImgPath = uploadImgPath;
	}
	public String getMmGroup() {
		return mmGroup;
	}
	public void setMmGroup(String mmGroup) {
		this.mmGroup = mmGroup;
	}

	
}
