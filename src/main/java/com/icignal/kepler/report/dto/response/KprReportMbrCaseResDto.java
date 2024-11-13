package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRReportMbrCaseResponseDTO
 * 2. 파일명	: KPRReportMbrCaseResponseDTO.java
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
public class KprReportMbrCaseResDto extends GridPagingItemResDto{
	
	private String typeA; 
	private String typeB;
	private String mon0m       ;
	private String mon1m       ;
	private String mon1mRate   ;
	private String mon12m      ;
	private String mon12mRate  ;
	private String seq;
	
	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTypeA() {
		return typeA;
	}
	public void setTypeA(String typeA) {
		this.typeA = typeA;
	}
	public String getTypeB() {
		return typeB;
	}
	public void setTypeB(String typeB) {
		this.typeB = typeB;
	}
	public String getMon0m() {
		return mon0m;
	}
	public void setMon0m(String mon0m) {
		this.mon0m = mon0m;
	}
	public String getMon1m() {
		return mon1m;
	}
	public void setMon1m(String mon1m) {
		this.mon1m = mon1m;
	}
	public String getMon1mRate() {
		return mon1mRate;
	}
	public void setMon1mRate(String mon1mRate) {
		this.mon1mRate = mon1mRate;
	}
	public String getMon12m() {
		return mon12m;
	}
	public void setMon12m(String mon12m) {
		this.mon12m = mon12m;
	}
	public String getMon12mRate() {
		return mon12mRate;
	}
	public void setMon12mRate(String mon12mRate) {
		this.mon12mRate = mon12mRate;
	}
}
