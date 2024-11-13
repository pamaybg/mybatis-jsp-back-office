package com.icignal.systemmanagement.employee.dto.request;
import com.icignal.common.base.dto.request.CommonCondReqDto;

/**
 * @name : MKTOrganizationDetailRequestDTO.java
 * @date : 2017. 2. 20.
 * @author : jun.lee
 * @description : 
 */
public class SystemOrganizationDetailReqDto extends CommonCondReqDto {
	
	private String rid;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
}
