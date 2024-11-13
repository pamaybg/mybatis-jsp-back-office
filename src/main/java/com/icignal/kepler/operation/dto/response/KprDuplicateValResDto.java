package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprDuplicateValResDto extends StatusResDto {

	
	private String id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

}
