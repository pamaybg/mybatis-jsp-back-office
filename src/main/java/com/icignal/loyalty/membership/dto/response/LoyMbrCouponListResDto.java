/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrCouponListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 13. 오후 4:43:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrCouponListResDto
 * 2. 파일명	: LoyMbrCouponListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrCouponListResDto extends GridPagingItemResDto{
	private String rid;
	private String ofrNm;
	private String ofrType;
    @MarkName(groupCode = "LOY_OFR_TYPE", codeField = "ofrType")
	private String ofrTypeNm;

	private String ofrSubType;
    @MarkName(groupCode = "LOY_OFR_SUB_TYPE", codeField = "ofrSubType")
	private String ofrSubTypeNm;
	private String cpnNo;
	private String cpnIssueDt;

	private String cpnStateCd;
	@MarkName(groupCode = "LOY_CPN_STAT_CD", codeField = "cpnStateCd")
	private String cpnStateCdNm;
	private String cpnlstUesdDt;
	private String createDate;
	private String cpnOccurDt;
	private String cpnUseChnlNo;
	private String cpnUseChnlNm;
	private String issChnlNo;
	private String issChnlNm;
	private String rcptNo;
	private String acrlCnclNo;
	private String useCnclNo;
	private String cpnTxnStateCd;
	@MarkName(groupCode = "LOY_CPN_TXN_STAT_CD", codeField = "cpnTxnStateCd")
	private String cpnTxnStateCdNm;
	private Integer cpnAvlCnt;
	private String ridUsedChnl;
	private String ridIssChnl;
	private String usedChnlNo;

	private String cpnNm;
	private String ridMbr;	
	private String cpnKind;
	private String cpnMethod;	
	private String cpnSummary;
	private String dcUnit;
	private String dcValue;
	private String cpnUseYN;
	private String regDate;
	
	private String expiryDate;
	private String ofrValAmt;
	private String useMinPurAmt;
	private String useDupYn;
	private String offYn;
	private String chnlNm;
	private String cpnExpiryState;
	
	private String cpnTypeCd;
	@MarkName(groupCode = "LNL_MALL_TYPE", codeField = "cpnTypeCd")
	private String cpnTypeCdNm;
	
	private String cpnCtgCd;
	@MarkName(groupCode = "LNL_MALL_COUPON_CATEGORY", codeField = "cpnCtgCd")
	private String cpnCtgCdNm;
	
	private String cpnDesc;
	private String saleType;
	@MarkName(groupCode = "LNL_MALL_SALE_TYPE", codeField = "saleType")
	private String saleTypeNm;
	private String chnlTxnNo;
	private String ridCpnTxn;
	private String cpnMaxCnt;
	
	private String useMaxDcAmt;
	private String useChnlLimitYn;
	private String useProdLimitYn;
	private String usableMaxCnt;
	
	private String valAmt;
	private String minPurAmt;
	private String maxDcAmt;
	private String useStatus;
	private String issuDate;
	private String useDate;
	private String ofrNo;
	
	@MarkName(groupCode = "LNL_MALL_USE_STATUS", codeField = "useStatus")
	private String useStatusNm;
	private String createBy;

	//데상트 쿠폰
	private String usrCponSeq;
	private String cponNm;
	@MarkName(groupCode = "X_DK_CPON_TP_CD", codeField = "cponTpCd")
	private String cponTpCdNm;
	private String cponTpCd;
	private String fstRegDt;
	private String discntTpCd;
	private String discnt;
	private String lmtPrc;
	private String useStartDt;
	private String useStopDt;
	private String useValidDt;
	private String useDt;
	@MarkName(groupCode = "CPN_EXPIRY_STATE", codeField = "cponStCd")
	private String cponStCdNm;
	private String cponStCd;

	private String publEaCd;

	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getUseDate() {
		return useDate;
	}
	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}
	public String getValAmt() {
		return valAmt;
	}
	public void setValAmt(String valAmt) {
		this.valAmt = valAmt;
	}
	public String getMinPurAmt() {
		return minPurAmt;
	}
	public void setMinPurAmt(String minPurAmt) {
		this.minPurAmt = minPurAmt;
	}
	public String getMaxDcAmt() {
		return maxDcAmt;
	}
	public void setMaxDcAmt(String maxDcAmt) {
		this.maxDcAmt = maxDcAmt;
	}
	public String getUseStatus() {
		return useStatus;
	}
	public void setUseStatus(String useStatus) {
		this.useStatus = useStatus;
	}
	public String getUseMaxDcAmt() {
		return useMaxDcAmt;
	}
	public void setUseMaxDcAmt(String useMaxDcAmt) {
		this.useMaxDcAmt = useMaxDcAmt;
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
	public String getUsableMaxCnt() {
		return usableMaxCnt;
	}
	public void setUsableMaxCnt(String usableMaxCnt) {
		this.usableMaxCnt = usableMaxCnt;
	}
	public String getCpnTypeCd() {
		return cpnTypeCd;
	}
	public void setCpnTypeCd(String cpnTypeCd) {
		this.cpnTypeCd = cpnTypeCd;
	}
	public String getCpnCtgCd() {
		return cpnCtgCd;
	}
	public void setCpnCtgCd(String cpnCtgCd) {
		this.cpnCtgCd = cpnCtgCd;
	}
	public String getCpnDesc() {
		return cpnDesc;
	}
	public void setCpnDesc(String cpnDesc) {
		this.cpnDesc = cpnDesc;
	}
	public String getSaleType() {
		return saleType;
	}
	public void setSaleType(String saleType) {
		this.saleType = saleType;
	}
	public String getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	public String getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(String ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
	}
	public String getUseMinPurAmt() {
		return useMinPurAmt;
	}
	public void setUseMinPurAmt(String useMinPurAmt) {
		this.useMinPurAmt = useMinPurAmt;
	}
	public String getUseDupYn() {
		return useDupYn;
	}
	public void setUseDupYn(String useDupYn) {
		this.useDupYn = useDupYn;
	}
	public String getOffYn() {
		return offYn;
	}
	public void setOffYn(String offYn) {
		this.offYn = offYn;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getCpnExpiryState() {
		return cpnExpiryState;
	}
	public void setCpnExpiryState(String cpnExpiryState) {
		this.cpnExpiryState = cpnExpiryState;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getCpnKind() {
		return cpnKind;
	}
	public void setCpnKind(String cpnKind) {
		this.cpnKind = cpnKind;
	}
	public String getCpnMethod() {
		return cpnMethod;
	}
	public void setCpnMethod(String cpnMethod) {
		this.cpnMethod = cpnMethod;
	}
	public String getCpnSummary() {
		return cpnSummary;
	}
	public void setCpnSummary(String cpnSummary) {
		this.cpnSummary = cpnSummary;
	}
	public String getDcUnit() {
		return dcUnit;
	}
	public void setDcUnit(String dcUnit) {
		this.dcUnit = dcUnit;
	}
	public String getDcValue() {
		return dcValue;
	}
	public void setDcValue(String dcValue) {
		this.dcValue = dcValue;
	}
	public String getCpnUseYN() {
		return cpnUseYN;
	}
	public void setCpnUseYN(String cpnUseYN) {
		this.cpnUseYN = cpnUseYN;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
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
	public String getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getCpnIssueDt() {
		return cpnIssueDt;
	}
	public void setCpnIssueDt(String cpnIssueDt) {
		this.cpnIssueDt = cpnIssueDt;
	}
	public String getCpnStateCd() {
		return cpnStateCd;
	}
	public void setCpnStateCd(String cpnStateCd) {
		this.cpnStateCd = cpnStateCd;
	}

	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getOfrTypeNm() {
		return ofrTypeNm;
	}
	public void setOfrTypeNm(String ofrTypeNm) {
		this.ofrTypeNm = ofrTypeNm;
	}
	public String getOfrSubTypeNm() {
		return ofrSubTypeNm;
	}
	public void setOfrSubTypeNm(String ofrSubTypeNm) {
		this.ofrSubTypeNm = ofrSubTypeNm;
	}
	public String getCpnStateCdNm() {
		return cpnStateCdNm;
	}
	public void setCpnStateCdNm(String cpnStateCdNm) {
		this.cpnStateCdNm = cpnStateCdNm;
	}
	public String getCpnlstUesdDt() {
		return cpnlstUesdDt;
	}
	public void setCpnlstUesdDt(String cpnlstUesdDt) {
		this.cpnlstUesdDt = cpnlstUesdDt;
	}
	public String getCpnOccurDt() {
		return cpnOccurDt;
	}
	public void setCpnOccurDt(String cpnOccurDt) {
		this.cpnOccurDt = cpnOccurDt;
	}
	public String getCpnUseChnlNo() {
		return cpnUseChnlNo;
	}
	public void setCpnUseChnlNo(String cpnUseChnlNo) {
		this.cpnUseChnlNo = cpnUseChnlNo;
	}
	public String getCpnUseChnlNm() {
		return cpnUseChnlNm;
	}
	public void setCpnUseChnlNm(String cpnUseChnlNm) {
		this.cpnUseChnlNm = cpnUseChnlNm;
	}
	public String getIssChnlNo() {
		return issChnlNo;
	}
	public void setIssChnlNo(String issChnlNo) {
		this.issChnlNo = issChnlNo;
	}
	public String getIssChnlNm() {
		return issChnlNm;
	}
	public void setIssChnlNm(String issChnlNm) {
		this.issChnlNm = issChnlNm;
	}
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public String getAcrlCnclNo() {
		return acrlCnclNo;
	}
	public void setAcrlCnclNo(String acrlCnclNo) {
		this.acrlCnclNo = acrlCnclNo;
	}
	public String getUseCnclNo() {
		return useCnclNo;
	}
	public void setUseCnclNo(String useCnclNo) {
		this.useCnclNo = useCnclNo;
	}
	public String getCpnTxnStateCd() {
		return cpnTxnStateCd;
	}
	public void setCpnTxnStateCd(String cpnTxnStateCd) {
		this.cpnTxnStateCd = cpnTxnStateCd;
	}
	public String getCpnTxnStateCdNm() {
		return cpnTxnStateCdNm;
	}
	public void setCpnTxnStateCdNm(String cpnTxnStateCdNm) {
		this.cpnTxnStateCdNm = cpnTxnStateCdNm;
	}
	public Integer getCpnAvlCnt() {
		return cpnAvlCnt;
	}
	public void setCpnAvlCnt(Integer cpnAvlCnt) {
		this.cpnAvlCnt = cpnAvlCnt;
	}
	public String getRidUsedChnl() {
		return ridUsedChnl;
	}
	public void setRidUsedChnl(String ridUsedChnl) {
		this.ridUsedChnl = ridUsedChnl;
	}
	public String getRidIssChnl() {
		return ridIssChnl;
	}
	public void setRidIssChnl(String ridIssChnl) {
		this.ridIssChnl = ridIssChnl;
	}
	public String getUsedChnlNo() {
		return usedChnlNo;
	}
	public void setUsedChnlNo(String usedChnlNo) {
		this.usedChnlNo = usedChnlNo;
	}
	public String getCpnNm() {
		return cpnNm;
	}
	public void setCpnNm(String cpnNm) {
		this.cpnNm = cpnNm;
	}
	public String getChnlTxnNo() {
		return chnlTxnNo;
	}
	public void setChnlTxnNo(String chnlTxnNo) {
		this.chnlTxnNo = chnlTxnNo;
	}
	public String getRidCpnTxn() {
		return ridCpnTxn;
	}
	public void setRidCpnTxn(String ridCpnTxn) {
		this.ridCpnTxn = ridCpnTxn;
	}
	public String getCpnMaxCnt() {
		return cpnMaxCnt;
	}
	public void setCpnMaxCnt(String cpnMaxCnt) {
		this.cpnMaxCnt = cpnMaxCnt;
	}
	public String getUseStatusNm() {
		return useStatusNm;
	}
	public void setUseStatusNm(String useStatusNm) {
		this.useStatusNm = useStatusNm;
	}
	public String getCpnCtgCdNm() {
		return cpnCtgCdNm;
	}
	public void setCpnCtgCdNm(String cpnCtgCdNm) {
		this.cpnCtgCdNm = cpnCtgCdNm;
	}
	public String getCpnTypeCdNm() {
		return cpnTypeCdNm;
	}
	public void setCpnTypeCdNm(String cpnTypeCdNm) {
		this.cpnTypeCdNm = cpnTypeCdNm;
	}
	public String getSaleTypeNm() {
		return saleTypeNm;
	}
	public void setSaleTypeNm(String saleTypeNm) {
		this.saleTypeNm = saleTypeNm;
	}
	public String getIssuDate() {
		return issuDate;
	}
	public void setIssuDate(String issuDate) {
		this.issuDate = issuDate;
	}

	public String getUsrCponSeq() {
		return usrCponSeq;
	}

	public void setUsrCponSeq(String usrCponSeq) {
		this.usrCponSeq = usrCponSeq;
	}

	public String getCponNm() {
		return cponNm;
	}

	public void setCponNm(String cponNm) {
		this.cponNm = cponNm;
	}

	public String getCponTpCd() {
		return cponTpCd;
	}

	public void setCponTpCd(String cponTpCd) {
		this.cponTpCd = cponTpCd;
	}

	public String getFstRegDt() {
		return fstRegDt;
	}

	public void setFstRegDt(String fstRegDt) {
		this.fstRegDt = fstRegDt;
	}

	public String getDiscntTpCd() {
		return discntTpCd;
	}

	public void setDiscntTpCd(String discntTpCd) {
		this.discntTpCd = discntTpCd;
	}

	public String getDiscnt() {
		return discnt;
	}

	public void setDiscnt(String discnt) {
		this.discnt = discnt;
	}

	public String getLmtPrc() {
		return lmtPrc;
	}

	public void setLmtPrc(String lmtPrc) {
		this.lmtPrc = lmtPrc;
	}

	public String getUseStartDt() {
		return useStartDt;
	}

	public void setUseStartDt(String useStartDt) {
		this.useStartDt = useStartDt;
	}

	public String getUseStopDt() {
		return useStopDt;
	}

	public void setUseStopDt(String useStopDt) {
		this.useStopDt = useStopDt;
	}

	public String getUseDt() {
		return useDt;
	}

	public void setUseDt(String useDt) {
		this.useDt = useDt;
	}

	public String getCponStCd() {
		return cponStCd;
	}

	public void setCponStCd(String cponStCd) {
		this.cponStCd = cponStCd;
	}

	public String getCponTpCdNm() {
		return cponTpCdNm;
	}

	public void setCponTpCdNm(String cponTpCdNm) {
		this.cponTpCdNm = cponTpCdNm;
	}

	public String getCponStCdNm() {
		return cponStCdNm;
	}

	public void setCponStCdNm(String cponStCdNm) {
		this.cponStCdNm = cponStCdNm;
	}

	public String getUseValidDt() {
		return useValidDt;
	}

	public void setUseValidDt(String useValidDt) {
		this.useValidDt = useValidDt;
	}

	public String getPublEaCd() {
		return publEaCd;
	}

	public void setPublEaCd(String publEaCd) {
		this.publEaCd = publEaCd;
	}
}
