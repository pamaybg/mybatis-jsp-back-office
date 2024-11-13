package com.icignal.loyalty.membershipcard.cardmaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
* @name : 
* @date : 
* @author : 
* @description :
*/
@CommCode
public class LoyCardNoPoolResDto extends GridPagingItemResDto{

	private String rid;
	private String createDate;
	private String modifyDate;
	private String ridCardKind;
	private String cardNo;
	private String statCd;
	@MarkName(groupCode = "LOY_CARD_NO_STAT_CD", codeField = "statCd")
	private String statNm;
	private String regDt;
	private String title;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getRidCardKind() {
		return ridCardKind;
	}

	public void setRidCardKind(String ridCardKind) {
		this.ridCardKind = ridCardKind;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getStatCd() {
		return statCd;
	}

	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

	public String getStatNm() {
		return statNm;
	}

	public void setStatNm(String statNm) {
		this.statNm = statNm;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
