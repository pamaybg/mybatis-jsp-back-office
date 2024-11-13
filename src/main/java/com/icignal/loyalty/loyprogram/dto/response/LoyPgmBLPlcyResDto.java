package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyPgmBLPlcyResDto extends GridPagingItemResDto {

	// 기본 필드
	private String fraudNo;
	private String fraudNm;
	private String statCd;   
	@MarkName(groupCode = "LOY_ACTIVE_CD", codeField = "statCd")
	private String statCdNm; 				/* 상태명 */
	private String fraudTypeCd;
	@MarkName(groupCode="LOY_FRAUD_TYPE_CD",codeField="fraudTypeCd")
	private String fraudTypeCdNm;
	private String fraudSubTypeCd;
	@MarkName(groupCode="LOY_FRAUD_SUB_TYPE_CD",codeField="fraudSubTypeCd")
	private String fraudSubTypeCdNm;

	// 시스템
	private String rid;             	 	/* RID */
	private String modifyDate;             	/* 수정일시 */
	private String modifyBy;             	/* 수정자 */
	
	
	public String getFraudNo() {
		return fraudNo;
	}
	public void setFraudNo(String fraudNo) {
		this.fraudNo = fraudNo;
	}
	public String getFraudNm() {
		return fraudNm;
	}
	public void setFraudNm(String fraudNm) {
		this.fraudNm = fraudNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
	public String getFraudTypeCd() {
		return fraudTypeCd;
	}
	public void setFraudTypeCd(String fraudTypeCd) {
		this.fraudTypeCd = fraudTypeCd;
	}
	public String getFraudTypeCdNm() {
		return fraudTypeCdNm;
	}
	public void setFraudTypeCdNm(String fraudTypeCdNm) {
		this.fraudTypeCdNm = fraudTypeCdNm;
	}
	public String getFraudSubTypeCd() {
		return fraudSubTypeCd;
	}
	public void setFraudSubTypeCd(String fraudSubTypeCd) {
		this.fraudSubTypeCd = fraudSubTypeCd;
	}
	public String getFraudSubTypeCdNm() {
		return fraudSubTypeCdNm;
	}
	public void setFraudSubTypeCdNm(String fraudSubTypeCdNm) {
		this.fraudSubTypeCdNm = fraudSubTypeCdNm;
	}
}
