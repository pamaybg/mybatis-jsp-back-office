package com.icignal.loyalty.channel.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChnlSubListResDto
 * 2. 파일명	: LoyChnlSubListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 10. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@CommCode
public class LoyChnlSubListResDto {
	
	private String rid;
	private String lowMbrbsCd;
	private String chnlNo;
	private String chnlNm;
	
	@MarkName(groupCode="POINT_CONTRACT" , codeField="point_cont_type")
	private String pointContType;
	
	@MarkName(groupCode="BC_STATUS" , codeField="mbrbs_status_cd")
	private String mbrbsStatus;
	
	private String bizrNo;
	private String reprNm;
	private String telNo;
	private String zipCd;
	private String adrDtl;
	private String acrlRuleCd;
	private String acrlRuleTypeCd;
	private String adjRuleCd;
	private String adjRuleTypeCd;
	
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getLowMbrbsCd() {
		return lowMbrbsCd;
	}
	public void setLowMbrbsCd(String lowMbrbsCd) {
		this.lowMbrbsCd = lowMbrbsCd;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getPointContType() {
		return pointContType;
	}
	public void setPointContType(String pointContType) {
		this.pointContType = pointContType;
	}
	public String getMbrbsStatus() {
		return mbrbsStatus;
	}
	public void setMbrbsStatus(String mbrbsStatus) {
		this.mbrbsStatus = mbrbsStatus;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getReprNm() {
		return reprNm;
	}
	public void setReprNm(String reprNm) {
		this.reprNm = reprNm;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getZipCd() {
		return zipCd;
	}
	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}
	public String getAdrDtl() {
		return adrDtl;
	}
	public void setAdrDtl(String adrDtl) {
		this.adrDtl = adrDtl;
	}
	public String getAcrlRuleCd() {
		return acrlRuleCd;
	}
	public void setAcrlRuleCd(String acrlRuleCd) {
		this.acrlRuleCd = acrlRuleCd;
	}
	public String getAcrlRuleTypeCd() {
		return acrlRuleTypeCd;
	}
	public void setAcrlRuleTypeCd(String acrlRuleTypeCd) {
		this.acrlRuleTypeCd = acrlRuleTypeCd;
	}
	public String getAdjRuleCd() {
		return adjRuleCd;
	}
	public void setAdjRuleCd(String adjRuleCd) {
		this.adjRuleCd = adjRuleCd;
	}
	public String getAdjRuleTypeCd() {
		return adjRuleTypeCd;
	}
	public void setAdjRuleTypeCd(String adjRuleTypeCd) {
		this.adjRuleTypeCd = adjRuleTypeCd;
	}
	
	
	

	
	
	



	
	

}
