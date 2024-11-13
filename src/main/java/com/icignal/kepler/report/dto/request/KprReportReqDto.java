package com.icignal.kepler.report.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/*
 * 1. 클래스명	: KPRReportRequestDTO
 * 2. 파일명	: KPRReportRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.request
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportReqDto extends CommonDataAuthReqDto {
	private String storeCd;
	private String ageCd;
	private String yyyymm;
	private String genCd;
	private String qryType;
	private String endyyyymm;
	private String toMonth;
	private String agoMonth;
	private String typeCd;
	private String baseYm;
	private String segMstId;
	
//	public KPRReportRequestDTO() {
//		 try {
//	            this.setCipherKey(CryptoManager.getCipherKey());
//	        }
//	        catch ( Exception e ) {
//	            LogUtil.error(e);
//	        }
//	}
	
	public String getTypeCd() {
		return typeCd;
	}
	public void setTypeCd(String typeCd) {
		this.typeCd = typeCd;
	}
	public String getToMonth() {
		return toMonth;
	}
	public void setToMonth(String toMonth) {
		this.toMonth = toMonth;
	}
	public String getAgoMonth() {
		return agoMonth;
	}
	public void setAgoMonth(String agoMonth) {
		this.agoMonth = agoMonth;
	}
	public String getEndyyyymm() {
		return endyyyymm;
	}
	public void setEndyyyymm(String endyyyymm) {
		this.endyyyymm = endyyyymm;
	}
	public String getQryType() {
		return qryType;
	}
	public void setQryType(String qryType) {
		this.qryType = qryType;
	}
	public String getStoreCd() {
		return storeCd;
	}
	public void setStoreCd(String storeCd) {
		this.storeCd = storeCd;
	}
	public String getAgeCd() {
		return ageCd;
	}
	public void setAgeCd(String ageCd) {
		this.ageCd = ageCd;
	}

	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getGenCd() {
		return genCd;
	}
	public void setGenCd(String genCd) {
		this.genCd = genCd;
	}
	public String getBaseYm() {
		return baseYm;
	}
	public void setBaseYm(String baseYm) {
		this.baseYm = baseYm;
	}
	public String getSegMstId() {
		return segMstId;
	}
	public void setSegMstId(String segMstId) {
		this.segMstId = segMstId;
	}

//	public String getCipherKey() {
//		return cipherKey;
//	}
//
//	public void setCipherKey(String cipherKey) {
//		this.cipherKey = cipherKey;
//	}

}
