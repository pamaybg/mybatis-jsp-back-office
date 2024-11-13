package com.icignal.loyalty.club.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyClubOfferListResDto
 * 2. 파일명	: LoyClubOfferListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.club.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *		클럽 혜택 Response DTO
 * </PRE>
 */ 
@CommCode
public class LoyClubOfferListResDto extends GridPagingItemResDto{
	
	private String rid;
	private String ofrNo;
	private String ofrNm;
	@MarkName(groupCode = "LOY_OFR_TYPE", codeField = "ofrTypeCd")
	private String ofrTypeCdNm;
	private String ofrSubTypeCd;
	@MarkName(groupCode = "LOY_OFR_SUB_TYPE", codeField = "ofrSubTypeCd")
	private String ofrSubTypeCdNm;
	private String ofrTypeCd;
	private String statCd;
	@MarkName(groupCode = "LOY_OFR_STAT_TYPE", codeField = "statCd")
	private String statCdNm;
	
	private String issType;
	@MarkName(groupCode = "LOY_CPN_ISS_TYPE", codeField = "issType")
	private String issTypeNm;
	
	private String modifyBy;
	private String modifyDate;
	private String cpnYn;
	private String ofrValType;

	
	@MarkName(groupCode = "LOY_OFR_VAL_TYPE", codeField = "ofrValType")
	private String ofrValTypeNm;
	
	private String ofrValAmt;
	private String useDupYn;
	private String useChnlLimitYn;
	private String useProdLimitYn;
	//오퍼 조회
	//@MarkName(groupCode = "LOY_OFR_SUB_TYPE", codeField = "ofrSubTypeCd")
//	private String ofrSubTypeCdNm;
//	private String ofrSubTypeCd;
	
	@MarkName(groupCode = "LOY_CLUB_BNFT_TYPE_CD", codeField = "bnftTypeCd")
	private String bnftTypeCdNm;
	private String bnftTypeCd;
	private int ofrAmt;
	@MarkName(groupCode = "LOY_CLUB_ACRL_CYCLE_TYPE", codeField = "acrlCycleTypeCd")
	private String acrlCycleTypeCdNm;
	private String acrlCycleTypeCd;
	private String useMinPurAmt; 	// 구매 최소 금액
	private String useMaxDcAmt;  // 최대 할인 금액
	private String offYn;  				// 오프라인 매장 전용
	private String usableMaxCnt;   // 사용 가능 횟수
	private String expireEndDt;
	private String vocYn; // 대응 지급 가능 여부  
	private String empYn; // 임직원 지급 가능여부  
	
