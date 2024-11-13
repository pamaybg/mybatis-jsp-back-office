package com.icignal.kepler.report.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRReportCampaignReactionRequestDTO
 * 2. 파일명	: KPRReportCampaignReactionRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportCampaignReactionReqDto extends CommonDataAuthReqDto{
	private String yyyymm;
	private String endyyyymm;
	private String camId; 
	private String ageCd;
	private String timeCd;
	private String genCd;
	private String startDd;
	private String endDd;
	
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getEndyyyymm() {
		return endyyyymm;
	}
	public void setEndyyyymm(String endyyyymm) {
		this.endyyyymm = endyyyymm;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getAgeCd() {
		return ageCd;
	}
	public void setAgeCd(String ageCd) {
		this.ageCd = ageCd;
	}
	public String getTimeCd() {
		return timeCd;
	}
	public void setTimeCd(String timeCd) {
		this.timeCd = timeCd;
	}
	public String getGenCd() {
		return genCd;
	}
	public void setGenCd(String genCd) {
		this.genCd = genCd;
	}
	public String getStartDd() {
		return startDd;
	}
	public void setStartDd(String startDd) {
		this.startDd = startDd;
	}
	public String getEndDd() {
		return endDd;
	}
	public void setEndDd(String endDd) {
		this.endDd = endDd;
	}

}
