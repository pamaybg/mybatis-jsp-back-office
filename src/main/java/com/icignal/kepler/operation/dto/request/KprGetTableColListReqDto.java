package com.icignal.kepler.operation.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 3.
 * @author : LEE
 * @description : 테이블 컬럼정보 조회 RequestDTO
 */
public class KprGetTableColListReqDto extends CommonDataAuthReqDto {
    
    private String tableId;	     //테이블 아이디
    private String tblId;	     //테이블 아이디
    private String colId;	     //컬럼 아이디
    private String colNm; 	     //컬럼명
    private String dbType; 	     //컬럼명
    private String colTypeCd;    //DIMENSION/MEASURE 구분
    
    private List<String> colId1; //컬럼 아이디
    
    public String getColTypeCd() {
        return colTypeCd;
    }
    
    public void setColTypeCd(String colTypeCd) {
        this.colTypeCd = colTypeCd;
    }
    
    public String getColNm() {
        return colNm;
    }
    
    public void setColNm(String colNm) {
        this.colNm = colNm;
    }
    
    public List<String> getColId1() {
        return colId1;
    }
    
    public void setColId1(List<String> colId1) {
        this.colId1 = colId1;
    }
    
    public String getTblId() {
        return tblId;
    }
    
    public void setTblId(String tblId) {
        this.tblId = tblId;
    }
    
    public String getColId() {
        return colId;
    }
    
    public void setColId(String colId) {
        this.colId = colId;
    }
    
    public String getTableId() {
        return tableId;
    }
    
    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    public String getDbType() {
        return dbType;
    }
    
    public void setDbType(String dbType) {
        this.dbType = dbType;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
}
