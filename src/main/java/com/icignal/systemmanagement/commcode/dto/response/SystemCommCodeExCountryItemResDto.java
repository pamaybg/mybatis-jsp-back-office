package com.icignal.systemmanagement.commcode.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class SystemCommCodeExCountryItemResDto extends StatusResDto {
	private String codeName;
	private String markName;
	private String type;
	
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
