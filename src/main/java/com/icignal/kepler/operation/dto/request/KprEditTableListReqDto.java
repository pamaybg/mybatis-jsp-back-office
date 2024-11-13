package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 테이블 정보 수정 RequestDTO
 */
public class KprEditTableListReqDto extends CommonDataAuthReqDto {
	
    private String tableId;    		//테이블정보 아이디
    private String accountId;   	//어카운트 아이디
    private String createBy;     	//생성자
    private String modifyBy;     	//수정자
    
	private String subjectDbId; 	//주제영역DB 아이디
	private String dbmsTypeCd; 	//DB유형
	private String dpNm; 			//디스플레이명
	private String tblTypeCd; 		//테이블 구분
	private String tblSpaceNm; 	//저장공간명
	private String schmaNm; 		//스키마명
	private String tblNm;			 //테이블명
	
	private String dbInformId; //DB정보 아이디
	private String subjectAreaId; //주제영역 아이디
	
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
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
	
}
