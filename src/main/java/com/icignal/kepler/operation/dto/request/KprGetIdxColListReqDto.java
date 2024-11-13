package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 1.
 * @author : LEE
 * @description : 인덱스 컬럼정보 조회 RequestDTO
 */
public class KprGetIdxColListReqDto extends CommonDataAuthReqDto {
	
	private String idxColId;		//컬럼아이디
	private String idxId;			//인덱스아이디
	private String tableId;		//테이블아이디
	private String accountId; 	//접속 아이디
	private String colNm; 		//컬럼명
	
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
	public String getIdxColId() {
		return idxColId;
	}
	public void setIdxColId(String idxColId) {
		this.idxColId = idxColId;
	}
	public String getIdxId() {
		return idxId;
	}
	public void setIdxId(String idxId) {
		this.idxId = idxId;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	
}
