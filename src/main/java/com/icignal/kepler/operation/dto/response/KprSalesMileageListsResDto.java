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
public class KprSalesMileageListsResDto extends StatusResDto {

	
	private List<KprSalesMileageListResDto> items;

	public List<KprSalesMileageListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprSalesMileageListResDto> items) {
		this.items = items;
	}

}
