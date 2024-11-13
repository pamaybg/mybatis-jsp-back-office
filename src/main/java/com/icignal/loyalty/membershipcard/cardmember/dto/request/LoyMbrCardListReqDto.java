/**
 *
 */
package com.icignal.loyalty.membershipcard.cardmember.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;




/**
* @name : infavor.loyalty.member.mbr.dto.request.LOYMbrOrangeCardRequestDTO
* @date : 2017. 10. 18.
* @author : 이성원
* @description :
*/
public class LoyMbrCardListReqDto  extends CommonDataAuthReqDto {

	/** RID_MEM */
	private String rid;
	private String ridMbr;
	private String cipherKey;
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

	
	public LoyMbrCardListReqDto(){
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
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

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCardPw() {
		return cardPw;
	}

	public void setCardPw(String cardPw) {
		this.cardPw = cardPw;
	}






}
