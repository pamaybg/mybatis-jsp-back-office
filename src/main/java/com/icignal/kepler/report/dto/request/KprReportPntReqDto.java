package com.icignal.kepler.report.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class KprReportPntReqDto extends CommonDataAuthReqDto {
	
	private String yyyymm;
    private String startDt;
    private String endDt;
    
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	
}
