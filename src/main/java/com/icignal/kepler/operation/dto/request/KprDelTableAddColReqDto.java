package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 테이블 컬럼 삭제 RequestDTO
 */
public class KprDelTableAddColReqDto extends CommonDataAuthReqDto {
	
    private List<String> colId;    //컬럼 아이디
    private String tableId;    		//테이블 아이디
    private String modifyBy;     	//수정자
    
    
	public List<String> getColId() {
		return colId;
	}
	public void setColId(List<String> colId) {
		this.colId = colId;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	
}
