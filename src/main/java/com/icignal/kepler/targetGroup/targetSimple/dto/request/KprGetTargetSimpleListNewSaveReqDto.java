package com.icignal.kepler.targetGroup.targetSimple.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprGetTargetSimpleListNewSaveReqDto extends MKTBaseReqDto {	
		
	private List<KprGetTargetSimpleListNewSaveDataReqDto> dataList;
	
	private String targetGroupId;
	private String tgtGroupNm;
	private String tgtGroupDesc;
	private String cnt;
	private String filterSql;
	private String filterSqlCount;
	private String dbInfo;
	private String targetCount;
	private String getTgtGroupNo;

	
	public List<KprGetTargetSimpleListNewSaveDataReqDto> getDataList() {
		return dataList;
	}
	public void setDataList(List<KprGetTargetSimpleListNewSaveDataReqDto> dataList) {
		this.dataList = dataList;
	}
	
	public String getDbInfo() {
		return dbInfo;
	}
	public void setDbInfo(String dbInfo) {
		this.dbInfo = dbInfo;
	}

	public String getTargetGroupId() {
		return targetGroupId;
	}
	public void setTargetGroupId(String targetGroupId) {
		this.targetGroupId = targetGroupId;
	}
	public String getTgtGroupNm() {
		return tgtGroupNm;
	}
	public void setTgtGroupNm(String tgtGroupNm) {
		this.tgtGroupNm = tgtGroupNm;
	}
	public String getTgtGroupDesc() {
		return tgtGroupDesc;
	}
	public void setTgtGroupDesc(String tgtGroupDesc) {
		this.tgtGroupDesc = tgtGroupDesc;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getFilterSql() {
		return filterSql;
	}
	public void setFilterSql(String filterSql) {
		this.filterSql = filterSql;
	}
	public String getFilterSqlCount() {
		return filterSqlCount;
	}
	public void setFilterSqlCount(String filterSqlCount) {
		this.filterSqlCount = filterSqlCount;
	}
	public String getTargetCount() {
		return targetCount;
	}
	public void setTargetCount(String targetCount) {
		this.targetCount = targetCount;
	}

	public String getGetTgtGroupNo() {
		return getTgtGroupNo;
	}

	public void setGetTgtGroupNo(String getTgtGroupNo) {
		this.getTgtGroupNo = getTgtGroupNo;
	}
}
