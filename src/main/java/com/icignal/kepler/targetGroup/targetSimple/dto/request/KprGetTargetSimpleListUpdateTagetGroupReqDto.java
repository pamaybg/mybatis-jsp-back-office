package com.icignal.kepler.targetGroup.targetSimple.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprGetTargetSimpleListUpdateTagetGroupReqDto extends MKTBaseReqDto {

	private String tgtGroupNm;
	private String tgtGroupDesc;
	private String cnt;
	private String filterSql;
	private String filterSqlCount;
	private String targetGroupId;
	
	private List<KprGetTargetSimpleListNewSaveDataReqDto> dataList;
	
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
	public String getTargetGroupId() {
		return targetGroupId;
	}
	public void setTargetGroupId(String targetGroupId) {
		this.targetGroupId = targetGroupId;
	}
	public List<KprGetTargetSimpleListNewSaveDataReqDto> getDataList() {
		return dataList;
	}
	public void setDataList(List<KprGetTargetSimpleListNewSaveDataReqDto> dataList) {
		this.dataList = dataList;
	}


}
