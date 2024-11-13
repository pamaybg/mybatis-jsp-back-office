package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 테이블 컬럼 정보 수정 RequestDTO
 */
public class KprEditTableAddColReqDto extends CommonDataAuthReqDto {
	
    private String colId;    			// 컬럼 아이디
    private String tableId;    		//테이블 아이디
    private String accountId;  		//어카운트 아이디
    private String createBy;     	//생성자
    private String modifyBy;     	//수정자
    
	private String colNm; 			//컬럼명
	private String pkYn; 			//PK여부
	private String dataTypeCd; 	//데이터타입
	private Integer len; 				//사이즈
	private Integer seq; 				//순서
	private String nullYn; 			//NULL여부
	private String deftVal;	 		//디폴트명
	private String dpNm; 			//디스플레이명
	private String colTypeCd; 		//디멘젼/메저구분
	private String gropCode; 		//그룹코드
	
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
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
	public Integer getLen() {
		return len;
	}
	public void setLen(Integer len) {
		this.len = len;
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
    
	
}
