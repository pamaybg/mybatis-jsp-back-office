package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 10. 4.
 * @author : 이원준
 * @description : 엑셀업로드 RequestDTO
 */
public class KprTableColInfoReqDto extends CommonDataAuthReqDto {
	
	private String tableNm;		//테이블명

	public String getTableNm() {
		return tableNm;
	}

	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}

	
}
