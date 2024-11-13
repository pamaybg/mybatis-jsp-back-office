package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 인덱스 목록 삭제 RequestDTO
 */
public class KprDelIdxListReqDto extends CommonDataAuthReqDto {
	
    private List<String> idxId;    	//인덱스 아이디
    private String tableId;     			//테이블 아이디
    private String modifyBy;     		//수정자
    
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	public List<String> getIdxId() {
		return idxId;
	}
	public void setIdxId(List<String> idxId) {
		this.idxId = idxId;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
    
}
