package com.icignal.kepler.report.dto.response;

import java.util.List;

/*
 * 1. 클래스명	: KPRReportAgeCdResponseDTO
 * 2. 파일명	: KPRReportAgeCdResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportAgeCdResDto {
	
	private List<KprReportAgeCdResDto> ageList;
	private String ageCd;
	private String ageNm;
	public String getAgeCd() {
		return ageCd;
	}
	public void setAgeCd(String ageCd) {
		this.ageCd = ageCd;
	}
	public String getAgeNm() {
		return ageNm;
	}
	public void setAgeNm(String ageNm) {
		this.ageNm = ageNm;
	}
	public List<KprReportAgeCdResDto> getAgeList() {
		return ageList;
	}
	public void setAgeList(List<KprReportAgeCdResDto> ageList) {
		this.ageList = ageList;
	}
	
	
	
}
