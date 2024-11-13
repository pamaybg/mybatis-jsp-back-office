package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 14.
 * @author : 이원준
 * @description : 테이블 목록 ResponseDTO
 */
public class KprGetTableResDto extends StatusResDto {

	private String tableId; // 아이디
	private String createByName; // 생성자명
	private String createDate; // 생성일시
	private String serviceNm; // 서비스명
	private String dbId; // DB유형
	private String subjectAreaNm; // 접속IP
	private String subjectAreaId; // 접속ID
	private String dpNm; // 접속PW
	private String tblTypeCd; // 설명
	private String tblTypeNm; // 설명
	private String tblSpaceNm; // 설명
	private String schmaNm; // 설명
	private Integer pctFree; // 설명
	private Integer initRans; // 설명
	private Integer maxTrans; // 설명
	private Integer initIal; // 설명
	private Integer next; // 설명
	private Integer minExtents; // 설명

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getCreateByName() {
		return createByName;
	}

	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getServiceNm() {
		return serviceNm;
	}

	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}

	public String getDbId() {
		return dbId;
	}

	public void setDbId(String dbId) {
		this.dbId = dbId;
	}

	public String getSubjectAreaNm() {
		return subjectAreaNm;
	}

	public void setSubjectAreaNm(String subjectAreaNm) {
		this.subjectAreaNm = subjectAreaNm;
	}

	public String getSubjectAreaId() {
		return subjectAreaId;
	}

	public void setSubjectAreaId(String subjectAreaId) {
		this.subjectAreaId = subjectAreaId;
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

	public String getTblTypeNm() {
		return tblTypeNm;
	}

	public void setTblTypeNm(String tblTypeNm) {
		this.tblTypeNm = tblTypeNm;
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

	public Integer getPctFree() {
		return pctFree;
	}

	public void setPctFree(Integer pctFree) {
		this.pctFree = pctFree;
	}

	public Integer getInitRans() {
		return initRans;
	}

	public void setInitRans(Integer initRans) {
		this.initRans = initRans;
	}

	public Integer getMaxTrans() {
		return maxTrans;
	}

	public void setMaxTrans(Integer maxTrans) {
		this.maxTrans = maxTrans;
	}

	public Integer getInitIal() {
		return initIal;
	}

	public void setInitIal(Integer initIal) {
		this.initIal = initIal;
	}

	public Integer getNext() {
		return next;
	}

	public void setNext(Integer next) {
		this.next = next;
	}

	public Integer getMinExtents() {
		return minExtents;
	}

	public void setMinExtents(Integer minExtents) {
		this.minExtents = minExtents;
	}

}
