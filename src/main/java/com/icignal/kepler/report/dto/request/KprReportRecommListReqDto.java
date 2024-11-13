package com.icignal.kepler.report.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class KprReportRecommListReqDto extends CommonDataAuthReqDto {
	
	private String startDt;	 	  
	private String endDt;	 	  
	private String mbrType;
	private String mbrMgtAttr;
	private String mbrMgtAttrVal;
	@Encrypted
	private String mbrNm;	// 회원명(추천자명)
	
	private String rcmmdNo;

	
	
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

	public String getMbrType() {
		return mbrType;
	}

	public void setMbrType(String mbrType) {
		this.mbrType = mbrType;
	}

	public String getMbrMgtAttr() {
		return mbrMgtAttr;
	}

	public void setMbrMgtAttr(String mbrMgtAttr) {
		this.mbrMgtAttr = mbrMgtAttr;
	}

	public String getMbrMgtAttrVal() {
		return mbrMgtAttrVal;
	}

	public void setMbrMgtAttrVal(String mbrMgtAttrVal) {
		this.mbrMgtAttrVal = mbrMgtAttrVal;
	}

	public String getMbrNm() {
		return mbrNm;
	}

	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
	}

	public String getRcmmdNo() {
		return rcmmdNo;
	}

	public void setRcmmdNo(String rcmmdNo) {
		this.rcmmdNo = rcmmdNo;
	}
	

}
