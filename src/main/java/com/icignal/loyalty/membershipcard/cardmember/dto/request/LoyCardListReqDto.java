package com.icignal.loyalty.membershipcard.cardmember.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.orangeCard.rgst.dto.request.LOYRgstCardListRequestDTO
* @date : 2017. 12. 6.
* @author : kimjunki
* @description :
*/
public class LoyCardListReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String cipherKey;
	private String ridMbr;
	private String searchCondIsYN;
	private String cardNo;
	private String mbrRidFlag;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getSearchCondIsYN() {
		return searchCondIsYN;
	}

	public void setSearchCondIsYN(String searchCondIsYN) {
		this.searchCondIsYN = searchCondIsYN;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getMbrRidFlag() {
		return mbrRidFlag;
	}

	public void setMbrRidFlag(String mbrRidFlag) {
		this.mbrRidFlag = mbrRidFlag;
	}



}
