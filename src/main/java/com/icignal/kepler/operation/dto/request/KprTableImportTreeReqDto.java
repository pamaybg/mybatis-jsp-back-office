package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 4.
 * @author : LEE
 * @description : 테이블정보 RequestDTO
 */
public class KprTableImportTreeReqDto extends CommonDataAuthReqDto {
	
    private String dbInformId; //db정보 아이디
    private String dbType;     //db정보
    
	public String getDbType() {
		return dbType;
	}
	public void setDbType(String dbType) {
		this.dbType = dbType;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

}
