package com.icignal.loyalty.club.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyClubOfferDetailReqDto extends CommonDataAuthReqDto{
	
	private String id;
	private String rid;
	private String empId;
	private String parRid;
	private String ridOfr;
	private String ofrNm;
	private String bnftTypeCd;
	private int ofrAmt;
	private String acrlCycleTypeCd;
	private String ofrType;
	private String ofrPromRuleYn;
	private String getOfferListPop;
	private String issType;
	private String promTypeLv2Cd;
	
	private String vocYn; // VOC_YN(대응 지급 가능 여부)
	private String empYn; // EMP_YN(임직원 지급 가능여부)
	private String ridMbr;
	
	
	public String getPromTypeLv2Cd() {
		return promTypeLv2Cd;
	}
	public void setPromTypeLv2Cd(String promTypeLv2Cd) {
		this.promTypeLv2Cd = promTypeLv2Cd;
	}
	public String getIssType() {
		return issType;
	}
	public void setIssType(String issType) {
		this.issType = issType;
	}
	public String getGetOfferListPop() {
		return getOfferListPop;
	}
	public void setGetOfferListPop(String getOfferListPop) {
		this.getOfferListPop = getOfferListPop;
	}
	public String getOfrPromRuleYn() {
		return ofrPromRuleYn;
	}
	public void setOfrPromRuleYn(String ofrPromRuleYn) {
		this.ofrPromRuleYn = ofrPromRuleYn;
	}
	public String getOfrType() {
		return ofrType;
	}
	public void setOfrType(String ofrType) {
		this.ofrType = ofrType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
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
	public String getAcrlCycleTypeCd() {
		return acrlCycleTypeCd;
	}
	public void setAcrlCycleTypeCd(String acrlCycleTypeCd) {
		this.acrlCycleTypeCd = acrlCycleTypeCd;
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
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	
}
