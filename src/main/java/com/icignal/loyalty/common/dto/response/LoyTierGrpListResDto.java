package com.icignal.loyalty.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyTierGrpListResDto extends GridPagingItemResDto{

	

     private String tierGrpId; 
     private String tierGrpNm;
     private String pgmNm;
     private String createDate;
     
     
	/**
	 * @return the tierGrpId
	 */
	public String getTierGrpId() {
		return tierGrpId;
	}
	/**
	 * @param tierGrpId the tierGrpId to set
	 */
	public void setTierGrpId(String tierGrpId) {
		this.tierGrpId = tierGrpId;
	}
	/**
	 * @return the tierGrpNm
	 */
	public String getTierGrpNm() {
		return tierGrpNm;
	}
	/**
	 * @param tierGrpNm the tierGrpNm to set
	 */
	public void setTierGrpNm(String tierGrpNm) {
		this.tierGrpNm = tierGrpNm;
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
	 * @return the createDate
	 */
	public String getCreateDate() {
		return createDate;
	}
	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
     
     
     
}
