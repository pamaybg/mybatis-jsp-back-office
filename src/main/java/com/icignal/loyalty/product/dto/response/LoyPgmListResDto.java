package com.icignal.loyalty.product.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class LoyPgmListResDto extends GridPagingItemResDto{
	/** RID */
	private String rid;

	/** 프로그램 번호 */
	private String pgmNo;

	/** 프로그램 명 */
	private String pgmNm;

	/** 유효 시작 일자 */
	private String validStartDate;
	
	
	@MarkName(groupCode = "LOY_PGM_STAT_CD", codeField = "pgmStat")
	private String pgmStatNm; 				/* 프로그램 상태명 */
	private String pgmStat;             	/* 프로그램 상태 */
	
	private String modifyDate;
	private String modifyBy;
	private String chnlNm;
	private String repYn;
	
	public String getRepYn() {
		return repYn;
	}

	public void setRepYn(String repYn) {
		this.repYn = repYn;
	}

	/**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}

	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}

	/**
	 * @return the pgmNo
	 */
	public String getPgmNo() {
		return pgmNo;
	}

	/**
	 * @param pgmNo the pgmNo to set
	 */
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}

	/**
	 * @return the pgmNm
	 */
	public String getPgmNm() {
		return pgmNm;
	}

	/**
	 * @param pgmNm the pgmNm to set
	 */
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

	/**
	 * @return the validStartDate
	 */
	public String getValidStartDate() {
		return validStartDate;
	}

	/**
	 * @param validStartDate the validStartDate to set
	 */
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}

	public String getPgmStatNm() {
		return pgmStatNm;
	}

	public void setPgmStatNm(String pgmStatNm) {
		this.pgmStatNm = pgmStatNm;
	}

	public String getPgmStat() {
		return pgmStat;
	}

	public void setPgmStat(String pgmStat) {
		this.pgmStat = pgmStat;
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

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}


}
