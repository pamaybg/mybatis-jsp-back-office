/**
 *
 */
package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
* @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrPtnTxnHistResponseDTO
* @date : 2017. 10. 19.
* @author : 이성원
* @description :
*/
@CommCode
public class LoyMbrPtnTxnHistResDto  extends GridPagingItemResDto {

	private String txnUniqNo;
	private String apprDate;
	private String pntTxnType1Cd;
	private String pntTxnType2Cd;
	private String pntTxnType3Cd;
	private String pntTxnType4Cd;
	private String mbrNo;
	private String custNm;
	private String memDiv;
	
	@MarkName(groupCode="MEMBER_GRADE", codeField="memGradeCd")
	private String memGrade;
	private String memGradeCd;
	private String pntAmt;
	private String usePnt;
	private String giftPnt;
	private String prodNm;
	private String txnAmt;
	private String chnlNo;
	private String chnlNm;
	private String groupPnt;
	private String rid;
	private String cardNoDecoding;
	private String cardNo;
	private String ridMbr;
	private String promoCnt;
	private String ridMbrCard;
	private String mbrType;
	private String cprtCardCd;
	private String cardKndCd;
	
	@MarkName(groupCode="MEMBER_CARD_CD", codeField="cardKndCd")
	private String cardKndNm;
	private String cprtCard;
	private String ridChnl;
	private String totalPntAvl;
	private String txnDt;
	private String dtlApprNo;
	private String rcptNo;
	private String txnTypeDtlDesc; //거래유형상세 (승인서버에서 입력해주는 값)
	private String validDate; //포인트 유효기간
	private String acrlDesc;
	private String orgnApprNo;
	private String orgnApprDate;
	private String txnStatCd;
	private String apprDateYYYYMMDD;
	private String pntTxnType1code;
	private String pntTxnType2code;
	private String acrlAmt;
	private String rdmAmt;
	
	@MarkName(groupCode="PNT_TXN_STAT_CD", codeField="txnStatCd")
	private String txnStat;
	
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getRdmAmt() {
		return rdmAmt;
	}
	public void setRdmAmt(String rdmAmt) {
		this.rdmAmt = rdmAmt;
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
	public String getTxnStatCd() {
		return txnStatCd;
	}
	public void setTxnStatCd(String txnStatCd) {
		this.txnStatCd = txnStatCd;
	}
	public String getApprDateYYYYMMDD() {
		return apprDateYYYYMMDD;
	}
	public void setApprDateYYYYMMDD(String apprDateYYYYMMDD) {
		this.apprDateYYYYMMDD = apprDateYYYYMMDD;
	}
	public String getPntTxnType1code() {
		return pntTxnType1code;
	}
	public void setPntTxnType1code(String pntTxnType1code) {
		this.pntTxnType1code = pntTxnType1code;
	}
	public String getPntTxnType2code() {
		return pntTxnType2code;
	}
	public void setPntTxnType2code(String pntTxnType2code) {
		this.pntTxnType2code = pntTxnType2code;
	}
	public String getDtlApprNo() {
		return dtlApprNo;
	}
	public void setDtlApprNo(String dtlApprNo) {
		this.dtlApprNo = dtlApprNo;
	}
	public String getTxnUniqNo() {
		return txnUniqNo;
	}
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMemDiv() {
		return memDiv;
	}
	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}
	public String getMemGrade() {
		return memGrade;
	}
	public void setMemGrade(String memGrade) {
		this.memGrade = memGrade;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(String usePnt) {
		this.usePnt = usePnt;
	}
	public String getGiftPnt() {
		return giftPnt;
	}
	public void setGiftPnt(String giftPnt) {
		this.giftPnt = giftPnt;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
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
	public String getGroupPnt() {
		return groupPnt;
	}
	public void setGroupPnt(String groupPnt) {
		this.groupPnt = groupPnt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCardNoDecoding() {
		return cardNoDecoding;
	}
	public void setCardNoDecoding(String cardNoDecoding) {
		this.cardNoDecoding = cardNoDecoding;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getPromoCnt() {
		return promoCnt;
	}
	public void setPromoCnt(String promoCnt) {
		this.promoCnt = promoCnt;
	}
	public String getRidMbrCard() {
		return ridMbrCard;
	}
	public void setRidMbrCard(String ridMbrCard) {
		this.ridMbrCard = ridMbrCard;
	}
	public String getMbrType() {
		return mbrType;
	}
	public void setMbrType(String mbrType) {
		this.mbrType = mbrType;
	}
	public String getCprtCardCd() {
		return cprtCardCd;
	}
	public void setCprtCardCd(String cprtCardCd) {
		this.cprtCardCd = cprtCardCd;
	}
	public String getCardKndNm() {
		return cardKndNm;
	}
	public void setCardKndNm(String cardKndNm) {
		this.cardKndNm = cardKndNm;
	}
	public String getCprtCard() {
		return cprtCard;
	}
	public void setCprtCard(String cprtCard) {
		this.cprtCard = cprtCard;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getTotalPntAvl() {
		return totalPntAvl;
	}
	public void setTotalPntAvl(String totalPntAvl) {
		this.totalPntAvl = totalPntAvl;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getPntTxnType3Cd() {
		return pntTxnType3Cd;
	}
	public void setPntTxnType3Cd(String pntTxnType3Cd) {
		this.pntTxnType3Cd = pntTxnType3Cd;
	}
	public String getPntTxnType4Cd() {
		return pntTxnType4Cd;
	}
	public void setPntTxnType4Cd(String pntTxnType4Cd) {
		this.pntTxnType4Cd = pntTxnType4Cd;
	}
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public String getTxnTypeDtlDesc() {
		return txnTypeDtlDesc;
	}
	public void setTxnTypeDtlDesc(String txnTypeDtlDesc) {
		this.txnTypeDtlDesc = txnTypeDtlDesc;
	}
	public String getValidDate() {
		return validDate;
	}
	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}
	public String getAcrlDesc() {
		return acrlDesc;
	}
	public void setAcrlDesc(String acrlDesc) {
		this.acrlDesc = acrlDesc;
	}
	public String getTxnStat() {
		return txnStat;
	}
	public void setTxnStat(String txnStat) {
		this.txnStat = txnStat;
	}
	public String getMemGradeCd() {
		return memGradeCd;
	}
	public void setMemGradeCd(String memGradeCd) {
		this.memGradeCd = memGradeCd;
	}
	public String getCardKndCd() {
		return cardKndCd;
	}
	public void setCardKndCd(String cardKndCd) {
		this.cardKndCd = cardKndCd;
	}
	
	
	
	
	
}
