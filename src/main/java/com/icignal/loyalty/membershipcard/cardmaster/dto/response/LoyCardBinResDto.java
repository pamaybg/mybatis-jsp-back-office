package com.icignal.loyalty.membershipcard.cardmaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : 
* @date : 
* @author : 
* @description :
*/
public class LoyCardBinResDto extends GridPagingItemResDto {

	private String rid;
	private String ridCardKind;
	private String startNo;
	private String endNo;
	private String validEndDt;
	private String modifyBy;
	private String modifyDate;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidCardKind() {
		return ridCardKind;
	}

	public void setRidCardKind(String ridCardKind) {
		this.ridCardKind = ridCardKind;
	}

	public String getStartNo() {
		return startNo;
	}

	public void setStartNo(String startNo) {
		this.startNo = startNo;
	}

	public String getEndNo() {
		return endNo;
	}

	public void setEndNo(String endNo) {
		this.endNo = endNo;
	}

	public String getValidEndDt() {
		return validEndDt;
	}

	public void setValidEndDt(String validEndDt) {
		this.validEndDt = validEndDt;
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
}
