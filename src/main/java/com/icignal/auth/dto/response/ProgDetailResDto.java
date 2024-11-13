package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class ProgDetailResDto extends StatusResDto {

	private String progNo;
	private String progName;
	private String progType;
	private String progPath;
	private String progCreater;
	private String progCreateDate;
	
	
	public String getProgNo() {
		return progNo;
	}
	public void setProgNo(String progNo) {
		this.progNo = progNo;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getProgCreater() {
		return progCreater;
	}
	public void setProgCreater(String progCreater) {
		this.progCreater = progCreater;
	}
	public String getProgCreateDate() {
		return progCreateDate;
	}
	public void setProgCreateDate(String progCreateDate) {
		this.progCreateDate = progCreateDate;
	}
	
	
}
