/*
 * Copyright 2016-2021 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: selectRecommReportExcelList.java
 * 2. Package	: com.icignal.kepler.report.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2021. 7. 5. 오후 3:11:39
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021. 7. 5.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: selectRecommReportExcelList
 * 2. 파일명	: selectRecommReportExcelList.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2021. 7. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
public class selectRecommReportExcelList extends GridPagingItemResDto{
	// 멤버필드
		private String ranking; 		// 순위(등수)
		
		@Decrypted(masked = "none")
		private String recommenderNm;

		private String mbrNo;    
		private String custNo;    
		private String ridMbr;    
		private String mbrTypeCd;        
		private String mbrTypeCdNm;
		private String custTypeCd; 	 
		private String custTypeCdNm;  
		private String attrSubCd;        
		private String attrSubCdNm;      
		private String tierNm;           
		private String genCd;
		private String genCdNm;

		private String custStatCd;
		private String custStatCdNm;
		
		@Decrypted(masked = "none")
		private String webId;   
		
		@Decrypted(masked = "none")
		private String hhp;
		
		@Decrypted(masked = "none")
		private String email;            
		
		private String recommCount;      
		private String accumulPointAmt;
		
		private String recommendedPersonRid; // 피추천인(추천자로부터 추천받아 가입한 신규가입자) rid
		
		@Decrypted(masked = "none")
		private String custNm;

		private String regDate;	// 가입일
		private String agreYn;
		public String getRanking() {
			return ranking;
		}
		public void setRanking(String ranking) {
			this.ranking = ranking;
		}
		public String getRecommenderNm() {
			return recommenderNm;
		}
		public void setRecommenderNm(String recommenderNm) {
			this.recommenderNm = recommenderNm;
		}
		public String getMbrNo() {
			return mbrNo;
		}
		public void setMbrNo(String mbrNo) {
			this.mbrNo = mbrNo;
		}
		public String getCustNo() {
			return custNo;
		}
		public void setCustNo(String custNo) {
			this.custNo = custNo;
		}
		public String getRidMbr() {
			return ridMbr;
		}
		public void setRidMbr(String ridMbr) {
			this.ridMbr = ridMbr;
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
		public String getAttrSubCd() {
			return attrSubCd;
		}
		public void setAttrSubCd(String attrSubCd) {
			this.attrSubCd = attrSubCd;
		}
		public String getAttrSubCdNm() {
			return attrSubCdNm;
		}
		public void setAttrSubCdNm(String attrSubCdNm) {
			this.attrSubCdNm = attrSubCdNm;
		}
		public String getTierNm() {
			return tierNm;
		}
		public void setTierNm(String tierNm) {
			this.tierNm = tierNm;
		}
		public String getGenCd() {
			return genCd;
		}
		public void setGenCd(String genCd) {
			this.genCd = genCd;
		}
		public String getGenCdNm() {
			return genCdNm;
		}
		public void setGenCdNm(String genCdNm) {
			this.genCdNm = genCdNm;
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
		public String getWebId() {
			return webId;
		}
		public void setWebId(String webId) {
			this.webId = webId;
		}
		public String getHhp() {
			return hhp;
		}
		public void setHhp(String hhp) {
			this.hhp = hhp;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getRecommCount() {
			return recommCount;
		}
		public void setRecommCount(String recommCount) {
			this.recommCount = recommCount;
		}
		public String getAccumulPointAmt() {
			return accumulPointAmt;
		}
		public void setAccumulPointAmt(String accumulPointAmt) {
			this.accumulPointAmt = accumulPointAmt;
		}
		public String getRecommendedPersonRid() {
			return recommendedPersonRid;
		}
		public void setRecommendedPersonRid(String recommendedPersonRid) {
			this.recommendedPersonRid = recommendedPersonRid;
		}
		public String getCustNm() {
			return custNm;
		}
		public void setCustNm(String custNm) {
			this.custNm = custNm;
		}
		public String getRegDate() {
			return regDate;
		}
		public void setRegDate(String regDate) {
			this.regDate = regDate;
		}
		public String getAgreYn() {
			return agreYn;
		}
		public void setAgreYn(String agreYn) {
			this.agreYn = agreYn;
		}
		
		
}
