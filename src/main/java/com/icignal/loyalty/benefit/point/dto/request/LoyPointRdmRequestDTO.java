package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.Loyalty.common.dto.request.LoyPointRdmRequestDTO
* @date : 2018. 12. 3.
* @author : hy.jun
* @description : 포인트 차감
*/
public class LoyPointRdmRequestDTO extends MKTBaseReqDto {
	private int isConTran;
	private String pgmNo;
	private String identiType;
	private String identiVal;
	private String encryptKey;
	private String offerNo;
	private String offerType;
	private String ridIntactType;
	private String ridIntactDate;
	private String chnlNo;
	private String posNo;
	private String txnTypeCd;
	private String txnTypeDtlCd;
	private String sndDate;
	private String sndTime;
	private String txnUniqNo;
	private String txnDate;
	private String txnTime;
	private String orgnApprDate;
	private String orgnApprNo;
	private int pntAmt;
	private String refNo;
	private String rcptNo;
	private int txnAmt;
	private String calcFlag;
	private String keyFieldType;
	private String tranDtlTypeDesc;

	private String rst;
	private String rstCd;
	private String rstMsg;
	private int usePnt;
	private int preAcrlPnt;
	private int expr1MonthPnt;
	private int expr3MonthPnt;
	private int totalAcrlPnt;
	private int totalRdmPnt;
	private int totalAcrlCancelPnt;
	private int totalRdmCancelPnt;
	private int totalExprPnt;
	private String apprNo;
	private String apprDate;
	private String apprTime;
	private String pntTxnType;
	private String pntTxnDtlType;
	private String applyPnt;
	
	
	public String getApplyPnt() {
		return applyPnt;
	}

	public void setApplyPnt(String applyPnt) {
		this.applyPnt = applyPnt;
	}

	public String getPntTxnType() {
		return pntTxnType;
	}

	public void setPntTxnType(String pntTxnType) {
		this.pntTxnType = pntTxnType;
	}

	public String getPntTxnDtlType() {
		return pntTxnDtlType;
	}

	public void setPntTxnDtlType(String pntTxnDtlType) {
		this.pntTxnDtlType = pntTxnDtlType;
	}

	public LoyPointRdmRequestDTO() throws Exception {
//		encryptKey = CryptoManager.getCipherKey();
	}
	
