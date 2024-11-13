package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprDrillDownGroupReqDto extends MKTBaseReqDto {
	private Integer nodeLevel;

	private String databaseId;
	private String tableId;

	private String drillDownGroupId;
	private String drillDownGroupName;
	private Integer seq;
	private String levelId_1;
	private String levelId_2;
	private String levelId_3;
	private String levelId_4;
	private String levelId_5;

	public Integer getNodeLevel() {
		return nodeLevel;
	}

	public void setNodeLevel(Integer nodeLevel) {
		this.nodeLevel = nodeLevel;
	}

	public String getDatabaseId() {
		return databaseId;
	}

	public void setDatabaseId(String databaseId) {
		this.databaseId = databaseId;
	}

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getDrillDownGroupId() {
		return drillDownGroupId;
	}

	public void setDrillDownGroupId(String drillDownGroupId) {
		this.drillDownGroupId = drillDownGroupId;
	}

	public String getDrillDownGroupName() {
		return drillDownGroupName;
	}

	public void setDrillDownGroupName(String drillDownGroupName) {
		this.drillDownGroupName = drillDownGroupName;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getLevelId_1() {
		return levelId_1;
	}

	public void setLevelId_1(String levelId_1) {
		this.levelId_1 = levelId_1;
	}

	public String getLevelId_2() {
		return levelId_2;
	}

	public void setLevelId_2(String levelId_2) {
		this.levelId_2 = levelId_2;
	}

	public String getLevelId_3() {
		return levelId_3;
	}

	public void setLevelId_3(String levelId_3) {
		this.levelId_3 = levelId_3;
	}

	public String getLevelId_4() {
		return levelId_4;
	}

	public void setLevelId_4(String levelId_4) {
		this.levelId_4 = levelId_4;
	}

	public String getLevelId_5() {
		return levelId_5;
	}

	public void setLevelId_5(String levelId_5) {
		this.levelId_5 = levelId_5;
	}
}