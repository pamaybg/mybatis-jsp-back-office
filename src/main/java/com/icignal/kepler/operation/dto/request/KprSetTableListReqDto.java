package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 테이블 등록 RequestDTO
 */
public class KprSetTableListReqDto extends CommonDataAuthReqDto {

	private String tableId; // 테이블정보 아이디

	private String subjectDbId; // 주제영역DB 아이디
	private String dbmsTypeCd; // DB유형
	private String dpNm; // 디스플레이명
	private String tblTypeCd; // 테이블 구분
	private String tblSpaceNm; // 저장공간명
	private String schmaNm; // 스키마명
	private String tblNm; // 테이블명
	private String comment; // 코멘트
	private String engine;

	private String dbInformId; // DB정보 아이디
	private String subjectAreaId; // 주제영역 아이디
	private String subjectDbRelId; // 주제영역DB 아이디
	private String dbType;

	private List<KprSetTableListReqDto> tableDataList;

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getEngine() {
		return engine;
	}

	public void setEngine(String engine) {
		this.engine = engine;
	}

	public String getSubjectDbRelId() {
		return subjectDbRelId;
	}

	public void setSubjectDbRelId(String subjectDbRelId) {
		this.subjectDbRelId = subjectDbRelId;
	}

	public String getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

	public String getSubjectAreaId() {
		return subjectAreaId;
	}

	public void setSubjectAreaId(String subjectAreaId) {
		this.subjectAreaId = subjectAreaId;
	}

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getSubjectDbId() {
		return subjectDbId;
	}

	public void setSubjectDbId(String subjectDbId) {
		this.subjectDbId = subjectDbId;
	}

	public String getDbmsTypeCd() {
		return dbmsTypeCd;
	}

	public void setDbmsTypeCd(String dbmsTypeCd) {
		this.dbmsTypeCd = dbmsTypeCd;
	}

	public String getDpNm() {
		return dpNm;
	}

	public void setDpNm(String dpNm) {
		this.dpNm = dpNm;
	}

	public String getTblTypeCd() {
		return tblTypeCd;
	}

	public void setTblTypeCd(String tblTypeCd) {
		this.tblTypeCd = tblTypeCd;
	}

	public String getTblSpaceNm() {
		return tblSpaceNm;
	}

	public void setTblSpaceNm(String tblSpaceNm) {
		this.tblSpaceNm = tblSpaceNm;
	}

	public String getSchmaNm() {
		return schmaNm;
	}

	public void setSchmaNm(String schmaNm) {
		this.schmaNm = schmaNm;
	}

	public String getTblNm() {
		return tblNm;
	}

	public void setTblNm(String tblNm) {
		this.tblNm = tblNm;
	}

	public String getDbType() {
		return dbType;
	}

	public void setDbType(String dbType) {
		this.dbType = dbType;
	}

	public List<KprSetTableListReqDto> getTableDataList() {
		return tableDataList;
	}

	public void setTableDataList(List<KprSetTableListReqDto> tableDataList) {
		this.tableDataList = tableDataList;
	}
}