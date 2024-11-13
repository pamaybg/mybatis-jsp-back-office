package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyCustMbrRelResDto extends GridPagingItemResDto {

	// 기본 필드
	private String createDate;
	private String modifyDate;

	// 코드
	private String statCd;
	@MarkName(groupCode="LOY_MBR_C_REL_STAT_CD", codeField="statCd")
	private String statCdNm;

	// 릴레이션
	private String custNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "cardNum")
	private String cardNo;
	private String brNm;

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

	public String getStatCd() {
		return statCd;
	}

	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

	public String getStatCdNm() {
		return statCdNm;
	}

	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}

	public String getCustNo() {
		return custNo;
	}

	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getBrNm() {
		return brNm;
	}

	public void setBrNm(String brNm) {
		this.brNm = brNm;
	}
}
