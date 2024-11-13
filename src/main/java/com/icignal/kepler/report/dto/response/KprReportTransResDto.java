package com.icignal.kepler.report.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportTransResDto extends GridPagingItemResDto{

	private  String stageNm;
	private List<String> colList;
	private String yyyymm;
	private String preStageNm;
	private String transCnt;
	private String transRate;
	private int TRANSCNT_01;
	private int TRANSCNT_02;
	private int TRANSCNT_03;
	private int TRANSCNT_04;
	private int TRANSRATE_01;
	private int TRANSRATE_02;
	private int TRANSRATE_03;
	private int TRANSRATE_04;
	
	
	
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getPreStageNm() {
		return preStageNm;
	}
	public void setPreStageNm(String preStageNm) {
		this.preStageNm = preStageNm;
	}
	public String getTransCnt() {
		return transCnt;
	}
	public void setTransCnt(String transCnt) {
		this.transCnt = transCnt;
	}
	public String getTransRate() {
		return transRate;
	}
	public void setTransRate(String transRate) {
		this.transRate = transRate;
	}
	public String getStageNm() {
		return stageNm;
	}
	public void setStageNm(String stageNm) {
		this.stageNm = stageNm;
	}
	public int getTRANSCNT_01() {
		return TRANSCNT_01;
	}
	public void setTRANSCNT_01(int tRANSCNT_01) {
		TRANSCNT_01 = tRANSCNT_01;
	}
	public int getTRANSCNT_02() {
		return TRANSCNT_02;
	}
	public void setTRANSCNT_02(int tRANSCNT_02) {
		TRANSCNT_02 = tRANSCNT_02;
	}
	public int getTRANSCNT_03() {
		return TRANSCNT_03;
	}
	public void setTRANSCNT_03(int tRANSCNT_03) {
		TRANSCNT_03 = tRANSCNT_03;
	}
	public int getTRANSCNT_04() {
		return TRANSCNT_04;
	}
	public void setTRANSCNT_04(int tRANSCNT_04) {
		TRANSCNT_04 = tRANSCNT_04;
	}
	public int getTRANSRATE_01() {
		return TRANSRATE_01;
	}
	public void setTRANSRATE_01(int tRANSRATE_01) {
		TRANSRATE_01 = tRANSRATE_01;
	}
	public int getTRANSRATE_02() {
		return TRANSRATE_02;
	}
	public void setTRANSRATE_02(int tRANSRATE_02) {
		TRANSRATE_02 = tRANSRATE_02;
	}
	public int getTRANSRATE_03() {
		return TRANSRATE_03;
	}
	public void setTRANSRATE_03(int tRANSRATE_03) {
		TRANSRATE_03 = tRANSRATE_03;
	}
	public int getTRANSRATE_04() {
		return TRANSRATE_04;
	}
	public void setTRANSRATE_04(int tRANSRATE_04) {
		TRANSRATE_04 = tRANSRATE_04;
	}
	public List<String> getColList() {
		return colList;
	}
	public void setColList(List<String> colList) {
		this.colList = colList;
	}
	
	
	
}
