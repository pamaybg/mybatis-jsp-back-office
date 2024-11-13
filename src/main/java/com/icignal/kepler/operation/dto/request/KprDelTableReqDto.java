package com.icignal.kepler.operation.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 12.
 * @author : LEE
 * @description : 테이블 삭제 RequestDTO
 */
public class KprDelTableReqDto extends CommonDataAuthReqDto {
	
    private String schmaNm;   //스키마
    private String tblNm;     //테이블
    
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

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
