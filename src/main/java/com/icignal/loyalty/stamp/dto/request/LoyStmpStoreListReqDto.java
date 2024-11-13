package com.icignal.loyalty.stamp.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpStoreListRequestDTO
* @date : 2019. 3. 5.
* @author : hy.jun
* @description :
*/
public class LoyStmpStoreListReqDto extends MKTGridPagingReqDto {
	private String ridStmp;
	private String excelHeader;

	public String getRidStmp() {
		return ridStmp;
	}

	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}

	public String getExcelHeader() {
		return excelHeader;
	}

	public void setExcelHeader(String excelHeader) {
		this.excelHeader = excelHeader;
	}
}
