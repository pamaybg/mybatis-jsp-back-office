package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 10. 7.
 * @author : LEE
 * @description :
 */
public class KprExcelColListReqDto extends CommonDataAuthReqDto {
	
	private List<KprExcelColListsReqDto> excelColList;

	public List<KprExcelColListsReqDto> getExcelColList() {
		return excelColList;
	}

	public void setExcelColList(List<KprExcelColListsReqDto> excelColList) {
		this.excelColList = excelColList;
	}
	

}
