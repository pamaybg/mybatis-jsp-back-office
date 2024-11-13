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
public class KprSalesListsResDto extends StatusResDto {

	
	private List<KprSalesListResDto> items;

	public List<KprSalesListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprSalesListResDto> items) {
		this.items = items;
	}
    
}
