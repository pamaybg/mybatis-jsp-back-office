package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 10. 7.
 * @author : LEE
 * @description :
 */
public class KprExcelColListsReqDto extends CommonDataAuthReqDto {
	
	private String colId;			//컬럼
	private String excelColId;		//엑셀컬럼
	private String excelColNm;		//엑셀컬럼명
	
	
	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
	}
	public String getExcelColId() {
		return excelColId;
	}
	public void setExcelColId(String excelColId) {
		this.excelColId = excelColId;
	}
	public String getExcelColNm() {
		return excelColNm;
	}
	public void setExcelColNm(String excelColNm) {
		this.excelColNm = excelColNm;
	}

}
