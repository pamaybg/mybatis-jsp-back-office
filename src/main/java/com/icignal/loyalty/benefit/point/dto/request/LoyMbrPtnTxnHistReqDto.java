/**
 *
 */
package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.base.dto.request.ExcelExportReqDto;

/**
  * @fileName : LoyMbrPtnTxnHistRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 포인트 거래이력 DTO
  */
public class LoyMbrPtnTxnHistReqDto  extends CommonDataAuthReqDto {
	/** RID */
	private String rid;

	/** 프로그램 ID */
	private String ridPgm;

	/** 회원 ID */
	private String ridMbr;

	/** RID_PAR_PNT_TXN */
	private String ridParPntTxn;

	/** RID_인터랙션 유형 */
    private String ridIntactType;

   	/** 인터랙션 데이터 ID */
    private String ridIntactData;

   	/** RID_채널 */
    private String ridChnl;

   	/** 회원 카드 ID */
    private String ridMbrCard;

   	/** 포인트 거래 유형 1 코드: PNT_TXN_TYPE */
    private String pntTxnType1Cd;

   	/** 포인트 거래 유형 2 코드: PNT_TXN_DTL_TYPE */
    private String pntTxnType2Cd;

   	/** 거래 고유 번호 */
    private String txnUniqNo;

   	/** 전송 일자 */
    private String sndDate;

   	/** 전송 시간 */
    private String sndTime;

   	/** 거래 일자 */
    private String txnDate;

   	/** 거래 시간 */
    private String txnTime;

   	/** 원 승인 일자 */
    private String orgnApprDate;

   	/** 원 승인 번호 */
    private String orgnApprNo;

   	/** 영수증 번호 */
    private String rcptNo;

   	/** 참조번호 */
    private String refNo;

   	/** 거래 금액 */
    private String txnAmt;

   	/** 승인 일자 */
    private String apprDate;

   	/** 승인 시각 */
    private String apprTm;

   	/** 승인 번호 */
    private String apprNo;

   	/** 포인트 금액 */
    private String pntAmt;

   	/** 단말기 번호 */
    private String posNo;

   	/** 거래 상태 코드: PNT_TXN_STAT_CD */
    private String txnStatCd;

    private String searchType;

    private String cipherKey;

    private String pntTxnDateType;

    private ExcelExportReqDto excelObj;
    
    private String dtlApprNo; //승인번호
    
    private String startDt;
    
    private String endDt;
    
    private String chnlNm; // 채널명
    
    private String pntTxnType;
    
    private String rceptNo;
    
    
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getDtlApprNo() {
		return dtlApprNo;
	}
	public void setDtlApprNo(String dtlApprNo) {
		this.dtlApprNo = dtlApprNo;
	}

	public LoyMbrPtnTxnHistReqDto() {
     /*   try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
    }
	@Override
	public String getSearchType() {
		return searchType;
	}

	@Override
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	/**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}

	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}

	/**
	 * @return the ridPgm
	 */
	public String getRidPgm() {
		return ridPgm;
	}

	/**
	 * @param ridPgm the ridPgm to set
	 */
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	/**
	 * @return the ridMbr
	 */
	public String getRidMbr() {
		return ridMbr;
	}

	/**
	 * @param ridMbr the ridMbr to set
	 */
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	/**
	 * @return the ridParPntTxn
	 */
	public String getRidParPntTxn() {
		return ridParPntTxn;
	}

	/**
	 * @param ridParPntTxn the ridParPntTxn to set
	 */
	public void setRidParPntTxn(String ridParPntTxn) {
		this.ridParPntTxn = ridParPntTxn;
	}

	/**
	 * @return the ridIntactType
	 */
	public String getRidIntactType() {
		return ridIntactType;
	}

	/**
	 * @param ridIntactType the ridIntactType to set
	 */
	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
	}

	/**
	 * @return the ridIntactData
	 */
	public String getRidIntactData() {
		return ridIntactData;
	}

	/**
	 * @param ridIntactData the ridIntactData to set
	 */
	public void setRidIntactData(String ridIntactData) {
		this.ridIntactData = ridIntactData;
	}

	/**
	 * @return the ridChnl
	 */
	public String getRidChnl() {
		return ridChnl;
	}

	/**
	 * @param ridChnl the ridChnl to set
	 */
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	/**
	 * @return the ridMbrCard
	 */
	public String getRidMbrCard() {
		return ridMbrCard;
	}

	/**
	 * @param ridMbrCard the ridMbrCard to set
	 */
	public void setRidMbrCard(String ridMbrCard) {
		this.ridMbrCard = ridMbrCard;
	}

