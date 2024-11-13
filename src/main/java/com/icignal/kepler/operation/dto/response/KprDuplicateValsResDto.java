package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprDuplicateValsResDto extends StatusResDto {

	
	private List<KprDuplicateValResDto> items;

	public List<KprDuplicateValResDto> getItems() {
		return items;
	}

	public void setItems(List<KprDuplicateValResDto> items) {
		this.items = items;
	}

}
