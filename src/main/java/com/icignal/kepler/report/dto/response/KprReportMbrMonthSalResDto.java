package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRReportMbrMonthSalResponseDTO
 * 2. 파일명	: KPRReportMbrMonthSalResponseDTO.java
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
public class KprReportMbrMonthSalResDto extends GridPagingItemResDto{

	private String seq;
	private String typea;
	private String typeb;
	private String month0m;
	private String month1m;
	private String month12m;
	private String month1mRate;
	private String month12mRate;
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTypea() {
		return typea;
	}
	public void setTypea(String typea) {
		this.typea = typea;
	}
	public String getTypeb() {
		return typeb;
	}
	public void setTypeb(String typeb) {
		this.typeb = typeb;
	}
	public String getMonth0m() {
		return month0m;
	}
	public void setMonth0m(String month0m) {
		this.month0m = month0m;
	}
	public String getMonth1m() {
		return month1m;
	}
	public void setMonth1m(String month1m) {
		this.month1m = month1m;
	}
	public String getMonth12m() {
		return month12m;
	}
	public void setMonth12m(String month12m) {
		this.month12m = month12m;
	}
	public String getMonth1mRate() {
		return month1mRate;
	}
	public void setMonth1mRate(String month1mRate) {
		this.month1mRate = month1mRate;
	}
	public String getMonth12mRate() {
		return month12mRate;
	}
	public void setMonth12mRate(String month12mRate) {
		this.month12mRate = month12mRate;
	}
	
}
