package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MenuProgListResDto extends GridPagingItemResDto {
	
	private String applyType;
	private String progNum;
	private String progName;
	private String progPath;
	private String progType;
	
	
	public String getApplyType() {
		return applyType;
	}
	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}
	public String getProgNum() {
		return progNum;
	}
	public void setProgNum(String progNum) {
		this.progNum = progNum;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}

}
