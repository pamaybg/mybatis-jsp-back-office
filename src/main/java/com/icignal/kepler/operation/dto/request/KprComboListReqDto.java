package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 서비스명 RequestDTO
 */
public class KprComboListReqDto extends MKTGridPagingReqDto {
	
	private String dbInformId;		//타겟 테이블 아이디
	private String tableType;		//타겟 테이블 아이디

	public String getTableType() {
		return tableType;
	}
	public void setTableType(String tableType) {
		this.tableType = tableType;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
    
}
