package com.icignal.kepler.operation.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 8.
 * @author : LEE
 * @description : 테이블 컬럼 불러오기 RequestDTO
 */
public class KprTableColImportReqDto extends CommonDataAuthReqDto {
	
    private String tblNm;   //db정보 아이디
    private String schmaNm; //db정보 아이디
    
    private String dbInformId; //DB정보 아이디
    
	public String getDbInformId() {
        return dbInformId;
    }
    public void setDbInformId(String dbInformId) {
        this.dbInformId = dbInformId;
    }
    public String getTblNm() {
		return tblNm;
	}
	public void setTblNm(String tblNm) {
		this.tblNm = tblNm;
	}
	public String getSchmaNm() {
		return schmaNm;
	}
	public void setSchmaNm(String schmaNm) {
		this.schmaNm = schmaNm;
	}

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
