package com.icignal.kepler.operation.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 8. 8.
 * @author : LEE
 * @description : 테이블 컬럼 불러오기 ResponseDTO
 */
public class KprTableColImportResDto extends GridPagingItemResDto {
	
	private String colNm;    	//컬럼명
    private String seq;    	    //순서
    private String dpNm;    	//디스플레이명
    private String nullYn;    	//NULL여부
    private String dataTypeCd;  //데이터타입
    private String len;    		//사이즈
    private String deftVal;   	//디폴트명
    private String pkYn;    	//PK여부
    
    
    public String getColNm() {
        return colNm;
    }
    
    public void setColNm(String colNm) {
        this.colNm = colNm;
    }
    
    public String getSeq() {
        return seq;
    }
    
    public void setSeq(String seq) {
        this.seq = seq;
    }
    
    public String getDpNm() {
        return dpNm;
    }
    
    public void setDpNm(String dpNm) {
        this.dpNm = dpNm;
    }
    
    public String getNullYn() {
        return nullYn;
    }
    
    public void setNullYn(String nullYn) {
        this.nullYn = nullYn;
    }
    
    public String getDataTypeCd() {
        return dataTypeCd;
    }
    
    public void setDataTypeCd(String dataTypeCd) {
        this.dataTypeCd = dataTypeCd;
    }
    
    public String getLen() {
        return len;
    }
    
    public void setLen(String len) {
        this.len = len;
    }
    
    public String getDeftVal() {
        return deftVal;
    }
    
    public void setDeftVal(String deftVal) {
        this.deftVal = deftVal;
    }
    
    public String getPkYn() {
        return pkYn;
    }
    
    public void setPkYn(String pkYn) {
        this.pkYn = pkYn;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
