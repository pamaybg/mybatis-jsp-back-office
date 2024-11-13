package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;



/**
 * @name : infavor.voc.requestConsultation.dto.response.VOCGetRgstCardListResponseDTO
 * @date : 2018. 1. 27.
 * @author : jun.lee
 * @description : 포인트카드 목록 조회
 */

@PersonalData
public class VocGetRgstCardListResDto extends GridPagingItemResDto {
	
	private String rid;
	private String mbrRid;
	@Decrypted(masked = "cardNum")
	private String cardNo;
	private String cardKndNm;
	private String cprtCard;	
	private String stat;
	private String regChnlCd;
	private String createDate;
	private String createBy;
	private String loseDt;
	private String loseTrTr;
	private String cardLeavDate;
	private String cardPw;
	private String statCd;
	private String mbrType;
	private String cprtCardCd;
	private String cprtCardItemCd;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
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
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getRegChnlCd() {
		return regChnlCd;
	}
	public void setRegChnlCd(String regChnlCd) {
		this.regChnlCd = regChnlCd;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getLoseDt() {
		return loseDt;
	}
	public void setLoseDt(String loseDt) {
		this.loseDt = loseDt;
	}
	public String getLoseTrTr() {
		return loseTrTr;
	}
	public void setLoseTrTr(String loseTrTr) {
		this.loseTrTr = loseTrTr;
	}
	public String getCardLeavDate() {
		return cardLeavDate;
	}
	public void setCardLeavDate(String cardLeavDate) {
		this.cardLeavDate = cardLeavDate;
	}
	public String getCardPw() {
		return cardPw;
	}
	public void setCardPw(String cardPw) {
		this.cardPw = cardPw;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
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
	public String getCprtCardItemCd() {
		return cprtCardItemCd;
	}
	public void setCprtCardItemCd(String cprtCardItemCd) {
		this.cprtCardItemCd = cprtCardItemCd;
	}
	
}