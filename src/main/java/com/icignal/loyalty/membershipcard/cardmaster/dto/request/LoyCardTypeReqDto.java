package com.icignal.loyalty.membershipcard.cardmaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCardTypeReqDto extends CommonDataAuthReqDto {

	private String rid;

	private String cardKindNm;

	private String cardType;
	private String makeType;

	private String ridTier;
	private String ridClub;
	private String ridChnl;
	private String binNoRule;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
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

	public String getMakeType() {
		return makeType;
	}

	public void setMakeType(String makeType) {
		this.makeType = makeType;
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

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getBinNoRule() {
		return binNoRule;
	}

	public void setBinNoRule(String binNoRule) {
		this.binNoRule = binNoRule;
	}
}