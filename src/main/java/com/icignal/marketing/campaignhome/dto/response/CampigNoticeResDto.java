package com.icignal.marketing.campaignhome.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class CampigNoticeResDto extends GridPagingItemResDto {
	
    private String segId;   
    private String segNm;   
    private String modifyDate;
    
	public String getSegId() {
		return segId;
	}
	public void setSegId(String segId) {
		this.segId = segId;
	}
	public String getSegNm() {
		return segNm;
	}
	public void setSegNm(String segNm) {
		this.segNm = segNm;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}   
}
