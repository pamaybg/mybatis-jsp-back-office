package com.icignal.loyalty.membershipcard.cardmaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyIssuedCardResDto extends GridPagingItemResDto {

	private String cardNo;
	private String cardKindNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	private String memDiv;
	private String mbrNo;
	private String ecommMbrNo;
	private String cprtCardCd;
	private String stat;
	@MarkName(groupCode = "LOY_CARD_MBR_STAT_CD", codeField = "stat")
	private String statNm;
	private String regDt;
	private String apvSrvrTrmStatusCd;
	private String loseDt;
	private String leavDate;
	private String ridCardKind;
	private String ridMbr;
	private String ridCust;
	private String rid;
	private String cprtCardCdCode;
	private String cardTypeCd;
	private String promoCnt;
	private String cprtCardItemCd;
	private String issueDate;
	private String chnlNm;
	private String createDate;
	private String modifyDate;
	private String modifyBy;

	public String getEcommMbrNo() {
		return ecommMbrNo;
	}
	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getCardKindNo() {
		return cardKindNo;
	}
	public void setCardKindNo(String cardKindNo) {
		this.cardKindNo = cardKindNo;
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
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCprtCardCd() {
		return cprtCardCd;
	}
	public void setCprtCardCd(String cprtCardCd) {
		this.cprtCardCd = cprtCardCd;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getApvSrvrTrmStatusCd() {
		return apvSrvrTrmStatusCd;
	}
	public void setApvSrvrTrmStatusCd(String apvSrvrTrmStatusCd) {
		this.apvSrvrTrmStatusCd = apvSrvrTrmStatusCd;
	}
	public String getLoseDt() {
		return loseDt;
	}
	public void setLoseDt(String loseDt) {
		this.loseDt = loseDt;
	}

	public String getLeavDate() {
		return leavDate;
	}

	public void setLeavDate(String leavDate) {
		this.leavDate = leavDate;
	}

	public String getRidCardKind() {
		return ridCardKind;
	}
	public void setRidCardKind(String ridCardKind) {
		this.ridCardKind = ridCardKind;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCprtCardCdCode() {
		return cprtCardCdCode;
	}
	public void setCprtCardCdCode(String cprtCardCdCode) {
		this.cprtCardCdCode = cprtCardCdCode;
	}
	public String getCardTypeCd() {
		return cardTypeCd;
	}
	public void setCardTypeCd(String cardTypeCd) {
		this.cardTypeCd = cardTypeCd;
	}
	public String getPromoCnt() {
		return promoCnt;
	}
	public void setPromoCnt(String promoCnt) {
		this.promoCnt = promoCnt;
	}
	public String getCprtCardItemCd() {
		return cprtCardItemCd;
	}
	public void setCprtCardItemCd(String cprtCardItemCd) {
		this.cprtCardItemCd = cprtCardItemCd;
	}

	public String getStatNm() {
		return statNm;
	}

	public void setStatNm(String statNm) {
		this.statNm = statNm;
	}

	public String getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
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

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
}
