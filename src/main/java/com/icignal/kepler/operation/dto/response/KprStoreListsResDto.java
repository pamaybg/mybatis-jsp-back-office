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
public class KprStoreListsResDto extends StatusResDto {

	
	private List<KprStoreListResDto> items;

	public List<KprStoreListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprStoreListResDto> items) {
		this.items = items;
	}
	
}
