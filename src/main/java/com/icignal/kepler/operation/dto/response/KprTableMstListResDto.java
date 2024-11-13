package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 21.
 * @author : 이원준
 * @description : 테이블 관리 목록 ResponseDTO
 */
public class KprTableMstListResDto extends GridPagingItemResDto {
	
	
    private String tableId;     			//테이블 아이디
    private String createByName;     		//생성자명
    private String createDate;     			//생성일시
    private String serviceNm;     			//서비스명
    private String subjectAreaNm;     		//주제영역명
    private String dbmsTypeCd;    			//DB유형
    private String schmaNm;  				//스키마명
    private String tblNm; 					//테이블명
    private String dpNm; 					//디스플레이명
    private String tblType; 				//테이블구분
    private String tblTypeCd; 				//테이블구분
    private String tblSpaceNm; 				//저장공간명
    private String importYn; 				//불러오기여부
    private String subjectAreaId; 			//주제영역 아이디
    private String dbId; 					//DB정보 아이디
    private int cnt; 						//중복CNT
    private int lgcFlag; 					//L.C사용유무
    
	public int getLgcFlag() {
		return lgcFlag;
	}
	public void setLgcFlag(int lgcFlag) {
		this.lgcFlag = lgcFlag;
	}
	public String getServiceNm() {
		return serviceNm;
	}
	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}
	public String getTblType() {
		return tblType;
	}
	public void setTblType(String tblType) {
		this.tblType = tblType;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getSubjectAreaId() {
		return subjectAreaId;
	}
	public void setSubjectAreaId(String subjectAreaId) {
		this.subjectAreaId = subjectAreaId;
	}
	public String getDbId() {
		return dbId;
	}
	public void setDbId(String dbId) {
		this.dbId = dbId;
	}
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
	public String getSubjectAreaNm() {
		return subjectAreaNm;
	}
	public void setSubjectAreaNm(String subjectAreaNm) {
		this.subjectAreaNm = subjectAreaNm;
	}
	public String getDbmsTypeCd() {
		return dbmsTypeCd;
	}
	public void setDbmsTypeCd(String dbmsTypeCd) {
		this.dbmsTypeCd = dbmsTypeCd;
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
	public String getImportYn() {
		return importYn;
	}
	public void setImportYn(String importYn) {
		this.importYn = importYn;
	}
    
    

}
