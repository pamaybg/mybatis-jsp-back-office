package com.icignal.kepler.analysis.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;


/*
 * 1. 클래스명	: KPRAnalysisListByCustTierResponseDTO
 * 2. 파일명	: KPRAnalysisListByCustTierResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisListByCustTierResDto extends StatusResDto {
	
	private String ymonthcd;
	private String memtypecd;
	private String memtypenm;
	private String memgradecd;
	private String memgradenm;
	private String memactivecnt;
	private String memactivecnt2;
	private String totactivecnt;
	private String rate;
	private String fillvolt;
	
	public String getYmonthcd() {
		return ymonthcd;
	}
	public void setYmonthcd(String ymonthcd) {
		this.ymonthcd = ymonthcd;
	}
	public String getMemtypecd() {
		return memtypecd;
	}
	public void setMemtypecd(String memtypecd) {
		this.memtypecd = memtypecd;
	}
	public String getMemtypenm() {
		return memtypenm;
	}
	public void setMemtypenm(String memtypenm) {
		this.memtypenm = memtypenm;
	}
	public String getMemgradecd() {
		return memgradecd;
	}
	public void setMemgradecd(String memgradecd) {
		this.memgradecd = memgradecd;
	}
	public String getMemgradenm() {
		return memgradenm;
	}
	public void setMemgradenm(String memgradenm) {
		this.memgradenm = memgradenm;
	}
	public String getMemactivecnt() {
		return memactivecnt;
	}
	public void setMemactivecnt(String memactivecnt) {
		this.memactivecnt = memactivecnt;
	}
	public String getMemactivecnt2() {
		return memactivecnt2;
	}
	public void setMemactivecnt2(String memactivecnt2) {
		this.memactivecnt2 = memactivecnt2;
	}
	public String getTotactivecnt() {
		return totactivecnt;
	}
	public void setTotactivecnt(String totactivecnt) {
		this.totactivecnt = totactivecnt;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public String getFillvolt() {
		return fillvolt;
	}
	public void setFillvolt(String fillvolt) {
		this.fillvolt = fillvolt;
	}
	
	
	
	
}