package com.icignal.kepler.report.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportCrossDtlResDto extends GridPagingItemResDto{

	private List<String> colList;
	private List<preMonVal> preMonList;
	private String yyyymm;
	private String rowNm;
	private float crossRate;
	private int crossCnt;
	private String preMonth;
	private String m1StageNm;
	private String m6StageNm;
	
	
	
	public String getM1StageNm() {
		return m1StageNm;
	}

	public void setM1StageNm(String m1StageNm) {
		this.m1StageNm = m1StageNm;
	}

	public String getM6StageNm() {
		return m6StageNm;
	}

	public void setM6StageNm(String m6StageNm) {
		this.m6StageNm = m6StageNm;
	}

	public List<String> getColList() {
		return colList;
	}

	public void setColList(List<String> colList) {
		this.colList = colList;
	}

	public List<preMonVal> getPreMonList() {
		return preMonList;
	}

	public void setPreMonList(List<preMonVal> preMonList) {
		this.preMonList = preMonList;
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

	public int getCrossCnt() {
		return crossCnt;
	}

	public void setCrossCnt(int crossCnt) {
		this.crossCnt = crossCnt;
	}

	public String getPreMonth() {
		return preMonth;
	}

	public void setPreMonth(String preMonth) {
		this.preMonth = preMonth;
	}

	public float getCrossRate() {
		return crossRate;
	}

	public void setCrossRate(float crossRate) {
		this.crossRate = crossRate;
	}

	public static class preMonVal  {
		private String m1StageNm;
		private int lcCnt;
		private float lcRate;
		
		public int getLcCnt() {
			return lcCnt;
		}
		public void setLcCnt(int lcCnt) {
			this.lcCnt = lcCnt;
		}
		
		public String getM1StageNm() {
			return m1StageNm;
		}
		public void setM1StageNm(String m1StageNm) {
			this.m1StageNm = m1StageNm;
		}
		public float getLcRate() {
			return lcRate;
		}
		public void setLcRate(float lcRate) {
			this.lcRate = lcRate;
		}
		
		
	}
	
	
}
