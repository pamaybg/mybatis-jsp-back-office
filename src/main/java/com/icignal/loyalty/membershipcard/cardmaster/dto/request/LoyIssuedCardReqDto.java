package com.icignal.loyalty.membershipcard.cardmaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
* <pre>
* infavor.loyalty.membership.card.dto.request
*  |_ LOYgetCardListRequestDTO.java
* </pre>
* @작성일		: 2017. 1. 3. 
* @작성자		: wjlee 
* @프로그램설명	: 카드유형 RequestDTO
 */
		
public class LoyIssuedCardReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String ridCardKind;
	private String mbrCardRid;
	private String cardQnumRid;
	private String cipherKey;
	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidCardKind() {
		return ridCardKind;
	}

	public void setRidCardKind(String ridCardKind) {
		this.ridCardKind = ridCardKind;
	}

	public String getMbrCardRid() {
		return mbrCardRid;
	}

	public void setMbrCardRid(String mbrCardRid) {
		this.mbrCardRid = mbrCardRid;
	}

	public String getCardQnumRid() {
		return cardQnumRid;
	}

	public void setCardQnumRid(String cardQnumRid) {
		this.cardQnumRid = cardQnumRid;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
}