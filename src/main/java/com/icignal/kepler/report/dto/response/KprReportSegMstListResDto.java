package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportSegMstListResDto  extends GridPagingItemResDto{
	
	
	private String segMstId;
	private String segMstNm;
	public String getSegMstId() {
		return segMstId;
	}
	public void setSegMstId(String segMstId) {
		this.segMstId = segMstId;
	}
	public String getSegMstNm() {
		return segMstNm;
	}
	public void setSegMstNm(String segMstNm) {
		this.segMstNm = segMstNm;
	}
	
	
	

}
