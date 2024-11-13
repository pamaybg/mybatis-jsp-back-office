package com.icignal.loyalty.membershipcard.cardmaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyCardTypeResDto extends GridPagingItemResDto {
	
	private String rid;
	private String ridPgm;
	private String cardKindNo; 
	private String cardKindNm;
	private String createBy;
	private String createDate;

	private String cardType;
	@MarkName(groupCode = "LOY_CARD_TYPE", codeField = "cardType")
	private String cardTypeNm;
	private String makeType;
	@MarkName(groupCode = "LOY_CARD_MAKE_TYPE", codeField = "makeType")
	private String makeTypeNm;

	private String ridTier;
	private String tierNm;
	private String ridClub;
	private String clubNm;
	private String ridChnl;
	private String chnlNm;
	private String binNoRule;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getCardKindNo() {
		return cardKindNo;
	}
	public void setCardKindNo(String cardKindNo) {
		this.cardKindNo = cardKindNo;
	}

	public String getCardKindNm() {
		return cardKindNm;
	}

	public void setCardKindNm(String cardKindNm) {
		this.cardKindNm = cardKindNm;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getCardTypeNm() {
		return cardTypeNm;
	}

	public void setCardTypeNm(String cardTypeNm) {
		this.cardTypeNm = cardTypeNm;
	}

	public String getMakeType() {
		return makeType;
	}
	public void setMakeType(String makeType) {
		this.makeType = makeType;
	}
	public String getMakeTypeNm() {
		return makeTypeNm;
	}
	public void setMakeTypeNm(String makeTypeNm) {
		this.makeTypeNm = makeTypeNm;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getTierNm() {
		return tierNm;
	}

	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	public String getRidTier() {
		return ridTier;
	}

	public void setRidTier(String ridTier) {
		this.ridTier = ridTier;
	}

	public String getRidClub() {
		return ridClub;
	}

	public void setRidClub(String ridClub) {
		this.ridClub = ridClub;
	}

	public String getClubNm() {
		return clubNm;
	}

	public void setClubNm(String clubNm) {
		this.clubNm = clubNm;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getBinNoRule() {
		return binNoRule;
	}

	public void setBinNoRule(String binNoRule) {
		this.binNoRule = binNoRule;
	}
}