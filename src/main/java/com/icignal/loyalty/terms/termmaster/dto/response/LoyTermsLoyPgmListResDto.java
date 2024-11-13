package com.icignal.loyalty.terms.termmaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class LoyTermsLoyPgmListResDto extends GridPagingItemResDto{

	private String rid;
	private String pgmNo;
	private String pgmNm;
	private String createBy;
	private String createDate;
	private String modifyBy;
	private String modifyDate;
	@MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "useYnCd")
	private String useYn;
	private String useYnCd;
	//LOY_PGM TABLE CLUMN
	@MarkName(groupCode = "LOY_PGM_STAT_CD", codeField = "statCd")
	private String statCdNm;
	private String statCd;
	
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
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
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getUseYnCd() {
		return useYnCd;
	}
	public void setUseYnCd(String useYnCd) {
		this.useYnCd = useYnCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	
}
