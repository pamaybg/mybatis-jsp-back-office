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
public class KprCardListsResDto extends StatusResDto {

	
	private List<KprCardListResDto> items;

	public List<KprCardListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprCardListResDto> items) {
		this.items = items;
	}

}
