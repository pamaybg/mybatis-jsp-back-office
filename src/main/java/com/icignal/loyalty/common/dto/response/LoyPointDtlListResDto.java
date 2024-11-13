package com.icignal.loyalty.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 
* <pre>
* infavor.loyalty.point.dto.response
*  |_ LOYgetPointListResponseDTO.java
* </pre>
* @작성일		: 2017. 2. 04. 
* @작성자		: 이성원  
* @프로그램설명	: 포인트 이력 조회
 */
public class LoyPointDtlListResDto extends GridPagingItemResDto {

    private String rid;                 //RID
    private String ridChnl;
    private String ridPgm;
    private String ridMbr;
    private String txnDate;
    private String txnTime;
    private String custNm;
    private String birthDt;
    private String mbrStatCd;
    private String pntTxnType1;
    private String pntTxnType2;
    private String txnAmt;
    private String pntAmt;
    private String rcptNo;
    private String txnStatCd;
    private String apprNo;
    private String apprDate;
    private String apprTm;
    private String orgnApprNo;
    private String orgnApprDate;
    private String posNo;
    private String chnlNm;
    private String txnUniqNo;
    private String pgmNm;
    private String offerType;
    private String offerSubType;
    private String txnTypeDtlDesc;

    private String camNm;           // 캠페인명
    private String offerNm;         // 오퍼명
    private String offerTypeCd;     // 오퍼유형
    private String validStartDate;  // 유효기간 시작일자
    private String validEndDate;    // 유효기간 종료일자
    private String acrlAmt;         // 포인트
    private String giftPntYn;       // 선물가능여부
    private String offerTypeCdNm;   // 오퍼 유형명
    
    private String pntAccntBigTypeCdNm; //지급계정 대분류
    private String pntAccntMidTypeCdNm; //지급계정 중분류
    private String pntAccntSmlTypeCdNm; //지급계정 소분류
    private String pntAccntDetailTypeCdNm; //지급계정 세분류
    private String validDate; //포인트 유효기간

    public String getOfferTypeCdNm() {
        return offerTypeCdNm;
    }
    public void setOfferTypeCdNm(String offerTypeCdNm) {
        this.offerTypeCdNm = offerTypeCdNm;
    }
    public String getCamNm() {
        return camNm;
    }
    public void setCamNm(String camNm) {
        this.camNm = camNm;
    }
    public String getOfferNm() {
        return offerNm;
    }
    public void setOfferNm(String offerNm) {
        this.offerNm = offerNm;
    }
    public String getOfferTypeCd() {
        return offerTypeCd;
    }
    public void setOfferTypeCd(String offerTypeCd) {
        this.offerTypeCd = offerTypeCd;
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
    public String getAcrlAmt() {
        return acrlAmt;
    }
    public void setAcrlAmt(String acrlAmt) {
        this.acrlAmt = acrlAmt;
    }
    public String getGiftPntYn() {
        return giftPntYn;
    }
    public void setGiftPntYn(String giftPntYn) {
        this.giftPntYn = giftPntYn;
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
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getPntTxnType1() {
		return pntTxnType1;
	}
	public void setPntTxnType1(String pntTxnType1) {
		this.pntTxnType1 = pntTxnType1;
	}
	public String getPntTxnType2() {
		return pntTxnType2;
	}
	public void setPntTxnType2(String pntTxnType2) {
		this.pntTxnType2 = pntTxnType2;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public String getTxnStatCd() {
		return txnStatCd;
	}
	public void setTxnStatCd(String txnStatCd) {
		this.txnStatCd = txnStatCd;
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
	public String getApprTm() {
		return apprTm;
	}
	public void setApprTm(String apprTm) {
		this.apprTm = apprTm;
	}
	public String getOrgnApprNo() {
		return orgnApprNo;
	}
	public void setOrgnApprNo(String orgnApprNo) {
		this.orgnApprNo = orgnApprNo;
	}
	public String getOrgnApprDate() {
		return orgnApprDate;
	}
	public void setOrgnApprDate(String orgnApprDate) {
		this.orgnApprDate = orgnApprDate;
	}
	public String getPosNo() {
		return posNo;
	}
	public void setPosNo(String posNo) {
		this.posNo = posNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getTxnUniqNo() {
		return txnUniqNo;
	}
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getOfferSubType() {
		return offerSubType;
	}
	public void setOfferSubType(String offerSubType) {
		this.offerSubType = offerSubType;
	}
	public String getTxnTypeDtlDesc() {
		return txnTypeDtlDesc;
	}
	public void setTxnTypeDtlDesc(String txnTypeDtlDesc) {
		this.txnTypeDtlDesc = txnTypeDtlDesc;
	}
	public String getPntAccntBigTypeCdNm() {
		return pntAccntBigTypeCdNm;
	}
	public void setPntAccntBigTypeCdNm(String pntAccntBigTypeCdNm) {
		this.pntAccntBigTypeCdNm = pntAccntBigTypeCdNm;
	}
	public String getPntAccntMidTypeCdNm() {
		return pntAccntMidTypeCdNm;
	}
	public void setPntAccntMidTypeCdNm(String pntAccntMidTypeCdNm) {
		this.pntAccntMidTypeCdNm = pntAccntMidTypeCdNm;
	}
	public String getPntAccntSmlTypeCdNm() {
		return pntAccntSmlTypeCdNm;
	}
	public void setPntAccntSmlTypeCdNm(String pntAccntSmlTypeCdNm) {
		this.pntAccntSmlTypeCdNm = pntAccntSmlTypeCdNm;
	}
	public String getPntAccntDetailTypeCdNm() {
		return pntAccntDetailTypeCdNm;
	}
	public void setPntAccntDetailTypeCdNm(String pntAccntDetailTypeCdNm) {
		this.pntAccntDetailTypeCdNm = pntAccntDetailTypeCdNm;
	}
	public String getValidDate() {
		return validDate;
	}
	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}       
	
}