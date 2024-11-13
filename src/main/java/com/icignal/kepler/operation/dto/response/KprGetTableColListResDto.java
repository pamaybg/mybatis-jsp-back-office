package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 14.
 * @author : 이원준
 * @description : 인덱스컬럼 목록 ResponseDTO
 */
public class KprGetTableColListResDto extends GridPagingItemResDto {
	
    private String colId;     			//컬럼아이디
    private String tableId;     			//테이블아이디
    private String createByName;    //생성자명
    private String createDate;     	//생성일시
    private String colNm;     			//컬럼명
    private String pkYn;    				//pk여부
    private String dataTypeCd;  		//데이터타입
    private Double len; 						//길이
    private String nullYn; 				//널여부
    private String deftVal; 				//디폴트
    private Integer seq; 						//순서
    private String dpNm; 				//디스플레이명
    private String colTypeCd; 			//컬럼타입

    private String delFlag; 				//삭제flag
    private int cnt; 						//중복cnt
    
	public Double getLen() {
		return len;
	}
	public void setLen(Double len) {
		this.len = len;
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
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
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
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
    

}
