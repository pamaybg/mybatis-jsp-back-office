package com.icignal.kepler.customerSegment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class CustSegReqDto extends CommonDataAuthReqDto {


	private String rid;
	private String csegHadId;
	private String csegNm;
	private String csegTypeCd;
	private String csegTypeNm;
	private String csegStatusCd;
	
	private String aplyStartDd;
	private String aplyEndDd;
	private String csegInfoDesc;
	private String csegCyclTypeCd;
	
	private String todayDate;


	

	public String getRid() {
		return rid;
	}

	public String getCsegHadId() {
		return csegHadId;
	}

	public void setCsegHadId(String csegHadId) {
		this.csegHadId = csegHadId;
	}

	public String getCsegNm() {
		return csegNm;
	}

	public void setCsegNm(String csegNm) {
		this.csegNm = csegNm;
	}

	public String getCsegTypeCd() {
		return csegTypeCd;
	}

	public void setCsegTypeCd(String csegTypeCd) {
		this.csegTypeCd = csegTypeCd;
	}

	public String getCsegTypeNm() {
		return csegTypeNm;
	}

	public void setCsegTypeNm(String csegTypeNm) {
		this.csegTypeNm = csegTypeNm;
	}

	public String getCsegStatusCd() {
		return csegStatusCd;
	}

	public void setCsegStatusCd(String csegStatusCd) {
		this.csegStatusCd = csegStatusCd;
	}

	public String getAplyStartDd() {
		return aplyStartDd;
	}

	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}

	public String getAplyEndDd() {
		return aplyEndDd;
	}

	public void setAplyEndDd(String aplyEndDd) {
		this.aplyEndDd = aplyEndDd;
	}

	public String getCsegInfoDesc() {
		return csegInfoDesc;
	}

	public void setCsegInfoDesc(String csegInfoDesc) {
		this.csegInfoDesc = csegInfoDesc;
	}

	public String getCsegCyclTypeCd() {
		return csegCyclTypeCd;
	}

	public void setCsegCyclTypeCd(String csegCyclTypeCd) {
		this.csegCyclTypeCd = csegCyclTypeCd;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getTodayDate() {
		return todayDate;
	}

	public void setTodayDate(String todayDate) {
		this.todayDate = todayDate;
	}
	
	
	


}
