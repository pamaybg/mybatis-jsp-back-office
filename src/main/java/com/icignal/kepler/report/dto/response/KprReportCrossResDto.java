package com.icignal.kepler.report.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportCrossResDto extends GridPagingItemResDto{

	private  String stageNm;
	private List<String> colList;
	private String yyyymm;
	private String rowNm;
	private int crossRate;
	private int crossCnt;
	private String preYyyymm;
	private String colStageNm;
	private String rowStageNm;
	private String incRate;
	private String incCnt;
	
	
	
	
	public String getPreYyyymm() {
		return preYyyymm;
	}
	public void setPreYyyymm(String preYyyymm) {
		this.preYyyymm = preYyyymm;
	}
	public String getColStageNm() {
		return colStageNm;
	}
	public void setColStageNm(String colStageNm) {
		this.colStageNm = colStageNm;
	}
	public String getRowStageNm() {
		return rowStageNm;
	}
	public void setRowStageNm(String rowStageNm) {
		this.rowStageNm = rowStageNm;
	}
	public String getIncRate() {
		return incRate;
	}
	public void setIncRate(String incRate) {
		this.incRate = incRate;
	}
	public String getIncCnt() {
		return incCnt;
	}
	public void setIncCnt(String incCnt) {
		this.incCnt = incCnt;
	}
	public String getStageNm() {
		return stageNm;
	}
	public void setStageNm(String stageNm) {
		this.stageNm = stageNm;
	}
	public List<String> getColList() {
		return colList;
	}
	public void setColList(List<String> colList) {
		this.colList = colList;
	}
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getRowNm() {
		return rowNm;
	}
	public void setRowNm(String rowNm) {
		this.rowNm = rowNm;
	}
	public int getCrossRate() {
		return crossRate;
	}
	public void setCrossRate(int crossRate) {
		this.crossRate = crossRate;
	}
	public int getCrossCnt() {
		return crossCnt;
	}
	public void setCrossCnt(int crossCnt) {
		this.crossCnt = crossCnt;
	}
	
	
	
	
	
}
