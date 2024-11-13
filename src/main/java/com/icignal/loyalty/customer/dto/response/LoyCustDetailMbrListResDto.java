package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class LoyCustDetailMbrListResDto  extends GridPagingItemResDto{

	private String rid;
	private String mbrNo;
	private String pgmNm;
	@MarkName(groupCode = "LOY_MBR_STAT_CD", codeField = "mbrStatCd")
	private String mbrStat;
	private String mbrStatCd;
	private String sbscDate;
	private String chnlNm;
	private String sbscPathCd;
	@MarkName(groupCode = "LOY_SBSC_PATH_CD", codeField = "sbscPathCd")
	private String sbscPathCdNm;
	private String mcardNo;
	
	
	public String getSbscPathCd() {
		return sbscPathCd;
	}
	public void setSbscPathCd(String sbscPathCd) {
		this.sbscPathCd = sbscPathCd;
	}
	public String getSbscPathCdNm() {
		return sbscPathCdNm;
	}
	public void setSbscPathCdNm(String sbscPathCdNm) {
		this.sbscPathCdNm = sbscPathCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}
	public String getMbrStat() {
		return mbrStat;
	}
	public void setMbrStat(String mbrStat) {
		this.mbrStat = mbrStat;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getMcardNo() {
		return mcardNo;
	}
	public void setMcardNo(String mcardNo) {
		this.mcardNo = mcardNo;
	}
}