	/**
	 * @return the pntTxnType1Cd
	 */
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}

	/**
	 * @param pntTxnType1Cd the pntTxnType1Cd to set
	 */
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}

	/**
	 * @return the pntTxnType2Cd
	 */
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}

	/**
	 * @param pntTxnType2Cd the pntTxnType2Cd to set
	 */
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
	}

	/**
	 * @return the txnUniqNo
	 */
	public String getTxnUniqNo() {
		return txnUniqNo;
	}

	/**
	 * @param txnUniqNo the txnUniqNo to set
	 */
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}

	/**
	 * @return the sndDate
	 */
	public String getSndDate() {
		return sndDate;
	}

	/**
	 * @param sndDate the sndDate to set
	 */
	public void setSndDate(String sndDate) {
		this.sndDate = sndDate;
	}

	/**
	 * @return the sndTime
	 */
	public String getSndTime() {
		return sndTime;
	}

	/**
	 * @param sndTime the sndTime to set
	 */
	public void setSndTime(String sndTime) {
		this.sndTime = sndTime;
	}

	/**
	 * @return the txnDate
	 */
	public String getTxnDate() {
		return txnDate;
	}

	/**
	 * @param txnDate the txnDate to set
	 */
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}

	/**
	 * @return the txnTime
	 */
	public String getTxnTime() {
		return txnTime;
	}

	/**
	 * @param txnTime the txnTime to set
	 */
	public void setTxnTime(String txnTime) {
		this.txnTime = txnTime;
	}

	/**
	 * @return the orgnApprDate
	 */
	public String getOrgnApprDate() {
		return orgnApprDate;
	}

	/**
	 * @param orgnApprDate the orgnApprDate to set
	 */
	public void setOrgnApprDate(String orgnApprDate) {
		this.orgnApprDate = orgnApprDate;
	}

	/**
	 * @return the orgnApprNo
	 */
	public String getOrgnApprNo() {
		return orgnApprNo;
	}

	/**
	 * @param orgnApprNo the orgnApprNo to set
	 */
	public void setOrgnApprNo(String orgnApprNo) {
		this.orgnApprNo = orgnApprNo;
	}

	/**
	 * @return the rcptNo
	 */
	public String getRcptNo() {
		return rcptNo;
	}

	/**
	 * @param rcptNo the rcptNo to set
	 */
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}

	/**
	 * @return the refNo
	 */
	public String getRefNo() {
		return refNo;
	}

	/**
	 * @param refNo the refNo to set
	 */
	public void setRefNo(String refNo) {
		this.refNo = refNo;
	}

	/**
	 * @return the txnAmt
	 */
	public String getTxnAmt() {
		return txnAmt;
	}

	/**
	 * @param txnAmt the txnAmt to set
	 */
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}

	/**
	 * @return the apprDate
	 */
	public String getApprDate() {
		return apprDate;
	}

	/**
	 * @param apprDate the apprDate to set
	 */
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}

	/**
	 * @return the apprTm
	 */
	public String getApprTm() {
		return apprTm;
	}

	/**
	 * @param apprTm the apprTm to set
	 */
	public void setApprTm(String apprTm) {
		this.apprTm = apprTm;
	}

	/**
	 * @return the apprNo
	 */
	public String getApprNo() {
		return apprNo;
	}

	/**
	 * @param apprNo the apprNo to set
	 */
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}

	/**
	 * @return the pntAmt
	 */
	public String getPntAmt() {
		return pntAmt;
	}

	/**
	 * @param pntAmt the pntAmt to set
	 */
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}

	/**
	 * @return the posNo
	 */
	public String getPosNo() {
		return posNo;
	}

	/**
	 * @param posNo the posNo to set
	 */
	public void setPosNo(String posNo) {
		this.posNo = posNo;
	}

	/**
	 * @return the txnStatCd
	 */
	public String getTxnStatCd() {
		return txnStatCd;
	}

	/**
	 * @param txnStatCd the txnStatCd to set
	 */
	public void setTxnStatCd(String txnStatCd) {
		this.txnStatCd = txnStatCd;
	}



	public String getCipherKey() {
		return cipherKey;
	}



	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}



	public String getPntTxnDateType() {
		return pntTxnDateType;
	}



	public void setPntTxnDateType(String pntTxnDateType) {
		this.pntTxnDateType = pntTxnDateType;
	}



	/**
	* @return the excelObj
	*/
	public ExcelExportReqDto getExcelObj() {
		return excelObj;
	}



	/**
	* @param excelObj the excelObj to set
	*/
	public void setExcelObj(ExcelExportReqDto excelObj) {
		this.excelObj = excelObj;
	}
	public String getPntTxnType() {
		return pntTxnType;
	}
	public void setPntTxnType(String pntTxnType) {
		this.pntTxnType = pntTxnType;
	}
	public String getRceptNo() {
		return rceptNo;
	}
	public void setRceptNo(String rceptNo) {
		this.rceptNo = rceptNo;
	}




}
