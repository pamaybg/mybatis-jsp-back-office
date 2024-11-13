package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyEventWinningCondResDto extends StatusResDto{
	private String rowId;
	private String voteCnt;
	private String apllicantCnt;
	private String winningCnt;
	private String extrResult;
	private String condSetting;
	
	public String getRowId() {
		return rowId;
	}
	public void setRowId(String rowId) {
		this.rowId = rowId;
	}
	public String getVoteCnt() {
		return voteCnt;
	}
	public void setVoteCnt(String voteCnt) {
		this.voteCnt = voteCnt;
	}
	public String getApllicantCnt() {
		return apllicantCnt;
	}
	public void setApllicantCnt(String apllicantCnt) {
		this.apllicantCnt = apllicantCnt;
	}
	public String getWinningCnt() {
		return winningCnt;
	}
	public void setWinningCnt(String winningCnt) {
		this.winningCnt = winningCnt;
	}
	public String getExtrResult() {
		return extrResult;
	}
	public void setExtrResult(String extrResult) {
		this.extrResult = extrResult;
	}
	public String getCondSetting() {
		return condSetting;
	}
	public void setCondSetting(String condSetting) {
		this.condSetting = condSetting;
	}
	
}
