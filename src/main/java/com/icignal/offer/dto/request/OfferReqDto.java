package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OfferReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 릴레이션
	private String ridChnl;
	private String ridOfrgrp;
	
	// 코드
	private String statCd;
	private String ofrType;
	private String ofrSubType;
	private String ofrValType;
	private String settleType;
	private String expirType;

	// 기본 필드
	private String ofrNo;
	private String ofrNm;
	private String descText;

	private String validStartDate;
	private String validEndDate;
	private String feeAmt;
	private String feeCurncy;
	private String feeShareBaseAmt;
	private String ofrValAmt;
	private String ofrCostAmt;
	private String hqSettleRate;
	private String feeSettleUseRate;
	private String expirMM;

	private String cpnYn;
	private String feeYn;
	private String vocYn;
	private String giftYn;
	private String useChnlLimitYn;
	private String useProdLimitYn;
	
	private String refCd;
	private String settleRefCd;
	
	private String maxAmt;
	private String maxLimitTypeCd;
	private String maxLimitAmt;
	
	private String effStrtDayCnt;
	private String effStartDate;
	private String effStartDayCnt;
	private String effDateType;
	private String empYn;
	private String ofrCtg;

	private String useExpirType;
	private int useExpirDayCnt;
	private String useFixStartDate;
	private String useFixEndDate;
	private String useMinPurAmt;
	private String useMaxDcAmt;

	private String cpndescText;

	public String getOfrCtg() {
		return ofrCtg;
	}
	public void setOfrCtg(String ofrCtg) {
		this.ofrCtg = ofrCtg;
	}
	public String getEmpYn() {
		return empYn;
	}
	public void setEmpYn(String empYn) {
		this.empYn = empYn;
	}
	public String getEffDateType() {
		return effDateType;
	}
	public void setEffDateType(String effDateType) {
		this.effDateType = effDateType;
	}
	public String getEffStrtDayCnt() {
		return effStrtDayCnt;
	}
	public void setEffStrtDayCnt(String effStrtDayCnt) {
		this.effStrtDayCnt = effStrtDayCnt;
	}
	
	public String getEffStartDate() {
		return effStartDate;
	}
	public void setEffStartDate(String effStartDate) {
		this.effStartDate = effStartDate;
	}
	public String getEffStartDayCnt() {
		return effStartDayCnt;
	}
	public void setEffStartDayCnt(String effStartDayCnt) {
		this.effStartDayCnt = effStartDayCnt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getRidOfrgrp() {
		return ridOfrgrp;
	}
	public void setRidOfrgrp(String ridOfrgrp) {
		this.ridOfrgrp = ridOfrgrp;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getOfrType() {
		return ofrType;
	}
	public void setOfrType(String ofrType) {
		this.ofrType = ofrType;
	}
	public String getOfrSubType() {
		return ofrSubType;
	}
	public void setOfrSubType(String ofrSubType) {
		this.ofrSubType = ofrSubType;
	}
	public String getOfrValType() {
		return ofrValType;
	}
	public void setOfrValType(String ofrValType) {
		this.ofrValType = ofrValType;
	}
	public String getSettleType() {
		return settleType;
	}
	public void setSettleType(String settleType) {
		this.settleType = settleType;
	}
	public String getExpirType() {
		return expirType;
	}
	public void setExpirType(String expirType) {
		this.expirType = expirType;
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
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}

	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getFeeAmt() {
		return feeAmt;
	}
	public void setFeeAmt(String feeAmt) {
		this.feeAmt = feeAmt;
	}
	public String getFeeCurncy() {
		return feeCurncy;
	}
	public void setFeeCurncy(String feeCurncy) {
		this.feeCurncy = feeCurncy;
	}
	public String getFeeShareBaseAmt() {
		return feeShareBaseAmt;
	}
	public void setFeeShareBaseAmt(String feeShareBaseAmt) {
		this.feeShareBaseAmt = feeShareBaseAmt;
	}
	public String getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(String ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
	}
	public String getOfrCostAmt() {
		return ofrCostAmt;
	}
	public void setOfrCostAmt(String ofrCostAmt) {
		this.ofrCostAmt = ofrCostAmt;
	}
	public String getHqSettleRate() {
		return hqSettleRate;
	}
	public void setHqSettleRate(String hqSettleRate) {
		this.hqSettleRate = hqSettleRate;
	}
	public String getFeeSettleUseRate() {
		return feeSettleUseRate;
	}
	public void setFeeSettleUseRate(String feeSettleUseRate) {
		this.feeSettleUseRate = feeSettleUseRate;
	}
	public String getExpirMM() {
		return expirMM;
	}
	public void setExpirMM(String expirMM) {
		this.expirMM = expirMM;
	}
	public String getCpnYn() {
		return cpnYn;
	}
	public void setCpnYn(String cpnYn) {
		this.cpnYn = cpnYn;
	}
	public String getFeeYn() {
		return feeYn;
	}
	public void setFeeYn(String feeYn) {
		this.feeYn = feeYn;
	}
	public String getVocYn() {
		return vocYn;
	}
	public void setVocYn(String vocYn) {
		this.vocYn = vocYn;
	}
	public String getGiftYn() {
		return giftYn;
	}
	public void setGiftYn(String giftYn) {
		this.giftYn = giftYn;
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
	public String getRefCd() {
		return refCd;
	}
	public void setRefCd(String refCd) {
		this.refCd = refCd;
	}
	public String getSettleRefCd() {
		return settleRefCd;
	}
	public void setSettleRefCd(String settleRefCd) {
		this.settleRefCd = settleRefCd;
	}
	public String getMaxAmt() {
		return maxAmt;
	}
	public void setMaxAmt(String maxAmt) {
		this.maxAmt = maxAmt;
	}
	public String getMaxLimitTypeCd() {
		return maxLimitTypeCd;
	}
	public void setMaxLimitTypeCd(String maxLimitTypeCd) {
		this.maxLimitTypeCd = maxLimitTypeCd;
	}
	public String getMaxLimitAmt() {
		return maxLimitAmt;
	}
	public void setMaxLimitAmt(String maxLimitAmt) {
		this.maxLimitAmt = maxLimitAmt;
	}
	public String getUseExpirType() {return useExpirType;}
	public void setUseExpirType(String useExpirType) {this.useExpirType = useExpirType;}
	public int getUseExpirDayCnt() {return useExpirDayCnt;}
	public void setUseExpirDayCnt(int useExpirDayCnt) {this.useExpirDayCnt = useExpirDayCnt;}
	public String getUseFixStartDate() {return useFixStartDate;}
	public void setUseFixStartDate(String useFixStartDate) {this.useFixStartDate = useFixStartDate;}
	public String getUseFixEndDate() {return useFixEndDate;}
	public void setUseFixEndDate(String useFixEndDate) {this.useFixEndDate = useFixEndDate;}
	public String getUseMinPurAmt() {return useMinPurAmt;}
	public void setUseMinPurAmt(String useMinPurAmt) {this.useMinPurAmt = useMinPurAmt;}
	public String getUseMaxDcAmt() {return useMaxDcAmt;}
	public void setUseMaxDcAmt(String useMaxDcAmt) {this.useMaxDcAmt = useMaxDcAmt;}
	public String getCpndescText() {
		return cpndescText;
	}
	public void setCpndescText(String cpndescText) {
		this.cpndescText = cpndescText;
	}
}
