package com.icignal.loyalty.custdi.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@PersonalData
@CommCode
public class LoyCustDupRstResDto extends GridPagingItemResDto{

	private String rid;
	@Decrypted(masked = "none")
	private String tgtCustNm;
	@Decrypted(masked = "none")
	private String similrCustNm;
	private String tgtCustNo;
	private String similrCustNo;
	@MarkName(groupCode = "LOY_CUST_MRG_TYPE_CD", codeField = "mrgTypeCd")
	private String mrgTypeCdNm;
	private String mrgTypeCd;
	@MarkName(groupCode = "LOY_CUST_DUP_PROC_STAT_CD", codeField = "statCd")
	private String statCdNm;
	private String statCd;
	private String createDate;
	private String score;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTgtCustNm() {
		return tgtCustNm;
	}
	public void setTgtCustNm(String tgtCustNm) {
		this.tgtCustNm = tgtCustNm;
	}
	public String getSimilrCustNm() {
		return similrCustNm;
	}
	public void setSimilrCustNm(String similrCustNm) {
		this.similrCustNm = similrCustNm;
	}
	public String getTgtCustNo() {
		return tgtCustNo;
	}
	public void setTgtCustNo(String tgtCustNo) {
		this.tgtCustNo = tgtCustNo;
	}
	public String getSimilrCustNo() {
		return similrCustNo;
	}
	public void setSimilrCustNo(String similrCustNo) {
		this.similrCustNo = similrCustNo;
	}
	public String getMrgTypeCd() {
		return mrgTypeCd;
	}
	public void setMrgTypeCd(String mrgTypeCd) {
		this.mrgTypeCd = mrgTypeCd;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getMrgTypeCdNm() {
		return mrgTypeCdNm;
	}
	public void setMrgTypeCdNm(String mrgTypeCdNm) {
		this.mrgTypeCdNm = mrgTypeCdNm;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	
}
