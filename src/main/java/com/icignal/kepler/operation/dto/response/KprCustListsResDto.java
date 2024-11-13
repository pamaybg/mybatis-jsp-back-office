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
public class KprCustListsResDto extends StatusResDto {

	
	private List<KprCustListResDto> items;

	public List<KprCustListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprCustListResDto> items) {
		this.items = items;
	}

}
