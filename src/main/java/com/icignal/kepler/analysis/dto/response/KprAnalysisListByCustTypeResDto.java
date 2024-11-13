package com.icignal.kepler.analysis.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;


/*
 * 1. 클래스명	: KPRAnalysisListByCustTypeResponseDTO
 * 2. 파일명	: KPRAnalysisListByCustTypeResponseDTO.java
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
public class KprAnalysisListByCustTypeResDto extends StatusResDto {
	
	private String ymonthcd;
	private String memtypecd;
	private String memtypenm;
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