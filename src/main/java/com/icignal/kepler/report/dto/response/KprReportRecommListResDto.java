package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class KprReportRecommListResDto extends GridPagingItemResDto {
	// 멤버필드
	private String ranking; 		// 순위(등수)
	
	@Decrypted(masked = "custNm")
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
	
	@Decrypted(masked = "webId")
	private String webId;   
	
	@Decrypted(masked = "tel")
	private String hhp;
	
	@Decrypted(masked = "email")
	private String email;            
	
	private String recommCount;      
	private String accumulPointAmt;
	
	private String recommendedPersonRid; // 피추천인(추천자로부터 추천받아 가입한 신규가입자) rid
	
	@Decrypted(masked = "none")
	private String custNm;

	private String regDate;	// 가입일
	private String agreYn;
	
	
	public String getAgreYn() {
		return agreYn;
	}
	public void setAgreYn(String agreYn) {
		this.agreYn = agreYn;
	}
	// Getter Setter
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
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
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
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
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
	
}