	private String acrlDate;
	private String validStartDt;
	private String validEndDt;
	private String acrlAmt;
	private String blanc;
	private String acrlDesc;
	
	
	public String getAcrlDesc() {
		return acrlDesc;
	}
	public void setAcrlDesc(String acrlDesc) {
		this.acrlDesc = acrlDesc;
	}
	public String getAcrlDate() {
		return acrlDate;
	}
	public void setAcrlDate(String acrlDate) {
		this.acrlDate = acrlDate;
	}
	public String getValidStartDt() {
		return validStartDt;
	}
	public void setValidStartDt(String validStartDt) {
		this.validStartDt = validStartDt;
	}
	public String getValidEndDt() {
		return validEndDt;
	}
	public void setValidEndDt(String validEndDt) {
		this.validEndDt = validEndDt;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getBlanc() {
		return blanc;
	}
	public void setBlanc(String blanc) {
		this.blanc = blanc;
	}


	public String getIssType() {
		return issType;
	}
	public void setIssType(String issType) {
		this.issType = issType;
	}
	public String getIssTypeNm() {
		return issTypeNm;
	}
	public void setIssTypeNm(String issTypeNm) {
		this.issTypeNm = issTypeNm;
	}
	public String getOfrValType() {
		return ofrValType;
	}
	public void setOfrValType(String ofrValType) {
		this.ofrValType = ofrValType;
	}
	public String getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(String ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
	}
	public String getOfrSubTypeCd() {
		return ofrSubTypeCd;
	}
	public void setOfrSubTypeCd(String ofrSubTypeCd) {
		this.ofrSubTypeCd = ofrSubTypeCd;
	}
	public String getOfrSubTypeCdNm() {
		return ofrSubTypeCdNm;
	}
	public void setOfrSubTypeCdNm(String ofrSubTypeCdNm) {
		this.ofrSubTypeCdNm = ofrSubTypeCdNm;
	}
	public String getCpnYn() {
		return cpnYn;
	}
	public void setCpnYn(String cpnYn) {
		this.cpnYn = cpnYn;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getOfrTypeCdNm() {
		return ofrTypeCdNm;
	}
	public void setOfrTypeCdNm(String ofrTypeCdNm) {
		this.ofrTypeCdNm = ofrTypeCdNm;
	}
	public String getOfrTypeCd() {
		return ofrTypeCd;
	}
	public void setOfrTypeCd(String ofrTypeCd) {
		this.ofrTypeCd = ofrTypeCd;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
//	public String getOfrSubTypeCdNm() {
//		return ofrSubTypeCdNm;
//	}
//	public void setOfrSubTypeCdNm(String ofrSubTypeCdNm) {
//		this.ofrSubTypeCdNm = ofrSubTypeCdNm;
//	}
//	public String getOfrSubTypeCd() {
//		return ofrSubTypeCd;
//	}
//	public void setOfrSubTypeCd(String ofrSubTypeCd) {
//		this.ofrSubTypeCd = ofrSubTypeCd;
//	}
	public String getBnftTypeCdNm() {
		return bnftTypeCdNm;
	}
	public void setBnftTypeCdNm(String bnftTypeCdNm) {
		this.bnftTypeCdNm = bnftTypeCdNm;
	}
	public String getBnftTypeCd() {
		return bnftTypeCd;
	}
	public void setBnftTypeCd(String bnftTypeCd) {
		this.bnftTypeCd = bnftTypeCd;
	}
	public int getOfrAmt() {
		return ofrAmt;
	}
	public void setOfrAmt(int ofrAmt) {
		this.ofrAmt = ofrAmt;
	}
	public String getAcrlCycleTypeCdNm() {
		return acrlCycleTypeCdNm;
	}
	public void setAcrlCycleTypeCdNm(String acrlCycleTypeCdNm) {
		this.acrlCycleTypeCdNm = acrlCycleTypeCdNm;
	}
	public String getAcrlCycleTypeCd() {
		return acrlCycleTypeCd;
	}
	public void setAcrlCycleTypeCd(String acrlCycleTypeCd) {
		this.acrlCycleTypeCd = acrlCycleTypeCd;
	}
	public String getUseMinPurAmt() {
		return useMinPurAmt;
	}
	public void setUseMinPurAmt(String useMinPurAmt) {
		this.useMinPurAmt = useMinPurAmt;
	}
	public String getUseMaxDcAmt() {
		return useMaxDcAmt;
	}
	public void setUseMaxDcAmt(String useMaxDcAmt) {
		this.useMaxDcAmt = useMaxDcAmt;
	}
	public String getOffYn() {
		return offYn;
	}
	public void setOffYn(String offYn) {
		this.offYn = offYn;
	}
	public String getUsableMaxCnt() {
		return usableMaxCnt;
	}
	public void setUsableMaxCnt(String usableMaxCnt) {
		this.usableMaxCnt = usableMaxCnt;
	}
	public String getUseDupYn() {
		return useDupYn;
	}
	public void setUseDupYn(String useDupYn) {
		this.useDupYn = useDupYn;
	}
	public String getUseChnlLimitYn() {
		return useChnlLimitYn;
	}
	public void setUseChnlLimitYn(String useChnlLimitYn) {
		this.useChnlLimitYn = useChnlLimitYn;
	}
	public String getUseProdLimitYn() {
		return useProdLimitYn;
	}
	public void setUseProdLimitYn(String useProdLimitYn) {
		this.useProdLimitYn = useProdLimitYn;
	}
	public String getOfrValTypeNm() {
		return ofrValTypeNm;
	}
	public void setOfrValTypeNm(String ofrValTypeNm) {
		this.ofrValTypeNm = ofrValTypeNm;
	}
	public String getVocYn() {
		return vocYn;
	}
	public void setVocYn(String vocYn) {
		this.vocYn = vocYn;
	}
	public String getEmpYn() {
		return empYn;
	}
	public void setEmpYn(String empYn) {
		this.empYn = empYn;
	}
	public String getExpireEndDt() {
		return expireEndDt;
	}
	public void setExpireEndDt(String expireEndDt) {
		this.expireEndDt = expireEndDt;
	}
	

}
