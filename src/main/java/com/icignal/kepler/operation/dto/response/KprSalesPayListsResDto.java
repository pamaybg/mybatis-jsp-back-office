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
public class KprSalesPayListsResDto extends StatusResDto {

	
	private List<KprSalesPayListResDto> items;

	public List<KprSalesPayListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprSalesPayListResDto> items) {
		this.items = items;
	}
	
}
