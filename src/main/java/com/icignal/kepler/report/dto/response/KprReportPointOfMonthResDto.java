package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

import oracle.net.aso.l;

public class KprReportPointOfMonthResDto extends GridPagingItemResDto {
	private String chnlType; //온오프 구분
	private String basePnt ; //기초 포인트
	private String acrlPnt;  //적립포인트
	private String rdmPnt; //사용포인트
	private String extPnt; //소멸 포인트
	private String totPnt;
	private String extOutPnt; //탈회 소멸 포인트
	
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getBasePnt() {
		return basePnt;
	}
	public void setBasePnt(String basePnt) {
		this.basePnt = basePnt;
	}
	public String getAcrlPnt() {
		return acrlPnt;
	}
	public void setAcrlPnt(String acrlPnt) {
		this.acrlPnt = acrlPnt;
	}
	public String getRdmPnt() {
		return rdmPnt;
	}
	public void setRdmPnt(String rdmPnt) {
		this.rdmPnt = rdmPnt;
	}
	public String getExtPnt() {
		return extPnt;
	}
	public void setExtPnt(String extPnt) {
		this.extPnt = extPnt;
	}
	public String getTotPnt() {
		return totPnt;
	}
	public void setTotPnt(String totPnt) {
		this.totPnt = totPnt;
	}
	public String getExtOutPnt() {
		return extOutPnt;
	}
	public void setExtOutPnt(String extOutPnt) {
		this.extOutPnt = extOutPnt;
	} 
}


