package com.icignal.systemmanagement.job.dto.response;

import java.util.Date;

public class SystemLogDtlItemForExcelResDto {

	private Date logDttm;
	private String logTypeCd;
	private String sbsqntJobNm;
	private String logContent;

	public Date getLogDttm() {
		return logDttm;
	}
	public void setLogDttm(Date logDttm) {
		this.logDttm = logDttm;
	}
	public String getLogTypeCd() {
		return logTypeCd;
	}
	public void setLogTypeCd(String logTypeCd) {
		this.logTypeCd = logTypeCd;
	}
	public String getSbsqntJobNm() {
		return sbsqntJobNm;
	}
	public void setSbsqntJobNm(String sbsqntJobNm) {
		this.sbsqntJobNm = sbsqntJobNm;
	}
	public String getLogContent() {
		return logContent;
	}
	public void setLogContent(String logContent) {
		this.logContent = logContent;
	}

}
