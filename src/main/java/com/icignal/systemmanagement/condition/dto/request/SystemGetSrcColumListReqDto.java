package com.icignal.systemmanagement.condition.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;



/**
 * @name : getBaseTable
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 기본 테이블 목록 조회
 */
public class SystemGetSrcColumListReqDto extends MKTGridPagingReqDto {
	
	private String empId;		//직원 아이디
	private String tableId;			//테이블 아이디
	private String tblEngNm;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	public String getTblEngNm() {
		return tblEngNm;
	}
	public void setTblEngNm(String tblEngNm) {
		this.tblEngNm = tblEngNm;
	}
	

	
	
}
