/**
 *
 */
package com.icignal.loyalty.membershipcard.cardmember.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;



/**
* @name : infavor.loyalty.member.mbr.dto.response.LOYMbrOrangeCardResponseDTO
* @date : 2017. 10. 18.
* @author : 이성원
* @description :
*/
@SuppressWarnings("serial")
@CommCode
@PersonalData
public class LoyMbrCardListResDto  extends GridPagingItemResDto {
 
	private String rid;
	private String mbrRid;
	@Decrypted(masked = "cardNum")
	private String cardNo;
	private String cardKndNm;
	@MarkName(groupCode="CARD_CORP_TYPE", codeField="cprtCardCd")
	private String cprtCard;	
	@MarkName(groupCode="MEMBER_CARD_STATUS", codeField="statCd")
	private String stat;
	@MarkName(groupCode="CARD_REGIST_CHANNEL", codeField="regChnlTypeCd")
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
	@MarkName(groupCode="CARD_CORP_ITEM", codeField="cprtCardItemTypeCd")
	private String cprtCardItemCd;
	private String regChnlTypeCd;
	private String cprtCardItemTypeCd;
	
	
	
	public String getCprtCardItemTypeCd() {
		return cprtCardItemTypeCd;
	}
	public void setCprtCardItemTypeCd(String cprtCardItemTypeCd) {
		this.cprtCardItemTypeCd = cprtCardItemTypeCd;
	}
	public String getRegChnlTypeCd() {
		return regChnlTypeCd;
	}
	public void setRegChnlTypeCd(String regChnlTypeCd) {
		this.regChnlTypeCd = regChnlTypeCd;
	}
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
