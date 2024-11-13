package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 테이블정보 RequestDTO
 */
public class KprTableMstListReqDto extends CommonDataAuthReqDto {
	
	private String tableId;		//타겟 테이블 아이디
	private String tblNm;		//타겟 테이블
	private String schmaNm;		//스키마
	private String dbInformId;  //DB정보 아이디
	
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
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
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
    
}
