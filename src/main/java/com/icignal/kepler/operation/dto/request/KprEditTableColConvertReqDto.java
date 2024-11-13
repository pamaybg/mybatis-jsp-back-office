package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : infavor.kepler.operation.dto.request.KPReditTableColConvertRequestDTO
 * @date : 2017. 7. 26.
 * @author : jh.kim
 * @description :
 */
public class KprEditTableColConvertReqDto extends MKTBaseReqDto {
    
    private String tblId;         // 변환할 컬럼의 테이블
    private String colTypeCd;     // 변환할 값
    private List<String> colIds;  // 변환할 컬럼의 id 
    
    public List<String> getColIds() {
        return colIds;
    }
    
    public void setColIds(List<String> colIds) {
        this.colIds = colIds;
    }
    
    public String getColTypeCd() {
        return colTypeCd;
    }
    
    public void setColTypeCd(String colTypeCd) {
        this.colTypeCd = colTypeCd;
    }
    
    public String getTblId() {
        return tblId;
    }
    
    public void setTblId(String tblId) {
        this.tblId = tblId;
    }
    
}
