package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class AuthGroupDivisionListResDto extends GridPagingItemResDto {
	
	private String accId;
	private String accName;
	private String accDesc;
	private String accType;
	private String accCreater;
	private String accCreateDate;
	private String id;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccId() {
		return accId;
	}
	public void setAccId(String accId) {
		this.accId = accId;
	}
	public String getAccName() {
		return accName;
	}
	public void setAccName(String accName) {
		this.accName = accName;
	}
	public String getAccDesc() {
		return accDesc;
	}
	public void setAccDesc(String accDesc) {
		this.accDesc = accDesc;
	}
	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	public String getAccCreater() {
		return accCreater;
	}
	public void setAccCreater(String accCreater) {
		this.accCreater = accCreater;
	}
	public String getAccCreateDate() {
		return accCreateDate;
	}
	public void setAccCreateDate(String accCreateDate) {
		this.accCreateDate = accCreateDate;
	}
}
