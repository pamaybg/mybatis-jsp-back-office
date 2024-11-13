package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyPgmFmlyPlcyResDto extends GridPagingItemResDto {

	// 기본 필드
	private int maxNum;            	 		/* 최대인원수 */
	private int minNum;			  	  		/* 최소인원수 */
	private int recrDelayNum;		  		/* 재가입 제한 월*/
	private String pntShareYn;				/* 포인트 합산 사용여부 */
	private String tierShareYn;				/* 패밀리내 최고 등급 공유 */

	// 시스템
	private String rid;             	 	/* RID */
	private String modifyDate;             	/* 수정일시 */
	private String modifyBy;             	/* 수정자 */
	
	public int getMaxNum() {
		return maxNum;
	}
	public void setMaxNum(int maxNum) {
		this.maxNum = maxNum;
	}
	public int getMinNum() {
		return minNum;
	}
	public void setMinNum(int minNum) {
		this.minNum = minNum;
	}
	public int getRecrDelayNum() {
		return recrDelayNum;
	}
	public void setRecrDelayNum(int recrDelayNum) {
		this.recrDelayNum = recrDelayNum;
	}
	public String getPntShareYn() {
		return pntShareYn;
	}
	public void setPntShareYn(String pntShareYn) {
		this.pntShareYn = pntShareYn;
	}
	public String getTierShareYn() {
		return tierShareYn;
	}
	public void setTierShareYn(String tierShareYn) {
		this.tierShareYn = tierShareYn;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