	public int getIsConTran() {
		return isConTran;
	}
	public void setIsConTran(int isConTran) {
		this.isConTran = isConTran;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getIdentiType() {
		return identiType;
	}
	public void setIdentiType(String identiType) {
		this.identiType = identiType;
	}
	public String getIdentiVal() {
		return identiVal;
	}
	public void setIdentiVal(String identiVal) {
		this.identiVal = identiVal;
	}
	public String getEncryptKey() {
		return encryptKey;
	}
	public void setEncryptKey(String encryptKey) {
		this.encryptKey = encryptKey;
	}
	public String getOfferNo() {
		return offerNo;
	}
	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getRidIntactType() {
		return ridIntactType;
	}
	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
	}
	public String getRidIntactDate() {
		return ridIntactDate;
	}
	public void setRidIntactDate(String ridIntactDate) {
		this.ridIntactDate = ridIntactDate;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getPosNo() {
		return posNo;
	}
	public void setPosNo(String posNo) {
		this.posNo = posNo;
	}
	public String getTxnTypeCd() {
		return txnTypeCd;
	}
	public void setTxnTypeCd(String txnTypeCd) {
		this.txnTypeCd = txnTypeCd;
	}
	public String getTxnTypeDtlCd() {
		return txnTypeDtlCd;
	}
	public void setTxnTypeDtlCd(String txnTypeDtlCd) {
		this.txnTypeDtlCd = txnTypeDtlCd;
	}
	public String getSndDate() {
		return sndDate;
	}
	public void setSndDate(String sndDate) {
		this.sndDate = sndDate;
	}
	public String getSndTime() {
		return sndTime;
	}
	public void setSndTime(String sndTime) {
		this.sndTime = sndTime;
	}
	public String getTxnUniqNo() {
		return txnUniqNo;
	}
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}
	public String getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}
	public String getTxnTime() {
		return txnTime;
	}
	public void setTxnTime(String txnTime) {
		this.txnTime = txnTime;
	}
	public String getOrgnApprDate() {
		return orgnApprDate;
	}
	public void setOrgnApprDate(String orgnApprDate) {
		this.orgnApprDate = orgnApprDate;
	}
	public String getOrgnApprNo() {
		return orgnApprNo;
	}
	public void setOrgnApprNo(String orgnApprNo) {
		this.orgnApprNo = orgnApprNo;
	}
	public int getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(int pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getRefNo() {
		return refNo;
	}
	public void setRefNo(String refNo) {
		this.refNo = refNo;
	}
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public int getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(int txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getCalcFlag() {
		return calcFlag;
	}
	public void setCalcFlag(String calcFlag) {
		this.calcFlag = calcFlag;
	}
	public String getKeyFieldType() {
		return keyFieldType;
	}
	public void setKeyFieldType(String keyFieldType) {
		this.keyFieldType = keyFieldType;
	}
	public String getTranDtlTypeDesc() {
		return tranDtlTypeDesc;
	}
	public void setTranDtlTypeDesc(String tranDtlTypeDesc) {
		this.tranDtlTypeDesc = tranDtlTypeDesc;
	}
	public String getRst() {
		return rst;
	}
	public void setRst(String rst) {
		this.rst = rst;
	}
	public String getRstCd() {
		return rstCd;
	}
	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}
	public String getRstMsg() {
		return rstMsg;
	}
	public void setRstMsg(String rstMsg) {
		this.rstMsg = rstMsg;
	}
	public int getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(int usePnt) {
		this.usePnt = usePnt;
	}
	public int getPreAcrlPnt() {
		return preAcrlPnt;
	}
	public void setPreAcrlPnt(int preAcrlPnt) {
		this.preAcrlPnt = preAcrlPnt;
	}
	public int getExpr1MonthPnt() {
		return expr1MonthPnt;
	}
	public void setExpr1MonthPnt(int expr1MonthPnt) {
		this.expr1MonthPnt = expr1MonthPnt;
	}
	public int getExpr3MonthPnt() {
		return expr3MonthPnt;
	}
	public void setExpr3MonthPnt(int expr3MonthPnt) {
		this.expr3MonthPnt = expr3MonthPnt;
	}
	public int getTotalAcrlPnt() {
		return totalAcrlPnt;
	}
	public void setTotalAcrlPnt(int totalAcrlPnt) {
		this.totalAcrlPnt = totalAcrlPnt;
	}
	public int getTotalRdmPnt() {
		return totalRdmPnt;
	}
	public void setTotalRdmPnt(int totalRdmPnt) {
		this.totalRdmPnt = totalRdmPnt;
	}
	public int getTotalAcrlCancelPnt() {
		return totalAcrlCancelPnt;
	}
	public void setTotalAcrlCancelPnt(int totalAcrlCancelPnt) {
		this.totalAcrlCancelPnt = totalAcrlCancelPnt;
	}
	public int getTotalRdmCancelPnt() {
		return totalRdmCancelPnt;
	}
	public void setTotalRdmCancelPnt(int totalRdmCancelPnt) {
		this.totalRdmCancelPnt = totalRdmCancelPnt;
	}
	public int getTotalExprPnt() {
		return totalExprPnt;
	}
	public void setTotalExprPnt(int totalExprPnt) {
		this.totalExprPnt = totalExprPnt;
	}
	public String getApprNo() {
		return apprNo;
	}
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getApprTime() {
		return apprTime;
	}
	public void setApprTime(String apprTime) {
		this.apprTime = apprTime;
	}
}
