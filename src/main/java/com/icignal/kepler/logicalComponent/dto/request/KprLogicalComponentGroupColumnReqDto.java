package com.icignal.kepler.logicalComponent.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentGroupColumnRequestDTO
 * 2. 파일명	: KPRLogicalComponentGroupColumnRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 4. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprLogicalComponentGroupColumnReqDto extends MKTBaseReqDto {
	private String lgcCompId;
	private String tblRelId;
	private String colId;
	private String grpFuncTypeCd;
	private String grpColId;

	private String tblRelId_New;

	private List<String> tblRelIdList;

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

	public String getTblRelId() {
		return tblRelId;
	}

	public void setTblRelId(String tblRelId) {
		this.tblRelId = tblRelId;
	}

	public String getColId() {
		return colId;
	}

	public void setColId(String colId) {
		this.colId = colId;
	}

	public String getGrpFuncTypeCd() {
		return grpFuncTypeCd;
	}

	public void setGrpFuncTypeCd(String grpFuncTypeCd) {
		this.grpFuncTypeCd = grpFuncTypeCd;
	}

	public String getGrpColId() {
		return grpColId;
	}

	public void setGrpColId(String grpColId) {
		this.grpColId = grpColId;
	}

	public String getTblRelId_New() {
		return tblRelId_New;
	}

	public void setTblRelId_New(String tblRelId_New) {
		this.tblRelId_New = tblRelId_New;
	}

	public List<String> getTblRelIdList() {
		return tblRelIdList;
	}

	public void setTblRelIdList(List<String> tblRelIdList) {
		this.tblRelIdList = tblRelIdList;
	}
}