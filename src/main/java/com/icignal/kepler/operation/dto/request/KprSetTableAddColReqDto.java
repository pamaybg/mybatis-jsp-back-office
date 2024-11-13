package com.icignal.kepler.operation.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 테이블 컬럼등록 RequestDTO
 */
public class KprSetTableAddColReqDto extends CommonDataAuthReqDto {
	
    private String colId;      // 컬럼 아이디
    private String tableId;    //테이블 아이디
    
	private String colNm;      //컬럼명
	private String pkYn;       //pk여부
	private String dataTypeCd; //데이터타입
	private Double len;        //사이즈
	private Integer seq;       //순서
	private String nullYn;     //null여부
	private String deftVal;    //디폴트명
	private String dpNm;       //디스플레이명
	private String colTypeCd;  //디멘젼/메저구분
	private String gropCode;   //그룹코드
	private String tblNm;      //테이블 명
	private String schmaNm;    //스키마명
	
	private String dbInformId; //DB정보 아이디
	
	public String getDbInformId() {
        return dbInformId;
    }
    public void setDbInformId(String dbInformId) {
        this.dbInformId = dbInformId;
    }
    public Double getLen() {
		return len;
	}
	public void setLen(Double len) {
		this.len = len;
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
	public String getColNm() {
		return colNm;
	}
	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
	public String getPkYn() {
		return pkYn;
	}
	public void setPkYn(String pkYn) {
		this.pkYn = pkYn;
	}
	public String getDataTypeCd() {
		return dataTypeCd;
	}
	public void setDataTypeCd(String dataTypeCd) {
		this.dataTypeCd = dataTypeCd;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getNullYn() {
		return nullYn;
	}
	public void setNullYn(String nullYn) {
		this.nullYn = nullYn;
	}
	public String getDeftVal() {
		return deftVal;
	}
	public void setDeftVal(String deftVal) {
		this.deftVal = deftVal;
	}
	public String getDpNm() {
		return dpNm;
	}
	public void setDpNm(String dpNm) {
		this.dpNm = dpNm;
	}
	public String getColTypeCd() {
		return colTypeCd;
	}
	public void setColTypeCd(String colTypeCd) {
		this.colTypeCd = colTypeCd;
	}
	public String getGropCode() {
		return gropCode;
	}
	public void setGropCode(String gropCode) {
		this.gropCode = gropCode;
	}

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
