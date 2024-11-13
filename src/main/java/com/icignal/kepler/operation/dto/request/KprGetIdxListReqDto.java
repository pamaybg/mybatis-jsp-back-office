package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 2.
 * @author : LEE
 * @description : 인덱스 정보 조회 RequestDTO
 */
public class KprGetIdxListReqDto extends CommonDataAuthReqDto {
	
	private String idxId;			//인덱스아이디
	private String tableId;		//테이블아이디
	private String accountId; 	//접속 아이디
	private String idxNm; 		//인덱스명
	
	public String getIdxNm() {
		return idxNm;
	}
	public void setIdxNm(String idxNm) {
		this.idxNm = idxNm;
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
	public String getIdxId() {
		return idxId;
	}
	public void setIdxId(String idxId) {
		this.idxId = idxId;
	}
}
