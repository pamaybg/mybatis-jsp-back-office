package com.icignal.marketing.campaignhome.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class CampigPromotionResDto extends GridPagingItemResDto {
	
    private String promId;   
    private String promNo;   
    private String promNm;   
    private String createDate;
    private String createBy;

    private String camId;
    private String camNm;
    private String camStartDd;
    private String camEndDd;

	public String getPromId() {
		return promId;
	}
	public void setPromId(String promId) {
		this.promId = promId;
	}
	public String getPromNo() {
		return promNo;
	}
	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}
	public String getPromNm() {
		return promNm;
	}
	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getCamNm() {
		return camNm;
	}

	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}

	public String getCamStartDd() {
		return camStartDd;
	}

	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}

	public String getCamEndDd() {
		return camEndDd;
	}

	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}
}
